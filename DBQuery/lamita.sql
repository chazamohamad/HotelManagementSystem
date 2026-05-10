--Task: Create a procedure to add a new room type with validation and automatic ID generation.

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

-- Task: Create a procedure to update user information based on USER_ID.

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
