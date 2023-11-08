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
	@CodigoUsuario INT
	)
WITH ENCRYPTION
 AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRANSACTION
		
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
