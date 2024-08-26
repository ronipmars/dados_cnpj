CREATE TABLE agrupamento_uf_municipio AS
SELECT 
    B.UF, 
    B.MUNICIPIO, 
    COUNT(DISTINCT A.CNPJ_BASICO) AS total_empresas, 
    COUNT(B.cnpj_basico) AS total_estabelecimentos
FROM 
    public.empresa A 
JOIN 
    public.estabelecimento B 
ON 
    A.cnpj_basico = B.cnpj_basico
GROUP BY 
    B.UF, 
    B.MUNICIPIO;
	
CREATE TABLE agrupamento_natureza_juridica AS
SELECT 
    A.NATUREZA_JURIDICA, 
    COUNT(DISTINCT A.CNPJ_BASICO) AS total_empresas
FROM 
    public.empresa A
GROUP BY 
    A.NATUREZA_JURIDICA;


CREATE TABLE agrupamento_porte_empresa AS
SELECT 
    A.porte_empresa, 
    COUNT(DISTINCT A.CNPJ_BASICO) AS total_empresas, 
    COUNT(B.cnpj_basico) AS total_estabelecimentos
FROM 
    public.empresa A 
JOIN 
    public.estabelecimento B 
ON 
    A.cnpj_basico = B.cnpj_basico
GROUP BY 
    A.porte_empresa;


CREATE TABLE agrupamento_data_inicio AS
    SELECT json_agg(row_to_json(result))
    FROM (
        SELECT 
            DATE_PART('year', 
                      CASE 
                          WHEN LENGTH(B.data_inicio_atividade) = 8 
                               AND TO_DATE(SUBSTRING(B.data_inicio_atividade, 1, 4) || '-' || 
                                           SUBSTRING(B.data_inicio_atividade, 5, 2) || '-' || 
                                           SUBSTRING(B.data_inicio_atividade, 7, 2), 'YYYY-MM-DD')::DATE IS NOT NULL
                          THEN TO_DATE(SUBSTRING(B.data_inicio_atividade, 1, 4) || '-' || 
                                       SUBSTRING(B.data_inicio_atividade, 5, 2) || '-' || 
                                       SUBSTRING(B.data_inicio_atividade, 7, 2), 'YYYY-MM-DD')
                          ELSE NULL
                      END
            ) AS ano_inicio_atividade, 
            COUNT(DISTINCT A.CNPJ_BASICO) AS total_empresas
        FROM 
            public.empresa A 
        JOIN 
            public.estabelecimento B 
        ON 
            A.cnpj_basico = B.cnpj_basico
        GROUP BY 
            DATE_PART('year', 
                      CASE 
                          WHEN LENGTH(B.data_inicio_atividade) = 8 
                               AND TO_DATE(SUBSTRING(B.data_inicio_atividade, 1, 4) || '-' || 
                                           SUBSTRING(B.data_inicio_atividade, 5, 2) || '-' || 
                                           SUBSTRING(B.data_inicio_atividade, 7, 2), 'YYYY-MM-DD')::DATE IS NOT NULL
                          THEN TO_DATE(SUBSTRING(B.data_inicio_atividade, 1, 4) || '-' || 
                                       SUBSTRING(B.data_inicio_atividade, 5, 2) || '-' || 
                                       SUBSTRING(B.data_inicio_atividade, 7, 2), 'YYYY-MM-DD')
                          ELSE NULL
                      END
            )
        ORDER BY 
            ano_inicio_atividade
	
	CREATE TABLE agrupamento_capital_social AS
SELECT 
    CASE 
        WHEN A.capital_social <= 50000 THEN '0-50k'
        WHEN A.capital_social <= 500000 THEN '50k-500k'
        WHEN A.capital_social <= 5000000 THEN '500k-5M'
		WHEN A.capital_social <= 50000000 THEN '5M-50M'
		WHEN A.capital_social <= 500000000 THEN '50M-500M'
        ELSE '500M+' 
    END AS faixa_capital_social,
    COUNT(DISTINCT A.CNPJ_BASICO) AS total_empresas
FROM 
    public.empresa A
GROUP BY 
    faixa_capital_social;

CREATE TABLE agrupamento_situacao_cadastral AS
SELECT 
    B.situacao_cadastral, 
    COUNT(DISTINCT A.CNPJ_BASICO) AS total_empresas
FROM 
    public.empresa A 
JOIN 
    public.estabelecimento B 
ON 
    A.cnpj_basico = B.cnpj_basico
GROUP BY 
    B.situacao_cadastral;

CREATE TABLE agrupamento_tipo_estabelecimento AS
SELECT 
    B.tipo_estabelecimento, 
    COUNT(B.cnpj_basico) AS total_estabelecimentos
FROM 
    public.estabelecimento B
GROUP BY 
    B.tipo_estabelecimento;


