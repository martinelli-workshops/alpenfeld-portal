-- Cross-row rules for overlapping contract-price periods and cumulative return quantities
-- must be enforced transactionally by the application.

CREATE SEQUENCE customer_seq START WITH 1 INCREMENT BY 1 CACHE 50;
CREATE SEQUENCE portal_user_seq START WITH 1 INCREMENT BY 1 CACHE 50;
CREATE SEQUENCE staff_user_seq START WITH 1 INCREMENT BY 1 CACHE 50;
CREATE SEQUENCE product_seq START WITH 1 INCREMENT BY 1 CACHE 50;
CREATE SEQUENCE contract_price_seq START WITH 1 INCREMENT BY 1 CACHE 50;
CREATE SEQUENCE product_stock_seq START WITH 1 INCREMENT BY 1 CACHE 50;
CREATE SEQUENCE customer_order_seq START WITH 1 INCREMENT BY 1 CACHE 50;
CREATE SEQUENCE order_line_seq START WITH 1 INCREMENT BY 1 CACHE 50;
CREATE SEQUENCE order_approval_seq START WITH 1 INCREMENT BY 1 CACHE 50;
CREATE SEQUENCE quote_request_seq START WITH 1 INCREMENT BY 1 CACHE 50;
CREATE SEQUENCE quote_request_line_seq START WITH 1 INCREMENT BY 1 CACHE 50;
CREATE SEQUENCE quote_seq START WITH 1 INCREMENT BY 1 CACHE 50;
CREATE SEQUENCE quote_line_seq START WITH 1 INCREMENT BY 1 CACHE 50;
CREATE SEQUENCE return_request_seq START WITH 1 INCREMENT BY 1 CACHE 50;
CREATE SEQUENCE return_line_seq START WITH 1 INCREMENT BY 1 CACHE 50;
CREATE SEQUENCE erp_order_delivery_seq START WITH 1 INCREMENT BY 1 CACHE 50;

CREATE TABLE customer
(
    id              BIGINT DEFAULT NEXT VALUE FOR customer_seq PRIMARY KEY,
    erp_customer_id VARCHAR(100) NOT NULL UNIQUE,
    name            VARCHAR(150) NOT NULL,
    approval_limit  DECIMAL(10,2)
);

CREATE TABLE portal_user
(
    id          BIGINT DEFAULT NEXT VALUE FOR portal_user_seq PRIMARY KEY,
    customer_id BIGINT       NOT NULL,
    email       VARCHAR(255) NOT NULL,
    first_name  VARCHAR(100) NOT NULL,
    last_name   VARCHAR(100) NOT NULL,
    role        VARCHAR(50)  NOT NULL,
    active      BOOLEAN      NOT NULL,
    CONSTRAINT fk_portal_user_customer FOREIGN KEY (customer_id) REFERENCES customer (id),
    CONSTRAINT ck_portal_user_role CHECK (role IN ('Buyer', 'Purchasing Manager'))
);

CREATE TABLE staff_user
(
    id         BIGINT DEFAULT NEXT VALUE FOR staff_user_seq PRIMARY KEY,
    email      VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name  VARCHAR(100) NOT NULL,
    active     BOOLEAN      NOT NULL
);

CREATE TABLE product
(
    id              BIGINT DEFAULT NEXT VALUE FOR product_seq PRIMARY KEY,
    pim_product_id  VARCHAR(100) NOT NULL UNIQUE,
    erp_product_id  VARCHAR(100) NOT NULL UNIQUE,
    name            VARCHAR(255) NOT NULL,
    description     VARCHAR(500),
    synchronized_at TIMESTAMP NOT NULL
);

