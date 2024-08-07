--테이블 생성
CREATE TABLE MEMBER(
	ID VARCHAR2(10) NOT NULL, --ID
	PASS VARCHAR2(10) NOT NULL, --PW
	NAME VARCHAR2(30) NOT NULL, --NAME
	REGIDATE DATE DEFAULT SYSDATE NOT NULL, --생성날짜
	PRIMARY KEY(ID) --기본키 생성
) -- 회원용 테이블

CREATE TABLE BOARD(
	NUM NUMBER PRIMARY KEY, -- 게시물 번호(시퀀스)
	TITLE VARCHAR2(200) NOT NULL, -- 제목
	CONTENT VARCHAR2(2000) NOT NULL, -- 내용
	ID VARCHAR2(10) NOT NULL, -- 작성자 -> MEMBER = ID
	POSTDATE DATE DEFAULT SYSDATE NOT NULL, -- 작성일
	VISITCOUNT NUMBER(6)	--조회수
)

-- 외래키 설정 (부모 MEMBER -> 자식 BOARD ) *자식에서 부모를 바라본다
--                     제약조건   제약조건 이름
ALTER TABLE BOARD ADD CONSTRAINT BOARD_MEMBER_FK FOREIGN KEY(ID) REFERENCES MEMBER(ID);

--시퀀스 설정 (자동번호 주입)
CREATE SEQUENCE SEQ_BOARD_NUM
	INCREMENT BY 1  -- 증가값 1
	START WITH 1 -- 시작값 1
	MINVALUE 1 -- 최소값 1
	NOMAXVALUE -- 최대값 없음
	NOCYCLE -- 반복 없음
	NOCACHE; -- 미리 만들지 않음
	
DROP SEQUENCE SEQ_BOARD_NUM ; -- 시퀀스 객체 삭제

INSERT INTO MEMBER(ID, PASS, NAME) VALUES('KKW', '1234', '김기원');
INSERT INTO MEMBER(ID, PASS, NAME) VALUES('AAA', '1234', '안희준');
INSERT INTO MEMBER(ID, PASS, NAME) VALUES('BBB', '1234', '용상엽');
INSERT INTO MEMBER(ID, PASS, NAME) VALUES('CCC', '1234', '양승환');
INSERT INTO MEMBER(ID, PASS, NAME) VALUES('DDD', '1234', '조건재');


-- 더미데이터 
INSERT INTO BOARD(NUM, TITLE, CONTENT, ID, POSTDATE, VISITCOUNT)
VALUES(SEQ_BOARD_NUM.NEXTVAL, '제목1', '내용1', 'KKW', SYSDATE, 0);
INSERT INTO BOARD(NUM, TITLE, CONTENT, ID, POSTDATE, VISITCOUNT)
VALUES(SEQ_BOARD_NUM.NEXTVAL, '제목2', '내용2', 'AAA', SYSDATE, 0);
INSERT INTO BOARD(NUM, TITLE, CONTENT, ID, POSTDATE, VISITCOUNT)
VALUES(SEQ_BOARD_NUM.NEXTVAL, '제목3', '내용3', 'BBB', SYSDATE, 0);
INSERT INTO BOARD(NUM, TITLE, CONTENT, ID, POSTDATE, VISITCOUNT)
VALUES(SEQ_BOARD_NUM.NEXTVAL, '제목4', '내용4', 'CCC', SYSDATE, 0);
INSERT INTO BOARD(NUM, TITLE, CONTENT, ID, POSTDATE, VISITCOUNT)
VALUES(SEQ_BOARD_NUM.NEXTVAL, '제목5', '내용5', 'DDD', SYSDATE, 0);

SELECT * FROM MEMBER; -- MEMBER 테이블 전체 보기
SELECT * FROM BOARD; -- BOARD 테이블 전체 보기
select * from member where id='KKW' and pass='1234';

select count(*) from board where title like '%제목%';

select B.*, M.* from member M inner join board B on M.id = B.id where num=3; -- Join
update board set visitcount = visitcount+1 where num=2;

select *from (
 			   select Tb.*, rownum rNum from (
 			   								  select * from board order by num desc
 			   								 ) Tb
			 ) where rNum between 1 and 10 ;
			 
			 
create table myfile (
	idx number primary key,
	name varchar2(50) not null,
	title varchar2(200) not null,
	cate varchar2(30),
	ofile varchar2(100) not null, -- 원본파일명
	sfile varchar2(100) not null, -- 저장파일명
	postdate date default sysdate not null
);

select * from myfile;
drop table myfile;