/*
    날짜: 2025/07/17
    이름: 윤종인
    내용: 6장 PL/SQL
*/

-- 1. PL/SQL구조
set serveroutput on;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello, Oracle!');
END;    

DECLARE
    NO NUMBER(4) := 1001;
    NAME VARCHAR2(10) := '홍길동';
    HP CHAR(13) := '010-1000-1001';
    ADDR VARCHAR2(100) := '부산광역시';
BEGIN
    DBMS_OUTPUT.PUT_LINE('번호: ' || NO);
    DBMS_OUTPUT.PUT_LINE('이름: ' || NAME);
    DBMS_OUTPUT.PUT_LINE('전화: ' || HP);
    DBMS_OUTPUT.PUT_LINE('주소: ' || ADDR);
END;    
/
--2.변수와상수
set serveroutput on;
DECLARE
    NO CONSTANT NUMBER(4) := 1001;
    NAME VARCHAR2(10);
    HP CHAR(13) := '000-0000-0000';
    AGE NUMBER(2) DEFAULT 1;
    ADDR VARCHAR2(10) NOT NULL := '부산';
BEGIN
    NAME := '김유신';
    HP := '010-1000-1001';
    DBMS_OUTPUT.PUT_LINE('번호: ' || NO);
    DBMS_OUTPUT.PUT_LINE('이름: ' || NAME);
    DBMS_OUTPUT.PUT_LINE('전화: ' || HP);
    DBMS_OUTPUT.PUT_LINE('나이: ' || AGE);
    DBMS_OUTPUT.PUT_LINE('주소: ' || ADDR);
END;
/

DECLARE
    NO DEPT.DEPTNO%TYPE;
    NAME DEPT.DNAME%TYPE;
    DTEL DEPT.DTEL%TYPE;
BEGIN
    SELECT *
    INTO NO,NAME,DTEL
    FROM DEPT
    WHERE DEPTNO = 30;
    
    DBMS_OUTPUT.PUT_LINE('부서번호: ' || NO);
    DBMS_OUTPUT.PUT_LINE('부서명: ' || NAME);
    DBMS_OUTPUT.PUT_LINE('주소: ' || DTEL);
END;
/

DECLARE
    ROW_DEPT DEPT%ROWTYPE;
BEGIN
    SELECT *
    INTO ROW_DEPT
    FROM DEPT
    WHERE DEPTNO = 40;
    
    DBMS_OUTPUT.PUT_LINE('부서번호: ' || ROW_DEPT.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('부서명: ' || ROW_DEPT.DNAME);
    DBMS_OUTPUT.PUT_LINE('주소: ' || ROW_DEPT.DTEL);
END;
/
    
DECLARE
    TYPE REC_DEPT IS RECORD(
        deptno NUMBER(2),
        dname DEPT.DNAME%TYPE,
        dtel DEPT.DTEL%Type
    );
    
    dept_rec REC_DEPT;
BEGIN
    dept_rec.deptno := 10;
    dept_rec.dname := '개발부';
    dept_rec.dtel := '051-512-1010';
    
    DBMS_OUTPUT.PUT_LINE('deptno: ' || dept_rec.deptno);
    DBMS_OUTPUT.PUT_LINE('dname: ' || dept_rec.dname);
    DBMS_OUTPUT.PUT_LINE('dtel: ' || dept_rec.dtel);
END;
/

DECLARE
    TYPE ARR_CITY IS TABLE OF VARCHAR2(20) INDEX BY PLS_INTEGER;
    arrCity ARR_CITY;
BEGIN
    arrCity(1) := '서울';
    arrCity(2) := '대전';
    arrCity(3) := '대구';
    
    DBMS_OUTPUT.PUT_LINE('arrCity(1): ' || arrCity(1));
    DBMS_OUTPUT.PUT_LINE('arrCity(2): ' || arrCity(2));
    DBMS_OUTPUT.PUT_LINE('arrCity(3): ' || arrCity(3));
END;
/

--4.커서와 예외처리
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
    
    CURSOR c1 IS SELECT * FROM DEPT WHERE DEPTNO=40;
BEGIN
    OPEN c1;
    
    FETCH c1 INTO V_DEPT_ROW;
    
    DBMS_OUTPUT.PUT_LINE('DEPTNO:' || V_DEPT_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME:' || V_DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('DTEL:' || V_DEPT_ROW.DTEL);
    
    CLOSE c1;
END;
/
DECLARE
    V_EMP_ROW EMP%ROWTYPE;
    CURSOR emp_cursor IS SELECT * FROM EMP;
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO V_EMP_ROW;
        
        EXIT WHEN emp_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('------------------------------');
        DBMS_OUTPUT.PUT_LINE('EMPNO: ' || V_EMP_ROW.EMPNO);
        DBMS_OUTPUT.PUT_LINE('NAME: ' || V_EMP_ROW.NAME);
        DBMS_OUTPUT.PUT_LINE('REGDATE: ' || V_EMP_ROW.REGDATE);
    END LOOP;
END;
/

DECLARE
    CURSOR c1 IS SELECT * FROM DEPT;
BEGIN
    FOR c1_rec IN c1 LOOP
        DBMS_OUTPUT.PUT_LINE('------------------------------');
        DBMS_OUTPUT.PUT_LINE('DEPTNO: ' || c1_rec.DEPTNO);
        DBMS_OUTPUT.PUT_LINE('DNAME: ' || c1_rec.DNAME);
        DBMS_OUTPUT.PUT_LINE('DTEL: ' || c1_rec.DTEL);
    END LOOP;
END;
/

--5.저장서브프로그램
CREATE PROCEDURE hello_procedure (p_name IN VARCHAR2)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('안녕하세요, ' || p_name || '님!');
    DBMS_OUTPUT.PUT_LINE('환영합니다.');
END;
/

execute hello_procedure('홍길동');
execute hello_procedure('김철수');

drop procedure hello_procedure;

CREATE FUNCTION get_emp_name(p_empno NUMBER) RETURN VARCHAR2
IS
    v_ename VARCHAR2(20);
BEGIN
    select name into v_ename from emp where empno=p_empno;
    RETURN v_ename;
END;
/

select get_emp_name(1001) from dual;

CREATE TABLE emp_log (
    log_date date,
    empno number,
    action varchar2(10)
);

create trigger trgg_emp_insert
after insert on emp
for each row
begin
    insert into emp_log (log_date,empno,action)
    values (sysdate,:NEW.empno,'INSERT');
end;
/

insert into emp values(2002,'김춘추','M','대리',10,sysdate);