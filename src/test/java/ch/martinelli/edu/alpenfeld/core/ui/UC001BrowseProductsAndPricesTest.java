package ch.martinelli.edu.alpenfeld.core.ui;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.util.Locale;
import java.util.Optional;

import ch.martinelli.edu.alpenfeld.core.catalog.CurrentBuyerIdentity;
import ch.martinelli.edu.alpenfeld.core.catalog.ProductCatalogItem;
import ch.martinelli.edu.alpenfeld.usecase.UseCase;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.html.Paragraph;
import com.vaadin.flow.component.html.Span;
import com.vaadin.flow.component.textfield.TextField;
import org.jooq.DSLContext;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.Primary;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.jdbc.Sql;

import static ch.martinelli.edu.alpenfeld.db.Tables.CUSTOMER_ORDER;
import static ch.martinelli.edu.alpenfeld.db.Tables.PRODUCT;
import static ch.martinelli.edu.alpenfeld.db.Tables.QUOTE_REQUEST;
import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@Import(UC001BrowseProductsAndPricesTest.BuyerIdentityTestConfiguration.class)
class UC001BrowseProductsAndPricesTest extends AlpenfeldBrowserlessTest {

    private static final String BUYER_EMAIL = "buyer@example.test";

    @Autowired
    private DSLContext dsl;

    @Test
    @UseCase(id = "UC-001")
    void buyer_can_search_and_review_product_details() {
        navigate(ProductCatalogView.class);

        Grid<ProductCatalogItem> grid = $(Grid.class).single();
        assertThat(test(grid).size()).isEqualTo(4);
        assertThat(test(grid).getCellText(0, 0)).isEqualTo("Impact Driver");

        selectProduct(grid, 0);

        assertThat(paragraphContaining("Precision driver for workshop use")).isPresent();
        assertThat(paragraphContaining("Contract price: 125.50")).isPresent();
        assertThat(paragraphContaining("Stock: 17")).isPresent();
    }

    @Test
    @UseCase(id = "UC-001", scenario = "A1: No Matching Products")
    void buyer_can_change_search_after_no_matches() {
        navigate(ProductCatalogView.class);

        TextField search = $(TextField.class).withCaption("Search products").single();
        test(search).setValue("not-a-product");

        assertThat($(Span.class).withText("No products match your search.").single().isVisible()).isTrue();
        assertThat(test($(Grid.class).single()).size()).isZero();

        test(search).setValue("precision");

        assertThat(test($(Grid.class).single()).size()).isEqualTo(1);
        assertThat(test($(Grid.class).single()).getCellText(0, 0)).isEqualTo("Impact Driver");
    }

    @Test
    @UseCase(id = "UC-001", scenario = "A2: No Applicable Contract Price", businessRules = {"BR-001"})
    void expired_price_is_not_shown() {
        navigate(ProductCatalogView.class);

        Grid<ProductCatalogItem> grid = $(Grid.class).single();
        selectProduct(grid, 2);

        assertThat(paragraphContaining("No contract price is available for this Product.")).isPresent();
        assertThat(paragraphContaining("Stock: 0")).isPresent();
        assertThat(paragraphContaining("Contract price: 99.00")).isEmpty();
    }

    @Test
    @UseCase(id = "UC-001", scenario = "A3: Stock Information Unavailable")
    void product_without_stock_displays_other_available_details() {
        navigate(ProductCatalogView.class);

        Grid<ProductCatalogItem> grid = $(Grid.class).single();
        selectProduct(grid, 1);

        assertThat(paragraphContaining("Stock information is unavailable.")).isPresent();
        assertThat(paragraphContaining("Contract price: 240.00")).isPresent();
    }

    @Test
    @UseCase(id = "UC-001", scenario = "A4: Product Catalog Unavailable")
    @Sql(statements = {
            "DELETE FROM contract_price",
            "DELETE FROM product_stock",
            "DELETE FROM product"
    })
    @DirtiesContext(methodMode = DirtiesContext.MethodMode.AFTER_METHOD)
    void empty_catalog_is_reported_as_unavailable() {
        navigate(ProductCatalogView.class);

        assertThat($(Span.class).withText("The product catalog is unavailable.").single().isVisible()).isTrue();
        assertThat(test($(Grid.class).single()).size()).isZero();
    }

    @Test
    @UseCase(id = "UC-001", scenario = "A5: No Product Meets the Buyer's Need")
    void browsing_does_not_create_orders_or_quote_requests() {
        int productsBeforeBrowsing = dsl.fetchCount(PRODUCT);

        navigate(ProductCatalogView.class);

        assertThat(dsl.fetchCount(PRODUCT)).isEqualTo(productsBeforeBrowsing);
        assertThat(dsl.fetchCount(CUSTOMER_ORDER)).isZero();
        assertThat(dsl.fetchCount(QUOTE_REQUEST)).isZero();
    }

    @Test
    @UseCase(id = "UC-001", scenario = "A6: A Data Item Is Updated While the Buyer Is Browsing",
            businessRules = {"BR-002"})
    void each_displayed_value_uses_its_own_synchronization_time() {
        navigate(ProductCatalogView.class);

        Grid<ProductCatalogItem> grid = $(Grid.class).single();
        selectProduct(grid, 0);

        assertThat(paragraphContaining("Product data synchronized: "
                + formatDateTime(LocalDateTime.of(2026, 11, 18, 8, 0)))).isPresent();
        assertThat(paragraphContaining("Contract price synchronized: "
                + formatDateTime(LocalDateTime.of(2026, 11, 18, 8, 5)))).isPresent();
        assertThat(paragraphContaining("Stock synchronized: "
                + formatDateTime(LocalDateTime.of(2026, 11, 18, 8, 10)))).isPresent();
    }

    @Test
    @UseCase(id = "UC-001", businessRules = {"BR-001"})
    void contract_price_is_customer_specific_and_date_boundaries_are_inclusive() {
        navigate(ProductCatalogView.class);

        Grid<ProductCatalogItem> grid = $(Grid.class).single();
        selectProduct(grid, 0);
        assertThat(paragraphContaining("Contract price: 125.50")).isPresent();
        assertThat(paragraphContaining("Contract price: 999.99")).isEmpty();

        selectProduct(grid, 1);
        assertThat(paragraphContaining("Contract price: 240.00")).isPresent();

        selectProduct(grid, 3);
        assertThat(paragraphContaining("Contract price: 15.75")).isPresent();
    }

    private void selectProduct(Grid<ProductCatalogItem> grid, int row) {
        ProductCatalogItem product = test(grid).getRow(row);
        grid.select(product);
    }

    private Optional<Paragraph> paragraphContaining(String text) {
        var matches = $(Paragraph.class).withTextContaining(text).all();
        return matches.stream().findFirst();
    }

    private String formatDateTime(LocalDateTime value) {
        return DateTimeFormatter.ofLocalizedDateTime(FormatStyle.MEDIUM)
                .withLocale(Locale.ENGLISH)
                .format(value);
    }

    @TestConfiguration(proxyBeanMethods = false)
    static class BuyerIdentityTestConfiguration {

        @Bean
        @Primary
        CurrentBuyerIdentity testBuyerIdentity() {
            return () -> Optional.of(BUYER_EMAIL);
        }

    }

}
