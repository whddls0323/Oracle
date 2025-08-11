-- 생성자 Oracle SQL Developer Data Modeler 24.3.1.347.1153
--   위치:        2025-08-11 15:48:38 KST
--   사이트:      Oracle Database 21c
--   유형:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE cart (
    cartno        NUMBER NOT NULL,
    userid        VARCHAR2(20 BYTE) NOT NULL,
    prodno        NUMBER(6) NOT NULL,
    cartprodcount NUMBER,
    cartproddate  DATE NOT NULL
);

ALTER TABLE cart ADD CONSTRAINT cart_pk PRIMARY KEY ( cartno );

CREATE TABLE category (
    cateno   NUMBER(2) NOT NULL,
    catename VARCHAR2(100 BYTE) NOT NULL
);

ALTER TABLE category ADD CONSTRAINT category_pk PRIMARY KEY ( cateno );

CREATE TABLE orders (
    orderno         CHAR(11 BYTE) NOT NULL,
    userid          VARCHAR2(20 BYTE) NOT NULL,
    ordertotalprice NUMBER NOT NULL,
    orderaddress    VARCHAR2(200 BYTE) NOT NULL,
    orderstatus     NUMBER,
    orderdate       DATE NOT NULL
);

ALTER TABLE orders ADD CONSTRAINT orders_pk PRIMARY KEY ( orderno );

CREATE TABLE ordersitem (
    itemno       NUMBER NOT NULL,
    orderno      CHAR(11 BYTE) NOT NULL,
    prodno       NUMBER(6) NOT NULL,
    itemprice    NUMBER NOT NULL,
    itemdiscount NUMBER NOT NULL,
    itemcount    NUMBER
);

ALTER TABLE ordersitem ADD CONSTRAINT ordersitem_pk PRIMARY KEY ( itemno );

CREATE TABLE point (
    pointno   NUMBER NOT NULL,
    userid    VARCHAR2(20 BYTE) NOT NULL,
    point     NUMBER NOT NULL,
    "desc"    VARCHAR2(100 BYTE) NOT NULL,
    pointdate DATE NOT NULL
);

ALTER TABLE point ADD CONSTRAINT point_pk PRIMARY KEY ( pointno );

CREATE TABLE product (
    prodno       NUMBER(6) NOT NULL,
    cateno       NUMBER(2) NOT NULL,
    sellerno     NUMBER(5),
    prodname     VARCHAR2(100 BYTE) NOT NULL,
    prodprice    NUMBER NOT NULL,
    prodstock    NUMBER,
    prodsold     NUMBER,
    proddiscount NUMBER
);

ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( prodno );

CREATE TABLE seller (
    sellerno NUMBER(5) NOT NULL,
    company  VARCHAR2(100 BYTE) NOT NULL,
    tel      VARCHAR2(20 BYTE) NOT NULL,
    manager  VARCHAR2(20 BYTE) NOT NULL,
    address  VARCHAR2(100 BYTE) NOT NULL
);

ALTER TABLE seller ADD CONSTRAINT seller_pk PRIMARY KEY ( sellerno );

CREATE TABLE "User" (
    userid  VARCHAR2(20 BYTE) NOT NULL,
    name    VARCHAR2(20 BYTE) NOT NULL,
    birth   CHAR(10 BYTE) NOT NULL,
    gender  CHAR(1 BYTE) NOT NULL,
    hp      CHAR(13 BYTE) NOT NULL,
    email   VARCHAR2(100 BYTE),
    point   NUMBER,
    "level" NUMBER,
    address VARCHAR2(100 BYTE),
    regdate DATE NOT NULL
);

ALTER TABLE "User" ADD CONSTRAINT user_pk PRIMARY KEY ( userid );

ALTER TABLE "User" ADD CONSTRAINT user__un UNIQUE ( hp,
                                                    email );

ALTER TABLE cart
    ADD CONSTRAINT cart_product_fk FOREIGN KEY ( prodno )
        REFERENCES product ( prodno );

ALTER TABLE cart
    ADD CONSTRAINT cart_user_fk FOREIGN KEY ( userid )
        REFERENCES "User" ( userid );

ALTER TABLE orders
    ADD CONSTRAINT orders_user_fk FOREIGN KEY ( userid )
        REFERENCES "User" ( userid );

ALTER TABLE ordersitem
    ADD CONSTRAINT ordersitem_orders_fk FOREIGN KEY ( orderno )
        REFERENCES orders ( orderno );

ALTER TABLE ordersitem
    ADD CONSTRAINT ordersitem_product_fk FOREIGN KEY ( prodno )
        REFERENCES product ( prodno );

ALTER TABLE point
    ADD CONSTRAINT point_user_fk FOREIGN KEY ( userid )
        REFERENCES "User" ( userid );

ALTER TABLE product
    ADD CONSTRAINT product_category_fk FOREIGN KEY ( cateno )
        REFERENCES category ( cateno );

