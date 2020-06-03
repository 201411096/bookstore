---------------------------------------- ���� ----------------------------------------
--1. DB ����
----1_1. ���̺�
----1_2. ������
--2. ������ �Է�
--3. SQL�� Ȯ��
--4. DB ����
--5. ������ �ʱ�ȭ
------------------------------1.DB ���� ------------------------------
--------------------1_1.���̺�--------------------
--���̺��ȣ : 1
--���̺�� : CUSTOMER
--����ϴ� ������ : X
--�����ϴ� ���̺� : X
--�����Ǵ� ���̺� : QUESTION, TENDENCY, BUYCARTLIST, RENTCARTLIST, BUYLIST, RENTLIST, BUYREVIEW, RENTREVIEW
CREATE TABLE CUSTOMER(
    CUSTOMER_ID VARCHAR2(30),
    CUSTOMER_PASSWORD VARCHAR2(30),
    CUSTOMER_NAME VARCHAR2(30),
    CUSTOMER_TEL VARCHAR2(30),
    CUSTOMER_POINT NUMBER(30),
    CUSTOMER_FLAG NUMBER(30),
    CONSTRAINT CUSTOMER_PK PRIMARY KEY(CUSTOMER_ID)
);
--���̺��ȣ : 2
--���̺�� : QUESTION
--����ϴ� ������ : QUESTION_ID_SEQ, QUESTION_GROUPID_SEQ
--�����ϴ� ���̺� : CUSTOMER
--�����Ǵ� ���̺� : X
CREATE TABLE QUESTION(
    QUESTION_ID NUMBER(30),
    CUSTOMER_ID VARCHAR2(30),
    QUESTION_FLAG NUMBER(30),
    QUESTION_TITLE VARCHAR2(30),
    QUESTION_CONTENT VARCHAR2(2048),
    QUESTION_GROUPID NUMBER(30),
    CONSTRAINT QUESTION_PK PRIMARY KEY(QUESTION_ID),
    CONSTRAINT QUESTION_FK_1 FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID)
);
--���̺��ȣ : 3
--���̺�� : TENDENCY
--����ϴ� ������ : TENDENCY_ID_SEQ
--�����ϴ� ���̺� : CUSTOMER
--�����Ǵ� ���̺� : X
CREATE TABLE TENDENCY(
    TENDENCY_ID NUMBER(30),
    CUSTOMER_ID VARCHAR2(30),
    ART NUMBER(30),
    SOCIAL NUMBER(30),
    ECONOMIC NUMBER(30),
    TECHNOLOGY NUMBER(30),
    LITERATURE NUMBER(30),
    HISTORY NUMBER(30),
    CONSTRAINT TENDENCY_PK PRIMARY KEY(TENDENCY_ID),
    CONSTRAINT TENDENCY_FK_1 FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID)
);
--���̺��ȣ : 4
--���̺�� : WRITER
--����ϴ� ������ : WRITER_ID_SEQ
--�����ϴ� ���̺� : X
--�����Ǵ� ���̺� : BOOK
CREATE TABLE WRITER(
    WRITER_ID NUMBER(30),
    WRITER_NAME VARCHAR2(30),
    CONSTRAINT WRITER_PK PRIMARY KEY(WRITER_ID)
);
--���̺��ȣ : 5
--���̺�� : STORE
--����ϴ� ������ : STORE_ID_SEQ
--�����ϴ� ���̺� : X
--�����Ǵ� ���̺� : BOOKSALE
CREATE TABLE STORE(
    STORE_ID NUMBER(30),
    STORE_NAME VARCHAR2(30),
    STORE_ADDR VARCHAR2(256),
    STORE_POINT VARCHAR2(256),
    STORE_TEL VARCHAR2(30),
    CONSTRAINT STORE_PK PRIMARY KEY(STORE_ID)
);
--���̺��ȣ : 6
--���̺�� : BOOK
--����ϴ� ������ : BOOK_ID_SEQ
--�����ϴ� ���̺� : WRITER
--�����Ǵ� ���̺� : BOOKSALE, BUY
CREATE TABLE BOOK(
    BOOK_ID NUMBER(30),
    WRITER_ID NUMBER(30),
    BOOK_PRICE NUMBER(30),
    BOOK_NAME VARCHAR2(256),
    BOOK_GENRE VARCHAR2(30),
    BOOK_STORY varchar2(2048),
    BOOK_PDATE VARCHAR2(30),
    BOOK_SALEPRICE NUMBER(30),
    BOOK_CNT NUMBER(30),
    BOOK_SCORE NUMBER(30, 2),
    BOOK_SCORECOUNT NUMBER(30),
    CONSTRAINT BOOK_PK PRIMARY KEY(BOOK_ID),
    CONSTRAINT WRITER_FK_1 FOREIGN KEY(WRITER_ID) REFERENCES WRITER(WRITER_ID)
);
alter table book add(book_scorecount number(30));
alter table book modify(book_score number(30, 2));
--���̺��ȣ : 7
--���̺�� : BOOKSALE
--����ϴ� ������ : BOOKSALE_ID_SEQ
--�����ϴ� ���̺� : BOOK, STORE
--�����Ǵ� ���̺� : X
CREATE TABLE BOOKSALE(
    BOOKSALE_ID NUMBER(30),
    BOOK_ID NUMBER(30),
    STORE_ID NUMBER(30),
    CONSTRAINT BOOKSALE_PK PRIMARY KEY(BOOKSALE_ID),
    CONSTRAINT BOOKSALE_FK_1 FOREIGN KEY(BOOK_ID) REFERENCES BOOK(BOOK_ID),
    CONSTRAINT BOOKSALE_FK_2 FOREIGN KEY(STORE_ID) REFERENCES STORE(STORE_ID)
);
--���̺��ȣ : 8
--���̺�� : BUYLIST
--����ϴ� ������ : BUYLIST_ID_SEQ
--�����ϴ� ���̺� : CUSTOMER
--�����Ǵ� ���̺� : BUY
CREATE TABLE BUYLIST(
    BUYLIST_ID NUMBER(30),
    CUSTOMER_ID VARCHAR2(30),
    BUY_DATE DATE,
    BUYLIST_SHIPPINGADDRESS varchar2(100),
    CONSTRAINT BUYLIST_PK PRIMARY KEY(BUYLIST_ID),
    CONSTRAINT BUYLIST_FK_1 FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID)
);
--���̺��ȣ : 9
--���̺�� : BUY
--����ϴ� ������ : BUY_ID_SEQ
--�����ϴ� ���̺� : BUYLIST, BOOK
--�����Ǵ� ���̺� : X
CREATE TABLE BUY(
    BUY_ID NUMBER(30),
    BUYLIST_ID NUMBER(30),
    BOOK_ID NUMBER(30),
    BUY_CNT NUMBER(30),
    CONSTRAINT BUY_PK PRIMARY KEY(BUY_ID),
    CONSTRAINT BUY_FK_1 FOREIGN KEY(BUYLIST_ID) REFERENCES BUYLIST(BUYLIST_ID),
    CONSTRAINT BUY_FK_2 FOREIGN KEY(BOOK_ID) REFERENCES BOOK(BOOK_ID)
);
--���̺��ȣ : 10
--���̺�� : BUYCARTLIST
--����ϴ� ������ : BUYCARTLIST_ID_SEQ
--�����ϴ� ���̺� : CUSTOMER, BOOK
--�����Ǵ� ���̺� : X
CREATE TABLE BUYCARTLIST(
    BUYCARTLIST_ID NUMBER(30),
    CUSTOMER_ID VARCHAR2(30),
    BOOK_ID NUMBER(30),
    BUYCARTLIST_CNT NUMBER(30),
    CONSTRAINT BUYCARTLIST_PK PRIMARY KEY(BUYCARTLIST_ID),
    CONSTRAINT BUYCARTLIST_FK_1 FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
    CONSTRAINT BUYCARTLIST_FK_2 FOREIGN KEY(BOOK_ID) REFERENCES BOOK(BOOK_ID)
);
--���̺��ȣ : 11
--���̺�� : BUYREVIEW
--����ϴ� ������ : BUYREVIEW_ID_SEQ
--�����ϴ� ���̺� : CUSTOMER, BOOK
--�����Ǵ� ���̺� : X
CREATE TABLE BUYREVIEW(
    BUYREVIEW_ID NUMBER(30),
    CUSTOMER_ID VARCHAR2(30),
    BOOK_ID NUMBER(30),
    BUYREVIEW_CONTENT VARCHAR2(2048),
    BUYREVIEW_SCORE NUMBER(30),
    CONSTRAINT BUYREVIEW_PK PRIMARY KEY(BUYREVIEW_ID),
    CONSTRAINT BUYREVIEW_FK_1 FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
    CONSTRAINT BUYREVIEW_FK_2 FOREIGN KEY(BOOK_ID) REFERENCES BOOK(BOOK_ID)
);
--------------------1_2.������--------------------
--��������ȣ : 1
--�������̸� : QUESTION_ID_SEQ
--���Ǵ� ���̺� : QUESTION
CREATE SEQUENCE QUESTION_ID_SEQ
START WITH 1
MAXVALUE 10000
CYCLE;

