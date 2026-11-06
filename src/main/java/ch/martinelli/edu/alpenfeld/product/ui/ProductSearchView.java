package ch.martinelli.edu.alpenfeld.product.ui;

import ch.martinelli.edu.alpenfeld.product.ProductSearchRepository;
import ch.martinelli.edu.alpenfeld.product.ProductSearchResult;
import com.vaadin.flow.component.Key;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.html.H1;
import com.vaadin.flow.component.html.Image;
import com.vaadin.flow.component.html.Span;
import com.vaadin.flow.component.orderedlayout.FlexComponent;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.data.renderer.ComponentRenderer;
import com.vaadin.flow.router.PageTitle;
import com.vaadin.flow.router.Route;
import com.vaadin.flow.router.RouteAlias;

/**
 * UC-001 Find Product.
 */
@PageTitle("Find Product")
@Route("products")
@RouteAlias("")
public class ProductSearchView extends VerticalLayout {

    static final int MIN_SEARCH_TERM_LENGTH = 2;

    private final ProductSearchRepository productSearchRepository;

    private final TextField searchTermField = new TextField("Search term");
    private final Span noMatchMessage = new Span("No Product matches the search term.");
    private final Grid<ProductSearchResult> grid = new Grid<>();

    public ProductSearchView(ProductSearchRepository productSearchRepository) {
        this.productSearchRepository = productSearchRepository;

        setSizeFull();

        searchTermField.setId("search-term");
        searchTermField.setClearButtonVisible(true);
        searchTermField.setWidth("24rem");
        searchTermField.setHelperText("At least %d characters".formatted(MIN_SEARCH_TERM_LENGTH));

        var searchButton = new Button("Search", event -> search());
        searchButton.setId("search-button");
        searchButton.addThemeVariants(ButtonVariant.PRIMARY);
        searchButton.addClickShortcut(Key.ENTER);

        var searchBar = new HorizontalLayout(searchTermField, searchButton);
        searchBar.setDefaultVerticalComponentAlignment(FlexComponent.Alignment.BASELINE);

        noMatchMessage.setId("no-match-message");
        noMatchMessage.setVisible(false);

        configureGrid();

        add(new H1("Find Product"), searchBar, noMatchMessage, grid);
    }

    private void configureGrid() {
        grid.setId("product-grid");
        grid.setSizeFull();
        grid.setVisible(false);

        // UC-001 BR-007: A Product without an image is listed without an image.
        grid.addColumn(new ComponentRenderer<>(product -> {
                    if (product.firstImageUrl() == null) {
                        return new Span();
                    }
                    var image = new Image(product.firstImageUrl(), product.name());
                    image.setHeight("3rem");
                    return image;
                }))
                .setHeader("Image")
                .setAutoWidth(true)
                .setFlexGrow(0);
        grid.addColumn(ProductSearchResult::name).setHeader("Name").setFlexGrow(1);
        grid.addColumn(ProductSearchResult::productNumber).setHeader("Product Number").setAutoWidth(true);
        grid.addColumn(ProductSearchResult::stock).setHeader("Stock").setAutoWidth(true);

        grid.addItemClickListener(event ->
                getUI().ifPresent(ui -> ui.navigate("products/" + event.getItem().id())));
    }

    private void search() {
        // UC-001 BR-001: Leading and trailing spaces do not count towards the minimum length.
        var searchTerm = searchTermField.getValue().trim();

        // UC-001 BR-001: A search term must contain at least 2 characters.
        if (searchTerm.length() < MIN_SEARCH_TERM_LENGTH) {
            searchTermField.setErrorMessage(
                    "The search term must contain at least %d characters.".formatted(MIN_SEARCH_TERM_LENGTH));
            searchTermField.setInvalid(true);
            noMatchMessage.setVisible(false);
            grid.setVisible(false);
            return;
        }
        searchTermField.setInvalid(false);

        int count = productSearchRepository.count(searchTerm);
        noMatchMessage.setVisible(count == 0);
        grid.setVisible(count > 0);
        grid.setItems(
                query -> productSearchRepository.find(searchTerm, query.getOffset(), query.getLimit()).stream(),
                query -> productSearchRepository.count(searchTerm));
    }
}
