-- Number of users of different streaming services
CREATE VIEW num_users_streaming_services AS (
SELECT 
	DISTINCT(primary_streaming_service),
	COUNT(*) as total
FROM 
	user_info
WHERE 
	primary_streaming_service IS NOT NULL
GROUP BY 
	DISTINCT(primary_streaming_service)
);





-- Average age of the dataset
CREATE VIEW avg_age AS (
	SELECT ROUND(AVG(age), 1)
	FROM user_info
);






-- Creating age groups for further analysis in PowerBI
CREATE VIEW user_info_with_age_group AS (
SELECT *,
	CASE
		WHEN age >= 10 AND age < 18 THEN 'children'
		WHEN age >= 18 AND age < 25 THEN 'young_adult'
		WHEN age >= 25 AND age < 45 THEN 'adult'
		WHEN age >= 45 THEN 'mature_adult'
	END AS age_group
FROM user_info
);




--AVG age for different streaming service users
CREATE VIEW average_age_different_streaming_services AS (
SELECT
	ROUND(AVG(age), 1) AS average_age,
	primary_streaming_service
FROM user_info
WHERE primary_streaming_service IS NOT NULL
GROUP BY primary_streaming_service
ORDER BY 
	average_age ASC
);






-- Count of favourite genres among the dataset
CREATE VIEW count_of_fav_genres AS (
SELECT
	DISTINCT(fav_genre) as favourite_genres,
	COUNT(*)
FROM 
	user_info
GROUP BY 
	favourite_genres
ORDER BY
	COUNT(*) DESC
LIMIT 10
);







-- AVG hours of daily listening by different age groups
CREATE VIEW avg_daily_listening_age_groups AS (
WITH age_group_avg_listening AS (SELECT 
	CASE
		WHEN age < 18 THEN 'children'
		WHEN age >= 18 AND age < 25 THEN 'young_adult'
		WHEN age >= 25 AND age < 45 THEN 'adult'
		WHEN age >= 45 THEN 'mature_adult'
	END AS age_group, 
	AVG(hours_per_day) AS average_hours 
FROM
	user_info
WHERE 
	age IS NOT NULL
GROUP BY
	age_group)

SELECT 
	age_group,
	ROUND(average_hours::NUMERIC, 2) AS avg_daily_listening
FROM 
	age_group_avg_listening
);







-- AVG mental health scores scores for different music genre listeners
CREATE VIEW avg_mhealth_scores_different_genres AS (
SELECT 
	u.fav_genre,
	ROUND(AVG(m.anxiety::NUMERIC), 1) AS avg_anxiety_score,
	ROUND(AVG(m.depression::NUMERIC), 1) AS avg_depression_score,
	ROUND(AVG(m.insomnia::NUMERIC), 1) AS avg_insomnia_score,
	ROUND(AVG(m.ocd::NUMERIC), 1) AS avg_ocd_score
FROM 
	user_info u 
LEFT JOIN 
	mental_health_scores m ON u.submission_id = m.submission_id
GROUP BY 
	u.fav_genre
ORDER BY 
	avg_anxiety_score ASC
LIMIT 10
);








-- AVGs for rock listeners
CREATE VIEW avg_rock_listeners AS (
SELECT
	f.rock,
	ROUND(AVG(m.anxiety::NUMERIC), 1) AS avg_anxiety,
	ROUND(AVG(m.depression::NUMERIC), 1) AS avg_depression_score,
	ROUND(AVG(m.insomnia::NUMERIC), 1) AS avg_insomnia_score,
	ROUND(AVG(m.ocd::NUMERIC), 1) AS avg_ocd_score
FROM 
	frequencies f
JOIN
	mental_health_scores m ON f.submission_id = m.submission_id
GROUP BY 
	f.rock
);






-- AVGs for rap listeners
CREATE VIEW avg_rap_listeners AS (
SELECT
	f.rap,
	ROUND(AVG(m.anxiety::NUMERIC), 1) AS avg_anxiety,
	ROUND(AVG(m.depression::NUMERIC), 1) AS avg_depression_score,
	ROUND(AVG(m.insomnia::NUMERIC), 1) AS avg_insomnia_score,
	ROUND(AVG(m.ocd::NUMERIC), 1) AS avg_ocd_score
FROM 
	frequencies f
JOIN
	mental_health_scores m ON f.submission_id = m.submission_id
GROUP BY 
	f.rap
);







-- Count of instrumentalist and composers
CREATE VIEW count_instrumentalist_composers AS (
SELECT 
	COUNT(CASE WHEN instrumentalist IS TRUE THEN 1 END) AS instrumentalists,
	COUNT(CASE WHEN instrumentalist IS FALSE THEN 1 END) AS non_instrumentalist,
	COUNT(CASE WHEN composer IS TRUE THEN 1 END) AS composers,
	COUNT(CASE WHEN composer IS FALSE THEN 1 END) AS non_composers
FROM
	user_info
);











-- Grouping hourly listener groups
CREATE VIEW user_info_with_hourly_listeners AS (
SELECT *,
	CASE
		WHEN hours_per_day < 2 THEN 'couple hours a day or less'
		WHEN hours_per_day >=2 AND hours_per_day < 4 THEN '2-4 hours a day'
		WHEN hours_per_day >=4 AND hours_per_day < 8 THEN '4-8 hours a day'
		WHEN hours_per_day >=8  THEN 'more than 8 hours a day'
	END AS how_much_listens
FROM 
	user_info
);









-- Number of people who think music has an effect on their wellbeing and mental health
CREATE VIEW num_music_effect AS (
SELECT 
	DISTINCT(music_effects),
	COUNT(*) AS no_of_people
FROM 
	mental_health_scores
WHERE 
	music_effects IS NOT NULL
GROUP BY 
	DISTINCT(music_effects)
ORDER BY 
	COUNT(*) DESC
);










	
