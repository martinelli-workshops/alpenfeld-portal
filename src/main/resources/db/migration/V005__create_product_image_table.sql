CREATE SEQUENCE product_image_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE product_image
(
    id         BIGINT DEFAULT nextval('product_image_seq') PRIMARY KEY,
    product_id BIGINT       NOT NULL REFERENCES product (id),
    file_name  VARCHAR(255) NOT NULL,
    alt_text   VARCHAR(255),
    sort_order INTEGER      NOT NULL,
    CONSTRAINT product_image_product_sort_order_uk UNIQUE (product_id, sort_order)
);
