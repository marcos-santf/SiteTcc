SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pr_envia_dados_paciente]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[pr_envia_dados_paciente]
GO

CREATE PROCEDURE dbo.pr_envia_dados_paciente(
	@cd_exame					INT = NULL,
	@ds_sintomas				VARCHAR(MAX) = NULL, 
	@ds_pressao					VARCHAR(100) = NULL,
	@ds_batimento				VARCHAR(100) = NULL, 
	@ds_oxigenacao				VARCHAR(100) = NULL,
	@ds_queixa_paciente			VARCHAR(MAX) = NULL,
	@ds_observacoes				VARCHAR(MAX) = NULL,
	@ds_observacoes_enfermagem	VARCHAR(MAX) = NULL,
	@ds_diagnostico_medico		VARCHAR(MAX) = NULL,
	@ds_prescricao_medica		VARCHAR(MAX) = NULL,
	@ds_observacao_medica		VARCHAR(MAX) = NULL,
	@ind_prioridade				INT = NULL,
	@ind_etapa_triagem			INT = NULL
	)
WITH ENCRYPTION
 AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRANSACTION
		
		IF EXISTS (SELECT 1 FROM tb_paciente_exames WHERE cd_exame = @cd_exame AND cd_medico IS NULL)
		BEGIN
			DECLARE @cd_medico INT = NULL, @TotalTarefas INT = NULL

			SELECT TOP 1 @cd_medico = m.cd_medico, @TotalTarefas = COALESCE(COUNT(pe.cd_medico), 0)
			FROM  tb_medico m
			LEFT JOIN  tb_paciente_exames pe ON pe.cd_medico = m.cd_medico
			WHERE m.ind_prioridade = @ind_prioridade
			GROUP BY m.cd_medico
			ORDER BY COALESCE(COUNT(pe.cd_medico), 0), m.cd_medico

			IF(@cd_medico IS NULL)
			BEGIN
				SELECT TOP 1 @cd_medico = m.cd_medico, @TotalTarefas = COALESCE(COUNT(pe.cd_medico), 0)
				FROM  tb_medico m
				LEFT JOIN  tb_paciente_exames pe ON pe.cd_medico = m.cd_medico
				GROUP BY m.cd_medico
				ORDER BY COALESCE(COUNT(pe.cd_medico), 0), m.cd_medico
			END

			UPDATE 
				tb_paciente_exames 
			SET 
				ds_sintomas = @ds_sintomas, 
				ds_pressao = @ds_pressao, 
				ds_batimento = @ds_batimento, 
				ds_oxigenacao = @ds_oxigenacao, 
				ds_queixa_paciente = @ds_queixa_paciente,
				ds_observacoes_enfermagem = @ds_observacoes_enfermagem,
				cd_medico = @cd_medico,
				fg_enfermagem_finalizado = 1,
				dt_alteracao = getdate()
			WHERE cd_exame = @cd_exame
		END
		ELSE 
		BEGIN
			UPDATE 
				tb_paciente_exames 
			SET 
				ds_diagnostico_medico = @ds_diagnostico_medico, 
				ds_prescricao_medica = @ds_prescricao_medica, 
				ds_observacao_medica = @ds_observacao_medica, 
				fg_medico_finalizado = 1,
				dt_alteracao = getdate()
			WHERE cd_exame = @cd_exame

			IF(@ind_etapa_triagem = 9)
				UPDATE tb_paciente SET nr_senha = NULL, ind_etapa_triagem = @ind_etapa_triagem WHERE cd_paciente = (SELECT cd_paciente FROM tb_paciente_exames WHERE cd_exame = @cd_exame)
			ELSE
				UPDATE tb_paciente SET ind_etapa_triagem = @ind_etapa_triagem WHERE cd_paciente = (SELECT cd_paciente FROM tb_paciente_exames WHERE cd_exame = @cd_exame)
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
