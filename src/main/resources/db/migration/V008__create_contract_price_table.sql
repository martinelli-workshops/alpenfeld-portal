CREATE SEQUENCE contract_price_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE contract_price
(
    id                   BIGINT DEFAULT nextval('contract_price_seq') PRIMARY KEY,
    business_customer_id BIGINT         NOT NULL,
    product_id           BIGINT         NOT NULL,
    unit_price           DECIMAL(10, 2) NOT NULL,
    synchronized_at      TIMESTAMP      NOT NULL,
    CONSTRAINT fk_contract_price_business_customer FOREIGN KEY (business_customer_id) REFERENCES business_customer (id),
    CONSTRAINT fk_contract_price_product FOREIGN KEY (product_id) REFERENCES product (id),
    CONSTRAINT uk_contract_price_customer_product UNIQUE (business_customer_id, product_id)
);
