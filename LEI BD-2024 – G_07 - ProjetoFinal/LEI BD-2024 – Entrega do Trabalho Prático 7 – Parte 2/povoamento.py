import mysql.connector
from mysql.connector import errorcode

# Função para inserir dados na tabela Esquadra
def inserir_esquadra(cursor, nome_coordenador, rua, localidade, cod_postal, nome_esquadra):
    query = ("INSERT INTO Esquadra (nome_coordenador, rua, localidade, cod_postal, nome_esquadra) "
             "VALUES (%s, %s, %s, %s, %s)")
    dados = (nome_coordenador, rua, localidade, cod_postal, nome_esquadra)
    cursor.execute(query, dados)

# Função para inserir dados na tabela Suspeito
def inserir_suspeito(cursor, nome, contacto, localizacao, descricao):
    query = ("INSERT INTO Suspeito (nome, contacto, localizacao, descricao) "
             "VALUES (%s, %s, %s, %s)")
    dados = (nome, contacto, localizacao, descricao)
    cursor.execute(query, dados)

# Função para inserir dados na tabela Torre
def inserir_torre(cursor, alcance, coordenadas):
    query = ("INSERT INTO Torre (alcance, coordenadas) "
             "VALUES (%s, %s)")
    dados = (alcance, coordenadas)
    cursor.execute(query, dados)

# Função para inserir dados na tabela Agente_Policia
def inserir_agente_policia(cursor, nome, cargo, categoria, idEsquadra):
    query = ("INSERT INTO Agente_Policia (nome, cargo, categoria, idEsquadra) "
             "VALUES (%s, %s, %s, %s)")
    dados = (nome, cargo, categoria, idEsquadra)
    cursor.execute(query, dados)

# Função para inserir dados na tabela Vitima
def inserir_vitima(cursor, nif, nome, idade, dat_nasc, emprego, conta_bancaria):
    query = ("INSERT INTO Vitima (nif, nome, idade, dat_nasc, emprego, conta_bancaria) "
             "VALUES (%s, %s, %s, %s, %s, %s)")
    dados = (nif, nome, idade, dat_nasc, emprego, conta_bancaria)
    cursor.execute(query, dados)

# Função para inserir dados na tabela Processo_Criminal
def inserir_processo_criminal(cursor, descr_incidente, dat_incidente, estado, dat_inicio, dat_fim, num_policial, idSuspeito, nif):
    # Verifica se num_policial existe
    cursor.execute("SELECT COUNT(*) FROM Agente_Policia WHERE num_policial = %s", (num_policial,))
    if cursor.fetchone()[0] == 0:
        print(f"Erro: num_policial {num_policial} não existe.")
        return

    # Verifica se idSuspeito existe
    cursor.execute("SELECT COUNT(*) FROM Suspeito WHERE idSuspeito = %s", (idSuspeito,))
    if cursor.fetchone()[0] == 0:
        print(f"Erro: idSuspeito {idSuspeito} não existe.")
        return

    # Verifica se nif existe
    cursor.execute("SELECT COUNT(*) FROM Vitima WHERE nif = %s", (nif,))
    if cursor.fetchone()[0] == 0:
        print(f"Erro: nif {nif} não existe.")
        return

    query = ("INSERT INTO Processo_Criminal (descr_incidente, dat_incidente, estado, dat_inicio, dat_fim, num_policial, idSuspeito, nif) "
             "VALUES (%s, %s, %s, %s, %s, %s, %s, %s)")
    dados = (descr_incidente, dat_incidente, estado, dat_inicio, dat_fim, num_policial, idSuspeito, nif)
    cursor.execute(query, dados)

# Inserção interativa de dados
def inserir_interativo(cursor):
    print("Escolha a tabela para inserir dados:")
    print("1. Esquadra")
    print("2. Suspeito")
    print("3. Torre")
    print("4. Agente Policia")
    print("5. Processo Criminal")
    print("6. Vitima")
    escolha = input("Escolha (1/2/3/4/5/6): ")
    
    if escolha == '1':
        nome_coordenador = input("Nome do Coordenador: ")
        rua = input("Rua: ")
        localidade = input("Localidade: ")
        cod_postal = input("Código Postal: ")
        nome_esquadra = input("Nome da Esquadra: ")
        inserir_esquadra(cursor, nome_coordenador, rua, localidade, cod_postal, nome_esquadra)
    
    elif escolha == '2':
        nome = input("Nome: ")
        contacto = input("Contacto: ")
        localizacao = input("Localização: ")
        descricao = input("Descrição: ")
        inserir_suspeito(cursor, nome, contacto, localizacao, descricao)
    
    elif escolha == '3':
        alcance = input("Alcance: ")
        coordenadas = input("Coordenadas: ")
        inserir_torre(cursor, alcance, coordenadas)
    
    elif escolha == '4':
        nome = input("Nome: ")
        cargo = input("Cargo: ")
        categoria = input("Categoria: ")
        idEsquadra = input("ID da Esquadra: ")
        inserir_agente_policia(cursor, nome, cargo, categoria, idEsquadra)

    elif escolha == '5':
        descr_incidente = input("Descrição do Incidente: ")
        dat_incidente = input("Data do Incidente (YYYY-MM-DD): ")
        estado = input("Estado (0 ou 1): ")
        dat_inicio = input("Data de Início (YYYY-MM-DD): ")
        dat_fim = input("Data de Fim (YYYY-MM-DD) ou deixe vazio: ")
        if dat_fim == '':
            dat_fim = None
        num_policial = input("Número Policial: ")
        idSuspeito = input("ID do Suspeito: ")
        nif = input("NIF da Vítima: ")
        inserir_processo_criminal(cursor, descr_incidente, dat_incidente, estado, dat_inicio, dat_fim, num_policial, idSuspeito, nif)
    
    elif escolha == '6':
        nif = input("NIF: ")
        nome = input("Nome: ")
        idade = input("Idade: ")
        dat_nasc = input("Data de Nascimento (YYYY-MM-DD): ")
        emprego = input("Emprego: ")
        conta_bancaria = input("Conta Bancária: ")
        inserir_vitima(cursor, nif, nome, idade, dat_nasc, emprego, conta_bancaria)

# Função para testar a conexão ao banco de dados
def testar_conexao(config):
    try:
        conn = mysql.connector.connect(**config)
        if conn.is_connected():
            print("Conexão ao banco de dados bem-sucedida!")
            conn.close()
            return True
        else:
            print("Não foi possível conectar ao banco de dados.")
            return False
    except mysql.connector.Error as err:
        print(f"Erro ao tentar conectar ao banco de dados: {err}")
        return False

# Menu principal
def menu():
    user = input("Digite o usuário do banco de dados: ")
    password = input("Digite a senha do banco de dados: ")
    
    config = {
        'user': user,
        'password': password,
        'host': 'localhost',
        'database': 'WaveDetectives'
    }
    
    if not testar_conexao(config):
        return
    
    while True:
        print("\nMenu de Inserção de Dados")
        print("1. Inserir dados interativamente")
        print("2. Sair")
        
        escolha = input("Escolha (1/2): ")
        
        if escolha == '1':
            try:
                conn = mysql.connector.connect(**config)
                cursor = conn.cursor()
                inserir_interativo(cursor)
                conn.commit()
                print("Dados inseridos com sucesso!")
            except mysql.connector.Error as err:
                print(f"Erro: {err}")
            finally:
                cursor.close()
                conn.close()
        
        elif escolha == '2':
            break
        else:
            print("Escolha inválida. Tente novamente.")

# Executar o menu
if __name__ == "__main__":
    menu()
