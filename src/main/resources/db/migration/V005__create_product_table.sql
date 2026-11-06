CREATE SEQUENCE product_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE product
(
    id                    BIGINT DEFAULT nextval('product_seq') PRIMARY KEY,
    pim_product_reference VARCHAR(100) NOT NULL UNIQUE,
    product_number        VARCHAR(10)  NOT NULL UNIQUE,
    name                  VARCHAR(255) NOT NULL,
    description           VARCHAR(500),
    synchronized_at       TIMESTAMP    NOT NULL
);
