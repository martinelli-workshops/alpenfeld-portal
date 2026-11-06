CREATE SEQUENCE sales_representative_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE sales_representative
(
    id    BIGINT DEFAULT nextval('sales_representative_seq') PRIMARY KEY,
    name  VARCHAR(150) NOT NULL,
    email VARCHAR(255) NOT NULL
);
