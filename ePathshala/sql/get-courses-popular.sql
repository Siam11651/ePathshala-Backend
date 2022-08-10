SELECT 
    COURSES.COURSE_ID AS COURSE_ID, 
    TITLE,
    DESCRIPTION, 
    DATE_OF_CREATION, 
    PRICE, 
    CREATOR_ID,
    FULL_NAME AS CREATOR_NAME, 
    COUNT(USERS.USER_ID) AS ENROLL_COUNT
FROM COURSES
JOIN ENROLLED_COURSES
ON(COURSES.COURSE_ID = ENROLLED_COURSES.COURSE_ID)
JOIN USERS
ON(COURSES.CREATOR_ID = USERS.USER_ID)
GROUP BY COURSES.COURSE_ID, TITLE, DESCRIPTION, DATE_OF_CREATION, PRICE, CREATOR_ID, CREATOR_NAME
ORDER BY ENROLL_COUNT