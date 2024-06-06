USE WaveDetectives; 

 
 -- Retorna um boolean. Indica se o suspeito tem ou não mais que um processo 
DELIMITER $$

CREATE FUNCTION fn_mais_de_um_processo (idSuspeito INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE num_processos INT;
    SELECT COUNT(*) INTO num_processos
    FROM Processo_Criminal
    WHERE idSuspeito = idSuspeito;
    RETURN IF(num_processos > 1, 1, 0);
END $$

DELIMITER ;

-- executar
-- SELECT fn_mais_de_um_processo(1); 
-- ------------------------------------------- 
-- PROCEDURES 
-- Lista os suspeitos de um dado agente passando o id do agente como argumento
DELIMITER $$

CREATE PROCEDURE sp_suspeitos_por_agente (IN idAgente INT)
BEGIN
  SELECT 
        S.idSuspeito, 
        S.nome, 
        S.contacto, 
        S.localizacao, 
        S.descricao 
    FROM Suspeito S 
    INNER JOIN Processo_Criminal P ON S.idSuspeito = P.idSuspeito 
    WHERE P.num_policial = idAgente;
END $$

DELIMITER ;

-- Lista os suspeitos por agente 
-- CALL sp_suspeitos_por_agente(1); -- Colocar o id do agente desejado
-- -------------------------------------


-- Lista as chamadas feitas por um dado suspeito dando o seu id 
 
DELIMITER $$

CREATE PROCEDURE sp_historico_chamadas_suspeito (
    IN p_idSuspeito INT
)
BEGIN
    SELECT 
        C.idChamada,
        C.num_origem,
        C.num_destino,
        C.data_hora,
        C.duracao,
        T.coordenadas AS torre_coordenadas,
        T.alcance AS torre_alcance
    FROM 
        Chamada C
    JOIN 
        Torre T ON C.idTorre = T.idTorre
    WHERE 
        C.idSuspeito = p_idSuspeito;
END $$

DELIMITER ;

-- executar 
-- CALL sp_historico_chamadas_suspeito(1); 




-- TRIGGERS
DELIMITER //
-- Atualizar a idade
CREATE TRIGGER update_idade_before_insert
BEFORE INSERT ON Vitima
FOR EACH ROW
BEGIN
  SET NEW.idade = TIMESTAMPDIFF(YEAR, NEW.dat_nasc, CURDATE());
END //

CREATE TRIGGER update_idade_before_update
BEFORE UPDATE ON Vitima
FOR EACH ROW
BEGIN
  SET NEW.idade = TIMESTAMPDIFF(YEAR, NEW.dat_nasc, CURDATE());
END //


-- Impedir Atualização de Status de Processo para Finalizado se Não Houver Data de Fim
CREATE TRIGGER impedir_finalizacao_sem_data_fim 
BEFORE UPDATE ON Processo_Criminal 
FOR EACH ROW 
BEGIN 
    IF NEW.estado = 1 AND NEW.dat_fim IS NULL THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é possível finalizar um processo sem definir a data de fim.'; 
    END IF; 
END; //

DELIMITER ;


