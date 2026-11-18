CREATE SEQUENCE cart_line_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE cart_line
(
    id         BIGINT DEFAULT nextval('cart_line_seq') PRIMARY KEY,
    cart_id    BIGINT  NOT NULL REFERENCES cart (id),
    product_id BIGINT  NOT NULL REFERENCES product (id),
    quantity   INTEGER NOT NULL CHECK (quantity BETWEEN 1 AND 99999),
    CONSTRAINT cart_line_cart_product_uk UNIQUE (cart_id, product_id)
);
