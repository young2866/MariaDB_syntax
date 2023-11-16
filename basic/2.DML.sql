-- insert, select, update, delete

-- author 테이블에 튜플 하나 넣기
INSERT INTO author(id, name, email) values(1, 'kim', 'abc@naver.com');
INSERT INTO author(id, name, email, password, role) 
values(4, 'choi', 'abc3@naver.com', '1234', 'User');