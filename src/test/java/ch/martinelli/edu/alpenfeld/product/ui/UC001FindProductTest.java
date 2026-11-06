package ch.martinelli.edu.alpenfeld.product.ui;

import ch.martinelli.edu.alpenfeld.core.ui.AlpenfeldBrowserlessTest;
import ch.martinelli.edu.alpenfeld.product.ProductSearchResult;
import ch.martinelli.edu.alpenfeld.usecase.UseCase;
import com.vaadin.flow.component.Key;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.html.Image;
import com.vaadin.flow.component.html.Span;
import com.vaadin.flow.component.textfield.TextField;
import org.jooq.DSLContext;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.stream.IntStream;

import static ch.martinelli.edu.alpenfeld.db.tables.ContractPrice.CONTRACT_PRICE;
import static ch.martinelli.edu.alpenfeld.db.tables.Product.PRODUCT;
import static ch.martinelli.edu.alpenfeld.db.tables.ProductImage.PRODUCT_IMAGE;
import static ch.martinelli.edu.alpenfeld.db.tables.ProductStock.PRODUCT_STOCK;
import static org.assertj.core.api.Assertions.assertThat;

/**
 * Use case test for UC-001 "Find Product".
 */
class UC001FindProductTest extends AlpenfeldBrowserlessTest {

    private static final int IMAGE_COLUMN = 0;
    private static final int NAME_COLUMN = 1;
    private static final int PRODUCT_NUMBER_COLUMN = 2;
    private static final int STOCK_COLUMN = 3;

    @Autowired
    private DSLContext ctx;

    private TextField searchTermField;

    @BeforeEach
    void openProductSearch() {
        navigate(ProductSearchView.class);

        searchTermField = $view(TextField.class).withCaption("Search term").single();
    }

    @Test
    @UseCase(id = "UC-001")
    void product_search_is_opened_without_results() {
        assertThat(searchTermField.getValue()).isEmpty();
        assertThat(gridIsVisible()).isFalse();
        assertThat(noMatchMessageIsVisible()).isFalse();
    }

    @Test
    @UseCase(id = "UC-001", businessRules = {"BR-002", "BR-006", "BR-007"})
    void matching_products_are_displayed_with_name_product_number_first_image_and_stock() {
        search("edelweiss");

        assertThat(gridIsVisible()).isTrue();
        assertThat(noMatchMessageIsVisible()).isFalse();
        assertThat(test(grid()).size()).isEqualTo(2);

        assertThat(test(grid()).getHeaderCell(IMAGE_COLUMN)).isEqualTo("Image");
        assertThat(test(grid()).getHeaderCell(NAME_COLUMN)).isEqualTo("Name");
        assertThat(test(grid()).getHeaderCell(PRODUCT_NUMBER_COLUMN)).isEqualTo("Product Number");
        assertThat(test(grid()).getHeaderCell(STOCK_COLUMN)).isEqualTo("Stock");

        assertThat(test(grid()).getCellText(0, NAME_COLUMN)).isEqualTo("Alpine Rope 50m");
        assertThat(test(grid()).getCellText(0, PRODUCT_NUMBER_COLUMN)).isEqualTo("AF-1002");
        assertThat(test(grid()).getCellText(0, STOCK_COLUMN)).isEqualTo("5");

        assertThat(test(grid()).getCellText(1, NAME_COLUMN)).isEqualTo("Edelweiss Hiking Boot");
        assertThat(test(grid()).getCellText(1, PRODUCT_NUMBER_COLUMN)).isEqualTo("AF-1001");
        assertThat(test(grid()).getCellText(1, STOCK_COLUMN)).isEqualTo("12");
    }

    @Test
    @UseCase(id = "UC-001", businessRules = {"BR-002"})
    void search_term_matches_the_name_ignoring_case() {
        search("HELMET");

        assertThat(names()).containsExactly("Bergsteiger Helmet");
    }

    @Test
    @UseCase(id = "UC-001", businessRules = {"BR-002"})
    void search_term_matches_the_description() {
        search("lightweight");

        assertThat(names()).containsExactly("Bergsteiger Helmet");
    }

    @Test
    @UseCase(id = "UC-001", businessRules = {"BR-002"})
    void search_term_matches_the_product_number_ignoring_case() {
        search("af-1003");

        assertThat(names()).containsExactly("Bergsteiger Helmet");
    }

    @Test
    @UseCase(id = "UC-001", businessRules = {"BR-002"})
    void every_word_must_match_in_any_order_and_in_different_fields() {
        // "leather" occurs only in the description, "edelweiss" in the name of AF-1001
        // and in the description of AF-1002
        search("LEATHER edelweiss");

        assertThat(names()).containsExactly("Edelweiss Hiking Boot");
    }

    @Test
    @UseCase(id = "UC-001", businessRules = {"BR-006"})
    void result_list_is_ordered_by_product_name_ascending() {
        search("af-100");

        assertThat(names()).containsExactly("Alpine Rope 50m", "Bergsteiger Helmet", "Edelweiss Hiking Boot");
    }

    @Test
    @UseCase(id = "UC-001", businessRules = {"BR-007"})
    void product_is_displayed_with_its_first_image() {
        search("af-1001");

        Image image = (Image) test(grid()).getCellComponent(0, IMAGE_COLUMN);
        assertThat(image.getSrc()).isEqualTo("https://images.example.com/af-1001-front.jpg");
        assertThat(image.getAlt()).hasValue("Edelweiss Hiking Boot");
    }

