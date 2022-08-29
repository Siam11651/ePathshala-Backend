CREATE OR REPLACE FUNCTION GET_INDIVIDUAL_CONTENT_RATE(PARAM_USER_ID BIGINT, PARAM_CONTENT_ID BIGINT)
RETURNS INT
LANGUAGE PLPGSQL
AS
$$
DECLARE
	RATE_VALUE INT;
BEGIN
	SELECT RATE INTO RATE_VALUE
	FROM CONTENT_VIEWERS
	WHERE USER_ID = PARAM_USER_ID AND CONTENT_ID = PARAM_CONTENT_ID;
	RETURN RATE_VALUE;
END;
$$;