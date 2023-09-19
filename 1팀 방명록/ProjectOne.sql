SELECT USER
FROM DUAL;
--==>> SCOTT

--○ 싸이월드 방명록 테이블 생성
CREATE TABLE TBL_CYWORLD
( NUM       NUMBER                  NOT NULL
, NAME      VARCHAR2(20)            NOT NULL
, PWD       VARCHAR2(20)            NOT NULL
, CONTENT   VARCHAR2(1000)          NOT NULL
, IPADDR    VARCHAR2(20)            
, CREATED   DATE                    DEFAULT SYSDATE
, CONSTRAINT GAME_NUM_PK PRIMARY KEY(NUM)
);
--==>> Table TBL_CYWORLD이(가) 생성되었습니다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 방명록의 최대 갯수를 구하는 쿼리문
SELECT NVL(MAX(NUM), 0) AS MAXNUM FROM TBL_CYWORLD
;
--==>> 101

--○ 방명록 조회 쿼리문 구성
SELECT NUM, NAME, CONTENT, CREATED, IPADDR
FROM
(
    SELECT ROWNUM RNUM, DATA.*
    FROM
    ( 
        SELECT NUM, NAME, CONTENT, IPADDR, TO_CHAR(CREATED, 'YYYY-MM-DD HH24:MI:SS') AS CREATED
        FROM TBL_CYWORLD
        ORDER BY NUM DESC
    ) DATA
)
WHERE RNUM>=1 AND RNUM<=10;
--> 한 줄 구성
SELECT NUM, NAME, CONTENT, CREATED, IPADDR FROM ( SELECT ROWNUM RNUM, DATA.* FROM ( SELECT NUM, NAME, CONTENT, IPADDR, TO_CHAR(CREATED, 'YYYY-MM-DD HH24:MI:SS') AS CREATED FROM TBL_CYWORLD ORDER BY NUM DESC     ) DATA ) WHERE RNUM>=1 AND RNUM<=10
;

--==>>
/*
3   양연수   집가고싶다   2023-06-08   211.238.142.52
2   강별희   힝 나는 2등   2023-06-08   211.238.142.48
1   권희정   앗싸 내가 1등~~   2023-06-08   211.238.142.47
*/


--○ 데이터 입력
INSERT INTO TBL_CYWORLD (NUM, NAME, PWD, CONTENT, IPADDR, CREATED)
VALUES(1, '권희정', '1212', '앗싸 내가 1등~~', '211.238.142.47', SYSDATE);

INSERT INTO TBL_CYWORLD (NUM, NAME, PWD, CONTENT, IPADDR, CREATED)
VALUES(2, '강별희', '1111', '힝 나는 2등', '211.238.142.48', SYSDATE);

INSERT INTO TBL_CYWORLD (NUM, NAME, PWD, CONTENT, IPADDR, CREATED)
VALUES(3, '양연수', '3333', '집가고싶다', '211.238.142.52', SYSDATE);
--> 한 줄 구성
INSERT INTO TBL_CYWORLD (NUM, NAME, PWD, CONTENT, IPADDR, CREATED) VALUES(3, '양연수', '3333', '집가고싶다', '211.238.142.52', SYSDATE)
;
--==>> 1 행 이(가) 삽입되었습니다. *3


--○ 특정 게시물을 수정하는 쿼리문 구성
--   작성자, 패스워드, 내용
UPDATE TBL_CYWORLD
SET NAME='최하경', PWD='1234', CONTENT='수정된내용'
WHERE NUM=1;
--> 한 줄 구성
UPDATE TBL_CYWORLD SET NAME='최하경', PWD='1234', CONTENT='수정된내용' WHERE NUM=1
;
--==>> 1 행 이(가) 업데이트되었습니다.


--○ 특정 게시물을 삭제하는 쿼리문 구성
DELETE
FROM TBL_CYWORLD
WHERE NUM=3;
--> 한 줄 구성
DELETE FROM TBL_CYWORLD WHERE NUM=3
;
--==>> 1 행 이(가) 삭제되었습니다.



