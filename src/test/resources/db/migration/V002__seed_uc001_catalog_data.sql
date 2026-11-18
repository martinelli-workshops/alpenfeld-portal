INSERT INTO customer (id, erp_customer_id, name)
VALUES (9901, 'TEST-CUSTOMER-1', 'UC-001 Test Customer'),
       (9902, 'TEST-CUSTOMER-2', 'UC-001 Other Customer');

INSERT INTO portal_user (id, customer_id, email, first_name, last_name, role, active)
VALUES (9901, 9901, 'buyer@example.test', 'Test', 'Buyer', 'Buyer', TRUE);

INSERT INTO product (id, pim_product_id, erp_product_id, name, description, synchronized_at)
VALUES (9911, 'TEST-PIM-1', 'TEST-ERP-1', 'Impact Driver', 'Precision driver for workshop use',
        TIMESTAMP '2026-11-18 08:00:00'),
       (9912, 'TEST-PIM-2', 'TEST-ERP-2', 'Laser Measure', 'Laser measuring tool',
        TIMESTAMP '2026-11-18 08:01:00'),
       (9913, 'TEST-PIM-3', 'TEST-ERP-3', 'Torque Wrench', 'Heavy-duty torque tool',
        TIMESTAMP '2026-11-18 08:02:00'),
       (9914, 'TEST-PIM-4', 'TEST-ERP-4', 'Workshop Clamp', 'Clamp for bench assemblies',
        TIMESTAMP '2026-11-18 08:03:00');

INSERT INTO contract_price
    (id, customer_id, product_id, unit_price, valid_from, valid_to, synchronized_at)
VALUES (9931, 9901, 9911, 125.50, DATEADD('DAY', -14, CURRENT_DATE), NULL,
        TIMESTAMP '2026-11-18 08:05:00'),
       (9932, 9902, 9911, 999.99, DATEADD('DAY', -14, CURRENT_DATE), NULL,
        TIMESTAMP '2026-11-18 08:06:00'),
       (9933, 9901, 9912, 240.00, DATEADD('DAY', -14, CURRENT_DATE), CURRENT_DATE,
        TIMESTAMP '2026-11-18 08:07:00'),
       (9934, 9901, 9913, 99.00, DATEADD('DAY', -14, CURRENT_DATE), DATEADD('DAY', -1, CURRENT_DATE),
        TIMESTAMP '2026-11-18 08:08:00'),
       (9935, 9901, 9914, 15.75, CURRENT_DATE, NULL,
        TIMESTAMP '2026-11-18 08:09:00');

INSERT INTO product_stock (id, product_id, quantity, synchronized_at)
VALUES (9941, 9911, 17, TIMESTAMP '2026-11-18 08:10:00'),
       (9942, 9913, 0, TIMESTAMP '2026-11-18 08:12:00'),
       (9943, 9914, 4, TIMESTAMP '2026-11-18 08:13:00');
