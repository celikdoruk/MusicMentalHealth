--Creating user_info table
CREATE TABLE user_info (
	submission_id INTEGER PRIMARY KEY,
	timestamp TIMESTAMP,
	age SMALLINT,
	primary_streaming_service TEXT,
	hours_per_day REAL,
 	while_working BOOLEAN,
	instrumentalist BOOLEAN,
	composer BOOLEAN,
	fav_genre TEXT,
	exploratory BOOLEAN,
	foreign_languages  BOOLEAN,
	BPM INTEGER
);

-- Creating the frequency table
CREATE TABLE frequencies (
	submission_id INTEGER PRIMARY KEY,
	classical TEXT,
	country TEXT,
	edm TEXT,
	folk TEXT,
	gospel TEXT,
	hip_hip TEXT,
	jazz TEXT,
	k_pop TEXT,
	latin TEXT,
	lofi TEXT,
	metal TEXT,
	pop TEXT,
	r_and_b TEXT,
	rap TEXT,
	rock TEXT,
	video_game_music TEXT
);

-- Create mental health table
CREATE TABLE mental_health_scores (
	submission_id INTEGER PRIMARY KEY,
	anxiety SMALLINT,
	depression SMALLINT,
	insomnia SMALLINT,
	ocd SMALLINT,
	music_effects TEXT
);







