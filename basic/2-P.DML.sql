INSERT INTO author(id, name, email, password, role) 
values(2, 'lee', 'abc1@naver.com', '1234', 'User');
INSERT INTO author(id, name, email, password, role) 
values(3, 'park', 'abc2@naver.com', '1234', 'User');
INSERT INTO author(id, name, email, password, role) 
values(4, 'choi', 'abc3@naver.com', '1234', 'User');
INSERT INTO author(id, name, email, password, role) 
values(5, 'jung', 'abc4@naver.com', '1234', 'User');
INSERT INTO author(id, name, email, password, role) 
values(5, 'hwang', 'abc5@naver.com', '1234', 'User');

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