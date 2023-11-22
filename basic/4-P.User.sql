CREATE USER testUser identified by 'admin';
GRANT INSERT ON board.author  TO 'testUser'@'%';
REVOKE INSERT ON board.author FROM 'testUser'@'%';
GRANT SELECT ON board.author TO 'testUser'@'%';