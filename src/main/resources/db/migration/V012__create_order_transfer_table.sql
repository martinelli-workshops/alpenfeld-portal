CREATE TABLE order_transfer
(
    order_id            BIGINT       NOT NULL PRIMARY KEY,
    idempotency_key     VARCHAR(100) NOT NULL UNIQUE,
    status              VARCHAR(50)  NOT NULL,
    erp_order_reference VARCHAR(100) UNIQUE,
    last_attempt_at     TIMESTAMP,
    CONSTRAINT fk_order_transfer_purchase_order FOREIGN KEY (order_id) REFERENCES purchase_order (id)
);
