CREATE SEQUENCE quote_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE quote
(
    id               BIGINT DEFAULT nextval('quote_seq') PRIMARY KEY,
    quote_request_id BIGINT    NOT NULL UNIQUE REFERENCES quote_request (id),
    valid_until      DATE      NOT NULL,
    created_at       TIMESTAMP NOT NULL,
    CONSTRAINT quote_valid_until_ck CHECK (valid_until >= CAST(created_at AS DATE))
);
