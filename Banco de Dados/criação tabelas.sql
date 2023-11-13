CREATE TABLE tb_perfil (
    cd_perfil INT IDENTITY(1,1) PRIMARY KEY,
    ds_perfil VARCHAR(50),
	fg_excluido BIT DEFAULT 0
)

CREATE TABLE tb_cargo (
    cd_cargo INT IDENTITY(1,1) PRIMARY KEY,
    ds_cargo VARCHAR(50),
	fg_excluido BIT DEFAULT 0
)

CREATE TABLE tb_pessoa (
    cd_pessoa INT IDENTITY(1,1) PRIMARY KEY,
    ds_nome VARCHAR(100),
	dt_nascimento DATE,
	ds_email VARCHAR(50),
	ds_rg VARCHAR(20),
	ds_orgao_emissor VARCHAR(50),
	ds_cpf VARCHAR(11),
	ds_telefone VARCHAR(20),
	fg_excluido BIT DEFAULT 0,
	dt_inclusao DATETIME,
	dt_alteracao DATETIME,
	ds_uf VARCHAR(10),
	ds_codigo_funcionario VARCHAR(100),
	fg_sexo INT,
	ds_nome_pai VARCHAR(100),
	ds_nome_mae VARCHAR(100),
	ds_profissao VARCHAR(100),
	ds_responsavel VARCHAR(100),
	ind_estado_civil INT,
	fg_funcionario BIT DEFAULT 0,
	cd_cargo INT
)

CREATE TABLE tb_usuario (
    cd_usuario INT IDENTITY(1,1) PRIMARY KEY,
	cd_perfil INT,
	cd_pessoa INT,
	ds_senha VARCHAR(150),
	ds_lembrete_senha VARCHAR(100),
	ind_tentativas INT,
	fg_bloqueio BIT DEFAULT 0,
	fg_excluido BIT DEFAULT 0,
	CONSTRAINT FK_Usuario_Perfil FOREIGN KEY (cd_perfil) REFERENCES tb_perfil(cd_perfil),
	CONSTRAINT FK_Usuario_Pessoa FOREIGN KEY (cd_pessoa) REFERENCES tb_pessoa(cd_pessoa)
)

CREATE TABLE tb_paciente (
    cd_paciente INT IDENTITY(1,1) PRIMARY KEY,
	cd_usuario INT,
	dt_inclusao DATETIME,
	dt_alteracao DATETIME,
	fg_excluido BIT DEFAULT 0,
	ind_etapa_triagem INT DEFAULT 0,
	ind_prioridade INT DEFAULT 0,
	CONSTRAINT FK_Paciente_Usuario FOREIGN KEY (cd_usuario) REFERENCES tb_usuario(cd_usuario)
)

CREATE TABLE tb_paciente_exames (
    cd_exame INT IDENTITY(1,1) PRIMARY KEY,
    cd_paciente INT,
	cd_enfermagem INT,
	cd_medico INT,
	dt_exame DATE,
	dt_inclusao DATETIME,
	dt_alteracao DATETIME,
	fg_excluido BIT DEFAULT 0,
	ds_sintomas VARCHAR(MAX),
	ds_pressao VARCHAR(100),
	ds_batimento VARCHAR(100),
	ds_oxigenacao VARCHAR(100),
	ds_queixa_paciente VARCHAR(MAX),
	ds_observacoes_enfermagem VARCHAR(MAX),
	ds_diagnostico_medico VARCHAR(MAX),
	ds_prescricao_medica  VARCHAR(MAX),
	ds_observacao_medica VARCHAR(MAX),
	fg_enfermagem_finalizado BIT DEFAULT 0,
	fg_medico_finalizado BIT DEFAULT 0
)

CREATE TABLE tb_medico (
    cd_medico INT IDENTITY(1,1) PRIMARY KEY,
    cd_usuario INT,
	dt_inclusao DATETIME,
	dt_alteracao DATETIME,
	fg_excluido BIT DEFAULT 0,
	ds_crm VARCHAR(100),
	cd_cargo INT,
	ind_prioridade INT,
	CONSTRAINT FK_Medico_Usuario FOREIGN KEY (cd_usuario) REFERENCES tb_usuario(cd_usuario)
)

CREATE TABLE tb_enfermagem (
    cd_enfermagem INT IDENTITY(1,1) PRIMARY KEY,
    cd_usuario INT,
	dt_inclusao DATETIME,
	dt_alteracao DATETIME,
	fg_excluido BIT DEFAULT 0,
	ds_coren VARCHAR(100),
	cd_cargo INT,
	ind_prioridade INT,
	CONSTRAINT FK_Enfermagem_Usuario FOREIGN KEY (cd_usuario) REFERENCES tb_usuario(cd_usuario)
)

CREATE TABLE tb_agenda_exames (
    cd_agenda INT IDENTITY(1,1) PRIMARY KEY,
    cd_usuario INT,
	dt_exame DATE,
	dt_inclusao DATETIME,
	dt_alteracao DATETIME,
	fg_excluido BIT DEFAULT 0,
	ds_tipo_exame VARCHAR(100),
	ds_exame_agendado VARCHAR(100)
)