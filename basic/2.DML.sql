-- insert, select, update, delete

-- author 테이블에 튜플 하나 넣기
INSERT INTO author(id, name, email) values(1, 'kim', 'abc@naver.com');
INSERT INTO author(id, name, email, password, role) 
values(4, 'choi', 'abc3@naver.com', '1234', 'User');
-- author 테이블의 id값이 1인 데이터의 email 주소를 수정
UPDATE author SET email='abc123@test.com' WHERE id=1;
-- author_id가 5인 author 테이블의 데이터 값을 지운다
DELETE FROM author WHERE author_id=5;