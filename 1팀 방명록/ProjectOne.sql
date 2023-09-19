SELECT USER
FROM DUAL;
--==>> SCOTT

--�� ���̿��� ���� ���̺� ����
CREATE TABLE TBL_CYWORLD
( NUM       NUMBER                  NOT NULL
, NAME      VARCHAR2(20)            NOT NULL
, PWD       VARCHAR2(20)            NOT NULL
, CONTENT   VARCHAR2(1000)          NOT NULL
, IPADDR    VARCHAR2(20)            
, CREATED   DATE                    DEFAULT SYSDATE
, CONSTRAINT GAME_NUM_PK PRIMARY KEY(NUM)
);
--==>> Table TBL_CYWORLD��(��) �����Ǿ����ϴ�.

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� ������ �ִ� ������ ���ϴ� ������
SELECT NVL(MAX(NUM), 0) AS MAXNUM FROM TBL_CYWORLD
;
--==>> 101

--�� ���� ��ȸ ������ ����
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
--> �� �� ����
SELECT NUM, NAME, CONTENT, CREATED, IPADDR FROM ( SELECT ROWNUM RNUM, DATA.* FROM ( SELECT NUM, NAME, CONTENT, IPADDR, TO_CHAR(CREATED, 'YYYY-MM-DD HH24:MI:SS') AS CREATED FROM TBL_CYWORLD ORDER BY NUM DESC     ) DATA ) WHERE RNUM>=1 AND RNUM<=10
;

--==>>
/*
3   �翬��   ������ʹ�   2023-06-08   211.238.142.52
2   ������   �� ���� 2��   2023-06-08   211.238.142.48
1   ������   �ѽ� ���� 1��~~   2023-06-08   211.238.142.47
*/


--�� ������ �Է�
INSERT INTO TBL_CYWORLD (NUM, NAME, PWD, CONTENT, IPADDR, CREATED)
VALUES(1, '������', '1212', '�ѽ� ���� 1��~~', '211.238.142.47', SYSDATE);

INSERT INTO TBL_CYWORLD (NUM, NAME, PWD, CONTENT, IPADDR, CREATED)
VALUES(2, '������', '1111', '�� ���� 2��', '211.238.142.48', SYSDATE);

INSERT INTO TBL_CYWORLD (NUM, NAME, PWD, CONTENT, IPADDR, CREATED)
VALUES(3, '�翬��', '3333', '������ʹ�', '211.238.142.52', SYSDATE);
--> �� �� ����
INSERT INTO TBL_CYWORLD (NUM, NAME, PWD, CONTENT, IPADDR, CREATED) VALUES(3, '�翬��', '3333', '������ʹ�', '211.238.142.52', SYSDATE)
;
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. *3


--�� Ư�� �Խù��� �����ϴ� ������ ����
--   �ۼ���, �н�����, ����
UPDATE TBL_CYWORLD
SET NAME='���ϰ�', PWD='1234', CONTENT='�����ȳ���'
WHERE NUM=1;
--> �� �� ����
UPDATE TBL_CYWORLD SET NAME='���ϰ�', PWD='1234', CONTENT='�����ȳ���' WHERE NUM=1
;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.


--�� Ư�� �Խù��� �����ϴ� ������ ����
DELETE
FROM TBL_CYWORLD
WHERE NUM=3;
--> �� �� ����
DELETE FROM TBL_CYWORLD WHERE NUM=3
;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.



--�� Ư�� �Խù�(ex. 3)�� ���� ��ȣ�� ������ ������ ����
SELECT NVL(MAX(NUM), -1) AS BEFORENUM
FROM TBL_CYWORLD
WHERE NUM<3;
--> �� �� ����
SELECT NVL(MAX(NUM), -1) AS BEFORENUM FROM TBL_CYWORLD WHERE NUM<3
;
--==>> 2

--�� Ư�� �Խù�(ex. 2)�� ���� ��ȣ�� ������ ������ ����
SELECT NVL(MIN(NUM), -1) AS NEXTNUM
FROM TBL_CYWORLD
WHERE NUM>2;
--> �� �� ����
SELECT NVL(MIN(NUM), -1) AS NEXTNUM FROM TBL_CYWORLD WHERE NUM>2;
--==>> 3

SELECT *
FROM TBL_CYWORLD;

SELECT *
FROM TBL_REPLY;


--�� ��� ���̺� ����
CREATE TABLE TBL_REPLY
( NUM       NUMBER                          NOT NULL
, NAME      VARCHAR2(20)                    NOT NULL
, PWD       VARCHAR2(40)                    NOT NULL
, CONTENT   VARCHAR2(4000)                  NOT NULL
, IPADDR    VARCHAR2(20)                    
, CREATED   DATE            DEFAULT SYSDATE NOT NULL
, CONSTRAINT REPLY_NUM_PK PRIMARY KEY(NUM)
);
--==>> Table TBL_REPLY��(��) �����Ǿ����ϴ�.

--�� ��� ���̺� CYNUM �÷� �߰�
ALTER TABLE TBL_REPLY 
ADD CYNUM NUMBER;


--�� CYNUM �÷��� FK �������� �߰� (���� ���̺��� NUM�� ����)
ALTER TABLE TBL_REPLY
ADD CONSTRAINT REPLY_CYNUM_FK FOREIGN KEY(CYNUM)
            REFERENCES TBL_CYWORLD(NUM);
                

