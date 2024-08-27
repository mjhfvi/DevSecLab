CREATE DATABASE employees;

\du
\l

GRANT CONNECT ON DATABASE employees TO postgres;
\connect employees
GRANT SELECT ON ALL TABLES IN SCHEMA public TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO postgres;

CREATE TABLE employees (id SERIAL PRIMARY KEY,name VARCHAR(100),position VARCHAR(100));

INSERT INTO employees (name, position) VALUES ('tzahi01', 'Developer');
INSERT INTO employees (name, position) VALUES ('tzahi02', 'Designer');
INSERT INTO employees (name, position) VALUES ('tzahi03', 'Devops');

SELECT * FROM employees;
