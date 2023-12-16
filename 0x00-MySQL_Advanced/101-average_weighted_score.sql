-- SQL script that creates a stored procedure ComputeAverageWeightedScoreForUsers that computes and store the average weighted score for all students

DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers;
DELIMITER $$
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE user_id INT;
    DECLARE weighted_score DECIMAL(10, 2);

    DECLARE user_cursor CURSOR FOR
        SELECT DISTINCT user_id FROM corrections;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN user_cursor;

    user_loop: LOOP
        FETCH user_cursor INTO user_id;
        IF done THEN
            LEAVE user_loop;
        END IF;

        SELECT SUM(corrections.score * projects.weight) INTO weighted_score
        FROM corrections
        INNER JOIN projects ON corrections.project_id = projects.id
        WHERE corrections.user_id = user_id;

        DECLARE total_weight DECIMAL(10, 2);
        SELECT SUM(projects.weight) INTO total_weight
        FROM corrections
        INNER JOIN projects ON corrections.project_id = projects.id
        WHERE corrections.user_id = user_id;

        UPDATE users
        SET average_score = IF(total_weight = 0, 0, weighted_score / total_weight)
        WHERE id = user_id;
    END LOOP;

    CLOSE user_cursor;
END $$
DELIMITER ;
