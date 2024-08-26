copy(
select municipio, desc_municipio, cnae_fiscal_principal, desc_cnae_fiscal_principal, count(cnae_fiscal_principal) as qtde

from public.ww_lista_resumida_uf_sp_ativa
group by municipio, desc_municipio, cnae_fiscal_principal, desc_cnae_fiscal_principal
)
TO 'd:\cnpj\arquivos_exportados\lista_resumida_uf_sp_ativa.csv' DELIMITER ';' CSV HEADER;

