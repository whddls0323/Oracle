-- 생성자 Oracle SQL Developer Data Modeler 24.3.1.347.1153
--   위치:        2025-08-11 11:30:14 KST
--   사이트:      Oracle Database 21c
--   유형:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE bank_account (
    a_no        CHAR(11 BYTE) NOT NULL,
    a_item_dist CHAR(2 BYTE) NOT NULL,
    a_item_name VARCHAR2(20 BYTE) NOT NULL,
    a_c_no      VARCHAR2(14 BYTE),
    a_balance   NUMBER NOT NULL,
    a_open_date DATE NOT NULL
);

ALTER TABLE bank_account ADD CONSTRAINT bank_account_pk PRIMARY KEY ( a_no );

CREATE TABLE bank_customer (
    c_no    VARCHAR2(14 BYTE) NOT NULL,
    c_name  VARCHAR2(20 BYTE) NOT NULL,
    c_dist  NUMBER NOT NULL,
    c_phone CHAR(13 BYTE) NOT NULL,
    c_addr  VARCHAR2(50 BYTE)
);

ALTER TABLE bank_customer ADD CONSTRAINT bank_customer_pk PRIMARY KEY ( c_no );

CREATE TABLE bank_transaction (
    t_no       NUMBER NOT NULL,
    t_a_no     CHAR(11 BYTE) NOT NULL,
    t_dist     NUMBER NOT NULL,
    t_amount   NUMBER NOT NULL,
    t_datetime DATE NOT NULL
);

ALTER TABLE bank_transaction ADD CONSTRAINT bank_transaction_pk PRIMARY KEY ( t_no );

ALTER TABLE bank_account
    ADD CONSTRAINT bank_account_bank_customer_fk FOREIGN KEY ( a_c_no )
        REFERENCES bank_customer ( c_no );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE bank_transaction
    ADD CONSTRAINT bk_transaction_bk_acnt_fk FOREIGN KEY ( t_a_no )
        REFERENCES bank_account ( a_no );

CREATE SEQUENCE bank_transaction_t_no_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER bank_transaction_t_no_trg BEFORE
    INSERT ON bank_transaction
    FOR EACH ROW
    WHEN ( new.t_no IS NULL )
BEGIN
    :new.t_no := bank_transaction_t_no_seq.nextval;
END;
/

-- 실습 6-5
insert into bank_customer values('730423-1000001','김유신',1,'010-1234-1001','경남 김해시');
insert into bank_customer values('730423-1000002','김춘추',1,'010-1234-1002','경남 경주시');
insert into bank_customer values('750423-1000003','장보고',1,'010-1234-1003','전남 완도군');
insert into bank_customer values('102-12-51094','(주)정보산업',2,'051-500-1004','부산시 부산진구');
insert into bank_customer values('930423-1000005','이순신',1,'010-1234-1005','서울 종로구');

insert into bank_account values('101-11-1001','S1','자유저축예금','730423-1000001',1550000,'2011-04-11');
insert into bank_account values('101-11-1002','S1','자유저축예금','930423-1000005',260000,'2011-05-12');
insert into bank_account values('101-11-1003','S1','자유저축예금','750423-1000003',75000,'2011-06-13');
insert into bank_account values('101-12-1001','S2','기업전용예금','102-12-51094',15000000,'2011-07-14');
insert into bank_account values('101-13-1001','S3','정기저축예금','730423-1000002',1200000,'2011-08-15');


insert into bank_transaction(t_a_no,t_dist,t_amount,t_datetime) values('101-11-1001',1,50000,'2023-01-01 13:15:10');
insert into bank_transaction(t_a_no,t_dist,t_amount,t_datetime) values('101-12-1001',2,1000000,'2023-01-02 13:15:12');
insert into bank_transaction(t_a_no,t_dist,t_amount,t_datetime) values('101-11-1002',3,260000,'2023-01-03 13:15:14');
insert into bank_transaction(t_a_no,t_dist,t_amount,t_datetime) values('101-11-1002',2,100000,'2023-01-04 13:15:16');
insert into bank_transaction(t_a_no,t_dist,t_amount,t_datetime) values('101-11-1003',3,75000,'2023-01-05 13:15:18');
insert into bank_transaction(t_a_no,t_dist,t_amount,t_datetime) values('101-11-1001',1,150000,'2023-01-05 13:15:28');

-- 실습 6-6
select c_no,c_name,c_phone,a_no,a_item_name,a_balance from bank_customer c
join bank_account a on c.c_no=a.a_c_no;

select t_dist,t_amount,t_datetime from bank_customer c join bank_account a on c.c_no=a.a_c_no
join bank_transaction t on a.a_no=t.t_a_no where c_name='이순신';

select c_no,c_name,a_no,a_balance,a_open_date from bank_customer c
join bank_account a on c.c_no=a.a_c_no where c_dist=1
order by a_balance desc fetch first 1 rows only;