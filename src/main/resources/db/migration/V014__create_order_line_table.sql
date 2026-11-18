CREATE SEQUENCE order_line_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE order_line
(
    id         BIGINT DEFAULT nextval('order_line_seq') PRIMARY KEY,
    order_id   BIGINT         NOT NULL REFERENCES customer_order (id),
    product_id BIGINT         NOT NULL REFERENCES product (id),
    quantity   INTEGER        NOT NULL CHECK (quantity BETWEEN 1 AND 99999),
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price BETWEEN 0 AND 99999999.99),
    CONSTRAINT order_line_order_product_uk UNIQUE (order_id, product_id)
);
