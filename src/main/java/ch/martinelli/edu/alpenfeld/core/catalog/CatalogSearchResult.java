package ch.martinelli.edu.alpenfeld.core.catalog;

import java.util.List;

public record CatalogSearchResult(boolean catalogAvailable, List<ProductCatalogItem> products) {

    public CatalogSearchResult {
        products = List.copyOf(products);
    }

}
