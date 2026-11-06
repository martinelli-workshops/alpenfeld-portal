package ch.martinelli.edu.alpenfeld.product;

import org.jooq.Condition;
import org.jooq.DSLContext;
import org.jooq.Records;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;

import static ch.martinelli.edu.alpenfeld.db.tables.Product.PRODUCT;
import static ch.martinelli.edu.alpenfeld.db.tables.ProductImage.PRODUCT_IMAGE;
import static ch.martinelli.edu.alpenfeld.db.tables.ProductStock.PRODUCT_STOCK;
import static org.jooq.impl.DSL.and;
import static org.jooq.impl.DSL.field;
import static org.jooq.impl.DSL.or;
import static org.jooq.impl.DSL.select;

/**
 * Data access for UC-001 Find Product.
 */
// UC-001 BR-005: The search reads only the portal's copy of Product data and Stock, never the PIM or the ERP.
@Repository
@Transactional(readOnly = true)
public class ProductSearchRepository {

    private final DSLContext ctx;

    public ProductSearchRepository(DSLContext ctx) {
        this.ctx = ctx;
    }

    public List<ProductSearchResult> find(String searchTerm, int offset, int limit) {
        return ctx.select(
                        PRODUCT.ID,
                        PRODUCT.NAME,
                        PRODUCT.PRODUCT_NUMBER,
                        // UC-001 BR-007: The first image by display order; a Product without an image yields null.
                        field(select(PRODUCT_IMAGE.IMAGE_URL)
                                .from(PRODUCT_IMAGE)
                                .where(PRODUCT_IMAGE.PRODUCT_ID.eq(PRODUCT.ID))
                                .orderBy(PRODUCT_IMAGE.DISPLAY_ORDER, PRODUCT_IMAGE.ID)
                                .limit(1)),
                        PRODUCT_STOCK.QUANTITY)
                .from(PRODUCT)
                .leftJoin(PRODUCT_STOCK).on(PRODUCT_STOCK.PRODUCT_ID.eq(PRODUCT.ID))
                .where(matches(searchTerm))
                // UC-001 BR-006: Ordered by product name ascending.
                .orderBy(PRODUCT.NAME.asc(), PRODUCT.ID.asc())
                .offset(offset)
                .limit(limit)
                .fetch(Records.mapping(ProductSearchResult::new));
    }

    public int count(String searchTerm) {
        return ctx.fetchCount(PRODUCT, matches(searchTerm));
    }

    // UC-001 BR-002: Every word must occur, ignoring case, in the name, description, or product number.
    private Condition matches(String searchTerm) {
        List<Condition> wordConditions = Arrays.stream(searchTerm.trim().split("\\s+"))
                .filter(word -> !word.isEmpty())
                .map(word -> or(
                        PRODUCT.NAME.containsIgnoreCase(word),
                        PRODUCT.DESCRIPTION.containsIgnoreCase(word),
                        PRODUCT.PRODUCT_NUMBER.containsIgnoreCase(word)))
                .toList();
        return and(wordConditions);
    }
}
