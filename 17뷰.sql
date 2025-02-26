SELECT * FROM EMP_DETAILS_VIEW;

--뷰란?
--제한적인 자료를 보기위해서 미리 만들어 놓은 가상테이블입니다
--자주 사용되는 컬럼만 지정해 놓으면, 관리가 용이해 집니다
--뷰는 물리적으로 데이터가 저장된 형태는 아니고, 원본 테이블을 기반으로 한 논리적 테이블 입니다

--뷰를 생성하려면, 계정이 생성 권한이 있어야 합니다
SELECT * FROM USER_SYS_PRIVS;

--단순 뷰(하나의 테이블에서 만들어진 뷰)
CREATE OR REPLACE VIEW VIEW_EMP
AS (
    SELECT EMPLOYEE_ID AS EMP_ID,
           FIRST_NAME || ' ' || LAST_NAME AS NAME,
           JOB_ID,
           SALARY
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 60
);

SELECT * FROM VIEW_EMP;
--복합 뷰(두 개 이상의 테이블이 조인을 통해서 만들어진 뷰)
CREATE OR REPLACE VIEW VIEW_EMP_JOB
AS (
    SELECT E.EMPLOYEE_ID,
           FIRST_NAME || ' ' || LAST_NAME AS NAME,
           D.DEPARTMENT_NAME,
           L.STREET_ADDRESS,
           J.JOB_TITLE
    FROM EMPLOYEES E
    LEFT JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    LEFT JOIN LOCATIONS L
    ON D.LOCATION_ID = L.LOCATION_ID
    LEFT JOIN JOBS J
    ON E.JOB_ID = J.JOB_ID
);
--뷰를 생성해두면, 데이터를 손쉽게 조회가 가근ㅇ하다
SELECT * FROM VIEW_EMP_JOB;

SELECT JOB_TITLE, COUNT(*) AS CNT FROM VIEW_EMP_JOB
GROUP BY JOB_TITLE; --직무별 직원수

--뷰의 수정은 OR REPLACE를 붙이면 됩니다
CREATE OR REPLACE VIEW VIEW_EMP_JOB
AS (
    SELECT E.EMPLOYEE_ID,
           FIRST_NAME || ' ' || LAST_NAME AS NAME,
           D.DEPARTMENT_NAME,
           L.STREET_ADDRESS,
           J.JOB_TITLE
    FROM EMPLOYEES E
    LEFT JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    LEFT JOIN LOCATIONS L
    ON D.LOCATION_ID = L.LOCATION_ID
    LEFT JOIN JOBS J
    ON E.JOB_ID = J.JOB_ID
    WHERE E.DEPARTMENT_ID = 60
);

--뷰의 삭제 DROP VIEW 뷰 이름
DROP VIEW VIEW_EMP_JOB;
--VIEW를 이용한 DML연산은 가능하긴 하지만, 많은 제약사항이 따릅니다
SELECT * FROM VIEW_EMP_JOB;

INSERT INTO VIEW_EMP(EMP_ID, NAME) VALUES(250, 'HONG'); -- EMP_ID, NAME 가상열이기 때문에 INSERT 불가능
INSERT INTO VIEW_EMP(JOB_ID, SALARY) VALUES('IT_PROG',5000); --물리적 테이블의 NOT NULL위배하기 때문에 불가능
INSERT INTO VIEW_EMP_JOB(EMPLOYEE_ID, JOB_TITLE) VALUES(200, 'TEST'); --복합뷰는 당연히 안됩니다

--------------------------------------------
-뷰의 옵션
-뷰 생성 문장에 마지막에 넣습니다
--WITH CHECK OPTION --WHERE 절에 들어간 컬럼의 변경이나, 추가를 금지제약
--WITH READ ONLY -- 읽기전요유, DML 구문 금지
CREATE OR REPLACE VIEW VIEW_EMP
AS (
    SELECT EMPLOYEE_ID,
           FIRST_NAME,
           EMAIL,
           JOB_ID
           DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID IN (60, 70, 80)
) WITH CHECK OPTION;

SELECT * FROM VIEW_EMP;
UPDATE VIEW_EMP SET DEPARTMENT_ID = 100 WHERE EMPLOYEE_ID = 105; --DEPARTMENT_ID는 60,70,80 이어야만 함 /위에서 그렇게 정했기 때문

CREATE OR REPLACE VIEW VIEW_EMP
AS (
    SELECT EMPLOYEE_ID,
           FIRST_NAME,
           EMAIL,
           JOB_ID
           DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID IN (60, 70, 80)
) WITH READ ONLY; --DML구문 전부 금지 (SELECT만 가능)





















