COPY (
select distinct 
emp.razao_social
, mun.codigo_siafi, mun.codigo_ibge, mun.munic_nome, popul.populacao
, qcnae.cnae, cnae.descricao, qcnae.qtde

from
public.empresa emp join public.estabelecimento_sp est
	on emp.cnpj_basico = est.cnpj_basico 
join public.munic_siafi_ibge mun on est.municipio = mun.codigo_siafi
	join public.munic_qtde_cnae qcnae
on mun.codigo_siafi = qcnae.codigo_siafi
	and est.municipio = mun.codigo_siafi
join public.munic_popul_jul21 popul on mun.codigo_ibge = popul.codigo_ibge
join public.cnae cnae on qcnae.cnae = cnae.codigo
and cnae.codigo = est.cnae_fiscal_principal

where 1=1
and mun.uf = 'SP'
and cnae.codigo between '9400000' and '9499999'
	and mun.codigo_siafi in ( '6137' -- AMPARO
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
) TO 'D:\cnpj\exported_lists\analise_cnae_regiao_sp.csv' DELIMITER ';' CSV HEADER ENCODING 'latin1' ;
	




