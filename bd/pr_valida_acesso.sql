SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pr_valida_acesso]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[pr_valida_acesso]
GO

CREATE PROCEDURE dbo.pr_valida_acesso(@ds_cpf VARCHAR(255), @ds_senha VARCHAR(255))
WITH ENCRYPTION
 AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRANSACTION
		
		IF NOT EXISTS(SELECT 1 FROM tb_pessoa p INNER JOIN tb_usuario u ON u.cd_pessoa = p.cd_pessoa WHERE p.ds_cpf = @ds_cpf)
		BEGIN
			RAISERROR('Usuário não encontrado.', 16, 1)
			GOTO erro
		END

		IF NOT EXISTS(SELECT 1 FROM tb_pessoa p INNER JOIN tb_usuario u ON u.cd_pessoa = p.cd_pessoa WHERE p.ds_cpf = @ds_cpf AND u.ds_senha = @ds_senha)
		BEGIN
			RAISERROR('Usuário não encontrado.', 16, 1)
			GOTO erro
		END
		
		SELECT * FROM tb_pessoa p INNER JOIN tb_usuario u ON u.cd_pessoa = p.cd_pessoa WHERE p.ds_cpf = @ds_cpf AND u.ds_senha = @ds_senha AND p.fg_excluido = 0 AND u.fg_excluido = 0

	
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
