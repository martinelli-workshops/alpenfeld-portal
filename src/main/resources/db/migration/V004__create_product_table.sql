CREATE SEQUENCE product_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE product
(
    id                      BIGINT DEFAULT nextval('product_seq') PRIMARY KEY,
    article_number          VARCHAR(50)    NOT NULL UNIQUE,
    name                    VARCHAR(200)   NOT NULL,
    description             VARCHAR(4000),
    technical_data          VARCHAR(4000),
    keywords                VARCHAR(500),
    category_id             BIGINT         NOT NULL REFERENCES category (id),
    list_price              DECIMAL(10, 2) NOT NULL CHECK (list_price BETWEEN 0 AND 99999999.99),
    stock                   INTEGER        NOT NULL CHECK (stock >= 0),
    product_synchronized_at TIMESTAMP      NOT NULL,
    stock_synchronized_at   TIMESTAMP
);
