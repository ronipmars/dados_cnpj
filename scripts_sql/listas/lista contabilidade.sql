
COPY (
SELECT emp.cnpj_basico, est.cnpj_ordem , est.cnpj_dv
, emp.razao_social --, emp.natureza_juridica
, nat.descricao
, socios.nome_socio_razao_social
--, emp.qualificacao_responsavel
, quals.descricao
, emp.capital_social
--, emp.porte_empresa
, case when emp.porte_empresa = '01' then 'Microempresa - ME' 
	when emp.porte_empresa = '03' then 'Empresa de pequeno porte - EPP' 
	when emp.porte_empresa = '05' then 'Demais empresas' 
	else 'ver' end  desc_porte_empresa
, emp.ente_federativo_responsavel
, est.nome_fantasia--, est.situacao_cadastral, est.data_situacao_cadastral
--, est.motivo_situacao_cadastral
, est.data_inicio_atividade--, est.cnae_fiscal_principal
, cnae.descricao
--, est.cnae_fiscal_secundaria
, est.tipo_logradouro, est.logradouro, est.numero, est.complemento
, est.bairro, est.cep, est.uf
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
	left join public.socios on quals.codigo = socios.qualificacao_socio 
	and socios.cnpj_basico = emp.cnpj_basico
	where 1=1
	and est.uf = 'SP'
	--and est.cep between '12900000' and '12999999'
	/*
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
	*/
	and cnae.codigo IN ( '6920601' -- contabilidaes			
						)
	order by emp.cnpj_basico
	) TO 'D:\cnpj\listagem_contabilidades_SP.csv' DELIMITER ';' CSV HEADER ENCODING 'latin1' ;
	
	