package ch.martinelli.edu.alpenfeld.core.ui;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.util.Locale;

import ch.martinelli.edu.alpenfeld.core.catalog.CatalogSearchResult;
import ch.martinelli.edu.alpenfeld.core.catalog.ProductCatalogItem;
import ch.martinelli.edu.alpenfeld.core.catalog.ProductCatalogService;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.html.H2;
import com.vaadin.flow.component.html.Paragraph;
import com.vaadin.flow.component.html.Span;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.data.value.ValueChangeMode;
import com.vaadin.flow.router.PageTitle;
import com.vaadin.flow.router.Route;

@Route("products")
@PageTitle("Browse Products and Prices")
public class ProductCatalogView extends VerticalLayout {

    private final ProductCatalogService catalogService;
    private final TextField searchField = new TextField("Search products");
    private final Grid<ProductCatalogItem> productsGrid = new Grid<>();
    private final Span catalogUnavailable = new Span("The product catalog is unavailable.");
    private final Span noMatchingProducts = new Span("No products match your search.");
    private final VerticalLayout productDetails = new VerticalLayout();

    public ProductCatalogView(ProductCatalogService catalogService) {
        this.catalogService = catalogService;

        setSizeFull();
        setPadding(true);
        setSpacing(true);

        searchField.setClearButtonVisible(true);
        searchField.setValueChangeMode(ValueChangeMode.LAZY);
        searchField.addValueChangeListener(event -> refreshProducts(event.getValue()));

        productsGrid.addColumn(ProductCatalogItem::name)
                .setHeader("Product")
                .setAutoWidth(true)
                .setFlexGrow(1);
        productsGrid.setSelectionMode(Grid.SelectionMode.SINGLE);
        productsGrid.addSelectionListener(event -> event.getFirstSelectedItem()
                .ifPresentOrElse(this::showProductDetails, productDetails::removeAll));
        productsGrid.setWidthFull();

        catalogUnavailable.setVisible(false);
        noMatchingProducts.setVisible(false);
        productDetails.setPadding(false);

        add(new H2("Browse Products and Prices"), searchField, catalogUnavailable, noMatchingProducts,
                productsGrid, productDetails);
        refreshProducts("");
    }

    private void refreshProducts(String searchTerm) {
        CatalogSearchResult result = catalogService.browse(searchTerm);
        productsGrid.setItems(result.products());
        catalogUnavailable.setVisible(!result.catalogAvailable());
        noMatchingProducts.setVisible(result.catalogAvailable() && result.products().isEmpty());
        productDetails.removeAll();
    }

    // UC-001 BR-002: Display each value with its own synchronization time.
    private void showProductDetails(ProductCatalogItem product) {
        productDetails.removeAll();
        productDetails.add(new H2(product.name()));

        if (product.description() != null && !product.description().isBlank()) {
            productDetails.add(new Paragraph(product.description()));
        }

        addContractPriceDetails(product);
        addStockDetails(product);
        productDetails.add(new Paragraph("Product data synchronized: "
                + formatDateTime(product.productSynchronizedAt())));
    }

    // UC-001 BR-001: Do not substitute a list price for a missing contract price.
    private void addContractPriceDetails(ProductCatalogItem product) {
        if (product.contractPrice() == null) {
            productDetails.add(new Paragraph("No contract price is available for this Product."));
            return;
        }

        productDetails.add(new Paragraph("Contract price: " + product.contractPrice().toPlainString()));
        productDetails.add(new Paragraph("Contract price synchronized: "
                + formatDateTime(product.contractPriceSynchronizedAt())));
    }

    private void addStockDetails(ProductCatalogItem product) {
        if (product.stockQuantity() == null) {
            productDetails.add(new Paragraph("Stock information is unavailable."));
            return;
        }

        productDetails.add(new Paragraph("Stock: " + product.stockQuantity()));
        productDetails.add(new Paragraph("Stock synchronized: "
                + formatDateTime(product.stockSynchronizedAt())));
    }

    private String formatDateTime(LocalDateTime value) {
        return DateTimeFormatter.ofLocalizedDateTime(FormatStyle.MEDIUM)
                .withLocale(Locale.getDefault())
                .format(value);
    }

}
