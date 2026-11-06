CREATE SEQUENCE buyer_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE buyer
(
    id                   BIGINT DEFAULT nextval('buyer_seq') PRIMARY KEY,
    business_customer_id BIGINT       NOT NULL,
    name                 VARCHAR(150) NOT NULL,
    email                VARCHAR(255) NOT NULL,
    active               BOOLEAN      NOT NULL,
    CONSTRAINT fk_buyer_business_customer FOREIGN KEY (business_customer_id) REFERENCES business_customer (id)
);
