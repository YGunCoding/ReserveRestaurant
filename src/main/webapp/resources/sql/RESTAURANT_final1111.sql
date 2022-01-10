--drop table
DROP TABLE BOOK CASCADE CONSTRAINTS;
DROP TABLE COMMENTS CASCADE CONSTRAINTS;
DROP TABLE MENU CASCADE CONSTRAINTS;
DROP TABLE NOTICE CASCADE CONSTRAINTS;
DROP TABLE OWNER CASCADE CONSTRAINTS;
DROP TABLE QNA CASCADE CONSTRAINTS;
DROP TABLE REPLY CASCADE CONSTRAINTS;
DROP TABLE RESTAURANT CASCADE CONSTRAINTS;
DROP TABLE REVIEW CASCADE CONSTRAINTS;
DROP TABLE UPLOADFILE CASCADE CONSTRAINTS;
DROP TABLE USERLOG CASCADE CONSTRAINTS;
DROP TABLE USERTABLE CASCADE CONSTRAINTS;
DROP TABLE PAY CASCADE CONSTRAINTS;


--create table

CREATE TABLE book (

    book_no                 NUMBER NOT NULL,

    book_type               VARCHAR2(32 BYTE),

    book_people               NUMBER,

    book_request              VARCHAR2(1000 BYTE),

    user_no                NUMBER NOT NULL,

    res_no                    NUMBER NOT NULL,

    book_state                NUMBER(1),

    book_hours              VARCHAR2(2 BYTE),

    book_date             VARCHAR2(2 BYTE)

);

 

ALTER TABLE book ADD CONSTRAINT book_pk PRIMARY KEY ( book_no );


CREATE TABLE comments (

    comment_no                 NUMBER NOT NULL,

    review_no                    NUMBER,         

    content                 VARCHAR2(32 BYTE),

    writer              VARCHAR2(1000 BYTE),

    create_date                date
    
);

 

ALTER TABLE comments ADD CONSTRAINT comments_pk PRIMARY KEY ( comment_no );

 

CREATE TABLE menu (

    menu_no                 NUMBER NOT NULL,

    menu_name                 VARCHAR2(100 BYTE),

    menu_price                NUMBER(13),
    
    res_no          NUMBER NOT NULL

);

 

ALTER TABLE menu ADD CONSTRAINT menu_pk PRIMARY KEY ( menu_no );

 

CREATE TABLE notice (

    notice_no          NUMBER NOT NULL,

    notice_writer          VARCHAR2(32 BYTE),

    notice_title           VARCHAR2(100 BYTE),

    notice_content         VARCHAR2(2000 BYTE),

    notice_hit             NUMBER,

    notice_date        DATE,

    notice_lastmodified    DATE

);

 

ALTER TABLE notice ADD CONSTRAINT notice_pk PRIMARY KEY ( notice_no );

 
CREATE TABLE owner (

    owner_no       NUMBER NOT NULL,

    id          VARCHAR2(32 BYTE) NOT NULL,

    pw          VARCHAR2(100 BYTE) NOT NULL,

    email       varchar2(100 BYTE),

    tel         VARCHAR2(13 BYTE),
    
    name       varchar2(50 byte),

    state       number(1)
    
   

);

 

ALTER TABLE owner ADD CONSTRAINT owner_pk PRIMARY KEY ( owner_no );

 

CREATE TABLE qna (

    qna_no            NUMBER NOT NULL,

    qna_writer          VARCHAR2(32 BYTE),
    
    qna_title           VARCHAR2(100 BYTE),

    qna_content         VARCHAR2(2000 BYTE),

    qna_hit             NUMBER,

    qna_date          DATE,

    qna_lastmodified 	DATE,

    qna_state       NUMBER(1),
    
    res_no          NUMBER
);

 

ALTER TABLE qna ADD CONSTRAINT qna_pk PRIMARY KEY ( qna_no );

 

CREATE TABLE reply (

    reply_no               NUMBER NOT NULL,
    
    reply_writer              VARCHAR2(32 BYTE),

    reply_content             VARCHAR2(2000 BYTE),

    reply_date             DATE,
    
    qna_no               NUMBER NOT NULL
);

 