CREATE TABLE contract_price
(
    id          BIGINT DEFAULT NEXT VALUE FOR contract_price_seq PRIMARY KEY,
    customer_id BIGINT        NOT NULL,
    product_id  BIGINT        NOT NULL,
    unit_price  DECIMAL(10,2) NOT NULL,
    valid_from  DATE          NOT NULL,
    valid_to    DATE,
    synchronized_at TIMESTAMP NOT NULL,
    CONSTRAINT fk_contract_price_customer FOREIGN KEY (customer_id) REFERENCES customer (id),
    CONSTRAINT fk_contract_price_product FOREIGN KEY (product_id) REFERENCES product (id),
    CONSTRAINT ck_contract_price_period CHECK (valid_to IS NULL OR valid_to >= valid_from),
    CONSTRAINT uq_contract_price_start UNIQUE (customer_id, product_id, valid_from)
);

CREATE TABLE product_stock
(
    id              BIGINT DEFAULT NEXT VALUE FOR product_stock_seq PRIMARY KEY,
    product_id      BIGINT    NOT NULL,
    quantity        INTEGER   NOT NULL,
    synchronized_at TIMESTAMP NOT NULL,
    CONSTRAINT fk_product_stock_product FOREIGN KEY (product_id) REFERENCES product (id),
    CONSTRAINT uq_product_stock_product UNIQUE (product_id)
);

CREATE TABLE customer_order
(
    id          BIGINT DEFAULT NEXT VALUE FOR customer_order_seq PRIMARY KEY,
    customer_id BIGINT      NOT NULL,
    buyer_id    BIGINT      NOT NULL,
    status      VARCHAR(50) NOT NULL,
    created_at  TIMESTAMP   NOT NULL,
    CONSTRAINT fk_customer_order_customer FOREIGN KEY (customer_id) REFERENCES customer (id),
    CONSTRAINT fk_customer_order_buyer FOREIGN KEY (buyer_id) REFERENCES portal_user (id),
    CONSTRAINT ck_customer_order_status CHECK (
        status IN ('Draft', 'Awaiting Approval', 'Approved', 'Rejected', 'Queued for ERP', 'Transferred to ERP', 'Cancelled')
    )
);

CREATE TABLE order_line
(
    id                BIGINT DEFAULT NEXT VALUE FOR order_line_seq PRIMARY KEY,
    customer_order_id BIGINT        NOT NULL,
    product_id        BIGINT        NOT NULL,
    quantity          INTEGER       NOT NULL,
    unit_price        DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_order_line_order FOREIGN KEY (customer_order_id) REFERENCES customer_order (id),
    CONSTRAINT fk_order_line_product FOREIGN KEY (product_id) REFERENCES product (id)
);

CREATE TABLE order_approval
(
    id                BIGINT DEFAULT NEXT VALUE FOR order_approval_seq PRIMARY KEY,
    customer_order_id BIGINT      NOT NULL,
    approver_id       BIGINT      NOT NULL,
    decision          VARCHAR(50) NOT NULL,
    decided_at        TIMESTAMP   NOT NULL,
    CONSTRAINT fk_order_approval_order FOREIGN KEY (customer_order_id) REFERENCES customer_order (id),
    CONSTRAINT fk_order_approval_approver FOREIGN KEY (approver_id) REFERENCES portal_user (id),
    CONSTRAINT ck_order_approval_decision CHECK (decision IN ('Approved', 'Rejected')),
    CONSTRAINT uq_order_approval_order UNIQUE (customer_order_id)
);

CREATE TABLE quote_request
(
    id          BIGINT DEFAULT NEXT VALUE FOR quote_request_seq PRIMARY KEY,
    customer_id BIGINT      NOT NULL,
    requester_id BIGINT     NOT NULL,
    status      VARCHAR(50) NOT NULL,
    created_at  TIMESTAMP   NOT NULL,
    CONSTRAINT fk_quote_request_customer FOREIGN KEY (customer_id) REFERENCES customer (id),
    CONSTRAINT fk_quote_request_requester FOREIGN KEY (requester_id) REFERENCES portal_user (id),
    CONSTRAINT ck_quote_request_status CHECK (status IN ('Requested', 'Quoted', 'Cancelled'))
);

