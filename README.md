CREATE TABLE intro_to_databases.learners (
id SMALLINT NULL,
name varchar(50) NOT NULL,
email varchar(50) NOT NULL,
active BOOL DEFAULT 0 NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_general_ci;
CREATE UNIQUE INDEX learners_id_IDX USING BTREE ON intro_to_databases.learners (id);

ALTER TABLE intro_to_databases.groups MODIFY COLUMN id smallint(6) DEFAULT NULL auto_increment NOT NULL PRIMARY KEY;
