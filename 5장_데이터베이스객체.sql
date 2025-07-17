/*
    날짜: 2025/07/17
    이름: 윤종인
    내용: 5장 데이터베이스 객체
*/

--1)데이터사전(DataDictionary)
select * from dictionary;

select table_name from user_tables;
select owner,table_name from all_tables;
select * from dba_tables;

--2)인덱스(Index)
select * from user_indexes;
select * from user_ind_columns;

create index idx_user1_id on USER1(user_ID);
select * from user_ind_columns;


--3)뷰(View)
create view VW_USER1 as (select name,hp,age from user1);
create view VW_USER2_AGE_UNDER30 as (select * from user2 where age < 30);
select * from user_views;

--4)시퀀스(Sequence)
create table user6 (
    seq number primary key,
    name varchar2(20),
    gender char(1),
    age number,
    addr varchar2(255)
);

create sequence seq_user6 increment by 1 start with 1;
insert into user6 values(seq_user6.nextVal,'김유신','M',25,'김해시');
insert into user6 values(seq_user6.nextVal,'김춘추','M',23,'경주시');
insert into user6 values(seq_user6.nextVal,'신사임당','f',27,'강릉시');

--1)사용자생성
alter session set "_ORACLE_SCRIPT"=true; //Oracle에서 내부 스크립트 실행이나 일반 사용자 생성을 가능하게 하기 위한 세션 설정
create user test1 identified by 1234;

select * from all_users;

alter user test1 identified by 1111;

-- 2)권한관리
grant connect,resource to test1;
grant unlimited tablespace to test1;

--1)조건문
declare
    num number := 1;
begin
    if num > 0 then
        dbms_output.put_line('num은 0보다 크다.');
    end if;
    dbms_output.put_line('PL/SQl 종료...');
end;
/

declare
    num number := -1;
begin
    if num > 0 then
        dbms_output.put_line('num은 0보다 크다.');
    else
        dbms_output.put_line('num은 0보다 작다.');
    end if;
    dbms_output.put_line('PL/SQL 종료...');
end;
/

declare
    score number := 86;
begin
    if score >= 90 and score <= 100 then
        dbms_output.put_line('A 입니다.');
    elsif score >= 80 and score < 90 then
        dbms_output.put_line('B 입니다.');
    elsif score >= 70 and score < 80 then
        dbms_output.put_line('C 입니다.');
    elsif score >= 60 and score < 70 then
        dbms_output.put_line('D 입니다.');
    else
        dbms_output.put_line('F 입니다.');
    end if;
end;
/

declare
    score number := 86;
begin
    case floor(score/10)
        when 9 then dbms_output.put_line('A입니다.');
        when 9 then dbms_output.put_line('A입니다.');
        when 9 then dbms_output.put_line('A입니다.');
        when 9 then dbms_output.put_line('A입니다.');
        else dbms_output.put_line('F 입니다.');
    end case;
    dmbs_output.put_line('PL/SQL 종료...');
end;

declare
    num number := 0;
begin
    loop
        dbms_output.put_line('num: ' || num);
        num := num + 1;
        
        if num > 3 then
            exit;
        end if;
    end loop;
    dbms_output.put_line('PL/SQL 종료...');
end;
/

begin
    for i in 1..3 loop
        dbms_output.put_line('i: ' || i);
    end loop;
    dbms_output.put_line('PL/SQL 종료...');
end;

declare
    num number := 0;
begin
    while num < 4 loop
        dbms_output.put_line('num: ' || num);
        num := num + 1;
    end loop;
    dbms_output.put_line('PL/SQL 종료...');
end;

declare
    num number := 0;
begin
    while num < 5 loop
        num := num + 1;
        
        if mod(num,2) = 0 then
            continue;
        end if;
        
        dbms_output.put_line('num: ' || num);
    end loop;
    dbms_output.put_line('PL/SQL 종료...');
end;
/

begin
    for i in 1..5 loop
        continue when mod(i,2) = 0;
        dbms_output.put_line('i: ' || i);
    end loop;
    dbms_output.put_line('PL/SQL종료...');
end;