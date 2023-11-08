SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pr_inclui_paciente]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[pr_inclui_paciente]
GO

CREATE PROCEDURE dbo.pr_inclui_paciente(
	@ds_nome VARCHAR(255), 
	@ds_rg VARCHAR(255),
	@ds_cpf VARCHAR(255), 
	@ds_telefone VARCHAR(255),
	@dt_nascimento date,
	@ds_responsavel VARCHAR(255),
	@ds_email VARCHAR(255),
	@ds_senha VARCHAR(255),
	@ds_lembrete_senha VARCHAR(100),
	@ind_prioridade INT
	)
WITH ENCRYPTION
 AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRANSACTION
		
		IF EXISTS(SELECT 1 FROM tb_pessoa WHERE ds_cpf = @ds_cpf AND fg_excluido = 0)
		BEGIN
			RAISERROR('CPF já Cadastrado.', 16, 1)
			GOTO erro
		END

		IF(@ds_telefone = '')
		BEGIN
			SET @ds_telefone = null
		END

		IF(@ds_responsavel = '')
		BEGIN
			SET @ds_responsavel = null
		END

		IF(@ds_email = '')
		BEGIN
			SET @ds_email = null
		END

		SET @ds_cpf = REPLACE(REPLACE(REPLACE(@ds_cpf,'-',''),'.',''),'/','')
		SET @ds_rg = REPLACE(REPLACE(REPLACE(@ds_rg,'-',''),'.',''),'/','')

		INSERT INTO tb_pessoa (
			ds_nome, 
			ds_rg, 
			ds_cpf, 
			ds_telefone, 
			dt_nascimento, 
			dt_inclusao,
			ds_responsavel,
			ds_email) 
		VALUES (
			@ds_nome, 
			@ds_rg, 
			@ds_cpf, 
			@ds_telefone, 
			@dt_nascimento,
			getdate(),
			@ds_responsavel,
			@ds_email)
		
		DECLARE @cd_pessoa INT = (SELECT TOP 1 cd_pessoa FROM tb_pessoa ORDER BY cd_pessoa DESC)

		INSERT INTO tb_usuario (
			cd_perfil,
			cd_pessoa,
			ds_senha,
			ds_lembrete_senha)
		VALUES (
			2,
			@cd_pessoa,
			@ds_senha,
			@ds_lembrete_senha)

		DECLARE @cd_usuario INT = (SELECT TOP 1 cd_usuario FROM tb_usuario ORDER BY cd_usuario DESC)

		DECLARE @SeqSenha VARCHAR(10) = NULL
		SET @SeqSenha = (SELECT dbo.fn_retornar_sequencia_senha(@ind_prioridade))

		INSERT INTO tb_paciente (
			cd_usuario,
			dt_inclusao,
			ind_prioridade,
			nr_senha)
		VALUES (
			@cd_usuario,
			getdate(),
			@ind_prioridade,
			@SeqSenha)

		DECLARE @cd_enfermagem INT = NULL, @TotalTarefas INT = NULL

		SELECT TOP 1 @cd_enfermagem = e.cd_enfermagem, @TotalTarefas = COALESCE(COUNT(pe.cd_enfermagem), 0)
		FROM  tb_enfermagem e
		LEFT JOIN  tb_paciente_exames pe ON pe.cd_enfermagem = e.cd_enfermagem
		WHERE e.ind_prioridade = @ind_prioridade
		GROUP BY e.cd_enfermagem
		ORDER BY COALESCE(COUNT(pe.cd_enfermagem), 0), e.cd_enfermagem

		IF(@cd_enfermagem IS NULL)
		BEGIN
			SELECT TOP 1 @cd_enfermagem = e.cd_enfermagem, @TotalTarefas = COALESCE(COUNT(pe.cd_enfermagem), 0)
			FROM  tb_enfermagem e
			LEFT JOIN  tb_paciente_exames pe ON pe.cd_enfermagem = e.cd_enfermagem
			GROUP BY e.cd_enfermagem
			ORDER BY COALESCE(COUNT(pe.cd_enfermagem), 0), e.cd_enfermagem
		END

		INSERT INTO tb_paciente_exames (
			cd_paciente,
			cd_enfermagem,
			dt_exame,
			dt_inclusao,
			fg_enfermagem_finalizado,
			fg_medico_finalizado) 
		VALUES (
			(SELECT TOP 1 cd_paciente FROM tb_paciente WHERE cd_usuario = @cd_usuario),
			@cd_enfermagem,
			getdate(),
			getdate(),
			0,
			0)
	
	COMMIT TRANSACTION
	return

erro:
	ROLLBACK TRANSACTION
	return

	SET NOCOUNT OFF
END
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF
GO
