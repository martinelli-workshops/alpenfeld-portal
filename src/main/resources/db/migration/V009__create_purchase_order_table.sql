-- Entity ORDER; named purchase_order because ORDER is a reserved SQL keyword
CREATE SEQUENCE purchase_order_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE purchase_order
(
    id           BIGINT DEFAULT nextval('purchase_order_seq') PRIMARY KEY,
    buyer_id     BIGINT      NOT NULL,
    submitted_at TIMESTAMP   NOT NULL,
    status       VARCHAR(50) NOT NULL,
    CONSTRAINT fk_purchase_order_buyer FOREIGN KEY (buyer_id) REFERENCES buyer (id)
);
