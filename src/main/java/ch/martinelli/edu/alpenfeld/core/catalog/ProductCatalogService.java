package ch.martinelli.edu.alpenfeld.core.catalog;

import java.security.Principal;
import java.time.LocalDate;
import java.util.List;

import com.vaadin.flow.server.VaadinRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProductCatalogService {

    private final ProductCatalogRepository repository;

    public ProductCatalogService(ProductCatalogRepository repository) {
        this.repository = repository;
    }

    @Transactional(readOnly = true)
    public CatalogSearchResult browse(String searchTerm) {
        VaadinRequest request = VaadinRequest.getCurrent();
        Principal principal = request == null ? null : request.getUserPrincipal();
        if (principal == null || principal.getName() == null || principal.getName().isBlank()) {
            throw new SecurityException("An authenticated Buyer is required.");
        }

        String email = principal.getName();
        BuyerContext buyer = repository.findActiveBuyerByEmail(email)
                .orElseThrow(() -> new SecurityException("The authenticated account is not an active Buyer."));

        if (!repository.hasProducts()) {
            return new CatalogSearchResult(false, List.of());
        }

        return new CatalogSearchResult(true,
                repository.searchProducts(searchTerm.strip(), buyer.customerId(), LocalDate.now()));
    }

}