    @Test
    @UseCase(id = "UC-001", businessRules = {"BR-007"})
    void product_without_image_is_listed_without_image() {
        search("af-1002");

        assertThat(names()).containsExactly("Alpine Rope 50m");
        assertThat(test(grid()).getCellComponent(0, IMAGE_COLUMN)).isNotInstanceOf(Image.class);
    }

    @Test
    @UseCase(id = "UC-001")
    void search_is_started_with_enter() {
        test(searchTermField).setValue("helmet");
        fireShortcut(Key.ENTER);

        assertThat(names()).containsExactly("Bergsteiger Helmet");
    }

    @Test
    @UseCase(id = "UC-001")
    void selecting_a_product_opens_its_details() {
        search("af-1003");

        test(grid()).clickRow(0);

        assertThat(UI.getCurrent().getActiveViewLocation().getPath()).isEqualTo("products/1003");
    }

    @Test
    @UseCase(id = "UC-001", scenario = "A1: Search Term Too Short", businessRules = {"BR-001"})
    void search_term_with_fewer_than_two_characters_is_rejected() {
        search("e");

        assertThat(searchTermField.isInvalid()).isTrue();
        assertThat(searchTermField.getErrorMessage())
                .isEqualTo("The search term must contain at least 2 characters.");
        assertThat(gridIsVisible()).isFalse();
        assertThat(noMatchMessageIsVisible()).isFalse();
    }

    @Test
    @UseCase(id = "UC-001", scenario = "A1: Search Term Too Short", businessRules = {"BR-001"})
    void blanks_do_not_count_towards_the_minimum_length() {
        search("  e  ");

        assertThat(searchTermField.isInvalid()).isTrue();
        assertThat(gridIsVisible()).isFalse();
    }

    @Test
    @UseCase(id = "UC-001", businessRules = {"BR-001"})
    void leading_and_trailing_blanks_are_ignored_for_an_accepted_search_term() {
        search("  50  ");

        assertThat(searchTermField.isInvalid()).isFalse();
        assertThat(names()).containsExactly("Alpine Rope 50m");
    }

    @Test
    @UseCase(id = "UC-001", scenario = "A1: Search Term Too Short", businessRules = {"BR-001"})
    void search_term_with_two_characters_is_accepted_and_buyer_continues_at_step_2() {
        search("e");
        search("50");

        assertThat(searchTermField.isInvalid()).isFalse();
        assertThat(names()).containsExactly("Alpine Rope 50m");
    }

    @Test
    @UseCase(id = "UC-001", scenario = "A2: No Matching Products", businessRules = {"BR-002"})
    void buyer_is_informed_when_no_product_matches() {
        search("snowboard");

        assertThat(noMatchMessageIsVisible()).isTrue();
        assertThat($view(Span.class).id("no-match-message").getText()).isEqualTo("No Product matches the search term.");
        assertThat(gridIsVisible()).isFalse();
    }

    @Test
    @UseCase(id = "UC-001", scenario = "A2: No Matching Products", businessRules = {"BR-002"})
    void no_product_matches_when_one_word_does_not_occur() {
        search("rope boot");

        assertThat(noMatchMessageIsVisible()).isTrue();
        assertThat(gridIsVisible()).isFalse();
    }

    @Test
    @UseCase(id = "UC-001", scenario = "A2: No Matching Products")
    void buyer_enters_a_different_search_term_after_no_match() {
        search("snowboard");
        search("helmet");

        assertThat(noMatchMessageIsVisible()).isFalse();
        assertThat(names()).containsExactly("Bergsteiger Helmet");
    }

    @Test
    @UseCase(id = "UC-001", scenario = "A2: No Matching Products")
    void search_changes_no_product_data_contract_price_or_stock() {
        var before = snapshotOfCopiedData();

        search("edelweiss");
        search("snowboard");

        assertThat(snapshotOfCopiedData()).isEqualTo(before);
    }

    @Test
    @UseCase(id = "UC-001", scenario = "A4: Buyer Does Not Select a Product")
    void buyer_refines_the_search_term() {
        search("edelweiss");
        assertThat(test(grid()).size()).isEqualTo(2);

        search("edelweiss boot");

        assertThat(names()).containsExactly("Edelweiss Hiking Boot");
    }

    private void search(String searchTerm) {
        test(searchTermField).setValue(searchTerm);
        test($view(Button.class).id("search-button")).click();
    }

    @SuppressWarnings("unchecked")
    private Grid<ProductSearchResult> grid() {
        return $view(Grid.class).id("product-grid");
    }

    // The component query finds only visible components
    private boolean gridIsVisible() {
        return $view(Grid.class).withId("product-grid").exists();
    }

    private boolean noMatchMessageIsVisible() {
        return $view(Span.class).withId("no-match-message").exists();
    }

    private List<String> snapshotOfCopiedData() {
        return List.of(
                ctx.selectFrom(PRODUCT).orderBy(PRODUCT.ID).fetch().formatCSV(),
                ctx.selectFrom(PRODUCT_IMAGE).orderBy(PRODUCT_IMAGE.ID).fetch().formatCSV(),
                ctx.selectFrom(PRODUCT_STOCK).orderBy(PRODUCT_STOCK.PRODUCT_ID).fetch().formatCSV(),
                ctx.selectFrom(CONTRACT_PRICE).orderBy(CONTRACT_PRICE.ID).fetch().formatCSV());
    }

    private List<String> names() {
        return IntStream.range(0, test(grid()).size())
                .mapToObj(row -> test(grid()).getCellText(row, NAME_COLUMN))
                .toList();
    }
}
