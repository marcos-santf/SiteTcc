SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pr_retorna_dados_usuario]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[pr_retorna_dados_usuario]
GO

CREATE PROCEDURE dbo.pr_retorna_dados_usuario(@cd_usuario INT, @dt_inicio DATE = NULL, @dt_fim DATE = NULL, @ds_tipo_exame VARCHAR(100) = NULL ,@ind_tipo INT)
WITH ENCRYPTION
 AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRANSACTION
		
		IF NOT EXISTS(SELECT 1 FROM tb_usuario WHERE cd_usuario = @cd_usuario)
		BEGIN
			RAISERROR('Usuário não encontrado.', 16, 1)
			GOTO erro
		END

		IF(@dt_inicio = '')
			SET @dt_inicio = NULL
		
		IF(@dt_fim = '')
			SET @dt_fim = NULL
		
		IF(@ds_tipo_exame = '')
			SET @ds_tipo_exame = NULL

		IF(@ind_tipo = 0)
		BEGIN
			SELECT 
				p.cd_pessoa,
				p.ds_nome,
				p.ds_cpf,
				p.ds_rg,
				p.dt_nascimento,
				p.ds_telefone,
				p.ds_uf,
				p.ds_email,
				p.ds_nome_mae,
				p.ds_nome_pai,
				p.ds_profissao,
				p.ds_responsavel,
				p.fg_excluido
			FROM 
				tb_pessoa p 
				INNER JOIN tb_usuario u ON u.cd_pessoa = p.cd_pessoa
			WHERE 
				u.cd_usuario = @cd_usuario
				AND u.fg_excluido = 0 
				AND p.fg_excluido = 0


			IF EXISTS(SELECT 1 FROM tb_paciente WHERE cd_usuario = @cd_usuario)
			BEGIN
				SELECT *
				FROM
					tb_paciente 
				WHERE
					cd_usuario = @cd_usuario 
					AND fg_excluido = 0

				SELECT 
					ps.ds_nome							AS [Nome do Paciente],
					ps2.ds_nome							AS [Enfermeira Responsável],
					ps3.ds_nome							AS [Médico Responsável],
					CONVERT(varchar, pe.dt_exame, 103)	AS [Data do Exame],
					pe.ds_sintomas						AS [Sintomas],
					pe.ds_pressao						AS [Pressão Arterial],
					pe.ds_batimento						AS [Batimentos Cardíacos], 
					pe.ds_oxigenacao					AS [Oxigenação], 
					pe.ds_queixa_paciente				AS [Queixas do Paciente], 
					pe.ds_observacoes_enfermagem		AS [Observações Enfermagem],
					pe.ds_diagnostico_medico			AS [Diagnóstico Médico],
					pe.ds_prescricao_medica				AS [Prescrição Médica]
				
				FROM
					tb_paciente_exames pe
					INNER JOIN tb_paciente p ON p.cd_paciente = pe.cd_paciente
					INNER JOIN tb_usuario u ON u.cd_usuario = p.cd_usuario AND u.fg_excluido = 0
					INNER JOIN tb_pessoa ps ON ps.cd_pessoa = u.cd_pessoa AND ps.fg_excluido = 0
					INNER JOIN tb_enfermagem en ON en.cd_enfermagem = pe.cd_enfermagem AND en.fg_excluido = 0
					INNER JOIN tb_usuario u2 ON u2.cd_usuario = en.cd_usuario AND u2.fg_excluido = 0
					INNER JOIN tb_pessoa ps2 ON ps2.cd_pessoa = u2.cd_pessoa AND ps2.fg_excluido = 0
					INNER JOIN tb_medico me ON me.cd_medico = pe.cd_medico AND me.fg_excluido = 0
					INNER JOIN tb_usuario u3 ON u3.cd_usuario = me.cd_usuario AND u3.fg_excluido = 0
					INNER JOIN tb_pessoa ps3 ON ps3.cd_pessoa = u3.cd_pessoa AND ps3.fg_excluido = 0
				WHERE pe.cd_paciente = (SELECT cd_paciente FROM tb_paciente WHERE cd_usuario = @cd_usuario) AND fg_enfermagem_finalizado = 1 AND fg_medico_finalizado = 1
				ORDER BY cd_exame
			END
			ELSE IF EXISTS(SELECT 1 FROM tb_enfermagem WHERE cd_usuario = @cd_usuario)
			BEGIN
				SELECT *
				FROM
					tb_enfermagem 
				WHERE
					cd_usuario = @cd_usuario 
					AND fg_excluido = 0

				SELECT TOP 1
					pe.cd_exame, 
					pe.cd_paciente, 
					ps.ds_nome AS ds_nome_paciente,
					p.nr_senha,
					p.ind_prioridade,
					p.ind_etapa_triagem,
					pe.cd_enfermagem, 
					pe.cd_medico, 
					pe.dt_exame, 
					pe.dt_inclusao,	
					pe.dt_alteracao, 
					pe.fg_excluido, 
					pe.ds_sintomas,	
					pe.ds_pressao, 
					pe.ds_batimento, 
					pe.ds_oxigenacao, 
					pe.ds_queixa_paciente, 
					pe.ds_observacoes_enfermagem, 
					pe.fg_enfermagem_finalizado, 
					pe.fg_medico_finalizado
				FROM
					tb_paciente_exames pe
					INNER JOIN tb_paciente p ON p.cd_paciente = pe.cd_paciente
					INNER JOIN tb_usuario u ON u.cd_usuario = p.cd_usuario AND u.fg_excluido = 0
					INNER JOIN tb_pessoa ps ON ps.cd_pessoa = u.cd_pessoa AND ps.fg_excluido = 0
				WHERE pe.cd_enfermagem = (SELECT cd_enfermagem FROM tb_enfermagem WHERE cd_usuario = @cd_usuario) AND pe.fg_enfermagem_finalizado = 0
				ORDER BY pe.cd_exame
			END
			ELSE IF EXISTS(SELECT 1 FROM tb_medico WHERE cd_usuario = @cd_usuario)
			BEGIN
				SELECT *
				FROM
					tb_medico 
				WHERE
					cd_usuario = @cd_usuario 
					AND fg_excluido = 0

				SELECT TOP 1
					pe.cd_exame, 
					pe.cd_paciente, 
					ps.ds_nome AS ds_nome_paciente,
					p.nr_senha,
					p.ind_prioridade,
					p.ind_etapa_triagem,
					pe.cd_enfermagem, 
					ps2.ds_nome AS ds_nome_enfermagem,
					e.ds_coren,
					pe.cd_medico, 
					pe.dt_exame, 
					pe.dt_inclusao,	
					pe.dt_alteracao, 
					pe.fg_excluido, 
					pe.ds_sintomas,	
					pe.ds_pressao, 
					pe.ds_batimento, 
					pe.ds_oxigenacao, 
					pe.ds_queixa_paciente, 
					pe.ds_observacoes_enfermagem, 
					pe.fg_enfermagem_finalizado, 
					pe.fg_medico_finalizado
				FROM
					tb_paciente_exames pe
					INNER JOIN tb_paciente p ON p.cd_paciente = pe.cd_paciente
					INNER JOIN tb_usuario u ON u.cd_usuario = p.cd_usuario AND u.fg_excluido = 0
					INNER JOIN tb_pessoa ps ON ps.cd_pessoa = u.cd_pessoa AND ps.fg_excluido = 0
					INNER JOIN tb_enfermagem e ON e.cd_enfermagem = pe.cd_enfermagem AND e.fg_excluido = 0
					INNER JOIN tb_usuario u2 ON u2.cd_usuario = e.cd_usuario AND u2.fg_excluido = 0
					INNER JOIN tb_pessoa ps2 ON ps2.cd_pessoa = u2.cd_pessoa AND ps2.fg_excluido = 0
				WHERE pe.cd_medico = (SELECT cd_medico FROM tb_medico WHERE cd_usuario = @cd_usuario) AND pe.fg_medico_finalizado = 0
				ORDER BY pe.cd_exame
			END
		END
		ELSE IF(@ind_tipo = 1)
		BEGIN
			IF(@ds_tipo_exame IS NOT NULL)
			BEGIN
				IF (@dt_inicio IS NOT NULL AND @dt_fim IS NOT NULL)
				BEGIN
					SELECT 
						cd_agenda AS Código,
						CONVERT(varchar, dt_exame, 103)	AS [Data],
						ds_tipo_exame					AS Tipo,
						ds_exame_agendado				AS Agendado,
						ds_hora							AS Horário
					FROM 
						tb_agenda_exames 
					WHERE 
						cd_usuario = @cd_usuario AND 
						fg_excluido = 0 AND
						ds_tipo_exame = @ds_tipo_exame AND
						dt_exame BETWEEN @dt_inicio AND @dt_fim
				END
				ELSE 
				BEGIN
					SELECT 
						cd_agenda AS Código,
						CONVERT(varchar, dt_exame, 103)	AS [Data],
						ds_tipo_exame					AS Tipo,
						ds_exame_agendado				AS Agendado,
						ds_hora							AS Horário
					FROM 
						tb_agenda_exames 
					WHERE 
						cd_usuario = @cd_usuario AND
						fg_excluido = 0 AND
						ds_tipo_exame = @ds_tipo_exame 
				END
			END
			ELSE
			BEGIN
				IF (@dt_inicio IS NOT NULL AND @dt_fim IS NOT NULL)
				BEGIN
					SELECT 
						cd_agenda AS Código,
						CONVERT(varchar, dt_exame, 103)	AS [Data],
						ds_tipo_exame					AS Tipo,
						ds_exame_agendado				AS Agendado,
						ds_hora							AS Horário
					FROM 
						tb_agenda_exames 
					WHERE 
						cd_usuario = @cd_usuario AND 
						fg_excluido = 0 AND
						dt_exame BETWEEN @dt_inicio AND @dt_fim
				END
				ELSE 
				BEGIN
					SELECT 
						cd_agenda AS Código,
						CONVERT(varchar, dt_exame, 103)	AS [Data],
						ds_tipo_exame					AS Tipo,
						ds_exame_agendado				AS Agendado,
						ds_hora							AS Horário
					FROM 
						tb_agenda_exames 
					WHERE 
						cd_usuario = @cd_usuario AND
						fg_excluido = 0 
				END
			END
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
