select 1;

CREATE USER test WITH PASSWORD 'test';

DROP DATABASE if exists test;
CREATE DATABASE test;
GRANT ALL PRIVILEGES ON DATABASE test to test;

DROP DATABASE if exists test1;
CREATE DATABASE test1;
GRANT ALL PRIVILEGES ON DATABASE test1 to test;

DROP DATABASE if exists test2;
CREATE DATABASE test2;
GRANT ALL PRIVILEGES ON DATABASE test2 to test;

ALTER USER test CREATEDB;
ALTER USER test CREATEROLE;
ALTER USER test WITH SUPERUSER;
ALTER USER test CREATEDB;
ALTER USER test CREATEROLE;
ALTER USER test WITH SUPERUSER;
CREATE EXTENSION IF NOT EXISTS pg_trgm;