CREATE TABLE quote_request_line
(
    id               BIGINT DEFAULT NEXT VALUE FOR quote_request_line_seq PRIMARY KEY,
    quote_request_id BIGINT  NOT NULL,
    product_id       BIGINT  NOT NULL,
    requested_quantity INTEGER NOT NULL,
    CONSTRAINT fk_quote_request_line_request FOREIGN KEY (quote_request_id) REFERENCES quote_request (id),
    CONSTRAINT fk_quote_request_line_product FOREIGN KEY (product_id) REFERENCES product (id)
);

CREATE TABLE quote
(
    id                      BIGINT DEFAULT NEXT VALUE FOR quote_seq PRIMARY KEY,
    quote_request_id        BIGINT      NOT NULL,
    sales_representative_id BIGINT      NOT NULL,
    status                  VARCHAR(50) NOT NULL,
    issued_at               TIMESTAMP   NOT NULL,
    valid_until             DATE,
    CONSTRAINT fk_quote_request FOREIGN KEY (quote_request_id) REFERENCES quote_request (id),
    CONSTRAINT fk_quote_sales_representative FOREIGN KEY (sales_representative_id) REFERENCES staff_user (id),
    CONSTRAINT ck_quote_status CHECK (status IN ('Open', 'Accepted', 'Declined', 'Expired')),
    CONSTRAINT uq_quote_request UNIQUE (quote_request_id)
);

CREATE TABLE quote_line
(
    id         BIGINT DEFAULT NEXT VALUE FOR quote_line_seq PRIMARY KEY,
    quote_id   BIGINT        NOT NULL,
    product_id BIGINT        NOT NULL,
    quantity   INTEGER       NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_quote_line_quote FOREIGN KEY (quote_id) REFERENCES quote (id),
    CONSTRAINT fk_quote_line_product FOREIGN KEY (product_id) REFERENCES product (id)
);

CREATE TABLE return_request
(
    id                BIGINT DEFAULT NEXT VALUE FOR return_request_seq PRIMARY KEY,
    customer_order_id BIGINT      NOT NULL,
    requester_id      BIGINT      NOT NULL,
    status            VARCHAR(50) NOT NULL,
    created_at        TIMESTAMP   NOT NULL,
    CONSTRAINT fk_return_request_order FOREIGN KEY (customer_order_id) REFERENCES customer_order (id),
    CONSTRAINT fk_return_request_requester FOREIGN KEY (requester_id) REFERENCES portal_user (id),
    CONSTRAINT ck_return_request_status CHECK (status IN ('Requested', 'Approved', 'Rejected', 'Completed', 'Cancelled'))
);

CREATE TABLE return_line
(
    id                BIGINT DEFAULT NEXT VALUE FOR return_line_seq PRIMARY KEY,
    return_request_id BIGINT  NOT NULL,
    order_line_id     BIGINT  NOT NULL,
    quantity          INTEGER NOT NULL,
    CONSTRAINT fk_return_line_request FOREIGN KEY (return_request_id) REFERENCES return_request (id),
    CONSTRAINT fk_return_line_order_line FOREIGN KEY (order_line_id) REFERENCES order_line (id)
);

CREATE TABLE erp_order_delivery
(
    id                BIGINT DEFAULT NEXT VALUE FOR erp_order_delivery_seq PRIMARY KEY,
    customer_order_id BIGINT       NOT NULL,
    idempotency_key   VARCHAR(100) NOT NULL,
    status            VARCHAR(50)  NOT NULL,
    attempt_count     INTEGER      NOT NULL,
    queued_at         TIMESTAMP    NOT NULL,
    last_attempt_at   TIMESTAMP,
    transferred_at    TIMESTAMP,
    CONSTRAINT fk_erp_order_delivery_order FOREIGN KEY (customer_order_id) REFERENCES customer_order (id),
    CONSTRAINT ck_erp_order_delivery_status CHECK (status IN ('Pending', 'In Progress', 'Succeeded', 'Failed')),
    CONSTRAINT uq_erp_order_delivery_order UNIQUE (customer_order_id),
    CONSTRAINT uq_erp_order_delivery_idempotency_key UNIQUE (idempotency_key)
);
