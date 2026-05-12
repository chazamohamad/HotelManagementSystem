--task1: view for rooms with room type details
CREATE OR REPLACE VIEW RoomView AS

SELECT 

    R.ROOM_ID,

    R.ROOM_NUMBER,

    R.FLOOR_NUMBER,

    R.STATUS,

    RT.ROOM_TYPE_ID,

    RT.TYPE_NAME,

    RT.DESCRIPTION,

    RT.BASE_PRICE,

    RT.MAX_GUESTS,

    RT.IMAGE_URL

FROM ROOMS R

JOIN ROOM_TYPES RT

    ON R.ROOM_TYPE_ID = RT.ROOM_TYPE_ID;
--SELECT * FROM RoomView; 




--task2 : create a procedure to add a new  room into the room table
CREATE OR REPLACE PROCEDURE ADD_ROOM (
    P_ROOM_NUMBER   IN ROOMS.ROOM_NUMBER%TYPE,
    P_FLOOR_NUMBER  IN ROOMS.FLOOR_NUMBER%TYPE,
    P_TYPE_NAME     IN ROOM_TYPES.TYPE_NAME%TYPE,
    P_BASE_PRICE    IN ROOM_TYPES.BASE_PRICE%TYPE,
    P_MAX_GUESTS    IN ROOM_TYPES.MAX_GUESTS%TYPE,
    P_STATUS        IN ROOMS.STATUS%TYPE
)
AS
    V_ROOM_TYPE_ID ROOM_TYPES.ROOM_TYPE_ID%TYPE;
BEGIN
    -- Validation
    IF P_BASE_PRICE < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Base price cannot be negative');
    END IF;

    IF P_MAX_GUESTS <= 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Max guests must be greater than 0');
    END IF;

    IF P_STATUS NOT IN ('Available', 'Occupied', 'Maintenance') THEN
        RAISE_APPLICATION_ERROR(-20003, 'Invalid room status');
    END IF;

    -- Check if room type already exists
    BEGIN
        SELECT ROOM_TYPE_ID
        INTO V_ROOM_TYPE_ID
        FROM ROOM_TYPES
        WHERE LOWER(TYPE_NAME) = LOWER(P_TYPE_NAME);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- If room type does not exist, create it
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
                NULL,
                P_BASE_PRICE,
                P_MAX_GUESTS,
                NULL
            )
            RETURNING ROOM_TYPE_ID INTO V_ROOM_TYPE_ID;
    END;

    -- Insert the new room
    INSERT INTO ROOMS (
        ROOM_ID,
        ROOM_NUMBER,
        ROOM_TYPE_ID,
        FLOOR_NUMBER,
        STATUS
    )
    VALUES (
        SEQ_ROOMS.NEXTVAL,
        P_ROOM_NUMBER,
        V_ROOM_TYPE_ID,
        P_FLOOR_NUMBER,
        P_STATUS
    );

    COMMIT;

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20004, 'Room number already exists');

    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/




--task3 : create a function to validate user login
CREATE OR REPLACE FUNCTION SIGN_IN_USER (
    P_USERNAME IN VARCHAR2,
    P_PASSWORD IN VARCHAR2
)
RETURN NUMBER
AS
    V_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO V_COUNT
    FROM USERS
    WHERE USERNAME = P_USERNAME
      AND PASSWORD_HASH = P_PASSWORD
      AND IS_ACTIVE = 1;

    IF V_COUNT > 0 THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END SIGN_IN_USER;
/
--SELECT SIGN_IN_USER('john_doe', 'customer123hash') AS LOGIN_RESULT FROM DUAL;


--task4 : create a procedure to delete a user by id
CREATE OR REPLACE PROCEDURE DELETE_USER (
    P_USER_ID IN USERS.USER_ID%TYPE
)
AS
BEGIN
    DELETE FROM USERS
    WHERE USER_ID = P_USER_ID;

    COMMIT;
END;
/