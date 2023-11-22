--View 생성
CREATE VIEW author_for_view AS
select a.name, a.email
from author a
--View 조회
SELECT * FROM author_for_view 