ALTER TABLE product
    ADD CONSTRAINT product_seller_fk FOREIGN KEY ( sellerno )
        REFERENCES seller ( sellerno );


-- 모델링 실습1
insert into "User" values('user1','김유신','1976-01-21','M','010-1101-1976','kimys@naver.com',7000,1,'서울','2022-01-10 10:50:12');
insert into "User" values('user2','계백','1975-06-11','M','010-1102-1975',null,5650,1,'서울','2022-01-10 10:50:12');
insert into "User" values('user3','김춘추','1989-05-30','M','010-1103-1989',null,4320,2,'서울','2022-01-10 10:50:12');
insert into "User" values('user4','이사부','1979-04-13','M','010-2101-1979','kimys@naver.com',0,1,'서울','2022-01-10 10:50:12');
insert into "User" values('user5','장보고','1966-09-12','M','010-2104-1966','kimys@naver.com',3000,4,'대전','2022-01-10 10:50:12');
insert into "User" values('user6','선덕여왕','1979-07-28','M','010-3101-1979','kimys@naver.com',15840,2,'대전','2022-01-10 10:50:12');
insert into "User" values('user7','강감찬','1984-06-15','F','010-4101-1984','kimys@naver.com',3610,0,'대구','2022-01-10 10:50:12');
insert into "User" values('user8','신사임당','1965-10-21','M','010-5101-1965','kimys@naver.com',0,1,'대구','2022-01-10 10:50:12');
insert into "User" values('user9','이이','1972-11-28','F','010-6101-1972','kimys@naver.com',0,3,'부산','2022-01-10 10:50:12');
insert into "User" values('user10','허난설헌','1992-09-07','F','010-7103-1992',null,0,3,'광주','2022-01-10 10:50:12');

insert into point values(1,'user1',1000,'회원가입 1000 적립','2022-01-10 10:50:12');
insert into point values(2,'user1',6000,'상품구매 5% 적립','2022-01-10 10:50:12');
insert into point values(3,'user3',2820,'상품구매 5% 적립','2022-01-10 10:50:12');
insert into point values(4,'user7',3610,'상품구매 5% 적립','2022-01-10 10:50:12');
insert into point values(5,'user5',3000,'이벤트 응모 3000 적립','2022-01-10 10:50:12');
insert into point values(6,'user2',1000,'회원가입 1000 적립','2022-01-10 10:50:12');
insert into point values(7,'user2',2000,'이벤트 응모 2000 적립','2022-01-10 10:50:12');
insert into point values(8,'user2',2650,'상품구매 5% 적립','2022-01-10 10:50:12');
insert into point values(9,'user3',1500,'이벤트 응모 1500 적립','2022-01-10 10:50:12');
insert into point values(10,'user6',15840,'상품구매 2% 적립','2022-01-10 10:50:12');

insert into seller values(10001,'(주)다팔아','02-201-1976','정우성','서울');
insert into seller values(10002,'판매의민족','02-102-1975','이정재','서울');
insert into seller values(10003,'멋남','031-103-1989','원빈','경기');
insert into seller values(10004,'스타일살아','032-201-1979','이나영','경기');
insert into seller values(10005,'(주)삼성전자','02-214-1966','장동건','서울');
insert into seller values(10006,'복실이옷짱','051-301-1979','고소영','부산');
insert into seller values(10007,'컴퓨존(주)','055-401-1984','유재석','대구');
insert into seller values(10008,'(주)LG전자','02-511-1965','강호동','서울');
insert into seller values(10009,'굿바디스포츠','070-6101-1972','조인성','부산');
insert into seller values(10010,'누리푸드','051-710-1992','강동원','부산');

insert into category values(10,'여성의류패션');
insert into category values(11,'남성의류패션');
insert into category values(12,'식품·생필품');
insert into category values(13,'취미·반려견');
insert into category values(14,'홈·문구');
insert into category values(15,'자동차·공구');
insert into category values(16,'스포츠·건강');
insert into category values(17,'컴퓨터·가전·디지털');
insert into category values(18,'여행');
insert into category values(19,'도서');

insert into product values(100101,11,10003,'반팔티 L~2XL',869,25000,132,20);
insert into product values(100110,10,10004,'트레이닝 통바지',1602,38000,398,15);
insert into product values(110101,10,10003,'신상 여성운동화',160,76000,40,5);
insert into product values(120101,12,10010,'암소 1등급 구이셋트 1.2kg',0,150000,87,15);
insert into product values(120103,12,10010,'바로구이 부채살 250g',0,21000,61,10);
insert into product values(130101,13,10006,'[ANF] 식스프리 강아지 사료',58,56000,142,0);
insert into product values(130112,13,10006,'중대형 사계절 강아지옷',120,15000,80,0);
insert into product values(141001,14,10001,'라떼 2인 소파/방수 패브릭',0,320000,42,0);
insert into product values(170115,17,10007,'지포스 3080 그래픽카드',28,900000,12,12);
insert into product values(160103,16,10009,'치닝디핑 33BR 철봉',32,120000,28,0);

