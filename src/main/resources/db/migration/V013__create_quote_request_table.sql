CREATE SEQUENCE quote_request_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE quote_request
(
    id           BIGINT DEFAULT nextval('quote_request_seq') PRIMARY KEY,
    buyer_id     BIGINT      NOT NULL,
    product_id   BIGINT      NOT NULL,
    quantity     INTEGER     NOT NULL,
    submitted_at TIMESTAMP   NOT NULL,
    status       VARCHAR(50) NOT NULL,
    CONSTRAINT fk_quote_request_buyer FOREIGN KEY (buyer_id) REFERENCES buyer (id),
    CONSTRAINT fk_quote_request_product FOREIGN KEY (product_id) REFERENCES product (id)
);
