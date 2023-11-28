SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pr_exclui_agenda_exame]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[pr_exclui_agenda_exame]
GO

CREATE PROCEDURE dbo.pr_exclui_agenda_exame(@cd_agenda INT)
WITH ENCRYPTION
 AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRANSACTION
		
		UPDATE tb_agenda_exames SET fg_excluido = 1, dt_alteracao = GETDATE() WHERE cd_agenda = @cd_agenda
	
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
