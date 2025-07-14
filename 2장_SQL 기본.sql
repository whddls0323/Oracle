/*
    -- 날짜: 2025/07/14
    -- 이름: 윤종인
    -- 내용: 2장 SQL 기본
*/
--1. 데이터베이스
-- 실습 1-2. NUMBER 자료형 이해
CREATE TABLE TYPE_TEST_NUMBER (
    num1 NUMBER,
    num2 NUMBER(2),
    num3 NUMBER(3,1),
    num4 NUMBER(4,2),
    num5 NUMBER(5,6),
    num6 NUMBER(6,-1)
);

insert into type_test_number (num1) values (1);
insert into type_test_number (num1) values (123);
insert into type_test_number (num1) values (123.74);
insert into type_test_number (num1) values (123.12345);

insert into type_test_number (num2) values (12);
insert into type_test_number (num2) values (123);
insert into type_test_number (num2) values (1.2);
insert into type_test_number (num2) values (1.23);
insert into type_test_number (num2) values (12.34567);
insert into type_test_number (num2) values (12.56789);
insert into type_test_number (num2) values (123.56789);

insert into TYPE_TEST_NUMBER (num3) values (12);
insert into TYPE_TEST_NUMBER (num3) values (123);
insert into TYPE_TEST_NUMBER (num3) values (12.1);
insert into TYPE_TEST_NUMBER (num3) values (12.1234);
insert into TYPE_TEST_NUMBER (num3) values (12.56789);
insert into TYPE_TEST_NUMBER (num3) values (123.56789);

CREATE TABLE type_test_char (
    char1 CHAR(1),
    char2 CHAR(2),
    char3 CHAR(3),
    vchar1 VARCHAR2(1),
    vchar2 VARCHAR2(2),
    vchar3 VARCHAR2(3),
    nvchar1 NVARCHAR2(1),
    nvchar2 NVARCHAR2(2),
    nvchar3 NVARCHAR2(3)
);

insert into type_test_char (char1) values ('A');
insert into type_test_char (char1) values ('가');

insert into type_test_char (vchar1) values ('A');
insert into type_test_char (vchar2) values ('AB');
insert into type_test_char (vchar3) values ('가');

insert into type_test_char (nvchar1) values ('A');
insert into type_test_char (nvchar2) values ('AB');
insert into type_test_char (nvchar3) values ('가나다');

CREATE TABLE user1 (
    user_id VARCHAR2(20),
    Name VARCHAR2(20),
    hp CHAR(13),
    age NUMBER
);

INSERT INTO user1 VALUES ('A101', '김유신', '010-1234-1111', 25);
INSERT INTO user1 VALUES ('A102', '김춘추', '010-1234-2222', 23);
INSERT INTO user1 VALUES ('A102', '장보고', '010-1234-3333', 32);
INSERT INTO user1 (user_id,name,age) VALUES ('A104','강감찬',45);
INSERT INTO user1 (user_id,name,hp) VALUES ('A105','이순신','010-1234-5555');

SELECT * FROM user1;
SELECT * FROM user1 WHERE user_id = 'A101';
SELECT * FROM user1 WHERE name = '김춘추';
SELECT * FROM user1 WHERE age > 30;
SELECT user_id,name,age FROM user1;

UPDATE user1 SET hp='010-1234-4444' WHERE user_id = 'A104';
UPDATE user1 SET age=51 WHERE user_id = 'A105';
UPDATE user1 SET hp = '010-1234-1001', age = 27 WHERE user_id = 'A101';

DELETE FROM user1 WHERE user_id = 'A101';
DELETE FROM user1 WHERE user_id = 'A102' AND age = 25;
DELETE FROM user1 WHERE age >= 30;

--------------------------------------------------------------------
-- 2. 제약조건
-- primary key(기본키) 컬럼은 중복,null 안됨.
CREATE TABLE user2 (
    user_id VARCHAR2(20) primary key,
    name VARCHAR2(20),
    hp CHAR(13),
    age NUMBER(2)
);


insert into user2 values ('A101','김유신','010-1234-1111',23);
insert into user2 values ('A101','김춘추','010-1234-2222',21);

-- unique 중복 안됨.
CREATE TABLE user3 (
    user_id VARCHAR2(20) primary key,
    name VARCHAR2(20),
    hp CHAR(13) UNIQUE,
    age NUMBER(3)
);

insert into user3 values ('a101','김유신','010-1234-1001',23);
insert into user3 values ('a102','김춘추','010-1234-1002',21);