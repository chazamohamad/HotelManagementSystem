-- =========================================================
-- Task: Create ADD_ROOM_TYPE Procedure
-- =========================================================
-- Description:
-- Create a stored procedure named ADD_ROOM_TYPE in the HotelDB database.
--
-- The procedure should insert a new record into the ROOM_TYPES table.
--
-- Input Parameters:
-- - TYPE_NAME: Name of the room type
-- - DESCRIPTION: Description of the room
-- - BASE_PRICE: Base price of the room (must not be negative)
-- - MAX_GUESTS: Maximum number of guests (must be greater than 0)
-- - IMAGE_URL: Image path or URL
--
-- Notes:
-- - ROOM_TYPE_ID should NOT be provided manually.
-- - It must be generated automatically using a sequence.
-- - Validation is required for BASE_PRICE and MAX_GUESTS.
-- =========================================================

CREATE OR REPLACE PROCEDURE ADD_ROOM_TYPE (
    P_TYPE_NAME     IN VARCHAR2,
    P_DESCRIPTION   IN VARCHAR2,
    P_BASE_PRICE    IN NUMBER,
    P_MAX_GUESTS    IN NUMBER,
    P_IMAGE_URL     IN VARCHAR2
)
AS
BEGIN
    -- Validation
    IF P_BASE_PRICE < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Price cannot be negative');
    END IF;

    IF P_MAX_GUESTS <= 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Max guests must be greater than 0');
    END IF;

    -- Insert
    INSERT INTO ROOM_TYPES (
        ROOM_TYPE_ID,
        TYPE_NAME,
        DESCRIPTION,
        BASE_PRICE,
        MAX_GUESTS,
        IMAGE_URL
    )
    VALUES (
        SEQ_ROOM_TYPES.NEXTVAL,
        P_TYPE_NAME,
        P_DESCRIPTION,
        P_BASE_PRICE,
        P_MAX_GUESTS,
        P_IMAGE_URL
    );

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
BEGIN
    ADD_ROOM_TYPE(
        'Deluxe Room',
        'Nice room with sea view',
        150,
        2,
        'image.jpg'
    );
END;
/

-- Task: Create an Update User Procedure
-- 
-- Create a procedure in the HotelDB database named UPDATE_USER.
-- 
-- The procedure should update an existing user in the USERS table.
-- 
-- The procedure must accept the following input values:
-- USER_ID, USERNAME, EMAIL, FULL_NAME, PHONE, ROLE, and IS_ACTIVE.
-- 
-- When the procedure is executed, it should find the user using the given USER_ID.
-- 
-- Then, it should update the user details with the new values provided.
-- 
-- The procedure should save the changes after updating the user.
CREATE OR REPLACE PROCEDURE UPDATE_USER (
    P_USER_ID    IN NUMBER,
    P_USERNAME   IN VARCHAR2,
    P_EMAIL      IN VARCHAR2,
    P_FULL_NAME  IN VARCHAR2,
    P_PHONE      IN VARCHAR2,
    P_ROLE       IN VARCHAR2,
    P_IS_ACTIVE  IN NUMBER
)
AS
BEGIN

    UPDATE USERS
    SET
        USERNAME  = P_USERNAME,
        EMAIL     = P_EMAIL,
        FULL_NAME = P_FULL_NAME,
        PHONE     = P_PHONE,
        ROLE      = P_ROLE,
        IS_ACTIVE = P_IS_ACTIVE
    WHERE USER_ID = P_USER_ID;

    COMMIT;

END;
/

BEGIN
    UPDATE_USER(
        1,
        'lamita',
        'new@email.com',
        'lamita sayed',
        '12345678',
        'Admin',
        1
    );
END;
/