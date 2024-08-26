
COPY (
SELECT emp.cnpj_basico--, est.cnpj_ordem , est.cnpj_dv
,  emp.razao_social --, emp.natureza_juridica, nat.descricao
--, emp.qualificacao_responsavel, quals.descricao
--, emp.capital_social, emp.porte_empresa, emp.ente_federativo_responsavel
, est.nome_fantasia--, est.situacao_cadastral, est.data_situacao_cadastral
, est.motivo_situacao_cadastral
, est.data_inicio_atividade--, est.cnae_fiscal_principal, cnae.descricao
--, est.cnae_fiscal_secundaria
--, est.tipo_logradouro, est.logradouro, est.numero, est.complemento
, est.bairro--, est.cep--, est.uf
--, est.municipio
, munic.descricao
, est.ddd_1, est.telefone_1
, est.correio_eletronico
--, est.data_situacao_cadastral
	FROM public.estabelecimento est 
	left join public.empresa emp on est.cnpj_basico = emp.cnpj_basico
	left join public.natju nat on emp.natureza_juridica = nat.codigo
	left join public.quals quals on emp.qualificacao_responsavel = quals.codigo 
	left join public.munic munic on munic.codigo = est.municipio
	left join public.cnae on cnae.codigo = est.cnae_fiscal_principal
	where 1=1
	and est.uf = 'SP'
	--and est.cep between '12900000' and '12999999'
	and munic.codigo in ( '6137' -- AMPARO
						 ,'6181' -- ATIBAIA
						 ,'6241' -- BOM JESUS DOS PERDOES
						 ,'6251' -- BRAGANCA PAULISTA
						 ,'6291' -- CAMPINAS
						 ,'6511' -- INDAITUBA
						 ,'6569' -- ITATIBA
						 ,'6605' -- JARINU
						 ,'6611' -- JOANOPOLIS
						 ,'6619' -- JUNDIAI
						 ,'6647' -- LOUVEIRA
						 ,'6671' -- MAIRIPORA
						 ,'6749' -- NAZARE PAULISTA
						 ,'6831' -- PAULINIA
						 ,'6871' -- PIQUETE
						 ,'6873' -- PIRACAIA
						 ,'7225' -- VALINHOS
						)
	and cnae.codigo IN ( '8630501' -- Atividade médica ambulatorial com recursos para realização de procedimentos cirúrgicos
						,'8610102' -- atendimento em pronto-socorro e unidades hospitalares para atendimento a urgências
						,'8630502' -- Atividade médica ambulatorial com recursos para realização de exames complementares 
						,'8630503' -- atividade médica ambulatorial restrita a consultas
						,'8610101' -- 8610-1/01	CLÍNICA MÉDICA COM INTERNAÇÃO; PÚBLICA OU PARTICULAR
						,'8640205' -- 8640-2/05	RADIOLOGIA MÉDICA; SERVIÇOS DE
						)
	--limit 10
	) TO 'D:\cnpj\listagem_MEDICOS.csv' DELIMITER ';' CSV HEADER ENCODING 'latin1' ;
	
	