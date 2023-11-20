INSERT INTO author(id, name, email, password, role) 
values(2, 'lee', 'abc1@naver.com', '1234', 'User');
INSERT INTO author(id, name, email, password, role) 
values(3, 'park', 'abc2@naver.com', '1234', 'User');
INSERT INTO author(id, name, email, password, role) 
values(4, 'choi', 'abc3@naver.com', '1234', 'User');
INSERT INTO author(id, name, email, password, role) 
values(5, 'jung', 'abc4@naver.com', '1234', 'User');
INSERT INTO author(id, name, email, password, role) 
values(6, 'hwang', 'abc5@naver.com', '1234', 'User');

INSERT INTO post(id, title, contents, author_id) 
values(1, 'hello1', 'go to hello', 1);
INSERT INTO post(id, title, contents, author_id) 
values(2, 'hello2', 'go to hello', 2);

-- 저자가 비어있는 데이터
INSERT INTO post(id, title, contents) 
values(3, 'hello3', 'go to hello');
INSERT INTO post(id, title, contents) 
values(4, 'hello4', 'go to hello');

-- author 테이블에 없는 저자 추가하는 데이터(에러발생)
INSERT INTO post(id, title, contents, author_id) 
values(5, 'hello55', 'go to hello', 55);
SQL Error [1452] [23000]: (conn=13) Cannot add or update a child row
: a foreign key constraint fails (`board`.`post`,
 CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`))

-- author 데이터 중 id가 4인 데이터의 email을 abc@naver.com, name을 abc로 변경
UPDATE author SET email='abc@naver.com', name='abc' WHERE id=4;
-- post에 글을 작성 하지 않은 author 데이터 1개 삭제
DELETE FROM author WHERE id=5;
-- post에 글 쓴적이 있는 author 데이터 1개 삭제 -> 에러 -> 조치 후 삭제
DELETE FROM author WHERE id=1;
ERROR 1451 (23000): Cannot delete or update a parent row
: a foreign key constraint fails (`board`.`post`,
 CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`))
DELETE FROM post WHERE author_id = 1;
DELETE FROM author WHERE id=1;

-- post의 title 칼럼의 제약조건을 not null로 변경
ALTER TABLE post MODIFY COLUMN title varchar(255) not null;

--post 테이블의 id에 auto_increment적용
alter table post MODIFY COLUMN id INT AUTO_INCREMENT;

--post 테이블에 id 없이 insert
INSERT INTO post (title, contents, author_id) VALUES ("1234", "1536", 2);

--위의 데이터 삭제
DELETE FROM post WHERE id = 6;

-- 다시 테이터 생성
-- auto_increment로 id값이 1 증가된 7인것을 볼 수 있다.
INSERT INTO post (title, contents, author_id) VALUES ("1234", "1536", 2);

--now()를 통해서 오늘 생성된 데이터 출력
SELECT * from post 
WHERE DATE_FORMAT(created_time,'%Y-%m-%d') = DATE_FORMAT(now(), '%Y-%m-%d');


-- 테이블의 인덱스 조회
SHOW INDEX FROM 테이블명
-- 테이블의 인덱스를 삭제
ALTER TABLE 테이블이름 DROP INDEX 인덱스명;

-- author 테이블의 email 컬럼에 unique제약 조건 추가
ALTER TABLE author MODIFY COLUMN email VARCHAR(255) UNIQUE;
--제약조건 조회
SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'author';
-- email 컬럼의 제약조건 삭제
ALTER TABLE author DROP CONSTRAINT email_unique;
-- author 테이블의 email 컬럼에 unique제약 조건 추가(방법 2)
ALTER TABLE author ADD CONSTRAINT unique_email UNIQUE(email);