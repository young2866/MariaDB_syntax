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

-- post테이블의 외래키 조건 삭제
ALTER TABLE post DROP FOREIGN KEY post_ibfk_1;
-- 조건 삭제됐는지 조회
SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'post';
-- ON UPDATE CASCADE 옵션을 가진 외래키 조건 생성
ALTER TABLE post ADD CONSTRAINT post_author_fk FOREIGN KEY(author_id)
REFERENCES author(id) ON UPDATE CASCADE;
-- author_id가 2인 데이터 업데이트
-- author_id가 2인 데이터들이 전부 10으로 변경된 것을 볼 수 있다.
UPDATE author SET id = 10 WHERE id = 2;

-- ON DELETE SET NULL ON UPDATE SET NULL
ALTER TABLE post ADD CONSTRAINT post_author_fk FOREIGN KEY(author_id)
REFERENCES author(id) ON DELETE SET NULL ON UPDATE SET NULL;
-- delete와 update 모두 post테이블에서 author_id = NULL로 바뀌는 것을 볼 수 있다.
DELETE FROM author WHERE id=2;
UPDATE author SET id = 2 WHERE id = 10;

-- post테이블에서 id, title, contents, 그리고 author_id의 경우 author_type이라는 이름으로 조회
--
SELECT id, title, contents, 
case author_id
    when 1 then 'First Author'
    when 2 then 'Second Author'
    when author_id is null then 'Anonymous'
    ELSE 'Others'
end
as author_type FROM post;

--A는 조건 B => 참일 경우의 반환값 C => 거짓일 경우의 반환값
IF(A, B, C)
--A의 값이 NULL이 아니면 A, NULL일 경우에 B
IFNULL(A, B)
--IF문법으로 id가 1이면 first author 그렇지 않은 경우는 others 출력
SELECT id, title, contents, 
IF(author_id = 1, "First Author", "Others")
as author_type FROM post;


--Group By
SELECT author_id ,COUNT(author_id)  from post group by author_id
SELECT author_id ,AVG(price), SUM(price)  from post group by author_id

-- 1.author_id 별로 price 평균값을 구하시오. 단, 건별로 2000원 이상인 데이터만 평균을 내서 출력하시오.
SELECT author_id ,AVG(price)  
from post
WHERE price >= 2000
group by author_id

-- 2.author_id  별로 price평균값을 구하되 그룹별 평균값이 2000원 이상인 데이터만 출력하시오.
SELECT author_id ,AVG(price)  
from post
group by author_id
HAVING AVG(price) >= 2000 

--(1 + 2)
SELECT author_id ,AVG(price)  
from post
WHERE price >= 2000
group by author_id
HAVING AVG(price) >= 2000

-- author 테이블에 name으로 인덱스 생성
CREATE INDEX idx_name ON author(name);
--author의 name, email으로 복합컬럼 인덱스 생성
CREATE INDEX mul_index ON author(name, email)

mysqldump -u root -p --default-character-set=utf8mb4 board > dumpfile.sql