insert into orders values('22010210001','user2',52300,'서울시 마포구 121',1,'2022-01-10 10:50:12');
insert into orders values('22010210002','user3',56700,'서울시 강남구 21-1',1,'2022-01-10 10:50:12');
insert into orders values('22010210010','user4',72200,'서울시 강서구 큰대로 38',2,'2022-01-10 10:50:12');
insert into orders values('22010310001','user5',127000,'경기도 광주시 초월로 21',1,'2022-01-10 10:50:12');
insert into orders values('22010310100','user1',120000,'경기도 수원시 120번지',0,'2022-01-10 10:50:12');
insert into orders values('22010410101','user6',792000,'부산시 남구 21-1',2,'2022-01-10 10:50:12');
insert into orders values('22010510021','user7',92200,'부산시 부산진구 56 10층',4,'2022-01-10 10:50:12');
insert into orders values('22010510027','user8',112000,'대구시 팔달로 19',3,'2022-01-10 10:50:12');
insert into orders values('22010510031','user10',792000,'대전시 한밭로 24-1',2,'2022-01-10 10:50:12');
insert into orders values('22010710110','user9',94500,'광주시 충열로 11',1,'2022-01-10 10:50:12');

insert into ordersitem values(1,22010210001,'100110',38000,15,1);
insert into ordersitem values(2,22010210001,'100101',25000,20,1);
insert into ordersitem values(3,22010210002,'120103',21000,10,3);
insert into ordersitem values(4,22010310001,'130112',15000,0,1);
insert into ordersitem values(5,22010310001,'130101',56000,0,2);
insert into ordersitem values(6,22010210010,'110101',76000,5,1);
insert into ordersitem values(7,22010310100,'160103',120000,0,1);
insert into ordersitem values(8,22010410101,'170115',900000,12,1);
insert into ordersitem values(9,22010510021,'110101',76000,5,1);
insert into ordersitem values(10,22010510027,'130101',56000,0,2);
insert into ordersitem values(11,22010510021,'100101',25000,20,1);
insert into ordersitem values(12,22010510031,'170115',900000,12,1);
insert into ordersitem values(13,22010710110,'120103',21000,10,5);

insert into cart values(1,'user1',100101,1,'2022-01-10 10:50:12');
insert into cart values(2,'user1',100110,2,'2022-01-10 10:50:12');
insert into cart values(3,'user3',120103,1,'2022-01-10 10:50:12');
insert into cart values(4,'user4',130112,1,'2022-01-10 10:50:12');
insert into cart values(5,'user5',130101,1,'2022-01-10 10:50:12');
insert into cart values(6,'user2',110101,3,'2022-01-10 10:50:12');
insert into cart values(7,'user2',160103,1,'2022-01-10 10:50:12');
insert into cart values(8,'user2',170115,1,'2022-01-10 10:50:12');
insert into cart values(9,'user3',110101,1,'2022-01-10 10:50:12');
insert into cart values(10,'user6',130101,1,'2022-01-10 10:50:12');

-- 문제1.
select u.name,p.prodName,c.cartProdCount from cart c 
join "User" u on c.userId=u.userId
join product p on c.prodNo=p.prodNo where cartProdCount >= 2;

-- 문제2.
select o.prodNo,c.cateName,p.prodName,p.prodprice,s.manager,s.tel from product p 
join ordersitem o on p.prodNo=o.prodNo
join category c on p.cateNO=c.cateNo
join seller s on p.sellerNo=s.sellerNo;

-- 문제3.
select u.userId,u.name,u.hp,u.point as 현재포인트,p.point as 적립포인트 from "User" u
left join point p on u.userId=p.userId;

-- 문제4.
select o.orderNo,o.userId,u.name,oi.itemPrice,o.orderDate from "User" u
join orders o on u.userId=o.userId 
join ordersitem oi on o.orderNo=oi.orderNo 
where itemPrice >= 100000 order by itemPrice desc,name;

-- 문제5.
select orders.orderno,cart.userId,user.name,product.prodName,orders.orderDate from "User" u
join orders o on u.userId=o.userId; -- ??

-- 문제6.
select prodNo,prodName,prodPrice,prodDiscount,
case
    when prodDiscount = 0 then prodPrice
    else prodPrice * (1 - prodDiscount / 100)
end as "할인된 가격" from product;

-- 문제7.
select p.prodNo,p.prodName,p.prodPrice,p.prodStock,s.manager from product p
join seller s on p.sellerNo=s.sellerNo where manager='고소영';

-- 문제8.
select sellerNo,company,manager,tel from seller where sellerNo not in(select sellerNo from product);


-- 문제9.
-- ??

-- 문제10.
select u.name,p.prodName from "User" u
join cart c on u.userId=c.userId
join product p on c.prodNo=p.prodNo where u.name='장보고';