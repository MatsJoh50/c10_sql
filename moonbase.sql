# --Uppgift 1: Create Succesfull mission table
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

#--Uppgift 2:
# ALTER TABLE succesfull_missions AUTO_INCREMENT = 1;
# ALTER TABLE succesfull_missions ADD PRIMARY KEY (mission_id);

#--Uppgift 3:
# UPDATE moon_mission
# SET operator = REPLACE(operator, ' ', '')
# WHERE operator IS NOT NULL;
#
# UPDATE succesfull_missions
# SET operator = REPLACE(operator,' ', '')
# WHERE operator IS NOT NULL;

