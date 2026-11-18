package ch.martinelli.edu.alpenfeld.core.ui.security;

import java.security.Principal;
import java.util.Optional;

import ch.martinelli.edu.alpenfeld.core.catalog.CurrentBuyerIdentity;
import com.vaadin.flow.server.VaadinRequest;
import org.springframework.stereotype.Component;

@Component
public class VaadinRequestBuyerIdentity implements CurrentBuyerIdentity {

    @Override
    public Optional<String> email() {
        VaadinRequest request = VaadinRequest.getCurrent();
        Principal principal = request == null ? null : request.getUserPrincipal();
        String email = principal == null ? null : principal.getName();
        return Optional.ofNullable(email).filter(value -> !value.isBlank());
    }

}
