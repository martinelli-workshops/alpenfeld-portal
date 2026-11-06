CREATE SEQUENCE purchasing_manager_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE purchasing_manager
(
    id                   BIGINT DEFAULT nextval('purchasing_manager_seq') PRIMARY KEY,
    business_customer_id BIGINT       NOT NULL,
    name                 VARCHAR(150) NOT NULL,
    email                VARCHAR(255) NOT NULL,
    active               BOOLEAN      NOT NULL,
    CONSTRAINT fk_purchasing_manager_business_customer FOREIGN KEY (business_customer_id) REFERENCES business_customer (id)
);
