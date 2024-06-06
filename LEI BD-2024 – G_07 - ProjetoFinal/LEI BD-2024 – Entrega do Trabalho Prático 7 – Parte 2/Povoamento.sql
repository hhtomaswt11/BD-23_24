use WaveDetectives;

-- Inserir dados na tabela Esquadra
INSERT INTO Esquadra (nome_coordenador, rua, localidade, cod_postal, nome_esquadra)
VALUES
    ('Jorge Mendes', 'Rua de Carcavelos', 'Vila Real', '1234-678', 'Policia de Alijó'),
    ('Maria Brito', 'Rua do Cacheiro', 'Paços de Ferreira', '9876-432', 'Policia de Paços de Ferreira'),
    ('Carlos Silva', 'Avenida Central', 'Braga', '1234-123', 'Policia de Braga');


-- Inserir dados na tabela ContactoEsquadra
INSERT INTO ContactoEsquadra (telefone, idEsquadra)
VALUES
    ('210000111', 1),
    ('255805157', 2),
    ('210000333', 3);
    
-- Inserir dados na tabela Suspeito
INSERT INTO Suspeito (nome, contacto, localizacao, descricao)
VALUES
    ('Joaquim Almeida', '921345654', 'Centro Braga', 'Voz grossa'),
    (NULL, '915125512', NULL, 'Cabelo castanho, barba negra, usa óculos'),
    ('Miguel Rocha', '923456789', 'Porto Centro', 'Tatuagem no braço direito'),
    ('Sofia Costa', '912345678', 'Vila Real Shopping', 'Cabelo loiro, cicatriz na mão esquerda'),
    ('Andreia Lima', '934567890', 'Lisboa Baixa', 'Alto, usa chapéu'),
    (NULL, '925126642', 'Coimbra', 'Voz suave feminina');


-- Inserir dados na tabela Vitima
INSERT INTO Vitima (nif, nome, dat_nasc, emprego, conta_bancaria)
VALUES
    (123456789, 'Ana Silva', '1993-05-14', 'Engenheira', 'PT50000201231234567890154'),
    (234567890, 'Bruno Costa', '1978-08-20', 'Professor', 'PT50000201231234567890155'),
    (345678901, 'Carla Ferreira', '1995-02-10', 'Médica', 'PT50000201231234567890156'),
    (456789012, 'David Martins', '1973-11-25', 'Advogado', 'PT50000201231234567890157'),
    (567890123, 'Eva Souza', '2001-01-30', 'Estudante', 'PT50000201231234567890158'),
    (678901234, 'Fernando Rocha', '1989-07-18', 'Engenheira', 'PT50000201231234567890159');

-- Inserir dados na tabela ContactoVitima
INSERT INTO ContactoVitima (telefone, nif)
VALUES
    ('925556677', 123456789),
    ('925556688', 234567890),
    ('925556699', 345678901),
    ('925556700', 456789012),
    ('925556711', 567890123),
    ('925556722', 678901234);

-- Inserir dados na tabela Torre
INSERT INTO Torre (alcance, coordenadas)
VALUES
    (100, '41.40338, 2.17403'),
    (80, '36.50368, 1.13676'),
    (150, '40.71278, -74.0060'),
    (120, '34.05223, -118.2437'),
    (200, '51.5074, -0.1278'),
    (90, '48.8566, 2.3522');

-- Inserir dados na tabela Agente_Policia
INSERT INTO Agente_Policia (nome, cargo, categoria, idEsquadra)
VALUES
    ('Claudio', 'Assistente', 'Civil', 1),
    ('Carlos Silva', 'Diretor nacional', 'Civil', 1),
    ('Jorge Mendes', 'Diretor nacional', 'Cibernética', 2),
    ('Sergio Calado', 'Chefe', 'Cibernética', 2),
    ('Maria Brito', 'Diretor nacional', 'Militar', 3),
    ('Catarina Mendes', 'Coordenador de investigação', 'Cibernética', 3),
    ('Gonçalo Maia', 'Investigador', 'Cibernética', 3),
    ('Fernando Mendes', 'Subchefe', 'Operações Especiais', 3);

