CREATE SEQUENCE quote_request_line_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE quote_request_line
(
    id               BIGINT DEFAULT nextval('quote_request_line_seq') PRIMARY KEY,
    quote_request_id BIGINT  NOT NULL REFERENCES quote_request (id),
    product_id       BIGINT  NOT NULL REFERENCES product (id),
    quantity         INTEGER NOT NULL CHECK (quantity BETWEEN 1 AND 99999),
    CONSTRAINT quote_request_line_request_product_uk UNIQUE (quote_request_id, product_id)
);
