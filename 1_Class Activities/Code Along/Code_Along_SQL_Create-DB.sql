CREATE DATABASE IF NOT EXISTS test_db CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
CREATE TABLE IF NOT EXISTS teams (
	team_id INT PRIMARY KEY AUTO_INCREMENT,
    team_name VARCHAR(45) NOT NULL,
    city VARCHAR(45) NOT NULL,
    coach VARCHAR(45),
    captain_id INT 
    );

CREATE TABLE IF NOT EXISTS players (
	player_id INT PRIMARY KEY AUTO_INCREMENT,
    player_name VARCHAR(45) NOT NULL,
    player_position VARCHAR(45),
    skill_level VARCHAR(15),
    team_id INT, FOREIGN KEY (team_id) REFERENCES teams(team_id) 
    );

INSERT INTO teams(team_name, city, coach, captain_id) values (
	"Boston Eagles", "Boston", "Coach Lars", 1
    );
    
INSERT INTO teams(team_name, city, coach, captain_id) values (
	"Hertha", "Berlin", "Coach Ronald", 2
    );
    
INSERT INTO players(player_name, player_postion, skill_level, team_id) values (
	"Ayse", "LW", "A", 1
    );
    
ALTER TABLE players
DROP FOREIGN KEY players_ibfk_1;

DELETE FROM players WHERE player_name="Ronals";  

DROP TABLE players;

CREATE TABLE IF NOT EXISTS players (
	player_id INT PRIMARY KEY AUTO_INCREMENT,
    player_name VARCHAR(45) NOT NULL,
    player_position VARCHAR(45),
    skill_level VARCHAR(15),
    team_id INT, FOREIGN KEY (team_id) REFERENCES teams(team_id) 
    );

SELECT * FROM players;

INSERT INTO players(player_name, player_postion, skill_level, team_id) values (
	"Ayse", "LW", "A", 1
    );

SELECT * FROM players;