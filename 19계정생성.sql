SELECT * FROM HR.EMPLOYEES;
--사용자 계정 확인
SELECT * FROM ALL_USERS;
--현재 사용자의 권한 확인
SELECT * FROM USER_SYS_PRIVS;
--사용자 계정 생성(관리자만 할 수 있음)
CREATE USER USER01 IDENTIFIED BY USER01; --앞에게 아이디 뒤에게 비밀번호
--데이터베이스에 접속 하려면 접속권한
--테이블 생성을 하려면 테이블 생성권한
--뷰 생성을 하려면 뷰 생성권한
--시퀀스 생성을 하려면 시퀀스 생성권한
--프로시저 생성을 하려면 프로시저 생성권한
GRANT CREATE SESSION/*접속권한*/, CREATE TABLE/*테이블 생성*/, 
      CREATE VIEW/*뷰 생성*/, CREATE SEQUENCE/*시퀀스 생성*/, 
      CREATE PROCEDURE/*프로시저 생성*/ /*(권한명)*/ TO USER01 /*(계정명)*/;
--테이블 스페이스 - 테이블에 데이터가 저장되는 물리적인 공간      
--               데이터베이스도 파일처럼 저장을 하는데 이 저장을 할 공간
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
--권한 회수 REVOKE FROM
REVOKE CREATE SESSION FROM USER01;
--계정 삭제
DROP USER USER01 CASCADE; --계정이 테이블과 데이터를 가지고 있으면, 테이블 포함해서 삭제 일어나야 한다

----------------------------------------------------------------------------------------
--롤을 이용한 권한부여
CREATE USER USER01 IDENTIFIED BY USER01;

GRANT RESOURCE, CONNECT TO USER01; --리소스롤(테이블, 뷰, 시퀀스, 프로시저 등의 권한의 그룹)
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
DROP USER USER01;
----------------------------------------------------------------------------------------
--계정 생성과, 권한 부여를 마우스로 
--보기 탭 -> DBA -> 관리자접속 -> 테이블스페이스 생성
      
      
      
      
      