--○ 특정 게시물(ex. 3)의 이전 번호를 얻어오는 쿼리문 구성
SELECT NVL(MAX(NUM), -1) AS BEFORENUM
FROM TBL_CYWORLD
WHERE NUM<3;
--> 한 줄 구성
SELECT NVL(MAX(NUM), -1) AS BEFORENUM FROM TBL_CYWORLD WHERE NUM<3
;
--==>> 2

--○ 특정 게시물(ex. 2)의 다음 번호를 얻어오는 쿼리문 구성
SELECT NVL(MIN(NUM), -1) AS NEXTNUM
FROM TBL_CYWORLD
WHERE NUM>2;
--> 한 줄 구성
SELECT NVL(MIN(NUM), -1) AS NEXTNUM FROM TBL_CYWORLD WHERE NUM>2;
--==>> 3

SELECT *
FROM TBL_CYWORLD;

SELECT *
FROM TBL_REPLY;


--○ 댓글 테이블 생성
CREATE TABLE TBL_REPLY
( NUM       NUMBER                          NOT NULL
, NAME      VARCHAR2(20)                    NOT NULL
, PWD       VARCHAR2(40)                    NOT NULL
, CONTENT   VARCHAR2(4000)                  NOT NULL
, IPADDR    VARCHAR2(20)                    
, CREATED   DATE            DEFAULT SYSDATE NOT NULL
, CONSTRAINT REPLY_NUM_PK PRIMARY KEY(NUM)
);
--==>> Table TBL_REPLY이(가) 생성되었습니다.

--○ 댓글 테이블에 CYNUM 컬럼 추가
ALTER TABLE TBL_REPLY 
ADD CYNUM NUMBER;


--○ CYNUM 컬럼에 FK 제약조건 추가 (방명록 테이블의 NUM을 참조)
ALTER TABLE TBL_REPLY
ADD CONSTRAINT REPLY_CYNUM_FK FOREIGN KEY(CYNUM)
            REFERENCES TBL_CYWORLD(NUM);
                

--○ 댓글 테이블에 데이터 삽입
INSERT INTO TBL_REPLY VALUES(5, '강별희', '11', '졸려', '211.238.142.52', SYSDATE, 1);  
INSERT INTO TBL_REPLY VALUES(6, '강별희', '11', '졸려', '211.238.142.52', SYSDATE, 2);
INSERT INTO TBL_REPLY VALUES(7, '강별희', '11', '졸려', '211.238.142.52', SYSDATE, 3);
INSERT INTO TBL_REPLY VALUES(8, '강별희', '11', '졸려', '211.238.142.52', SYSDATE, 4);
INSERT INTO TBL_REPLY VALUES(9, '강별희', '11', '졸려', '211.238.142.52', SYSDATE, 5);
INSERT INTO TBL_REPLY VALUES(10, '강별희', '11', '졸려', '211.238.142.52', SYSDATE, 5);
INSERT INTO TBL_REPLY VALUES(11, '강별희', '11', '졸려', '211.238.142.52', SYSDATE, 77);
INSERT INTO TBL_REPLY VALUES(12, '강별희', '11', '졸려', '211.238.142.52', SYSDATE, 77);
--==>> 1 행 이(가) 삽입되었습니다. * 8


--○ 커밋
commit; 
--==>> 커밋 완료.
            
--○ 특정 번호 방명록의 대댓글 출력 
SELECT NUM, NAME, PWD, CONTENT, IPADDR, TO_CHAR(CREATED, 'YYYY-MM-DD HH24:MI:SS') AS CREATED
FROM TBL_REPLY 
WHERE CYNUM = 77
ORDER BY NUM;
--> 한 줄 구성
SELECT NUM, NAME, PWD, CONTENT, IPADDR, TO_CHAR(CREATED, 'YYYY-MM-DD HH24:MI:SS') AS CREATED FROM TBL_REPLY  WHERE CYNUM = 77
;
--==>>
/*
11	강별희	11	졸려	211.238.142.52	2023-06-09
12	강별희	11	졸려	211.238.142.52	2023-06-09
*/

