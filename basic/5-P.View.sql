--View 생성
CREATE VIEW author_for_view AS
select a.name, a.email
from author a
--View 조회
SELECT * FROM author_for_view

--Procedure
--프로시저 생성
DELIMITER $$
CREATE PROCEDURE test_procedure (parameters)
BEGIN
  (SQL 문법)
END $$
DELIMITER ;
--프로시저 호출시
CALL 프로시저명();

DELIMITER //
CREATE PROCEDURE getUser(IN userid INT)
BEGIN
    SELECT * FROM author where id = userid;
END //
DELIMITER ;

show create procedure getUser;

DELIMITER //
CREATE PROCEDURE insert_Post(IN ptitle VARCHAR(255), pcontents VARCHAR(255), pauthor_id INT)
BEGIN
    INSERT INTO post(title, contents, author_id) values (ptitle, pcontents, pauthor_id);
END //
DELIMITER ;

-- 변수 선언
DECLARE 변수명 변수타입[DEFAULT default_value]

DELIMITER //
CREATE PROCEDURE check_author(IN pauthor_id INT)
BEGIN
  DECLARE avg_price int default 0;
  SELECT avg(price) into avg_price from post WHERE author_id = pauthor_id;
  IF avg_price >= 1000 THEN
  	SELECT "고액 원고료 작가입니다." AS MESSAGE;
  ELSE
  	SELECT "고액 원고료 작가가 아닙니다." AS MESSAGE;
  END IF;
END //
DELIMITER ;