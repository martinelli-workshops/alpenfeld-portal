CREATE SEQUENCE portal_user_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE portal_user
(
    id                   BIGINT DEFAULT nextval('portal_user_seq') PRIMARY KEY,
    username             VARCHAR(100) NOT NULL UNIQUE,
    email                VARCHAR(254) NOT NULL CHECK (REGEXP_LIKE(email, '^[^@\s]+@[^@\s]+\.[^@\s]+$')),
    first_name           VARCHAR(100) NOT NULL,
    last_name            VARCHAR(100) NOT NULL,
    role                 VARCHAR(30)  NOT NULL
        CHECK (role IN ('Buyer', 'Purchasing Manager', 'Sales Representative', 'Customer Service')),
    business_customer_id BIGINT REFERENCES business_customer (id),
    order_limit          DECIMAL(10, 2) CHECK (order_limit >= 0),
    language             VARCHAR(2)   NOT NULL CHECK (language IN ('DE', 'FR', 'EN')),
    active               BOOLEAN      NOT NULL,
    CONSTRAINT portal_user_business_customer_by_role_ck CHECK (
        (role IN ('Buyer', 'Purchasing Manager') AND business_customer_id IS NOT NULL)
            OR (role IN ('Sales Representative', 'Customer Service') AND business_customer_id IS NULL)),
    CONSTRAINT portal_user_order_limit_by_role_ck CHECK (
        (role = 'Buyer' AND order_limit IS NOT NULL)
            OR (role <> 'Buyer' AND order_limit IS NULL))
);

ALTER TABLE business_customer
    ADD CONSTRAINT business_customer_sales_representative_fk
        FOREIGN KEY (sales_representative_id) REFERENCES portal_user (id);
