package ch.martinelli.edu.alpenfeld.core.catalog;

import static ch.martinelli.edu.alpenfeld.db.Tables.CONTRACT_PRICE;
import static ch.martinelli.edu.alpenfeld.db.Tables.PORTAL_USER;
import static ch.martinelli.edu.alpenfeld.db.Tables.PRODUCT;
import static ch.martinelli.edu.alpenfeld.db.Tables.PRODUCT_STOCK;
import static org.jooq.impl.DSL.noCondition;
import static org.jooq.impl.DSL.selectOne;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.jooq.Condition;
import org.jooq.DSLContext;
import org.jooq.Records;
import org.springframework.stereotype.Repository;

@Repository
public class ProductCatalogRepository {

    private final DSLContext dsl;

    public ProductCatalogRepository(DSLContext dsl) {
        this.dsl = dsl;
    }

    public Optional<BuyerContext> findActiveBuyerByEmail(String email) {
        return dsl.select(PORTAL_USER.CUSTOMER_ID)
                .from(PORTAL_USER)
                .where(PORTAL_USER.EMAIL.eq(email))
                .and(PORTAL_USER.ACTIVE.isTrue())
                .and(PORTAL_USER.ROLE.eq("Buyer"))
                .fetchOptional(Records.mapping(BuyerContext::new));
    }

    public boolean hasProducts() {
        return dsl.fetchExists(selectOne().from(PRODUCT));
    }

    public List<ProductCatalogItem> searchProducts(String searchTerm, Long customerId, LocalDate today) {
        Condition searchCondition = noCondition();
        if (!searchTerm.isBlank()) {
            searchCondition = PRODUCT.NAME.containsIgnoreCase(searchTerm)
                    .or(PRODUCT.DESCRIPTION.containsIgnoreCase(searchTerm));
        }

        // UC-001 BR-002: Read copied values with their matching timestamps.
        return dsl.select(
                        PRODUCT.ID,
                        PRODUCT.NAME,
                        PRODUCT.DESCRIPTION,
                        CONTRACT_PRICE.UNIT_PRICE,
                        CONTRACT_PRICE.SYNCHRONIZED_AT,
                        PRODUCT_STOCK.QUANTITY,
                        PRODUCT_STOCK.SYNCHRONIZED_AT,
                        PRODUCT.SYNCHRONIZED_AT)
                .from(PRODUCT)
                .leftJoin(PRODUCT_STOCK)
                .on(PRODUCT.ID.eq(PRODUCT_STOCK.PRODUCT_ID))
                .leftJoin(CONTRACT_PRICE)
                // UC-001 BR-001: Show only the current customer's effective price.
                .on(CONTRACT_PRICE.PRODUCT_ID.eq(PRODUCT.ID)
                        .and(CONTRACT_PRICE.CUSTOMER_ID.eq(customerId))
                        .and(CONTRACT_PRICE.VALID_FROM.le(today))
                        .and(CONTRACT_PRICE.VALID_TO.isNull().or(CONTRACT_PRICE.VALID_TO.ge(today))))
                .where(searchCondition)
                .orderBy(PRODUCT.NAME.asc(), PRODUCT.ID.asc())
                .fetch(Records.mapping(ProductCatalogItem::new));
    }

}
