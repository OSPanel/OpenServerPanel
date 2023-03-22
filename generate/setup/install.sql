DELETE FROM mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
RENAME USER 'root'@'localhost' TO 'root'@'%';
FLUSH PRIVILEGES;
DROP USER 'root'@'127.0.0.1';
DROP USER 'root'@'::1';
DROP USER 'root'@'localhost';
DROP USER 'root'@'user-pc';