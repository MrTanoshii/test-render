INSERT INTO customer (full_name) VALUES
    ('Abeenesh'),
    ('Blessing'),
    ('Dhivyesh'),
    ('Jatin'),
    ('Khavind'),
    ('Nilesh'),
    ('Sanjiv'),
    ('Tushil')
;

INSERT INTO manufacturer (label)
VALUES
    ('Phoenix Bev'),
    ('Coca Cola'),
    ('Pepsico')
;

INSERT INTO beverage (label, price, manufacturer_id)
VALUES
    ('Phoenix Beer', 89.99, (SELECT id FROM manufacturer WHERE label = 'Phoenix Bev')),
    ('Coca Cola', NULL, (SELECT id FROM manufacturer WHERE label = 'Coca Cola')),
    ('Sprite', NULL, (SELECT id FROM manufacturer WHERE label = 'Coca Cola')),
    ('Fanta', NULL, (SELECT id FROM manufacturer WHERE label = 'Coca Cola')),
    ('Appletiser', NULL, (SELECT id FROM manufacturer WHERE label = 'Coca Cola')),
    ('Fuzetea', NULL, (SELECT id FROM manufacturer WHERE label = 'Coca Cola')),
    ('Pepsi', NULL, (SELECT id FROM manufacturer WHERE label = 'Pepsico')),
    ('Mountain Dew', NULL, (SELECT id FROM manufacturer WHERE label = 'Pepsico')),
    ('7up', NULL, (SELECT id FROM manufacturer WHERE label = 'Pepsico'))
;

INSERT INTO barcode (barcode, beverage_id)
VALUES
    ('123456789012', (SELECT id FROM beverage WHERE label = 'Phoenix Beer')),
    ('123456789013', (SELECT id FROM beverage WHERE label = 'Coca Cola')),
    ('123456789014', (SELECT id FROM beverage WHERE label = 'Sprite')),
    ('123456789015', (SELECT id FROM beverage WHERE label = 'Fanta')),
    ('123456789016', (SELECT id FROM beverage WHERE label = 'Appletiser')),
    ('123456789017', (SELECT id FROM beverage WHERE label = 'Fuzetea')),
    ('123456789018', (SELECT id FROM beverage WHERE label = 'Pepsi')),
    ('123456789019', (SELECT id FROM beverage WHERE label = 'Mountain Dew')),
    ('123456789020', (SELECT id FROM beverage WHERE label = '7up'))
;

INSERT INTO customer_beverage (customer_id, beverage_id, is_favorite)
VALUES
    (
        (SELECT id FROM customer WHERE full_name = 'Abeenesh'),
        (SELECT id FROM beverage WHERE label = 'Phoenix Beer'),
        FALSE
    ),
    (
        (SELECT id FROM customer WHERE full_name = 'Abeenesh'),
        (SELECT id FROM beverage WHERE label = 'Coca Cola'),
        TRUE
    ),
    (
        (SELECT id FROM customer WHERE full_name = 'Dhivyesh'),
        (SELECT id FROM beverage WHERE label = 'Phoenix Beer'),
        TRUE
    ),
    (
        (SELECT id FROM customer WHERE full_name = 'Dhivyesh'),
        (SELECT id FROM beverage WHERE label = 'Sprite'),
        FALSE
    ),
    (
        (SELECT id FROM customer WHERE full_name = 'Nilesh'),
        (SELECT id FROM beverage WHERE label = 'Phoenix Beer'),
        FALSE
    ),
    (
        (SELECT id FROM customer WHERE full_name = 'Nilesh'),
        (SELECT id FROM beverage WHERE label = 'Appletiser'),
        FALSE
    ),
    (
        (SELECT id FROM customer WHERE full_name = 'Nilesh'),
        (SELECT id FROM beverage WHERE label = 'Mountain Dew'),
        TRUE
    )
;