--�� ��� ���̺� ������ ����
INSERT INTO TBL_REPLY VALUES(5, '������', '11', '����', '211.238.142.52', SYSDATE, 1);  
INSERT INTO TBL_REPLY VALUES(6, '������', '11', '����', '211.238.142.52', SYSDATE, 2);
INSERT INTO TBL_REPLY VALUES(7, '������', '11', '����', '211.238.142.52', SYSDATE, 3);
INSERT INTO TBL_REPLY VALUES(8, '������', '11', '����', '211.238.142.52', SYSDATE, 4);
INSERT INTO TBL_REPLY VALUES(9, '������', '11', '����', '211.238.142.52', SYSDATE, 5);
INSERT INTO TBL_REPLY VALUES(10, '������', '11', '����', '211.238.142.52', SYSDATE, 5);
INSERT INTO TBL_REPLY VALUES(11, '������', '11', '����', '211.238.142.52', SYSDATE, 77);
INSERT INTO TBL_REPLY VALUES(12, '������', '11', '����', '211.238.142.52', SYSDATE, 77);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 8


--�� Ŀ��
commit; 
--==>> Ŀ�� �Ϸ�.
            
--�� Ư�� ��ȣ ������ ���� ��� 
SELECT NUM, NAME, PWD, CONTENT, IPADDR, TO_CHAR(CREATED, 'YYYY-MM-DD HH24:MI:SS') AS CREATED
FROM TBL_REPLY 
WHERE CYNUM = 77
ORDER BY NUM;
--> �� �� ����
SELECT NUM, NAME, PWD, CONTENT, IPADDR, TO_CHAR(CREATED, 'YYYY-MM-DD HH24:MI:SS') AS CREATED FROM TBL_REPLY  WHERE CYNUM = 77
;
--==>>
/*
11	������	11	����	211.238.142.52	2023-06-09
12	������	11	����	211.238.142.52	2023-06-09
*/

--�� �̴Ϲ� �÷� �߰�
ALTER TABLE TBL_CYWORLD 
ADD MINIMI VARCHAR2(10);


--�� CASCADE ���������� �߰��ϱ� ���� TBL_REPLY �� FK�� �����ϰ� �ٽ� �߰�
ALTER TABLE TBL_REPLY DROP CONSTRAINT REPLY_CYNUM_FK;

ALTER TABLE TBL_REPLY
ADD CONSTRAINT REPLY_CYNUM_FK FOREIGN KEY(CYNUM)
            REFERENCES TBL_CYWORLD(NUM)
            ON DELETE CASCADE;


--�� ���� ���̺� ��ȸ
SELECT *
FROM TBL_CYWORLD;

--�� ������ �÷��� ���� ���̺� �߰�
ALTER TABLE TBL_CYWORLD
ADD HEART NUMBER DEFAULT 0;
--> �� �� ����
ALTER TABLE TBL_CYWORLD ADD HEART NUMBER DEFAULT 0;
--==>> Table TBL_CYWORLD��(��) ����Ǿ����ϴ�.

--�� ���� ���̺� ��ȸ
SELECT *
FROM TBL_CYWORLD;

--�� �������� �ø��� ������Ʈ ������
UPDATE TBL_CYWORLD
SET HEART = HEART + 1
WHERE NUM = 102;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
--> �� �� ����
UPDATE TBL_CYWORLD SET HEART = HEART + 1 WHERE NUM = 102
;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� �׽�Ʈ�� ���� ����� ����
DELETE
FROM TBL_REPLY
WHERE NUM=35;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� ��� ���̺� ��ȸ
SELECT *
FROM TBL_REPLY;

--�� �׽�Ʈ�� ���� ����� ����
DELETE
FROM TBL_REPLY
WHERE NUM IN (34,37,71,78,79);
--==>> 5�� �� ��(��) �����Ǿ����ϴ�.

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� ��� �ִ� ��ȣ ���ϴ� ������
SELECT NVL(MAX(NUM), 0) AS MAXNUMRE
FROM TBL_REPLY;
--> �� �� ����
SELECT NVL(MAX(NUM), 0) AS MAXNUMRE FROM TBL_REPLY
;

--�� ���� ���̺� Ȯ��
DESC TBL_CYWORLD;

--�� �������� Ȯ��
SELECT *
FROM ALL_CONSTRAINTS;

--�� ���� �˻� ������
--   NAME �÷����� 'ȫ��'�̶�� �ܾ �� ���� ã�� RNUM�� 1�� �ͺ��� 5�� �ͱ��� 5���� �߸� �� (�� ������ �з�)
SELECT NUM, NAME, CONTENT, CREATED, IPADDR, MINIMI, HEART         
 FROM                                                            
 (                                                                 
     SELECT ROWNUM RNUM, DATA.*                                   
     FROM                                                          
     (                                                           
         SELECT NUM, NAME, CONTENT, TO_CHAR(CREATED, 'YYYY-MM-DD HH24:MI:SS') AS CREATED , IPADDR, MINIMI, HEART
         FROM TBL_CYWORLD                                        
         WHERE NAME LIKE '%ȫ��%'                                         
         ORDER BY NUM DESC                                        
     ) DATA                                                
 )                                                               
 WHERE RNUM>=1 AND RNUM<=5;  
 
--�� ���� �˻� ����� �� �� ������ �˾ƺ��� ������
SELECT COUNT(*) AS COUNT
FROM TBL_CYWORLD
WHERE NAME LIKE '%ȫ��%';


SELECT *
FROM TBL_CYWORLD
ORDER BY NUM DESC;

SELECT *
FROM TBL_REPLY
ORDER BY NUM DESC;






















