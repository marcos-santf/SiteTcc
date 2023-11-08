SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pr_retorna_dados_usuario]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[pr_retorna_dados_usuario]
GO

CREATE PROCEDURE dbo.pr_retorna_dados_usuario(@cd_usuario INT)
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

			SELECT *
			FROM
				tb_paciente_exames
			WHERE cd_paciente = (SELECT cd_paciente FROM tb_paciente WHERE cd_usuario = @cd_usuario) AND fg_enfermagem_finalizado = 1 AND fg_medico_finalizado = 1
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
