SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pr_altera_paciente]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[pr_altera_paciente]
GO

CREATE PROCEDURE dbo.pr_altera_paciente(
	@ds_nome VARCHAR(255), 
	@ds_rg VARCHAR(255),
	@ds_cpf VARCHAR(255), 
	@ds_telefone VARCHAR(255),
	@dt_nascimento date,
	@ds_responsavel VARCHAR(255),
	@ds_email VARCHAR(255),
	@CodigoUsuario INT,
	@ind_prioridade INT,
	@tipo INT
	)
WITH ENCRYPTION
 AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRANSACTION
		
		IF(@tipo = 0)
		BEGIN
			IF EXISTS(SELECT 1 FROM tb_pessoa p INNER JOIN tb_usuario u ON p.cd_pessoa = u.cd_pessoa WHERE p.ds_cpf = @ds_cpf AND p.fg_excluido = 0 AND u.cd_usuario != @CodigoUsuario)
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
				
			UPDATE p
			SET 
				p.ds_nome			= @ds_nome,
				p.ds_rg				= @ds_rg,
				p.ds_cpf			= @ds_cpf,
				p.ds_telefone		= @ds_telefone,
				p.dt_nascimento		= @dt_nascimento,
				p.dt_alteracao		= getdate(),
				p.ds_responsavel	= @ds_responsavel,
				p.ds_email			= @ds_email
			FROM tb_pessoa p
			INNER JOIN tb_usuario u ON u.cd_pessoa = p.cd_pessoa
			WHERE u.cd_usuario = @CodigoUsuario
		END
		ELSE IF(@tipo = 1)
		BEGIN
			DECLARE @SeqSenha VARCHAR(10) = NULL
			SET @SeqSenha = (SELECT dbo.fn_retornar_sequencia_senha(@ind_prioridade))

			UPDATE tb_paciente SET nr_senha = @SeqSenha WHERE cd_usuario = @CodigoUsuario

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
				(SELECT TOP 1 cd_paciente FROM tb_paciente WHERE cd_usuario = @CodigoUsuario),
				@cd_enfermagem,
				getdate(),
				getdate(),
				0,
				0)
		END
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
