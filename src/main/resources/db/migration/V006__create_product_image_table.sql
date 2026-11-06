CREATE SEQUENCE product_image_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE product_image
(
    id            BIGINT DEFAULT nextval('product_image_seq') PRIMARY KEY,
    product_id    BIGINT       NOT NULL,
    image_url     VARCHAR(500) NOT NULL,
    display_order INTEGER      NOT NULL,
    CONSTRAINT fk_product_image_product FOREIGN KEY (product_id) REFERENCES product (id)
);