--��������ȣ : 2
--�������̸� : QUESTION_GROUPID_SEQ
--���Ǵ� ���̺� : QUESTION
CREATE SEQUENCE QUESTION_GROUPID_SEQ
START WITH 1
MAXVALUE 10000
CYCLE;
--��������ȣ : 3
--�������̸� : TENDENCY_ID_SEQ
--���Ǵ� ���̺� : TENDENCY
CREATE SEQUENCE TENDENCY_ID_SEQ
START WITH 1
MAXVALUE 10000
CYCLE;

--��������ȣ : 4
--�������̸� : WRITER_ID_SEQ
--���Ǵ� ���̺� : WRITER
CREATE SEQUENCE WRITER_ID_SEQ
START WITH 1
MAXVALUE 10000
CYCLE;

--��������ȣ : 5
--�������̸� : STORE_ID_SEQ
--���Ǵ� ���̺� : STORE
CREATE SEQUENCE STORE_ID_SEQ
START WITH 1
MAXVALUE 10000
CYCLE;

--��������ȣ : 6
--�������̸� : BOOK_ID_SEQ
--���Ǵ� ���̺� : BOOK
CREATE SEQUENCE BOOK_ID_SEQ
START WITH 1
MAXVALUE 10000
CYCLE;

--��������ȣ : 7
--�������̸� : BOOKSALE_ID_SEQ
--���Ǵ� ���̺� : BOOKSALE
CREATE SEQUENCE BOOKSALE_ID_SEQ
START WITH 1
MAXVALUE 10000
CYCLE;

