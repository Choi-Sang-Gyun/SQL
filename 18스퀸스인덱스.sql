--시퀀스(순차적으로 증가하는 값)
--보통 PK를 지정하는데 사용할 수 있음
SELECT * FROM USER_SEQUENCES;

-생성
CREATE SEQUENCE DEPTS_SEQ; --기본값으로 지정이 되면서 시퀀스가 생성됩니다
DROP SEQUENCE DEPTS_SEQ; --삭제

CREATE SEQUENCE DEPTS_SEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 10
    MINVALUE 1
    NOCYCLE -- 스퀀스가 MAX에 도달했을 때 재사용X
    NOCACHE; -- 시퀀스는 메모리(캐시)에 두지 않음

----------------------------------------------------------------------
DROP TABLE DEPTS;
CREATE TABLE DEPTS(
    DEPT_NO NUMBER(2) PRIMARY KEY,
    DEPT_NAME VARCHAR2(30)

);

--시퀀스 사용 방법 2가지
SELECT DEPTS_SEQ.CURRVAL FROM DUAL; --NEXTVAL가 한번 실행 되고 난 이후에 확인 가능
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL; -- 한번 NEXTVAL가 일어나면 후진은 불가

INSERT INTO DEPTS VALUES (DEPTS_SEQ.NEXTVAL, 'EXAMPLE'); --MAXVALUE에 도달하면, 더 이상 사용이 불가능

SELECT * FROM DEPTS;

--시퀀스의 수정
ALTER SEQUENCE DEPTS_SEQ MAXVALUE 1000;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 10;
--시퀀스가 이미 테이블에서 사용중에 있으면, 시퀀스는 DROP하면 안됩니다
--주기적으로 시퀀스를 초기화 해야 한다면? (꼼수)
--EX) PK - SEQUENCE <- 이렇게만 하면 숫자가 계속 늘어나고 초기화 불가
--       - YYYY-SEQUENCE <- 이렇게 년도를 넣으면 초기화도 가능
--시퀀스 증가값을 -현재값으로 바꾸고
SELECT DEPTS_SEQ.CURRVAL FROM DUAL;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY -50 MINVALUE 0;
--전진을 시킴
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;
--다시 시퀀스 증가값을 양수값으로 바꿔
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 1;
--시퀀스가 초기화
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;
--문제
--
CREATE TABLE DEPTS2(
    EMPS_NO VARCHAR2(30) PRIMARY KEY,
    EMPS_NAME VARCHAR2(30)
);
--이 테이블에 PK를 2025-00001 형식으로 INSERT하려고 합니다
--다음 값은 2025-00002 형식이 됩니다
--시퀀스를 만들고 INSERT 넣을 때, 위 형식처럼 값이 들어갈 수 있도록 INSERT를 넣어주세요

SELECT * FROM DEPTS2;
CREATE SEQUENCE EMPS_SEQ NOCACHE;

INSERT INTO EMPS VALUES (TO_CHAR(SYSDATE, 'YYYY') || '-' || 
                        LPAD(EMPS_SEQ.NEXTVAL, 5, 0), 'EXAMPLE') ;
;

------------------------------------------------------------------------------
--인덱스 (검색을 빠르게 하는 HINT역할)
--INDEX의 종류로는 고유인덱스, 비고유인덱스가 있습니다
--고유인덱스(PK, UK)를 만들때 자동으로 생성되는 인덱스입니다
--비고유인덱스는 일반 컬럼에 지정해서 조회를 빠르게 할 수 있는 인덱스 입니다
--단, INDEX는 조회를 빠르게 하지만, 무작위하게 많이 사용되면 오히려 성능저하를 나타낼 수도 있습니다
--주로 사용되는 컬럼에서 SELECT절이 속도저하가 있으면, 일단 먼저 고려해볼 사항이 인덱스 입니다

DROP TABLE EMPS;
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES);

SELECT * FROM EMPS WHERE FIRST_NAME = 'Nancy';
--FIRST_NAME 컬럼에 인덱스 부착
CREATE INDEX EMPS_IDX ON EMPS(FIRST_NAME);
SELECT * FROM EMPS WHERE FIRST_NAME = 'Nancy';
--인덱스 삭제(삭제 하더라도 테이블에 영향을 미치지 않습니다)
DROP INDEX EMPS_IDX;
--결합 인덱스 (여러 컬럼을 묶어서 생성할 수 있습니다)
CREATE INDEX EMPS_IDX ON EMPS(FIRST_NAME, LAST_NAME);
SELECT * FROM EMPS WHERE FIRST_NAME = 'Nancy'; --인덱스 힌트를 받음
SELECT * FROM EMPS WHERE FIRST_NAME = 'Nancy' AND LAST_NAME = 'Greenberg'; --인덱스 힌트를 받음
SELECT * FROM EMPS WHERE LAST_NAME = 'Greenberg'; --인덱스 힌트를 못 받음
--고유인덱스(만들 일은 사실상 없긴 함)
CREATE UNIQUE INDEX 인덱스명 ON 테이블명(부착할 컬럼); --PK, UK 만들 때 자동 생성해 줍니다(PK, UK 조회할 때 인덱스 효과를 받음)

SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;







