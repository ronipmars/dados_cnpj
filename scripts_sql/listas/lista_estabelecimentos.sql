
--COPY (
SELECT emp.cnpj_basico, est.cnpj_ordem , est.cnpj_dv,  emp.razao_social, emp.natureza_juridica, nat.descricao
, emp.qualificacao_responsavel, quals.descricao
, emp.capital_social, emp.porte_empresa, emp.ente_federativo_responsavel
, est.nome_fantasia, est.situacao_cadastral, est.data_situacao_cadastral
, est.motivo_situacao_cadastral, est.data_inicio_atividade, est.cnae_fiscal_principal, cnae.descricao
, est.cnae_fiscal_secundaria
, est.tipo_logradouro, est.logradouro, est.numero, est.complemento, est.bairro, est.cep, est.uf, est.municipio, munic.descricao
, est.ddd_1, est.telefone_1
, est.correio_eletronico
, est.data_situacao_cadastral
	FROM public.estabelecimento est 
	left join public.empresa emp on est.cnpj_basico = emp.cnpj_basico
	left join public.natju nat on emp.natureza_juridica = nat.codigo
	left join public.quals quals on emp.qualificacao_responsavel = quals.codigo 
	left join public.munic munic on munic.codigo = est.municipio
	left join public.cnae on cnae.codigo = est.cnae_fiscal_principal
	where 1=1
	and est.uf = 'SP'
	and est.cep between '12900000' and '12999999'
	and munic.codigo = '6181'
	--and cnae.codigo = '6920601' --contabilidade
	and cnae.codigo = '8630504' -- dentista
	--limit 10
	--) TO 'D:\cnpj\filename.csv' DELIMITER ';' CSV HEADER ENCODING 'latin1' ;
	
	