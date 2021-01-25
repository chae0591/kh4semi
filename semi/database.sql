
-- 계정 생성
-- project5/project5
create user project5 identified by project5;
grant connect, resource to project5;

-- 테이블 확인
desc member;
desc tip_board;
desc tip_opinion;
desc tip_vote;
desc qna_opinion;
desc qna_vote;
desc qna_board;
desc tip_tmp_file;

-- 테이블 삭제
drop table tip_opinion;
drop table tip_vote;
drop table tip_board;
drop table qna_opinion;
drop table qna_vote;
drop table qna_board;
drop table member;
drop table tip_tmp_file;

-- 시퀀스 삭제
drop sequence member_seq;
drop sequence tip_opinion_seq;
drop sequence tip_vote_seq;
drop sequence tip_board_seq;
drop sequence qna_opinion_seq;
drop sequence qna_vote_seq;
drop sequence qna_board_seq;
drop sequence tip_tmp_file_seq;

-- 테스트
---- 테스트 데이터 생성
------ member
insert into member(member_no, member_id, member_pw, member_nick) values(pj5_member_seq.nextval, 'test', 'test', 'test');
------ tip_board
insert into tip_board(board_no, board_writer, board_title, board_content, start_date, end_date) 
values(
    tip_board_seq.nextval, 
    (select max(member_id) from member), 
	'test',
	'test',
    SYSDATE,
    SYSDATE
);
------ tip_opinion
insert into tip_opinion(opinion_no, opinion_text, board_no, opinion_writer) 
values(
    tip_opinion_seq.nextval, 
	'test',
    (select max(board_no) from tip_board), 
    (select max(member_id) from member)
);

------ commit
commit;

---- 테스트 데이터 확인
select * from member;
select * from tmp_file;
select * from tip_board order by board_no desc;
select * from tip_tmp_file;


-- 테이블 생성
--------------------------------------------------------------------------
---- 파일 테이블
create table qna_tmp_file(
	file_no number primary key,
	upload_name varchar2(256) not null,
	save_name varchar2(256) not null unique, 
	file_size number default 0, 
	file_type varchar2(256),
	board_no references qna_board(board_no) on delete set null
	-- 상황에 맞게 외래키 한개만 설정하면 다른 시스템과 연동이 가능
	-- (ex : 회원프로필사진 - 회원번호 , 첨부파일 - 게시판번호)
);
create sequence qna_tmp_file_seq;

create table tip_tmp_file(
	file_no number primary key,
	upload_name varchar2(256) not null,
	save_name varchar2(256) not null unique, 
	file_size number default 0, 
	file_type varchar2(256),
	board_no references tip_board(board_no) on delete set null
	-- 상황에 맞게 외래키 한개만 설정하면 다른 시스템과 연동이 가능
	-- (ex : 회원프로필사진 - 회원번호 , 첨부파일 - 게시판번호)
);
create sequence tip_tmp_file_seq;

---- 멤버 테이블 
create table member(
    member_no number primary key, 
    member_id varchar2(20) not null unique, 
    member_pw varchar2(20) not null, 
    member_nick varchar2(20) not null unique, 
    member_join date default sysdate not null 
);
create sequence member_seq;

---- 여행 Q&A 테이블
create table qna_board(
	board_no number primary key,
	board_writer not null references member(member_id) on delete cascade,
	board_title varchar2(240) not null,
	board_content varchar2(4000) not null,
	regist_time date default sysdate not null,
	vote number default 0 not null
);
create sequence qna_board_seq;

create table qna_opinion(
	opinion_no number primary key,
	opinion_content varchar2(240) not null,
	regist_time date default sysdate not null,
	board_no references qna_board(board_no) on delete cascade,
	opinion_writer references member(member_id) on delete set null
);
create sequence qna_opinion_seq;

create table qna_vote(
	vote_no number primary key,
	board_no references qna_board(board_no) on delete cascade,
	member_id references member(member_id) on delete set null
);
create sequence qna_vote_seq;

---- 여행 꿀팁 테이블
create table tip_board(
	board_no number primary key,
	board_writer not null references member(member_id) on delete cascade,
	board_title varchar2(240) not null,
	board_content varchar2(4000) not null,
	regist_time date default sysdate not null,
	vote number default 0 not null,
	start_date date not null,
	end_date date not null
);
create sequence tip_board_seq;

create table tip_opinion (
	opinion_no number primary key,
	opinion_text varchar2(240) not null,
	regist_time date default sysdate not null,
	board_no references tip_board(board_no) on delete cascade,
	opinion_writer references member(member_id) on delete set null
);
create sequence tip_opinion_seq;

create table tip_vote (
	vote_no	number primary key,
	board_no not null references tip_board(board_no) on delete cascade,
	member_no not null references member(member_no) on delete set null
);
create sequence tip_vote_seq;
