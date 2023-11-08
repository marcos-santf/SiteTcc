if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_retornar_sequencia_senha]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_retornar_sequencia_senha]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE FUNCTION dbo.fn_retornar_sequencia_senha
(
	@tipo_senha INT
) 
RETURNS varchar(100)

WITH ENCRYPTION AS
BEGIN
	DECLARE @RETURN VARCHAR(max)
	SET @RETURN = ''
	
	DECLARE @SeqSenha VARCHAR(10) = NULL
	DECLARE @SeqSenhaNumerica INT
	DECLARE @SeqSenhaNumericaStr VARCHAR(10)

	IF(@tipo_senha = 0)
	BEGIN		
		SET @SeqSenha = (SELECT TOP 1 nr_senha FROM tb_paciente WHERE ind_prioridade = 0 ORDER BY nr_senha DESC)

		IF(@SeqSenha IS NULL)
			SET @SeqSenha = 'AD000'

		SET @SeqSenhaNumerica = CAST(SUBSTRING(@SeqSenha, 3, LEN(@SeqSenha) - 2) AS INT)

		IF(@SeqSenhaNumerica = 999)
			SET @SeqSenhaNumerica = 1
		ELSE
			SET @SeqSenhaNumerica = @SeqSenhaNumerica + 1 

		SET @SeqSenhaNumericaStr = CAST(@SeqSenhaNumerica AS VARCHAR)

		IF @SeqSenhaNumerica < 10
			SET @SeqSenhaNumericaStr = '00' + @SeqSenhaNumericaStr
		ELSE IF @SeqSenhaNumerica < 100
			SET @SeqSenhaNumericaStr = '0' + @SeqSenhaNumericaStr

		SET @SeqSenha = 'AD' + @SeqSenhaNumericaStr
	
		SET @RETURN = @SeqSenha
	END
	ELSE IF(@tipo_senha = 1)
	BEGIN
		SET @SeqSenha = (SELECT TOP 1 nr_senha FROM tb_paciente WHERE ind_prioridade = 1 ORDER BY nr_senha DESC)

		IF(@SeqSenha IS NULL)
			SET @SeqSenha = 'CR000'

		SET @SeqSenhaNumerica = CAST(SUBSTRING(@SeqSenha, 3, LEN(@SeqSenha) - 2) AS INT)

		IF(@SeqSenhaNumerica = 999)
			SET @SeqSenhaNumerica = 1
		ELSE
			SET @SeqSenhaNumerica = @SeqSenhaNumerica + 1 

		SET @SeqSenhaNumericaStr = CAST(@SeqSenhaNumerica AS VARCHAR)

		IF @SeqSenhaNumerica < 10
			SET @SeqSenhaNumericaStr = '00' + @SeqSenhaNumericaStr
		ELSE IF @SeqSenhaNumerica < 100
			SET @SeqSenhaNumericaStr = '0' + @SeqSenhaNumericaStr

		SET @SeqSenha = 'CR' + @SeqSenhaNumericaStr
	
		SET @RETURN = @SeqSenha
	END
	ELSE IF(@tipo_senha = 2)
	BEGIN
		SET @SeqSenha = (SELECT TOP 1 nr_senha FROM tb_paciente WHERE ind_prioridade = 2 ORDER BY nr_senha DESC)

		IF(@SeqSenha IS NULL)
			SET @SeqSenha = 'PR000'

		SET @SeqSenhaNumerica = CAST(SUBSTRING(@SeqSenha, 3, LEN(@SeqSenha) - 2) AS INT)

		IF(@SeqSenhaNumerica = 999)
			SET @SeqSenhaNumerica = 1
		ELSE
			SET @SeqSenhaNumerica = @SeqSenhaNumerica + 1 

		SET @SeqSenhaNumericaStr = CAST(@SeqSenhaNumerica AS VARCHAR)

		IF @SeqSenhaNumerica < 10
			SET @SeqSenhaNumericaStr = '00' + @SeqSenhaNumericaStr
		ELSE IF @SeqSenhaNumerica < 100
			SET @SeqSenhaNumericaStr = '0' + @SeqSenhaNumericaStr

		SET @SeqSenha = 'PR' + @SeqSenhaNumericaStr
	
		SET @RETURN = @SeqSenha
	END

	RETURN @RETURN
	
END
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

