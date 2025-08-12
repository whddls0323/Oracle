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

INSERT INTO user3 VALUES ('a101','김유신','010-1234-1001',23);
INSERT INTO user3 VALUES ('a102','김춘추','010-1234-1002',21);

CREATE TABLE parent (
    pid VARCHAR2(20) primary key,
    name VARCHAR2(20),
    hp CHAR(13) UNIQUE
);

CREATE TABLE child(
    cid VARCHAR2(20) primary key,
    name VARCHAR2(20),
    hp CHAR(13) unique,
    parent VARCHAR2(20),
    FOREIGN KEY(parent) REFERENCES parent(pid)
);

INSERT INTO parent VALUES ('p101','김서현','010-1234-1001');
INSERT INTO parent VALUES ('p102','이성계','010-1234-1002');
INSERT INTO parent VALUES ('p103','신사임당','010-1234-1003');

INSERT INTO child VALUES ('c101','김유신','010-1234-2001','p101');
INSERT INTO child VALUES ('c102','이방우','010-1234-2002','p102');
INSERT INTO child VALUES ('c103','이방원','010-1234-2003','p102');
INSERT INTO child VALUES ('c104','이이','010-1234-2004','p103');
--부모 테이블 p105에 해당하는 값이 없기 때문에 참조 무결성 제약조건 위배
INSERT INTO child VALUES ('c105','김철수','010-1234-2005','p105'); 


CREATE TABLE USER4 (
    NAME VARCHAR2(20) NOT NULL,
    gender CHAR(1) NOT NULL,
    age NUMBER(2) DEFAULT 1,
    addr VARCHAR2(255)
);

INSERT INTO user4 VALUES ('김유신','M',23,'김해시');
INSERT INTO user4 VALUES ('김춘추','M',21,'경주시');
INSERT INTO user4(name,gender,addr) VALUES ('신사임당','F','강릉시');
INSERT INTO user4(name,gender) VALUES ('이순신','M');
INSERT INTO user4(name,age) VALUES ('정약용',33); --성별은 not null(반드시 입력)이기 때문에 해당 쿼리 에러

CREATE TABLE user5 (
    name VARCHAR2(20) not null,
    gender CHAR(1) NOT NULL check(gender IN('M','F')),
    age NUMBER(2) DEFAULT 1 check(age > 0 and age < 100),
    addr VARCHAR2(255)
);

INSERT INTO user5 VALUES('김유신','M',23,'김해시');
INSERT INTO user5 VALUES('김춘추','M',21,'경주시');
INSERT INTO user5(name,gender,addr) VALUES('신사임당','F','강릉시');
INSERT INTO user5(name,gender) VALUES ('김유신','M');
INSERT INTO user5(name,age) VALUES('김유신',33);

CREATE TABLE user7 (
    id NUMBER generated by default as identity primary key,
    name VARCHAR2(20),
    age NUMBER,
    email VARCHAR2(100)
);

insert into user7 (name,age,email) values ('김유신',25,'kim@gmail.com');
insert into user7 (name,age,email) values ('장보고',35,'jang@gmail.com');
insert into user7 (name,age,email) values ('이순신 ',45,'lee@gmail.com');

select * from user7;