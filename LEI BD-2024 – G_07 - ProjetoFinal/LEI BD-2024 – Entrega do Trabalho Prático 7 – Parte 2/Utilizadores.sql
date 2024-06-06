USE WaveDetectives;

-- Criação de Utilizadores
-- Rui Analista de Dados
CREATE USER 'rui'@'localhost' IDENTIFIED WITH mysql_native_password BY 'RuiSenha123!';
GRANT SELECT ON WaveDetectives.* TO 'rui'@'localhost';

-- Ramirez "Admin" 
CREATE USER 'Ramirez'@'localhost' IDENTIFIED WITH mysql_native_password BY 'RamirezSenha123!';
GRANT ALL PRIVILEGES ON WaveDetectives.* TO 'Ramirez'@'localhost' WITH GRANT OPTION;

-- Policias
CREATE USER 'policia'@'localhost' IDENTIFIED WITH mysql_native_password BY 'PoliciaSenha123!';
GRANT SELECT, INSERT, UPDATE ON WaveDetectives.* TO 'policia'@'localhost';

FLUSH PRIVILEGES;