CREATE OR REPLACE FUNCTION GET_COURSES_TEACHER_BY_DATE_ASC(PARAM_TEACHER_ID BIGINT)
RETURNS TABLE(COURSE_ID BIGINT, TITLE VARCHAR, DESCRIPTION VARCHAR, DATE_OF_CREATION DATE, PRICE INT, RATE NUMERIC, ENROLL_COUNT BIGINT)
LANGUAGE PLPGSQL
AS
$$
BEGIN
	RETURN QUERY SELECT
		COURSES.COURSE_ID,
		COURSES.TITLE,
		TRIM(COURSES.DESCRIPTION)::VARCHAR,
		COURSES.DATE_OF_CREATION,
		COURSES.PRICE,
		COURSES.RATE::NUMERIC(3, 2),
		COURSES.ENROLL_COUNT
	FROM COURSES
	WHERE CREATOR_ID = PARAM_TEACHER_ID
	ORDER BY DATE_OF_CREATION ASC;
END;
$$;