ALTER TABLE reply ADD CONSTRAINT reply_pk PRIMARY KEY ( reply_no );


CREATE TABLE pay (

    pay_no               NUMBER NOT NULL,
    
    user_no              NUMBER NOT NULL,

    res_no             NUMBER NOT NULL,
     
    book_no             NUMBER NOT NULL,
    
    pay_date           VARCHAR2(100 BYTE),

    pay_name          VARCHAR2(32 BYTE),

    pay_method       VARCHAR2(32 BYTE),    

    amount          NUMBER
    
);


 

ALTER TABLE pay ADD CONSTRAINT pay_pk PRIMARY KEY ( pay_no );


 

CREATE TABLE restaurant (

    res_no              NUMBER NOT NULL,

    res_name            VARCHAR2(50 BYTE),

    res_address          VARCHAR2(300 BYTE),
    
    res_address_detail       varchar2(300 byte),

    res_open_time        VARCHAR2(20 BYTE),
    
    res_close_time        VARCHAR2(20 BYTE),

    res_tel             VARCHAR2(13 BYTE),
    
    res_content       varchar2(4000 BYTE),
    
    res_option          varchar2(200 byte),

    res_origin           VARCHAR2(300 BYTE),

    res_saved            VARCHAR2(300 BYTE),

    res_path             VARCHAR2(300 BYTE),

    owner_no          NUMBER NOT NULL,
    
    res_state           NUMBER

);

 

ALTER TABLE restaurant ADD CONSTRAINT restaurant_pk PRIMARY KEY ( res_no );

 

CREATE TABLE review (

    review_no                 NUMBER NOT NULL,

    review_writer            VARCHAR2(32 BYTE),

    review_content           VARCHAR2(2000 BYTE),

    review_origin            VARCHAR2(300 BYTE),

    review_saved             VARCHAR2(300 BYTE),

    review_path              VARCHAR2(300 BYTE),

    review_date              DATE,

    review_rate              NUMBER(5),

    user_no                NUMBER NOT NULL,

    res_no         NUMBER NOT NULL


);

 

ALTER TABLE review ADD CONSTRAINT review_pk PRIMARY KEY ( review_no );

 

CREATE TABLE userlog (

    log_no                   NUMBER NOT NULL,

    log_date                DATE,

    user_no               NUMBER NOT NULL

);

 

ALTER TABLE userlog ADD CONSTRAINT userlog_pk PRIMARY KEY ( log_no );

 

CREATE TABLE usertable (

    user_no          NUMBER NOT NULL,

    id               VARCHAR2(32 BYTE) NOT NULL,

    pw               VARCHAR2(100 BYTE),

    name        VARCHAR2(50 BYTE),

    tel         VARCHAR2(13 BYTE),

    grade       VARCHAR2(6 BYTE),

    user_date        DATE,

    hbd         VARCHAR2(10 BYTE),

    state            NUMBER(1),

    point            NUMBER(4),

    email       VARCHAR2(100 BYTE)

);

CREATE TABLE uploadfile (

    uuid          VARCHAR2(100 BYTE) NOT NULL,

    PATH               VARCHAR2(100 BYTE),

    origin               VARCHAR2(100 BYTE),

    res_no            NUMBER

);


ALTER TABLE usertable ADD CONSTRAINT usertable_pk PRIMARY KEY ( user_no );

--drop sequence
DROP SEQUENCE book_no_seq;  
DROP SEQUENCE comment_no_seq;  
DROP SEQUENCE menu_no_seq; 
DROP SEQUENCE notice_no_seq; 
DROP SEQUENCE owner_no_seq; 
DROP SEQUENCE qna_no_seq; 
DROP SEQUENCE reply_no_seq; 
DROP SEQUENCE res_no_seq; 
DROP SEQUENCE review_no_seq; 
DROP SEQUENCE log_no_seq; 
DROP SEQUENCE user_no_seq; 
DROP SEQUENCE pay_no_seq; 

