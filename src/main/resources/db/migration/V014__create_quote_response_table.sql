CREATE SEQUENCE quote_response_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE quote_response
(
    id                      BIGINT DEFAULT nextval('quote_response_seq') PRIMARY KEY,
    quote_request_id        BIGINT         NOT NULL,
    sales_representative_id BIGINT         NOT NULL,
    quoted_unit_price       DECIMAL(10, 2) NOT NULL,
    response_text           VARCHAR(500),
    responded_at            TIMESTAMP      NOT NULL,
    CONSTRAINT fk_quote_response_quote_request FOREIGN KEY (quote_request_id) REFERENCES quote_request (id),
    CONSTRAINT fk_quote_response_sales_representative FOREIGN KEY (sales_representative_id) REFERENCES sales_representative (id)
);
