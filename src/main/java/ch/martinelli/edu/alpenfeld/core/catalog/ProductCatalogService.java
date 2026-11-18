package ch.martinelli.edu.alpenfeld.core.catalog;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProductCatalogService {

    private final ProductCatalogRepository repository;
    private final CurrentBuyerIdentity currentBuyerIdentity;

    public ProductCatalogService(ProductCatalogRepository repository, CurrentBuyerIdentity currentBuyerIdentity) {
        this.repository = repository;
        this.currentBuyerIdentity = currentBuyerIdentity;
    }

    @Transactional(readOnly = true)
    public CatalogSearchResult browse(String searchTerm) {
        String email = currentBuyerIdentity.email()
                .filter(value -> !value.isBlank())
                .orElseThrow(() -> new SecurityException("An authenticated Buyer is required."));
        BuyerContext buyer = repository.findActiveBuyerByEmail(email)
                .orElseThrow(() -> new SecurityException("The authenticated account is not an active Buyer."));

        if (!repository.hasProducts()) {
            return new CatalogSearchResult(false, List.of());
        }

        return new CatalogSearchResult(true,
                repository.searchProducts(searchTerm.strip(), buyer.customerId(), LocalDate.now()));
    }

}
