CREATE SEQUENCE return_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE return
(
    id               BIGINT DEFAULT nextval('return_seq') PRIMARY KEY,
    order_id         BIGINT      NOT NULL REFERENCES customer_order (id),
    buyer_id         BIGINT      NOT NULL REFERENCES portal_user (id),
    reason           VARCHAR(500),
    status           VARCHAR(20) NOT NULL CHECK (status IN ('Requested', 'Accepted', 'Rejected')),
    requested_at     TIMESTAMP   NOT NULL,
    processor_id     BIGINT REFERENCES portal_user (id),
    processed_at     TIMESTAMP,
    rejection_reason VARCHAR(500),
    CONSTRAINT return_processing_ck CHECK (
        (status = 'Requested' AND processor_id IS NULL AND processed_at IS NULL)
            OR (status IN ('Accepted', 'Rejected') AND processor_id IS NOT NULL AND processed_at IS NOT NULL)),
    CONSTRAINT return_rejection_reason_ck CHECK (
        (status = 'Rejected' AND rejection_reason IS NOT NULL)
            OR (status <> 'Rejected' AND rejection_reason IS NULL))
);
