CREATE OR REPLACE FUNCTION GET_QUESTIONS()
RETURNS TABLE(QUESTION_ID BIGINT, TITLE VARCHAR, ASKER_ID BIGINT, ASKER_NAME VARCHAR, DATE_OF_ASK DATE, TIME_OF_ASK TIME WITH TIME ZONE, RATE NUMERIC)
LANGUAGE PLPGSQL
AS
$$
BEGIN
	RETURN QUERY SELECT
		FORUM_QUESTIONS.QUESTION_ID,
		FORUM_QUESTIONS.TITLE,
		FORUM_QUESTIONS.ASKER_ID,
		USERS.FULL_NAME,
		FORUM_QUESTIONS.DATE_OF_ASK,
		FORUM_QUESTIONS.TIME_OF_ASK::TIME(0) WITH TIME ZONE,
		FORUM_QUESTIONS.RATE::NUMERIC(3, 2)
	FROM FORUM_QUESTIONS
	JOIN USERS
	ON (FORUM_QUESTIONS.ASKER_ID = USERS.USER_ID)
	ORDER BY FORUM_QUESTIONS.DATE_OF_ASK DESC;
END;
$$;