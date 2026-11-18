CREATE SEQUENCE business_customer_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE business_customer
(
    id                      BIGINT DEFAULT nextval('business_customer_seq') PRIMARY KEY,
    customer_number         VARCHAR(20)  NOT NULL UNIQUE,
    name                    VARCHAR(200) NOT NULL,
    -- Foreign key to portal_user is added in V002 (circular reference)
    sales_representative_id BIGINT
);
