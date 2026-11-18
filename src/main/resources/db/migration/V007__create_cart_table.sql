CREATE SEQUENCE cart_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE cart
(
    id         BIGINT DEFAULT nextval('cart_seq') PRIMARY KEY,
    buyer_id   BIGINT    NOT NULL UNIQUE REFERENCES portal_user (id),
    updated_at TIMESTAMP NOT NULL
);
