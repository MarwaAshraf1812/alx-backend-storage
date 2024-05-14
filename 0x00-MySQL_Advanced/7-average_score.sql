-- Creates a stored procedure ComputeAverageScoreForUser that
-- computes and stores the average score for a student.
DROP PROCEDURE IF EXISTS ComputeAverageScoreForUser;
DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser(user_id INT)
BEGIN
    DECLARE total_score FLOAT DEFAULT 0;
    DECLARE project_counts INT DEFAULT 0;
    DECLARE average_score FLOAT DEFAULT 0;

    -- Calculate the total score for the user
    SELECT SUM(score)
    INTO total_score
    FROM corrections
    WHERE user_id = user_id;

    -- Calculate the number of projects
    SELECT COUNT(DISTINCT project_id)
    INTO project_counts
    FROM corrections
    WHERE user_id = user_id;

    -- Calculate the average score
    IF project_counts > 0 THEN
        SET average_score = total_score / project_counts;
    END IF;

    -- Store the average score in the users table
    UPDATE users
    SET average_score = average_score
    WHERE id = user_id;
END //

DELIMITER ;
