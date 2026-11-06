-- Test data for UC-001 Find Product

INSERT INTO product (id, pim_product_reference, product_number, name, description, synchronized_at)
VALUES (1001, 'PIM-1001', 'AF-1001', 'Edelweiss Hiking Boot', 'Waterproof leather boot for mountain trails',
        CURRENT_TIMESTAMP),
       (1002, 'PIM-1002', 'AF-1002', 'Alpine Rope 50m', 'Dynamic climbing rope for edelweiss tours',
        CURRENT_TIMESTAMP),
       (1003, 'PIM-1003', 'AF-1003', 'Bergsteiger Helmet', 'Lightweight climbing helmet', CURRENT_TIMESTAMP);

-- The image with the lower display order is the first image (BR-007); product 1002 has no image
INSERT INTO product_image (id, product_id, image_url, display_order)
VALUES (1001, 1001, 'https://images.example.com/af-1001-side.jpg', 2),
       (1002, 1001, 'https://images.example.com/af-1001-front.jpg', 1),
       (1003, 1003, 'https://images.example.com/af-1003.jpg', 1);

INSERT INTO product_stock (product_id, quantity, synchronized_at)
VALUES (1001, 12, CURRENT_TIMESTAMP),
       (1002, 5, CURRENT_TIMESTAMP),
       (1003, 0, CURRENT_TIMESTAMP);
