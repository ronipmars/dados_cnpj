 SELECT
    c.cnae_fiscal_principal,
    e.descricao AS desc_cnae_fiscal_principal,
    c.cep,
    c.uf,
    f.descricao AS desc_municipio,
    b.descricao AS desc_natureza_juridica,
	count( a.cnpj_basico) as qtde
    FROM empresa a
     LEFT JOIN natju b ON a.natureza_juridica = b.codigo
     LEFT JOIN estabelecimento c ON a.cnpj_basico = c.cnpj_basico
     LEFT JOIN moti d ON c.motivo_situacao_cadastral = d.codigo
     LEFT JOIN cnae e ON c.cnae_fiscal_principal = e.codigo
     LEFT JOIN munic f ON c.municipio = f.codigo
  WHERE 1 = 1 AND c.uf = 'SP'::text AND c.situacao_cadastral = '02'::text
  group by     c.cnae_fiscal_principal,
    e.descricao, c.cep, c.uf, f.descricao, b.descricao 


CREATE TABLE IF NOT EXISTS public.qtde_cnae_cep_uf_municipio
(
	cnae_fiscal_principal text COLLATE pg_catalog."default",
	desc_cnae_fiscal_principal text COLLATE pg_catalog."default",
	cep text COLLATE pg_catalog."default",
	uf text COLLATE pg_catalog."default",
	desc_municipio text COLLATE pg_catalog."default",
	desc_natureza_juridica text COLLATE pg_catalog."default",
	qtde bigint     
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.qtde_cnae_cep_uf_municipio
    OWNER to postgres;

CREATE INDEX IF NOT EXISTS cep_qtde
    ON public.estabelecimento USING btree
    (cep COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;


