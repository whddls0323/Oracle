--p71
select ename,initcap(ename) "INITCAP" from emp where deptno = 10;
select name,INITCAP(name) "INITCAP" from professor where deptno = 101;

--p72
select ename,lower(ename) "LOWER", upper(ename) "UPPER" from emp where deptno = 10;

--p73
select ename,length(ename) "LENGTH", lengthb(ename) "LENGTH" from emp where deptno = 20;
select '서진수' "NAME",length('서진수') "LENGTH",lengthb('서진수') "LENGTHB" from dual;

--p74
select ename,length(ename) from emp where length(ename) > length('&ename');

select concat(ename,job) from emp where deptno = 10;

--p75
select substr('abcde',3,2) "3,2",substr('abcde',-3,2) "-3,2",substr('abcde',-3,4) "-3,4" from dual;

--p76
select name,substr(jumin,3,4) "Birthday", substr(jumin,3,4) -1 "Birthday -1" from student where deptno1 = 101;

SELECT '서진수' "NAME", SUBSTR('서진수',1,2) "SUBSTR", SUBSTRB('서진수',1,3) "SUBSTRB" from dual;

--p77
select 'A-B-C-D',instr('A-B-C-D','-',1,3) "INSTR" from dual;
select 'A-B-C-D',instr('A-B-C-D','-',3,1) "INSTR" from dual;
select 'A-B-C-D',instr('A-B-C-D','-',-1,3) "INSTR" from dual;

--p78
select 'A-B-C-D',instr('A-B-C-D','-',-6,2) "INSTR" from dual;

select name,tel,instr(tel,')') from student where deptno1 = 201;

--p79
select name,tel,instr(tel,'3') from student where deptno1 = 101;

--p80
select name,id,lpad(id,10,'*') from student where deptno1 = 201;

--p81
select rpad(ename,10,'-') "RPAD" from emp where deptno = 10;

--p82
select ename from emp where deptno = 10;
select ltrim(ename,'C') from emp where deptno = 10;

--p83
select ename,rtrim(ename,'R') "RTRIM" from emp where deptno = 10;

--p84
select ename,replace(ename,substr(ename,1,2),'**') "REPLACE" from emp where deptno = 10;

--p86
select round(987.654,2) "ROUND1", round(987.654,0) "ROUND2", round(987.654,-1) "ROUND3" from dual;

--p87
select trunc(987.654,2) "TRUNC1", trunc(987.654,0) "TRUNC2", trunc(987.654,-1) "TRUNC3" from dual;

select mod(121,10) "MOD",ceil(123.45) "CEIL",floor(123.45) "FLOOR" from dual;

--p88
select rownum "ROWNO",ceil(rownum/3) "TEAMNO",ename from emp;

select power(2,3) from dual;

--p90
select sysdate from dual;

--p91
select months_between('14/09/30','14/08/31') from dual;

--p92
select months_between('14/08/31','14/09/30') from dual;
select months_between('12/02/29','12/02/01') from dual;
select months_between('14/04/30','14/04/01') from dual;

--p93