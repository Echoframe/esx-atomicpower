USE `es_extended`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_atomic','Bank',1),
	('atomic_savings','Bank',0)
;

INSERT INTO `jobs` (name, label) VALUES
	('atomic','Physiker')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('atomic',0,'fahrer','Fahrer',0,'{}','{}'),
	('atomic',1,'physician','Physiker',0,'{}','{}'),
	('atomic',2,'boss','Abteilungsleiter',0,'{}','{}'),
;

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
	('radBox', 'Sicherheitsbox', 1, 0, 1),
	('dirty_uranium', 'schutziges Uran', 1, 0, 1),
	('cleaned_uranium', 'Uran', 1, 0, 1),
	('uranium_rod', 'Uranstäbe', 1, 0, 1),
;