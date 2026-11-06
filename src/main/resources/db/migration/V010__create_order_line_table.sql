CREATE SEQUENCE order_line_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE order_line
(
    id         BIGINT DEFAULT nextval('order_line_seq') PRIMARY KEY,
    order_id   BIGINT         NOT NULL,
    product_id BIGINT         NOT NULL,
    quantity   INTEGER        NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_order_line_purchase_order FOREIGN KEY (order_id) REFERENCES purchase_order (id),
    CONSTRAINT fk_order_line_product FOREIGN KEY (product_id) REFERENCES product (id)
);