-- create sequence

CREATE SEQUENCE book_no_seq  INCREMENT BY 1 START WITH 1  NOCYCLE NOCACHE; 
CREATE SEQUENCE comment_no_seq  INCREMENT BY 1 START WITH 1  NOCYCLE NOCACHE;
CREATE SEQUENCE menu_no_seq  INCREMENT BY 1 START WITH 1  NOCYCLE NOCACHE; 
CREATE SEQUENCE notice_no_seq  INCREMENT BY 1 START WITH 1  NOCYCLE NOCACHE; 
CREATE SEQUENCE owner_no_seq  INCREMENT BY 1 START WITH 1  NOCYCLE NOCACHE; 
CREATE SEQUENCE qna_no_seq  INCREMENT BY 1 START WITH 1  NOCYCLE NOCACHE; 
CREATE SEQUENCE reply_no_seq  INCREMENT BY 1 START WITH 1  NOCYCLE NOCACHE; 
CREATE SEQUENCE res_no_seq  INCREMENT BY 1 START WITH 1  NOCYCLE NOCACHE; 
CREATE SEQUENCE review_no_seq  INCREMENT BY 1 START WITH 1  NOCYCLE NOCACHE; 
CREATE SEQUENCE log_no_seq  INCREMENT BY 1 START WITH 1  NOCYCLE NOCACHE; 
CREATE SEQUENCE user_no_seq  INCREMENT BY 1 START WITH 1  NOCYCLE NOCACHE; 
CREATE SEQUENCE pay_no_seq  INCREMENT BY 1 START WITH 1  NOCYCLE NOCACHE; 



--foreign key

ALTER TABLE book

    ADD CONSTRAINT book_restaurant_fk FOREIGN KEY ( res_no )

        REFERENCES restaurant ( res_no )

            ON DELETE CASCADE;

 

ALTER TABLE book

    ADD CONSTRAINT book_usertable_fk FOREIGN KEY ( user_no )

        REFERENCES usertable ( user_no )

            ON DELETE CASCADE;

ALTER TABLE comments

    ADD CONSTRAINT comment_review_fk FOREIGN KEY ( review_no )

        REFERENCES review ( review_no )

            ON DELETE CASCADE;


 

ALTER TABLE menu

    ADD CONSTRAINT menu_restaurant_fk FOREIGN KEY ( res_no )

        REFERENCES restaurant ( res_no )

            ON DELETE CASCADE;

 


ALTER TABLE reply

    ADD CONSTRAINT reply_qna_fk FOREIGN KEY ( qna_no )

        REFERENCES qna ( qna_no )

            ON DELETE CASCADE;


ALTER TABLE restaurant

    ADD CONSTRAINT restaurant_owner_fk FOREIGN KEY ( owner_no )

        REFERENCES owner ( owner_no )

            ON DELETE CASCADE;

 

ALTER TABLE review

    ADD CONSTRAINT review_restaurant_fk FOREIGN KEY ( res_no )

        REFERENCES restaurant ( res_no )

            ON DELETE CASCADE;

 

ALTER TABLE review

    ADD CONSTRAINT review_usertable_fk FOREIGN KEY ( user_no )

        REFERENCES usertable ( user_no )

            ON DELETE CASCADE;

 

ALTER TABLE userlog

    ADD CONSTRAINT userlog_usertable_fk FOREIGN KEY ( user_no )

        REFERENCES usertable ( user_no )

            ON DELETE CASCADE;
            
ALTER TABLE pay

    ADD CONSTRAINT pay_usertable_fk FOREIGN KEY ( user_no )

        REFERENCES usertable ( user_no )

            ON DELETE CASCADE;
            
ALTER TABLE pay

    ADD CONSTRAINT pay_restaurant_fk FOREIGN KEY (res_no)

        REFERENCES restaurant (res_no)

            ON DELETE CASCADE;
            

ALTER TABLE pay

    ADD CONSTRAINT pay_book_fk FOREIGN KEY (book_no)

        REFERENCES book (book_no)
        ON DELETE CASCADE;