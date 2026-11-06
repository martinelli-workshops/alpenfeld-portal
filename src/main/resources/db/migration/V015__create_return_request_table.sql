CREATE SEQUENCE return_request_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE return_request
(
    id           BIGINT DEFAULT nextval('return_request_seq') PRIMARY KEY,
    order_id     BIGINT       NOT NULL,
    buyer_id     BIGINT       NOT NULL,
    reason       VARCHAR(500) NOT NULL,
    status       VARCHAR(50)  NOT NULL,
    submitted_at TIMESTAMP    NOT NULL,
    CONSTRAINT fk_return_request_purchase_order FOREIGN KEY (order_id) REFERENCES purchase_order (id),
    CONSTRAINT fk_return_request_buyer FOREIGN KEY (buyer_id) REFERENCES buyer (id)
);
