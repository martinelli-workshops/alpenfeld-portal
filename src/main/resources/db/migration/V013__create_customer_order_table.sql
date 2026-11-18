CREATE SEQUENCE customer_order_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE customer_order
(
    id                       BIGINT DEFAULT nextval('customer_order_seq') PRIMARY KEY,
    order_number             VARCHAR(20)    NOT NULL UNIQUE,
    business_customer_id     BIGINT         NOT NULL REFERENCES business_customer (id),
    buyer_id                 BIGINT         NOT NULL REFERENCES portal_user (id),
    quote_id                 BIGINT REFERENCES quote (id),
    status                   VARCHAR(20)    NOT NULL
        CHECK (status IN ('Pending Approval', 'Rejected', 'Placed', 'Transferred')),
    total                    DECIMAL(10, 2) NOT NULL CHECK (total BETWEEN 0 AND 99999999.99),
    ordered_at               TIMESTAMP      NOT NULL,
    approver_id              BIGINT REFERENCES portal_user (id),
    approval_decided_at      TIMESTAMP,
    rejection_reason         VARCHAR(500),
    transfer_attempts        INTEGER        NOT NULL CHECK (transfer_attempts >= 0),
    last_transfer_attempt_at TIMESTAMP,
    transferred_at           TIMESTAMP,
    erp_order_number         VARCHAR(20),
    delivered_on             DATE,
    CONSTRAINT customer_order_approval_ck CHECK (
        (approver_id IS NULL AND approval_decided_at IS NULL)
            OR (approver_id IS NOT NULL AND approval_decided_at IS NOT NULL)),
    CONSTRAINT customer_order_rejected_approval_ck CHECK (status <> 'Rejected' OR approver_id IS NOT NULL),
    CONSTRAINT customer_order_rejection_reason_ck CHECK (
        (status = 'Rejected' AND rejection_reason IS NOT NULL)
            OR (status <> 'Rejected' AND rejection_reason IS NULL)),
    CONSTRAINT customer_order_transfer_ck CHECK (
        (status = 'Transferred' AND transferred_at IS NOT NULL AND erp_order_number IS NOT NULL)
            OR (status <> 'Transferred' AND transferred_at IS NULL AND erp_order_number IS NULL))
);
