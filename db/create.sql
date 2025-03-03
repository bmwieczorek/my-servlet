SET DATABASE EVENT LOG SQL LEVEL 3;
CREATE SCHEMA MY_SCHEMA;
CREATE TABLE MY_SCHEMA.USER_PASSWORD ( USERNAME VARCHAR(50) not null constraint USER_PASSWORD_PK primary key, PASSWORD VARCHAR(50) not null );
CREATE UNIQUE INDEX MY_SCHEMA.USER_PASSWORD_USERNAME_UINDEX on MY_SCHEMA.USER_PASSWORD (USERNAME);
CREATE TABLE MY_SCHEMA.USER_PASSWORD_BASE64 ( USERNAME VARCHAR(50) not null constraint USER_PASSWORD_BASE64_PK primary key, PASSWORD VARCHAR(1024) not null );
CREATE UNIQUE INDEX MY_SCHEMA.USER_PASSWORD_BASE64_USERNAME_UINDEX on MY_SCHEMA.USER_PASSWORD_BASE64 (USERNAME);
CREATE TABLE MY_SCHEMA.USER_PASSWORD_HASH ( USERNAME VARCHAR(50), HASH VARBINARY(1024) );
CREATE TABLE MY_SCHEMA.USER_REVIEW ( USERNAME VARCHAR(50), REVIEW VARCHAR(2028) );
CREATE TABLE MY_SCHEMA.USER_BALANCE ( USERNAME VARCHAR(50), BALANCE DECIMAL(10,2) );
CREATE TABLE MY_SCHEMA.USER_TRANSACTION_HISTORY ( TRANSACTION_DATE TIMESTAMP, TYPE VARCHAR(50), SENDER VARCHAR(50), RECIPIENT VARCHAR(50), TRANSACTION_AMOUNT DECIMAL(10,2), RESULT_BALANCE DECIMAL(10,2));
