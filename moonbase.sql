-- Uppgift 1: Create Succesfull mission table
# CREATE TABLE succesfull_mission AS
#     SELECT moon_mission.mission_id,
#            moon_mission.spacecraft,
#            moon_mission.launch_date,
#            moon_mission.carrier_rocket,
#            moon_mission.operator,
#            moon_mission.mission_type,
#            moon_mission.outcome
#     FROM moon_mission
#     WHERE moon_mission.outcome = 'Successful';

-- Uppgift 2:
# ALTER TABLE succesfull_missions AUTO_INCREMENT = 1;
# ALTER TABLE succesfull_missions ADD PRIMARY KEY (mission_id);

-- Uppgift 3:
# UPDATE moon_mission
# SET operator = REPLACE(operator, ' ', '')
# WHERE operator IS NOT NULL;
#
# UPDATE succesfull_missions
# SET operator = REPLACE(operator,' ', '')
# WHERE operator IS NOT NULL;

-- Uppgift 4:
# DELETE FROM succesfull_missions
# WHERE launch_date >= '2010-01-01';

-- Uppgift 5:

# ALTER TABLE account
# ADD gender VARCHAR(255);
#
# UPDATE account
# SET gender = CASE
#                  WHEN account.gender IS NULL AND
#                       CAST(SUBSTRING(ssn, LENGTH(ssn), 1) AS UNSIGNED) % 2 = 0 THEN 'Female'
#                  ELSE 'Male'
#     END
# WHERE account.gender IS NULL;
#
# SELECT *,
#        CONCAT(first_name, ' ', last_name) AS name
# FROM account;

-- Uppgift 6

# DELETE FROM account
# WHERE gender = 'Female'
#     AND CAST(SUBSTRING(ssn, 1, 2) AS UNSIGNED) < 70;

-- Uppgift 7
# SELECT gender,
# FLOOR(YEAR(CURDATE()) - AVG(CAST(CONCAT('19',SUBSTRING(ssn, 1, 2)) AS UNSIGNED))) AS avg_age
# FROM account
# GROUP BY gender;


