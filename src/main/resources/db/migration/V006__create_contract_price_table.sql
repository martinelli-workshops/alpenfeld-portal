CREATE SEQUENCE contract_price_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE contract_price
(
    id                   BIGINT DEFAULT nextval('contract_price_seq') PRIMARY KEY,
    business_customer_id BIGINT         NOT NULL REFERENCES business_customer (id),
    product_id           BIGINT         NOT NULL REFERENCES product (id),
    price                DECIMAL(10, 2) NOT NULL CHECK (price BETWEEN 0 AND 99999999.99),
    last_synchronized_at TIMESTAMP      NOT NULL,
    CONSTRAINT contract_price_customer_product_uk UNIQUE (business_customer_id, product_id)
);
