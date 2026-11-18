CREATE SEQUENCE quote_request_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE quote_request
(
    id                      BIGINT DEFAULT nextval('quote_request_seq') PRIMARY KEY,
    business_customer_id    BIGINT      NOT NULL REFERENCES business_customer (id),
    buyer_id                BIGINT      NOT NULL REFERENCES portal_user (id),
    status                  VARCHAR(20) NOT NULL CHECK (status IN ('Open', 'Answered', 'Declined')),
    requested_at            TIMESTAMP   NOT NULL,
    sales_representative_id BIGINT REFERENCES portal_user (id),
    decided_at              TIMESTAMP,
    decline_reason          VARCHAR(500),
    CONSTRAINT quote_request_decision_ck CHECK (
        (status = 'Open' AND sales_representative_id IS NULL AND decided_at IS NULL)
            OR (status IN ('Answered', 'Declined') AND sales_representative_id IS NOT NULL AND decided_at IS NOT NULL)),
    CONSTRAINT quote_request_decline_reason_ck CHECK (
        (status = 'Declined' AND decline_reason IS NOT NULL)
            OR (status <> 'Declined' AND decline_reason IS NULL))
);