-- Inserir dados na tabela ContactoAgente
INSERT INTO ContactoAgente (telefone, num_policial)
VALUES
    ('912345678', 1),
    ('967357930', 2),
    ('960002321', 3),
    ('916838883', 4),
    ('933231110', 5),
    ('910009011', 6),
    ('924565512', 7),
    ('935001251', 8);

-- Inserir mais dados na tabela Processo_Criminal
INSERT INTO Processo_Criminal (descr_incidente, dat_incidente, estado, dat_inicio, dat_fim, num_policial, idSuspeito, nif)
VALUES
    ('Esquema de telefonema fraudulento levando a acesso não autorizado a conta bancária', '2023-09-05', 1, '2023-09-06', '2024-05-26', 3, 1, 345678901),
    ('Roubo de informações bancárias e desvio de fundos por telefonema', '2024-04-10', 1, '2024-04-11', '2024-05-26', 4, 1, 456789012),
    ('Roubo de informações bancárias via telefonema, resultando em transferência fraudulenta de dinheiro', '2023-07-10', 1, '2023-07-20', '2024-05-26', 1, 1, 123456789),
    ('Roubo de identidade e informações bancárias através de telefonema fraudulento', '2024-02-15', 0, '2024-02-16', NULL, 2, 2, 234567890),
    ('Engenharia social via chamada telefônica, resultando em transferência não autorizada de fundos', '2023-11-20', 1, '2023-11-21', '2024-01-20', 5, 3, 567890123),
    ('Fraude por telefonema, vitima enganada a transferir dinheiro para conta desconhecida', '2023-12-31', 1, '2023-12-31', '2024-01-20', 6, 3, 678901234),
    ('Fraude financeira através de chamada telefônica, vitima enganada a fornecer dados bancários', '2023-08-15', 1, '2023-08-16', '2023-09-02' , 2, 4, 234567890),
    ('Roubo de identidade e fraude bancária por telefonema, vitima perdeu uma grande soma de dinheiro', '2023-10-10', 1, '2023-10-20', '2023-12-20', 4, 5, 456789012),
    ('Fraude bancária por telefonema, vitima enganada a fornecer credenciais de acesso', '2024-03-05', 0, '2024-03-06', NULL, 3, 6, 345678901),
    ('Fraude financeira por telefonema, vitima foi convencida a divulgar informações bancárias', '2023-12-01', 0, '2023-12-02', NULL, 6, 6, 678901234),
    ('Esquema de phishing via telefonema, acesso a dados bancários e roubo de dinheiro', '2024-01-10', 0, '2024-01-11', NULL, 1, 6, 123456789);


-- Inserir dados na tabela Chamada
INSERT INTO Chamada (num_origem, num_destino, data_hora, duracao, idSuspeito, nif, idTorre)
VALUES
	('921348654', '925556699', '2023-09-05 13:10:44', '00:15:25', 1, 345678901, 1),
	('921348654', '925556700', '2024-04-10 09:06:42', '00:15:25', 1, 456789012, 5),
	('921348654', '925556677', '2023-07-10 08:47:41', '00:15:25', 1, 123456789, 4),
	('915125512', '925556688', '2024-02-16 12:30:51', '00:15:25', 2, 234567890, 2),
	('923456789', '925556711', '2023-11-20 11:23:16', '00:15:25', 3, 567890123, 3),
	('923456789', '925556722', '2023-12-31 16:25:15', '00:15:25', 3, 678901234, 1),
	('912345678', '925556688', '2023-08-15 12:53:31', '00:15:25', 4, 234567890, 2),
	('934567890', '925556700', '2024-10-10 14:10:45', '00:15:25', 5, 456789012, 6),
	('925126642', '925556699', '2024-03-05 19:00:21', '00:15:25', 6, 345678901, 2),
	('925126642', '925556722', '2023-12-01 22:22:12', '00:15:25', 6, 678901234, 3),
	('925126642', '925556677', '2024-01-10 10:54:22', '00:15:25', 6, 123456789, 1);
    