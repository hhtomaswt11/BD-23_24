USE WaveDetectives; 

-- Listar em quais casos um determinado agente está envolvido. 
SELECT Agente_Policia.num_policial, Agente_Policia.nome AS nome_policia, Processo_Criminal.idProcesso, Processo_Criminal.descr_incidente, Processo_Criminal.dat_incidente, Processo_Criminal.estado FROM Processo_Criminal  
	INNER JOIN Agente_Policia ON Processo_Criminal.num_policial=Agente_Policia.num_policial 
	WHERE Agente_Policia.num_policial = 1; 


-- Listar todas as chamadas associadas a uma determinada torre. 
SELECT T.idTorre , C.idChamada, C.num_destino, C.num_origem, C.data_hora AS data_hora_chamada FROM Chamada C  
	INNER JOIN Torre T ON C.idTorre = T.idTorre  
	WHERE T.idTorre = 1;  


-- Listar todos os processos criminais associados a uma determinada vítima. 
SELECT Processo_Criminal.idProcesso, Vitima.nif, Vitima.nome, Processo_Criminal.descr_incidente , Processo_Criminal.dat_incidente, Processo_Criminal.estado FROM Processo_Criminal 
	INNER JOIN Vitima ON Processo_Criminal.nif=Vitima.nif 
	WHERE Vitima.nif= 123456789;  

 
-- Listar os nomes dos policias que pertencem a uma determinada esquadra. 
SELECT Esquadra.idEsquadra, Agente_Policia.num_policial, Agente_Policia.nome FROM Agente_Policia 
	INNER JOIN Esquadra  
	WHERE Esquadra.idEsquadra=1 
	ORDER BY Agente_Policia.nome ASC; 
 


-- Lista todos os processos criminais que ainda estão a decorrer detalhando o caso, o agente responsável, a vítima e suspeito do caso 
SELECT Processo_Criminal.idProcesso, Processo_Criminal.descr_incidente, Agente_Policia.num_policial , Agente_Policia.nome AS nome_policia_responsavel, Vitima.nif, Vitima.nome AS nome_vitima , Suspeito.idSuspeito, Suspeito.nome AS nome_suspeito, Processo_Criminal.estado AS estado_processo FROM Processo_Criminal 
	INNER JOIN Agente_Policia ON Processo_Criminal.num_policial=Agente_Policia.num_policial 
	INNER JOIN Suspeito ON Processo_Criminal.idSuspeito=Suspeito.idSuspeito 
	INNER JOIN Vitima ON Processo_Criminal.nif=Vitima.nif 
	WHERE Processo_Criminal.estado=0;  


-- Lista os polícias responsáveis pela resolução de casos e as esquadras que estes representam ou seja, as esquadras que são responsáveis por casos que já foram concluídos 
-- Lista ainda o numero de incidentes por cada agente 
SELECT DISTINCT Agente_Policia.num_policial, Agente_Policia.nome AS nome_policia, 
		Esquadra.idEsquadra, Esquadra.nome_esquadra, 
		 COUNT(Processo_Criminal.idProcesso) AS numero_incidentes, 
		Processo_Criminal.estado AS estado_processo  
	FROM Agente_Policia 
	INNER JOIN Esquadra ON Agente_Policia.idEsquadra=Esquadra.idEsquadra 
	INNER JOIN Processo_Criminal ON Agente_Policia.num_policial=Processo_Criminal.num_policial 
	WHERE Processo_Criminal.estado=1 
	GROUP BY 
		Agente_Policia.num_policial, 
		Agente_Policia.nome, 
		Esquadra.idEsquadra, 
		Esquadra.nome_esquadra 
	ORDER BY Agente_Policia.nome ASC;  

 
-- Lista o número de processos criminais geridos por cada agente no ano de 2023 (DONE) 
SELECT Agente_Policia.nome , COUNT(Processo_Criminal.idProcesso) AS numero_incidentes  
	FROM Agente_Policia  
	INNER JOIN Processo_Criminal ON Agente_Policia.num_policial =Processo_Criminal.num_policial  WHERE Processo_Criminal.dat_inicio BETWEEN '2023-01-01' AND '2023-12-31'   
	GROUP BY Agente_Policia.nome  
	ORDER BY numero_incidentes DESC; 

 
-- Lista a informação das chamadas associadas a torres com alcance superior a 100km e a informação do sujeito envolvido incluindo a sua descrição e localização atual  (DONE)  
SELECT Chamada.idChamada, Chamada.num_origem, Chamada.num_destino, Suspeito.idSuspeito, Suspeito.nome, Suspeito.descricao , Suspeito.localizacao AS localizacao_suspeito , Torre.alcance FROM Chamada   
	INNER JOIN Torre ON Chamada.idTorre=Torre.idTorre 
	INNER JOIN Suspeito ON Chamada.idSuspeito=Suspeito.idSuspeito 
	WHERE Torre.alcance > 100;  


-- Listar os processos criminais envolvendo vítimas com um dado emprego  
SELECT Vitima.nif , Vitima.nome, Vitima.emprego , Processo_Criminal.idProcesso, Processo_Criminal.descr_incidente, Processo_Criminal.dat_incidente FROM Processo_Criminal  
	INNER JOIN Vitima ON Processo_Criminal.nif = Vitima.nif WHERE Vitima.emprego = 'Engenheira'  
	ORDER BY Processo_Criminal.dat_incidente DESC; 

-- Listar o histórico de chamadas feitas por uma vítima específica dando o seu nif 
SELECT Vitima.nif , Vitima.nome, Vitima.idade, Vitima.emprego, ContactoVitima.telefone, Chamada.num_origem, Chamada.num_destino, Chamada.data_hora AS data_hora_chamada FROM ContactoVitima 
	INNER JOIN Vitima ON ContactoVitima.nif = Vitima.nif 
	INNER JOIN Chamada ON Vitima.nif = Chamada.nif  
	WHERE  Vitima.nif = '123456789'  
	ORDER BY Chamada.data_hora DESC; 


-- Informações de Contatos de Agentes
SELECT 
		Agente_Policia.nome AS nome_agente,
		Agente_Policia.cargo,
		Agente_Policia.categoria,
		ContactoAgente.telefone AS telefone_agente,
		Esquadra.nome_esquadra
	FROM Agente_Policia
INNER JOIN ContactoAgente ON Agente_Policia.num_policial = ContactoAgente.num_policial
INNER JOIN Esquadra ON Agente_Policia.idEsquadra = Esquadra.idEsquadra;

-- Informações de Contatos de Esquadras
SELECT 
    Esquadra.nome_esquadra,
    Esquadra.nome_coordenador,
    Esquadra.rua,
    Esquadra.localidade,
    Esquadra.cod_postal,
    ContactoEsquadra.telefone AS telefone_esquadra
FROM Esquadra
INNER JOIN ContactoEsquadra ON Esquadra.idEsquadra = ContactoEsquadra.idEsquadra;