--○ 미니미 컬럼 추가
ALTER TABLE TBL_CYWORLD 
ADD MINIMI VARCHAR2(10);


--○ CASCADE 제약조건을 추가하기 위해 TBL_REPLY 의 FK를 삭제하고 다시 추가
ALTER TABLE TBL_REPLY DROP CONSTRAINT REPLY_CYNUM_FK;

ALTER TABLE TBL_REPLY
ADD CONSTRAINT REPLY_CYNUM_FK FOREIGN KEY(CYNUM)
            REFERENCES TBL_CYWORLD(NUM)
            ON DELETE CASCADE;


--○ 방명록 테이블 조회
SELECT *
FROM TBL_CYWORLD;

--○ 공감수 컬럼을 방명록 테이블에 추가
ALTER TABLE TBL_CYWORLD
ADD HEART NUMBER DEFAULT 0;
--> 한 줄 구성
ALTER TABLE TBL_CYWORLD ADD HEART NUMBER DEFAULT 0;
--==>> Table TBL_CYWORLD이(가) 변경되었습니다.

--○ 방명록 테이블 조회
SELECT *
FROM TBL_CYWORLD;

--○ 공감수를 올리는 업데이트 쿼리문
UPDATE TBL_CYWORLD
SET HEART = HEART + 1
WHERE NUM = 102;
--==>> 1 행 이(가) 업데이트되었습니다.
--> 한 줄 구성
UPDATE TBL_CYWORLD SET HEART = HEART + 1 WHERE NUM = 102
;
--==>> 1 행 이(가) 업데이트되었습니다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 테스트를 위해 댓글을 삭제
DELETE
FROM TBL_REPLY
WHERE NUM=35;
--==>> 1 행 이(가) 삭제되었습니다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 댓글 테이블 조회
SELECT *
FROM TBL_REPLY;

--○ 테스트를 위해 댓글을 삭제
DELETE
FROM TBL_REPLY
WHERE NUM IN (34,37,71,78,79);
--==>> 5개 행 이(가) 삭제되었습니다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 댓글 최대 번호 구하는 쿼리문
SELECT NVL(MAX(NUM), 0) AS MAXNUMRE
FROM TBL_REPLY;
--> 한 줄 구성
SELECT NVL(MAX(NUM), 0) AS MAXNUMRE FROM TBL_REPLY
;

--○ 방명록 테이블 확인
DESC TBL_CYWORLD;

--○ 제약조건 확인
SELECT *
FROM ALL_CONSTRAINTS;

--○ 방명록 검색 쿼리문
--   NAME 컬럼에서 '홍길'이라는 단어가 들어간 것을 찾고 RNUM이 1인 것부터 5인 것까지 5개만 추린 것 (한 페이지 분량)
SELECT NUM, NAME, CONTENT, CREATED, IPADDR, MINIMI, HEART         
 FROM                                                            
 (                                                                 
     SELECT ROWNUM RNUM, DATA.*                                   
     FROM                                                          
     (                                                           
         SELECT NUM, NAME, CONTENT, TO_CHAR(CREATED, 'YYYY-MM-DD HH24:MI:SS') AS CREATED , IPADDR, MINIMI, HEART
         FROM TBL_CYWORLD                                        
         WHERE NAME LIKE '%홍길%'                                         
         ORDER BY NUM DESC                                        
     ) DATA                                                
 )                                                               
 WHERE RNUM>=1 AND RNUM<=5;  
 
--○ 방명록 검색 결과가 총 몇 건인지 알아보는 쿼리문
SELECT COUNT(*) AS COUNT
FROM TBL_CYWORLD
WHERE NAME LIKE '%홍길%';


SELECT *
FROM TBL_CYWORLD
ORDER BY NUM DESC;

SELECT *
FROM TBL_REPLY
ORDER BY NUM DESC;






















