-- Views 
-- Listar o número de origem da chamada, associada a uma determinada torre
CREATE VIEW ChamadasPorTorre AS
SELECT t.idTorre, t.coordenadas AS coordenadas_torre, COUNT(*) AS total_chamadas
FROM Chamada c
JOIN Torre t ON c.idTorre = t.idTorre
GROUP BY t.idTorre, t.coordenadas;


-- Listar todos os processos criminais associados a uma determinada vítima
CREATE VIEW ProcessosPorVitima AS
SELECT pc.idProcesso, pc.descr_incidente, pc.dat_incidente, pc.estado, pc.dat_inicio, pc.dat_fim,
       v.nome AS nome_vitima
FROM Processo_Criminal pc
INNER JOIN Vitima v ON pc.nif = v.nif;


-- Listar o número de vítimas por faixa etária.
CREATE VIEW VitimasPorIdade AS
SELECT CASE 
    WHEN idade < 18 THEN 'Menor de 18'
    WHEN idade BETWEEN 18 AND 30 THEN '18-30'
    WHEN idade BETWEEN 31 AND 50 THEN '31-50'
    ELSE 'Mais de 50'
    END AS faixa_etaria,
    COUNT(*) AS total_vitimas
FROM Vitima
GROUP BY faixa_etaria;


-- Indexs
CREATE INDEX Torre_coordenadas ON Torre(coordenadas);
CREATE INDEX PC_dataIncidente ON Processo_Criminal(dat_incidente);
CREATE INDEX PC_idSuspeito ON Processo_Criminal(idSuspeito);
CREATE INDEX PC_nif ON Processo_Criminal(nif);