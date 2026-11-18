CREATE SEQUENCE return_line_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE return_line
(
    id            BIGINT DEFAULT nextval('return_line_seq') PRIMARY KEY,
    return_id     BIGINT  NOT NULL REFERENCES return (id),
    order_line_id BIGINT  NOT NULL REFERENCES order_line (id),
    quantity      INTEGER NOT NULL CHECK (quantity BETWEEN 1 AND 99999),
    CONSTRAINT return_line_return_order_line_uk UNIQUE (return_id, order_line_id)
);
