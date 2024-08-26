-- init.sql example
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, email) VALUES ('admin', 'admin@example.com');

-- 修正箇所: ユーザーが存在しない場合にのみ作成する
-- CREATE USER IF NOT EXISTS 'takato'@'%' IDENTIFIED BY '0605';
-- GRANT ALL PRIVILEGES ON *.* TO 'takato'@'%' WITH GRANT OPTION;
-- FLUSH PRIVILEGES;
CREATE USER IF NOT EXISTS 'takato'@'57.181.203.111' IDENTIFIED BY '0605';
GRANT ALL PRIVILEGES ON *.* TO 'takato'@'57.181.203.111' WITH GRANT OPTION;
FLUSH PRIVILEGES;
