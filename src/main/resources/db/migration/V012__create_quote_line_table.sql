CREATE SEQUENCE quote_line_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE quote_line
(
    id                    BIGINT DEFAULT nextval('quote_line_seq') PRIMARY KEY,
    quote_id              BIGINT         NOT NULL REFERENCES quote (id),
    quote_request_line_id BIGINT         NOT NULL UNIQUE REFERENCES quote_request_line (id),
    unit_price            DECIMAL(10, 2) NOT NULL CHECK (unit_price BETWEEN 0 AND 99999999.99)
);
