--숫자함수
--ROUND -반올림
SELECT ROUND(45.923, 2), ROUND(45.923, 0), ROUND(45.923, -1) FROM DUAL;
--TRUNC -절삭(버림)
SELECT TRUNC(45.923, 2), TRUNC(45.923), TRUNC(45.923, -1) FROM DUAL; --매개값을 하나만 주면, 자리수가 0까지(정수 부분까지)
--ABS -절대값, CEIL - 올림, FLOOR 내림(무조건 정수로만/절삭은 원하는 범위까지 가능), MOD 나머지
SELECT ABS(-3), CEIL(3.14), FLOOR(3.14), MOD(5, 2) FROM DUAL;

--날짜 함수
SELECT SYSDATE FROM DUAL;
SELECT SYSTIMESTAMP FROM DUAL; -- +시분초
--날짜는 연산이 가능하다
SELECT SYSDATE +1, SYSDATE -1 FROM DUAL; --날짜
SELECT SYSDATE - HIRE_DATE FROM EMPLOYEES; --일수
SELECT (SYSDATE - HIRE_DATE) / 7 FROM EMPLOYEES; --주
--날짜 반올림, 절삭 ROUND, TRUNC
SELECT SYSDATE, ROUND(SYSDATE), TRUNC(SYSDATE) FROM DUAL; --일 기준으로 반올림, 절삭
SELECT TRUNC(SYSDATE, 'YEAR') FROM DUAL; --년 기준으로 절삭
SELECT TRUNC(SYSDATE, 'MONTH') FROM DUAL; --월 기준으로 절삭










