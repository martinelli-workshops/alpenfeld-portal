package ch.martinelli.edu.alpenfeld.core.catalog;

import java.util.Optional;

@FunctionalInterface
public interface CurrentBuyerIdentity {

    Optional<String> email();

}
