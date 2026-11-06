CREATE TABLE order_approval
(
    order_id              BIGINT      NOT NULL PRIMARY KEY,
    purchasing_manager_id BIGINT      NOT NULL,
    status                VARCHAR(50) NOT NULL,
    decided_at            TIMESTAMP,
    CONSTRAINT fk_order_approval_purchase_order FOREIGN KEY (order_id) REFERENCES purchase_order (id),
    CONSTRAINT fk_order_approval_purchasing_manager FOREIGN KEY (purchasing_manager_id) REFERENCES purchasing_manager (id)
);
