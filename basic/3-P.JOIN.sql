-- author테이블의 id와 post테이블의 author_id가 일치하는 데이터만 조인
SELECT * from author a inner join post p on a.id = p.author_id;

SELECT a.name, b.title from author a inner join post p on a.id = p.author_id;

--author 테이블과 post 테이블을 JOIN하여, 글을 작성한 모든 저자의 이름(name)과 해당글의 제목(title)을 조회
SELECT a.name as Name, p.title as Title FROM author AS a INNER JOIN post AS p ON a.id = p.author_id
WHERE p.id IS NOT NULL ; 
--author 테이블을 기준으로 post 테이블과 JOIN하여 모든 저자의 이름과 해당 저자가 작성한 글의 제목을 조회
-- 글을 작성하지 않은 저자의 경우, 글 제목은 NULL로 표시
SELECT a.name as Name, p.title as Title FROM author a LEFT JOIN post p ON a.id = p.author_id; 
--위 예제와 동일하게 모든 저자의 이름과 해당 저자가 작성한 글의 제목을 조회, 단 저자의 나이가 25세 이상인 저자만 조회
SELECT a.name as Name, p.title as Title FROM author a LEFT JOIN post p ON a.id = p.author_id
WHERE a.age >= 25; 