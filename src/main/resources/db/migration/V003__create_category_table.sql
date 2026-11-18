CREATE SEQUENCE category_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE category
(
    id                   BIGINT DEFAULT nextval('category_seq') PRIMARY KEY,
    pim_code             VARCHAR(50)  NOT NULL UNIQUE,
    name                 VARCHAR(200) NOT NULL,
    parent_id            BIGINT REFERENCES category (id),
    sort_order           INTEGER      NOT NULL,
    last_synchronized_at TIMESTAMP    NOT NULL,
    CONSTRAINT category_parent_not_self_ck CHECK (parent_id IS NULL OR parent_id <> id)
);
