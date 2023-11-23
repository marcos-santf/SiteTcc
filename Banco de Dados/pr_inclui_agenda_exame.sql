SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pr_inclui_agenda_exame]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[pr_inclui_agenda_exame]
GO

CREATE PROCEDURE dbo.pr_inclui_agenda_exame(
	@cd_usuario			INT,
	@dt_exame			DATE,
	@ds_tipo_exame		VARCHAR(100),
	@ds_exame_agendado	VARCHAR(100),
	@ds_hora			VARCHAR(10)
	)
WITH ENCRYPTION
 AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRANSACTION

		INSERT INTO tb_agenda_exames (
			cd_usuario,
			dt_exame,
			dt_inclusao,
			ds_tipo_exame,
			ds_exame_agendado,
			ds_hora) 
		VALUES (
			@cd_usuario,
			@dt_exame,
			getdate(),
			@ds_tipo_exame,
			@ds_exame_agendado,
			@ds_hora)
		
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
