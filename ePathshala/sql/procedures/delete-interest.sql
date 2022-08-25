CREATE OR REPLACE PROCEDURE DELETE_INTEREST(PARAM_STUDENT_ID BIGINT, PARAM_INTEREST VARCHAR)
LANGUAGE PLPGSQL
AS
$$
BEGIN
	DELETE FROM STUDENT_INTERESTS
	WHERE STUDENT_ID = PARAM_STUDENT_ID AND INTEREST = PARAM_INTEREST;
END;
$$;