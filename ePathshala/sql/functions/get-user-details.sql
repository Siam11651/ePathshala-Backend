CREATE OR REPLACE FUNCTION GET_USER_DETAILS(PARAM_USER_ID BIGINT)
RETURNS TABLE(USER_ID BIGINT, FULL_NAME VARCHAR, DATE_OF_BIRTH DATE, BIO VARCHAR, EMAIL VARCHAR)
LANGUAGE PLPGSQL
AS
$$
BEGIN
	RETURN QUERY SELECT USERS.USER_ID, USERS.FULL_NAME, USERS.DATE_OF_BIRTH, TRIM(USERS.BIO)::VARCHAR, USERS.EMAIL
	FROM USERS
	WHERE USERS.USER_ID = PARAM_USER_ID;
END;
$$;