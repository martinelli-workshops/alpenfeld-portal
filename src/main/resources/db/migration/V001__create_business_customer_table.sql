CREATE SEQUENCE business_customer_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE business_customer
(
    id                     BIGINT DEFAULT nextval('business_customer_seq') PRIMARY KEY,
    erp_customer_reference VARCHAR(100) NOT NULL UNIQUE,
    name                   VARCHAR(255) NOT NULL,
    approval_limit         DECIMAL(10, 2)
);
