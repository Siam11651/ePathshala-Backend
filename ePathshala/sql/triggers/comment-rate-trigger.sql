CREATE OR REPLACE FUNCTION COMMENT_RATE_TRIGGER()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
DECLARE
	AVG_RATE NUMERIC;
	ID BIGINT;
BEGIN
	IF NEW.COMMENT_ID IS NOT NULL THEN
		ID := NEW.COMMENT_ID;
	ELSE
		ID := OLD.COMMENT_ID;
	END IF;
	SELECT AVG(RATE) INTO AVG_RATE
	FROM COMMENT_RATES
	WHERE COMMENT_ID = ID AND RATE != 0;
	IF AVG_RATE IS NULL THEN
		AVG_RATE := 0;
	END IF;
	UPDATE COMMENTS
	SET RATE = AVG_RATE
	WHERE COMMENT_ID = ID;
	RETURN NEW;
END;
$$;
CREATE OR REPLACE TRIGGER COMMENT_RATE_TRIGGER
AFTER INSERT OR DELETE OR UPDATE
OF RATE
ON COMMENT_RATES
FOR EACH ROW
EXECUTE PROCEDURE COMMENT_RATE_TRIGGER();