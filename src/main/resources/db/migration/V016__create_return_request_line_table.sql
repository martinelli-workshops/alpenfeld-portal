CREATE SEQUENCE return_request_line_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE return_request_line
(
    id                BIGINT DEFAULT nextval('return_request_line_seq') PRIMARY KEY,
    return_request_id BIGINT  NOT NULL,
    order_line_id     BIGINT  NOT NULL,
    quantity          INTEGER NOT NULL,
    CONSTRAINT fk_return_request_line_return_request FOREIGN KEY (return_request_id) REFERENCES return_request (id),
    CONSTRAINT fk_return_request_line_order_line FOREIGN KEY (order_line_id) REFERENCES order_line (id)
);