--��������ȣ : 8
--�������̸� : BUYLIST_ID_SEQ
--���Ǵ� ���̺� : BUYLIST
CREATE SEQUENCE BUYLIST_ID_SEQ
START WITH 1
MAXVALUE 10000
CYCLE;

--��������ȣ : 9
--�������̸� : BUY_ID_SEQ
--���Ǵ� ���̺� : BUY
CREATE SEQUENCE BUY_ID_SEQ
START WITH 1
MAXVALUE 10000
CYCLE;

--��������ȣ : 10
--�������̸� : BUYCARTLIST_ID_SEQ
--���Ǵ� ���̺� : BUYCARTLIST
CREATE SEQUENCE BUYCARTLIST_ID_SEQ
START WITH 1
MAXVALUE 10000
CYCLE;

--��������ȣ : 11
--�������̸� : BUYREVIEW_ID_SEQ
--���Ǵ� ���̺� : BUYREVIEW
CREATE SEQUENCE BUYREVIEW_ID_SEQ
START WITH 1
MAXVALUE 10000
CYCLE;

------------------------------2.������ �Է� ------------------------------
--------------------2_1.CUSTOMER--------------------
INSERT INTO CUSTOMER(CUSTOMER_ID, CUSTOMER_PASSWORD, CUSTOMER_NAME, CUSTOMER_TEL, CUSTOMER_POINT, CUSTOMER_FLAG) VALUES('admin', '1234', 'adminname', '010-1131-2222', 0, 0); -- ������ ����?..
INSERT INTO CUSTOMER(CUSTOMER_ID, CUSTOMER_PASSWORD, CUSTOMER_NAME, CUSTOMER_TEL, CUSTOMER_POINT, CUSTOMER_FLAG) VALUES('aaa', '1234', 'aaaname', '010-1111-2222', 0, 1);
INSERT INTO CUSTOMER(CUSTOMER_ID, CUSTOMER_PASSWORD, CUSTOMER_NAME, CUSTOMER_TEL, CUSTOMER_POINT, CUSTOMER_FLAG) VALUES('bbb', '1234', 'bbbname', '010-2222-3333', 0, 1);
INSERT INTO CUSTOMER(CUSTOMER_ID, CUSTOMER_PASSWORD, CUSTOMER_NAME, CUSTOMER_TEL, CUSTOMER_POINT, CUSTOMER_FLAG) VALUES('ccc', '1234', 'cccname', '010-3333-4444', 0, 1);
--------------------2_3.TENDENCY-------------------
INSERT INTO TENDENCY(TENDENCY_ID, CUSTOMER_ID, ART, SOCIAL, ECONOMIC, TECHNOLOGY, LITERATURE, HISTORY) VALUES(TENDENCY_ID_SEQ.NEXTVAL, 'aaa', 0, 0, 0, 0, 0, 0);
INSERT INTO TENDENCY(TENDENCY_ID, CUSTOMER_ID, ART, SOCIAL, ECONOMIC, TECHNOLOGY, LITERATURE, HISTORY) VALUES(TENDENCY_ID_SEQ.NEXTVAL, 'bbb', 0, 0, 0, 0, 0, 0);
INSERT INTO TENDENCY(TENDENCY_ID, CUSTOMER_ID, ART, SOCIAL, ECONOMIC, TECHNOLOGY, LITERATURE, HISTORY) VALUES(TENDENCY_ID_SEQ.NEXTVAL, 'ccc', 0, 0, 0, 0, 0, 0);
--------------------2_4.WRITER--------------------
INSERT INTO WRITER(WRITER_ID, WRITER_NAME) VALUES(WRITER_ID_SEQ.NEXTVAL, '�̼���');
INSERT INTO WRITER(WRITER_ID, WRITER_NAME) VALUES(WRITER_ID_SEQ.NEXTVAL, '��ä��');
INSERT INTO WRITER(WRITER_ID, WRITER_NAME) VALUES(WRITER_ID_SEQ.NEXTVAL, '�����');
INSERT INTO WRITER(WRITER_ID, WRITER_NAME) VALUES(WRITER_ID_SEQ.NEXTVAL, '�ڱ�ȣ');
INSERT INTO WRITER(WRITER_ID, WRITER_NAME) VALUES(WRITER_ID_SEQ.NEXTVAL, 'Į ���̰�');
--------------------2_6.BOOK--------------------
INSERT INTO BOOK(BOOK_ID, WRITER_ID, BOOK_PRICE, BOOK_NAME, BOOK_GENRE, BOOK_STORY, BOOK_PDATE, BOOK_SALEPRICE, BOOK_CNT, BOOK_SCORE, BOOK_SCORECOUNT)
VALUES(BOOK_ID_SEQ.NEXTVAL, 2, 15000, '�� �غ�', 'ECONOMIC', '�ο� ����� ������ �����, ������ ���� Having! ���� ���ʷ� �̱����� ��(�)�Ⱓ�Ǿ� ���谡 ���� ã�� ���� ���� �غ�(The Having)��.', '2020-03-01', 12000, 100, 0, 1);
INSERT INTO BOOK(BOOK_ID, WRITER_ID, BOOK_PRICE, BOOK_NAME, BOOK_GENRE, BOOK_STORY, BOOK_PDATE, BOOK_SALEPRICE, BOOK_CNT, BOOK_SCORE, BOOK_SCORECOUNT)
VALUES(BOOK_ID_SEQ.NEXTVAL, 2, 16000, '������ ���', 'ECONOMIC', '���ѹα� ���� 1%�� ���䰡 ���ϴ� ���� ������������ ��С�. �� å�� ��������� �����̴١���� ������ �������� ���� ���踦 Ǯ���, �츮�� ����� ������ ���� �ҿ��� ��ü�� �������� �鿩�ٺ���.', '2013-02-28', 14000, 100, 0, 1);
INSERT INTO BOOK(BOOK_ID, WRITER_ID, BOOK_PRICE, BOOK_NAME, BOOK_GENRE, BOOK_STORY, BOOK_PDATE, BOOK_SALEPRICE, BOOK_CNT, BOOK_SCORE, BOOK_SCORECOUNT)
VALUES(BOOK_ID_SEQ.NEXTVAL, 4, 18000, '�־��� �ʰ� ����ϰ�', 'LITERATURE', '��� �������� �������� ���� ��ȭ�����ڰ� �� ��!�������� ���� ���� �ߴ١� ����� �۰� 4�� ���� ����', '2020-06-05', 16000, 100, 0 , 1);
INSERT INTO BOOK(BOOK_ID, WRITER_ID, BOOK_PRICE, BOOK_NAME, BOOK_GENRE, BOOK_STORY, BOOK_PDATE, BOOK_SALEPRICE, BOOK_CNT, BOOK_SCORE, BOOK_SCORECOUNT)
VALUES(BOOK_ID_SEQ.NEXTVAL, 5, 15000, '���ο��� ����� �������� �� �¿��� ���� �Ա⵵ �ߴ�', 'LITERATURE', '����Ʈ ���� ����������� ���� �ڱ�ȣ�� ù ��° ���������ο��� ����� �������� �� �¿��� ���� �Ա⵵ �ߴ١�) �Ⱓ!', '2020-05-14', 13000, 100, 5 ,1);
INSERT INTO BOOK(BOOK_ID, WRITER_ID, BOOK_PRICE, BOOK_NAME, BOOK_GENRE, BOOK_STORY, BOOK_PDATE, BOOK_SALEPRICE, BOOK_CNT, BOOK_SCORE, BOOK_SCORECOUNT)
VALUES(BOOK_ID_SEQ.NEXTVAL, 5, 20000, '�������', 'LITERATURE', '�������Գ� �ִ� ������ ����� ����, ������� ������ ǥ������ ���� ���ο��ϴ� �������������� �̸��� �߶Ի��� �ձ۾��� ��� ������ ������� ������ ���� 3�� ���� �̸� �� �̵鿡�� 5,000���� ������ ���´� �ڱ�ȣ. 13�� SNS �����ڵ��� ������ �︰ ���� �̾߱⸦ ���������������. 2017�� �Ⱓ ���� ������ ���ڵ��� ������ �����ؿ� ������������� ���ο� ����� �������� ���� ���� 4���� ���� �������������� ���ڵ�� �ٽ� ������.', '2019-09-09', 17000, 100, 9.9, 3);
INSERT INTO BOOK(BOOK_ID, WRITER_ID, BOOK_PRICE, BOOK_NAME, BOOK_GENRE, BOOK_STORY, BOOK_PDATE, BOOK_SALEPRICE, BOOK_CNT, BOOK_SCORE, BOOK_SCORECOUNT)
VALUES(BOOK_ID_SEQ.NEXTVAL, 6, 20000, '�ڽ���', 'TECHNOLOGY', '���� ���缭�� �������ڽ��𽺡�. �� å���� ���ڴ� ������ ź���� ���ϰ��� ��ȭ, �¾��� ��� ����, ���ָ� ������ ������ �ǽ� �ִ� ������ �Ǵ� ����, �ܰ� ������ ���� ���� � ���� ������ �� ������ ������ �Ϸ���Ʈ�� ��鿩 ��̷Ӱ� �����Ѵ�. ���� õ������ ��ǥ�ϴ� ������ �������� ���ڴ� �� å���� ������� ������ ������, ������ ������ �����ϰ� �ؼ��ϴ� ���� �ɷ��� ������ �����Ѵ�.', '2006-01-20', 16000, 100, 15.15, 4);
--------------------2_10.BUYCARTLIST--------------------
INSERT INTO BUYCARTLIST(BUYCARTLIST_ID, CUSTOMER_ID, BOOK_ID, BUYCARTLIST_CNT) VALUES(BUYCARTLIST_ID_SEQ.NEXTVAL, 'aaa', 2, 3);
INSERT INTO BUYCARTLIST(BUYCARTLIST_ID, CUSTOMER_ID, BOOK_ID, BUYCARTLIST_CNT) VALUES(BUYCARTLIST_ID_SEQ.NEXTVAL, 'aaa', 3, 2);
INSERT INTO BUYCARTLIST(BUYCARTLIST_ID, CUSTOMER_ID, BOOK_ID, BUYCARTLIST_CNT) VALUES(BUYCARTLIST_ID_SEQ.NEXTVAL, 'aaa', 1, 1);
INSERT INTO BUYCARTLIST(BUYCARTLIST_ID, CUSTOMER_ID, BOOK_ID, BUYCARTLIST_CNT) VALUES(BUYCARTLIST_ID_SEQ.NEXTVAL, 'bbb', 2, 2);
------------------------------3.SQL�� Ȯ�� ------------------------------
--------------------2_1.CUSTOMER--------------------
select * from customer;
--------------------2_6.BOOK--------------------
select * from book;
SELECT b.BOOK_ID AS BOOK_ID, b.WRITER_ID AS WRITER_ID, b.BOOK_PRICE AS BOOK_PRICE, 
b.BOOK_NAME AS BOOK_NAME, b.BOOK_GENRE AS BOOK_GENRE, b.BOOK_STORY AS BOOK_STORY, 
b.BOOK_PDATE AS BOOK_PDATE, b.BOOK_SALEPRICE AS BOOK_SALEPRICE, b.BOOK_CNT AS BOOK_CNT, TO_CHAR(b.BOOK_SCORE, '999.00' ) AS BOOK_SCORE,
w.WRITER_ID AS WRITER_ID, w.WRITER_NAME AS WRITER_NAME
FROM BOOK b JOIN WRITER w 
ON b.WRITER_ID = w.WRITER_ID
WHERE REGEXP_LIKE (BOOK_NAME, '(*)��(*)') OR REGEXP_LIKE (WRITER_NAME, '(*)��(*)');
--WHERE BOOK_NAME = '������ ���';
select b.BOOK_ID AS BOOK_ID, b.WRITER_ID AS WRITER_ID, b.BOOK_PRICE AS BOOK_PRICE, b.BOOK_NAME AS BOOK_NAME, b.BOOK_GENRE AS BOOK_GENRE, b.BOOK_STORY AS BOOK_STORY, b.BOOK_PDATE AS BOOK_PDATE, b.BOOK_SALEPRICE AS BOOK_SALEPRICE, b.BOOK_CNT AS BOOK_CNT, b.BOOK_SCORE AS BOOK_SCORE, b.BOOK_SCORECOUNT AS BOOK_SCORECOUNT from (select * from book where book_genre = 'LITERATURE' order by book_score/book_scorecount desc) b where rownum=1;
--------------------2_13.BUYCARTLIST--------------------
ALTER TABLE BUYCARTLIST ADD (BUYCARTLIST_CNT NUMBER(30));
select SUM(BOOK_SALEPRICE) from book where book_id in ( select book_id from buycartlist WHERE customer_id='aaa' );
select SUM(BOOK_SALEPRICE) from book where book_id in ( select book_id from buycartlist WHERE customer_id='aaa' );
select book_id from buycartlist WHERE customer_id='aaa';
select b.book_id as book_id, b.book_name as book_name, l.buycartlist_cnt as book_cnt, b.book_price as book_price,(b.book_price*l.buycartlist_cnt) as book_totalprice
from book b 
inner join buycartlist l
on b.book_id = l.book_id
where customer_id='aaa';
------------------------------4.DB ���� ------------------------------
----- ���̺�1 �� ���� ������ ���� -----
DROP TABLE CUSTOMER;
----- ���̺�2 �� ���� ������ ���� -----
DROP TABLE QUESTION;
DROP SEQUENCE QUESTION_ID_SEQ;
DROP SEQUENCE QUESTION_GROUPID_SEQ;
----- ���̺�3 �� ���� ������ ���� -----
DROP TABLE TENDENCY;
DROP SEQUENCE TENDENCY_ID_SEQ;
----- ���̺�4 �� ���� ������ ���� -----
DROP TABLE WRITER;
DROP SEQUENCE WRITER_ID_SEQ;
----- ���̺�5 �� ���� ������ ���� -----
DROP TABLE STORE;
DROP SEQUENCE STORE_ID_SEQ;
----- ���̺�6 �� ���� ������ ���� -----
DROP TABLE BOOK;
DROP SEQUENCE BOOK_ID_SEQ;
----- ���̺�7 �� ���� ������ ���� -----
DROP TABLE BOOKSALE;
DROP SEQUENCE BOOKSALE_ID_SEQ;
----- ���̺�8 �� ���� ������ ���� -----
DROP TABLE BUYLIST;
DROP SEQUENCE BUYLIST_ID_SEQ;
----- ���̺�9 �� ���� ������ ���� -----
DROP TABLE BUY;
DROP SEQUENCE BUY_ID_SEQ;
----- ���̺�10 �� ���� ������ ���� -----
DROP TABLE BUYCARTLIST;
DROP SEQUENCE BUYCARTLIST_ID_SEQ;
----- ���̺�11 �� ���� ������ ���� -----
DROP TABLE BUYREVIEW;
DROP SEQUENCE BUYREVIEW_ID_SEQ;
------------------------------5. ������ �ʱ�ȭ------------------------------
-------------------------5_1. Template -------------------------
SELECT SEQUENCE_NAME FROM USER_SEQUENCES WHERE SEQUENCE_NAME='SEQUENCE_NAME';
SELECT SEQNENCE_NAME.CURRVAL FROM UDAL;
ALTER SEQUENCE SEQUENCE_NAME INCREMENT BY NUMBER;
-------------------------5_2. Example -------------------------
SELECT SEQUENCE_NAME FROM USER_SEQUENCES;
SELECT WRITER_ID_SEQ.NEXTVAL FROM UDAL;
ALTER SEQUENCE WRITER_ID_SEQ INCREMENT BY -15;
------------------------------6. sample------------------------------
select * from book where book_genre = 'LITERATURE' order by book_score/book_scorecount desc;
select b.* from (select * from book where book_genre = 'LITERATURE' order by book_score/book_scorecount desc) b where rownum=1;