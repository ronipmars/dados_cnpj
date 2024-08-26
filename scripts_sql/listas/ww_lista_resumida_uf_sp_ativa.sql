-- View: public.ww_lista_resumida_uf_sp_ativa

-- DROP VIEW public.ww_lista_resumida_uf_sp_ativa;

CREATE OR REPLACE VIEW public.ww_lista_resumida_uf_sp_ativa
 AS
 SELECT a.cnpj_basico,
    c.data_inicio_atividade,
    a.razao_social,
    c.nome_fantasia,
    c.cnae_fiscal_principal,
    e.descricao AS desc_cnae_fiscal_principal,
    c.cep,
    c.uf,
    c.municipio,
    f.descricao AS desc_municipio,
    a.natureza_juridica,
    b.descricao AS desc_natureza_juridica,
    c.situacao_cadastral,
        CASE
            WHEN c.situacao_cadastral = '01'::text THEN 'Nula'::text
            WHEN c.situacao_cadastral = '02'::text THEN 'Ativa'::text
            WHEN c.situacao_cadastral = '03'::text THEN 'Suspensa'::text
            WHEN c.situacao_cadastral = '04'::text THEN 'Inapta'::text
            WHEN c.situacao_cadastral = '08'::text THEN 'Baixada'::text
            ELSE 'verificar'::text
        END AS desc_situacao_cadastral,
    c.data_situacao_cadastral,
    c.motivo_situacao_cadastral,
    d.descricao AS desc_motivo_situacao_cadastral
   FROM empresa a
     LEFT JOIN natju b ON a.natureza_juridica = b.codigo
     LEFT JOIN estabelecimento c ON a.cnpj_basico = c.cnpj_basico
     LEFT JOIN moti d ON c.motivo_situacao_cadastral = d.codigo
     LEFT JOIN cnae e ON c.cnae_fiscal_principal = e.codigo
     LEFT JOIN munic f ON c.municipio = f.codigo
  WHERE 1 = 1 AND c.uf = 'SP'::text AND c.situacao_cadastral = '01'::text
and 


