CREATE SCHEMA IF NOT EXISTS WaveDetectives;
USE WaveDetectives;

-- ----------------------------------
-- Estrutura da tabela Esquadra
-- ----------------------------------
CREATE TABLE IF NOT EXISTS Esquadra (
  idEsquadra INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome_coordenador VARCHAR(75) NOT NULL,
  rua VARCHAR(75) NOT NULL,
  localidade VARCHAR(75) NOT NULL,
  cod_postal VARCHAR(9) NOT NULL,
  nome_esquadra VARCHAR(75) NOT NULL,
  PRIMARY KEY (idEsquadra)
)
ENGINE = InnoDB;


-- ----------------------------------
-- Estrutura da tabela Suspeito
-- ----------------------------------
CREATE TABLE IF NOT EXISTS Suspeito (
  idSuspeito INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NULL, 
  contacto VARCHAR(20) NOT NULL,
  localizacao VARCHAR(100) NULL,
  descricao TEXT NULL,
  PRIMARY KEY (idSuspeito)
)
ENGINE = InnoDB;


-- ----------------------------------
-- Estrutura da tabela Vitima
-- ----------------------------------
CREATE TABLE IF NOT EXISTS Vitima (
  nif INT NOT NULL,
  nome VARCHAR(45) NOT NULL,
  idade INT NOT NULL default 0,
  dat_nasc DATE NOT NULL,
  emprego VARCHAR(45) NOT NULL,
  conta_bancaria VARCHAR(100) NOT NULL,
  PRIMARY KEY (nif)
)
ENGINE = InnoDB;


-- ----------------------------------
-- Estrutura da tabela Torre
-- ----------------------------------
CREATE TABLE IF NOT EXISTS Torre (
  idTorre INT UNSIGNED NOT NULL AUTO_INCREMENT,
  alcance INT NOT NULL,
  coordenadas VARCHAR(100) NOT NULL,
  PRIMARY KEY (idTorre)
)
ENGINE = InnoDB;


-- ----------------------------------
-- Estrutura da tabela Agente_Policia
-- ----------------------------------
CREATE TABLE IF NOT EXISTS Agente_Policia (
  num_policial INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(75) NOT NULL,
  cargo ENUM('Diretor nacional', 'Diretor nacional adjunto', 'Chefe', 'Subchefe', 'Investigador', 'Coordenador de investigação', 'Assistente') NULL,
  categoria ENUM('Civil', 'Militar', 'Operações Especiais', 'Cibernética', 'Linha da Frente', 'Intervenção') NOT NULL,
  idEsquadra INT UNSIGNED NOT NULL,
  PRIMARY KEY (num_policial),
  CONSTRAINT fk_idEsquadraAgente FOREIGN KEY (idEsquadra) REFERENCES Esquadra (idEsquadra)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;


-- ----------------------------------
-- Estrutura da tabela ContactoAgente
-- ----------------------------------
CREATE TABLE IF NOT EXISTS ContactoAgente (
  telefone VARCHAR(20) NOT NULL,
  num_policial INT UNSIGNED NOT NULL,
  PRIMARY KEY (telefone),
  CONSTRAINT fk_num_policialContacto FOREIGN KEY (num_policial) REFERENCES Agente_Policia (num_policial)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- ----------------------------------
-- Estrutura da tabela ContactoEsquadra
-- ----------------------------------
CREATE TABLE IF NOT EXISTS ContactoEsquadra (
  telefone VARCHAR(20) NOT NULL,
  idEsquadra INT UNSIGNED NOT NULL,
  PRIMARY KEY (telefone),
  CONSTRAINT fk_idEsquadraContacto FOREIGN KEY (idEsquadra) REFERENCES Esquadra (idEsquadra)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- ----------------------------------
-- Estrutura da tabela ContactoVitima
-- ----------------------------------
CREATE TABLE IF NOT EXISTS ContactoVitima (
  telefone VARCHAR(20) NOT NULL,
  nif INT NOT NULL,
  PRIMARY KEY (telefone),
  CONSTRAINT fk_nifContacto FOREIGN KEY (nif) REFERENCES Vitima (nif)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- ----------------------------------
-- Estrutura da tabela Processo_Criminal
-- ----------------------------------
CREATE TABLE IF NOT EXISTS Processo_Criminal (
  idProcesso INT UNSIGNED NOT NULL AUTO_INCREMENT,
  descr_incidente VARCHAR(500) NOT NULL,
  dat_incidente DATE NOT NULL,
  estado TINYINT NOT NULL,
  dat_inicio DATE NOT NULL,
  dat_fim DATE NULL,
  num_policial INT UNSIGNED NOT NULL,
  idSuspeito INT UNSIGNED NOT NULL,
  nif INT NOT NULL,
  PRIMARY KEY (idProcesso),
  CONSTRAINT fk_nifProcesso FOREIGN KEY (nif) REFERENCES Vitima (nif)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_idSuspeitoProcesso FOREIGN KEY (idSuspeito) REFERENCES Suspeito (idSuspeito)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_num_policialProcesso FOREIGN KEY (num_policial) REFERENCES Agente_Policia (num_policial)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- ----------------------------------
-- Estrutura da tabela Chamada
-- ----------------------------------
CREATE TABLE IF NOT EXISTS Chamada (
  idChamada INT UNSIGNED NOT NULL AUTO_INCREMENT,
  num_destino VARCHAR(20) NOT NULL,
  num_origem VARCHAR(20) NULL,
  duracao VARCHAR(15) NOT NULL,
  data_hora TIMESTAMP NULL,
  idSuspeito INT UNSIGNED NOT NULL,
  nif INT NOT NULL,
  idTorre INT UNSIGNED NOT NULL,
  PRIMARY KEY (idChamada),
  CONSTRAINT fk_idSuspeitoChamada FOREIGN KEY (idSuspeito) REFERENCES Suspeito (idSuspeito)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_nifChamada FOREIGN KEY (nif) REFERENCES Vitima (nif)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_idTorreChamada FOREIGN KEY (idTorre) REFERENCES Torre (idTorre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;