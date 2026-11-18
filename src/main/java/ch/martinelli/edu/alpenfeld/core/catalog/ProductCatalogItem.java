package ch.martinelli.edu.alpenfeld.core.catalog;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record ProductCatalogItem(
        Long id,
        String name,
        String description,
        BigDecimal contractPrice,
        LocalDateTime contractPriceSynchronizedAt,
        Integer stockQuantity,
        LocalDateTime stockSynchronizedAt,
        LocalDateTime productSynchronizedAt) {
}
