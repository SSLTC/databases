USE intro_to_databases;

INSERT INTO groups (name, location, start_date, max_participants)
VALUES ('Back End', 'Ghent', '2023/03/01', 30);

SELECT * FROM groups;

INSERT INTO learners (name, email, active)
VALUES ('Dummy', 'dummy@dummy.be', 1);

SELECT * FROM learners;

CREATE TABLE intro_to_databases.coaches (
id SMALLINT NULL,
name varchar(50) NOT NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_general_ci;
CREATE UNIQUE INDEX learners_id_IDX USING BTREE ON intro_to_databases.learners (id);

INSERT INTO coaches (name)
VALUES ('Yordi');

SELECT * FROM coaches;

DELETE FROM coaches WHERE id=3;

SELECT name AS learner_name, email FROM learners WHERE id=1;

UPDATE groups SET start_date='2023/05/01' WHERE id=1;

SELECT * FROM groups;

ALTER TABLE groups ADD status text(500) NULL;

UPDATE groups SET status='Basile will be sick for a long period' WHERE id=1;

DELETE FROM learners WHERE id=2;

