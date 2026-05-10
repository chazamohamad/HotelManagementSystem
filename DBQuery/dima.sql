--task 1: create a view to get all room types with their names and ids

CREATE OR REPLACE VIEW ROOM_TYPE_VIEW AS
SELECT 
    ROOM_TYPE_ID,
    TYPE_NAME
FROM ROOM_TYPES;




--task 2: create a function to get all room types 

 CREATE OR REPLACE FUNCTION GET_ROOMS_BY_TYPE (
    P_ROOM_TYPE_ID IN NUMBER
)
RETURN SYS_REFCURSOR
AS
    V_CURSOR SYS_REFCURSOR;
BEGIN
    OPEN V_CURSOR FOR
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
        INNER JOIN ROOM_TYPES RT
            ON R.ROOM_TYPE_ID = RT.ROOM_TYPE_ID
        WHERE R.ROOM_TYPE_ID = P_ROOM_TYPE_ID;

    RETURN V_CURSOR;
END;
/


--run the function to get rooms of type 2

VARIABLE RC REFCURSOR;

EXEC :RC := GET_ROOMS_BY_TYPE(2);

PRINT RC;




--task3 create a procedure to delete a room type by id

CREATE OR REPLACE PROCEDURE DELETE_ROOM_TYPE (
    P_ROOM_TYPE_ID IN NUMBER
)
AS
BEGIN
    DELETE FROM ROOM_TYPES
    WHERE ROOM_TYPE_ID = P_ROOM_TYPE_ID;

    COMMIT;
END;
/

--run the procedure to delete room type with id 1
BEGIN
    DELETE_ROOM_TYPE(1);
END;
/

--task4 create a procedure to update room details and its related room type image

CREATE OR REPLACE PROCEDURE UPDATE_ROOM (
    P_ROOM_ID       IN NUMBER,
    P_ROOM_NUMBER   IN VARCHAR2,
    P_FLOOR_NUMBER  IN NUMBER,
    P_ROOM_TYPE_ID  IN NUMBER,
    P_STATUS        IN VARCHAR2,
    P_IMAGE_URL     IN VARCHAR2
)
AS
BEGIN

    -- Update room details
    UPDATE ROOMS
    SET 
        ROOM_NUMBER = P_ROOM_NUMBER,
        FLOOR_NUMBER = P_FLOOR_NUMBER,
        ROOM_TYPE_ID = P_ROOM_TYPE_ID,
        STATUS = P_STATUS
    WHERE ROOM_ID = P_ROOM_ID;

    -- Update related room type image
    UPDATE ROOM_TYPES
    SET IMAGE_URL = P_IMAGE_URL
    WHERE ROOM_TYPE_ID = P_ROOM_TYPE_ID;

    -- Save changes
    COMMIT;

END;
/
--run the procedure to update room details and its related room type image for room id 3
BEGIN
    UPDATE_ROOM(
        3,
        '105',
        1,
        2,
        'Occupied',
        '/images/new_double.jpg'
    );
END;
/

