CREATE TABLE product_stock
(
    product_id      BIGINT    NOT NULL PRIMARY KEY,
    quantity        INTEGER   NOT NULL,
    synchronized_at TIMESTAMP NOT NULL,
    CONSTRAINT fk_product_stock_product FOREIGN KEY (product_id) REFERENCES product (id)
);
