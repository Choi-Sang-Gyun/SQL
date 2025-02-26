--트랜잭션 (작업의 논리적인 단위)
--DML 구문에 대해서만 트랜잭션을 적용할 수 있습니다

--오토커밋 상태 확인
SHOW AUTOCOMMIT;
SET AUTOCOMMIT ON;
SET AUTOCOMMIT OFF;

----------------------------------------------------------------------
--SAVE POINT(실제로 많이 쓰진 않음)
COMMIT;
SELECT * FROM DEPTS;

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 10;
SAVEPOINT DEL10; --현재 시점을 세이브 포인트로 기록
DELETE FROM DEPTS WHERE DEPARTMENT_ID = 20;
SAVEPOINT DEL2O; --

ROLLBACK TO DEL2O; --세이브 포인트 명
SELECT * FROM DEPTS;
ROLLBACK TO DEL10;
ROLLBACK; --마지막 커밋 이후으로 돌아가게 굅니다

-- 커밋 (데이터 변경 실제로 반영) - COMMIT이후에는 되돌릴 수 없습니다
INSERT INTO DEPTS VALUES(280, 'AAA', NULL, 1800);
COMMIT;