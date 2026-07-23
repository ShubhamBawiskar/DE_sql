DELIMITER //
CREATE FUNCTION func_normalized_phone(f_phone VARCHAR(20))
RETURNS VARCHAR(20)
NO SQL
BEGIN
    DECLARE phone VARCHAR(20);
    SET phone = REPLACE(f_phone, ' ','');
    SET phone = REPLACE(f_phone, '-','');
    SET phone = CONCAT(f_phone, '+91', phone);

END //

DELIMITER //

CREATE FUNCTION inr_to_usd(inr DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE usd DECIMAL(10,2);
    SET usd = inr / 96;
    RETURN usd;
END //

