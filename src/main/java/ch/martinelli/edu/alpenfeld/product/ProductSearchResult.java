package ch.martinelli.edu.alpenfeld.product;

/**
 * A Product in the result list of the product search (UC-001).
 *
 * @param firstImageUrl {@code null} when the Product has no image
 * @param stock         {@code null} when the portal holds no Stock for the Product
 */
public record ProductSearchResult(long id, String name, String productNumber, String firstImageUrl, Integer stock) {
}
