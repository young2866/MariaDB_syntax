-- 데이터베이스 생성
CREATE DATABASE board;
-- 데이터베이스 선택
USE board;
-- author 테이블 신규 생성
CREATE TABLE author(id INT, name VARCHAR(255),
 email VARCHAR(255), password VARCHAR(255), 
 test1 VARCHAR(255), PRIMARY KEY (id));
-- 테이블 목록 조회
SHOW TABLES;
-- 테이블 컬럼 조회
DESCRIBE author;
-- post 테이블 신규 생성
CREATE TABLE posts(id INT PRIMARY KEY, title VARCHAR(255),
 content VARCHAR(255), author_id INT, FOREIGN KEY (author_id) REFERENCES author(id));
-- author 테이블 컬럼 상세 조회
 SHOW FULL COLUMNS FROM author;
-- author 테이블 생성문 조회
SHOW CREATE TABLE author;
-- 테이블 제약조건 조회
SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'posts';
-- 테이블 인덱스 조회
SHOW INDEX FROM posts;
-- posts 테이블 이름을 post로 변경
ALTER TABLE posts RENAME post;
-- author 테이블에 role이라는 컬럼 생성
ALTER TABLE author ADD COLUMN role VARCHAR(50);
-- author 테이블의 이름 타입 변경
ALTER TABLE author MODIFY COLUMN name VARCHAR(100) NOT NULL;
-- post 테이블의 content칼럼을 contents로 변경
ALTER TABLE post CHANGE COLUMN content contents VARCHAR(255);
-- author 테이블의 test1컬럼 삭제
ALTER TABLE author DROP COLUMN test1;
-- post 테이블의 contents컬럼 글자수 3000으로 변경
ALTER TABLE post MODIFY contents VARCHAR(3000);
-- author 테이블에 address 컬럼 varchar 255로 추가
ALTER TABLE author ADD COLUMN address VARCHAR(255);
-- post 테이블 생성문 미리 확인 -> post 테이블 삭제
SHOW CREATE TABLE post;
DROP TABLE post;
CREATE TABLE `post` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci