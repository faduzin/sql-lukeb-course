### Projeto de Análise de Dados em SQL

Descubra insights sobre o mercado de trabalho em dados! Este projeto explora 📈 as funções mais bem pagas para analistas de dados, 🔑 habilidades em alta demanda e 🌍 onde a demanda elevada encontra oportunidades lucrativas na análise de dados.

Inspirado por um tutorial em vídeo passo a passo de [Luke Barousse](https://www.youtube.com/@LukeBarousse), este projeto recria e expande a análise apresentada por ele.

Confira as queries SQL aqui: [pasta project_sql](/practice_project_sql/)

## Índice

1. [Contexto](#contexto)
2. [Ferramentas Utilizadas](#ferramentas-utilizadas)
3. [A Análise](#a-análise)
4. [O Que Aprendi](#o-que-aprendi)
5. [Habilidades Praticadas](#habilidades-praticadas)
6. [Conclusão](#conclusao)
7. [Planos Futuros](#planos-futuros)
8. [Contato](#contato)

## Contexto

O aumento da análise de dados tornou os cargos de analista de dados alguns dos mais procurados no mercado de trabalho. Com foco na interseção entre alta demanda e altos salários, este projeto analisa questões-chave sobre o mercado de trabalho em dados, como:

1. Quais são os cargos mais bem pagos para analistas de dados?
2. Quais são as habilidades necessárias para esses cargos de alto salário?
3. Quais são as habilidades mais procuradas para analistas de dados?
4. Quais são as principais habilidades com base no salário para analistas de dados?
5. Quais são as habilidades mais ótimas para aprender?

Respondendo a essas perguntas, este projeto fornece insights valiosos para qualquer pessoa que queira entrar ou crescer na área de análise de dados.

## Ferramentas Utilizadas

Para dar vida a este projeto, utilizei um conjunto de ferramentas poderosas:

- **SQL**: A base da minha análise, permitindo uma exploração detalhada e a criação de queries.
- **PostgreSQL**: Um robusto sistema de gerenciamento de bancos de dados para organizar e consultar eficientemente o dataset.
- **Visual Studio Code**: Meu ambiente preferido para escrever e executar scripts SQL.
- **Git e GitHub**: Essenciais para controle de versão e para compartilhar meu trabalho com clareza e organização
## A Análise

Este projeto focou em descobrir insights-chave sobre o mercado de trabalho para analistas de dados. Cada query foi projetada para abordar questões específicas, iluminando tendências, oportunidades e habilidades essenciais.

### *1. Quais são os cargos mais bem pagos para analistas de dados?*

Para identificar as funções mais bem pagas, foquei em cargos de analista de dados com salários anuais médios não nulos. A query destaca oportunidades remotas ("Anywhere") e as classifica por salário, exibindo os 10 cargos mais bem pagos na área.

```sql
SELECT
    job_postings_fact.job_title,
    job_postings_fact.salary_year_avg,
    company_dim.name as company_name
FROM
    job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_postings_fact.salary_year_avg IS NOT NULL AND
    job_postings_fact.job_location = 'Anywhere'
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

A query revela os 10 cargos mais bem pagos para analistas de dados no mercado, incluindo títulos, empresas e salários anuais médios.

| Rank | Cargo                                      | Empresa                        | Salário Anual Médio ($) |
|------|-------------------------------------------|--------------------------------|---------------------------|
| 1    | Data Analyst                              | Mantys                         | 650,000                  |
| 2    | Director of Analytics                     | Meta                           | 336,500                  |
| 3    | Associate Director- Data Insights         | AT&T                           | 255,829                  |
| 4    | Data Analyst, Marketing                   | Pinterest Job Advertisements   | 232,423                  |
| 5    | Data Analyst (Hybrid/Remote)              | Uclahealthcareers              | 217,000                  |
| 6    | Principal Data Analyst (Remote)           | SmartAsset                     | 205,000                  |
| 7    | Director, Data Analyst - HYBRID           | Inclusively                    | 189,309                  |
| 8    | Principal Data Analyst, AV Performance    | Motional                       | 189,000                  |
| 9    | Principal Data Analyst                    | SmartAsset                     | 186,000                  |
| 10   | ERM Data Analyst                          | Get It Recruit - IT            | 184,000                  |

#### Principais Insights Baseados nos Resultados:

- **Os Salários Variam Consideravelmente:** Os salários anuais para os cargos mais bem pagos vão de $184,000 a $650,000, indicando disparidades significativas baseadas em experiência, responsabilidades e empresas.

- **Empresas Diversificadas:** Os empregos são oferecidos por uma variedade de empresas como Mantys, Meta e AT&T, mostrando uma demanda ampla por profissionais de alto nível na área de análise de dados.

- **Títulos Variados:** Embora todos os cargos sejam de alto nível, os títulos incluem Diretor, Principal Data Analyst e Associate Director, sugerindo que a diversidade de funções oferece flexibilidade para trajetórias de carreira.

#### Resposta à Pergunta

A análise revela os cargos mais bem pagos para analistas de dados, com salários variando de $184,000 a $650,000. O cargo mais bem remunerado, "Data Analyst" na Mantys, supera significativamente outras posições, indicando uma demanda única no mercado. Funções de liderança como Diretor e Associate Director também estão entre as mais bem pagas, destacando o valor da expertise estratégica e gerencial na área de análise de dados.

### *2. Quais são as habilidades necessárias para esses cargos de alto salário?*

Esta query baseia-se nos cargos de analista de dados mais bem pagos identificados anteriormente, incorporando as habilidades específicas exigidas para cada um desses cargos. Ela recupera os detalhes dos empregos, incluindo títulos, salários e nomes das empresas, juntamente com uma lista de habilidades associadas, fornecendo uma compreensão mais profunda sobre o que torna essas funções valiosas. Os resultados são ordenados por salário, garantindo que os cargos mais bem pagos sejam destacados primeiro.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_postings_fact.job_id,
        job_postings_fact.job_title,
        job_postings_fact.salary_year_avg,
        company_dim.name as company_name
    FROM
        job_postings_fact
        LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst' AND
        job_postings_fact.salary_year_avg IS NOT NULL AND
        job_postings_fact.job_location = 'Anywhere'
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT
    top_paying_jobs.*,
    skills_dim.skills
FROM
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    top_paying_jobs.salary_year_avg DESC;
```

O gráfico de barras destaca as 5 habilidades mais demandadas entre os 10 cargos de analista de dados mais bem pagos. Essas habilidades são frequentemente mencionadas nas vagas, destacando sua importância para garantir posições lucrativas na área.

![Top 5 Most In-Demand Skills among the 10 highest-paying Data Analyst roles](<assets/top-5-in-demand-skills.png>)<figcaption>*Gráfico de barras visualizando as 5 habilidades mais demandadas para os cargos mais bem pagos de analista de dados; gráfico gerado a partir dos resultados das queries SQL.*</figcaption>

#### Principais Insights Baseados nos Resultados:

- **SQL Domina o Campo:** SQL é a habilidade mais frequentemente mencionada, aparecendo em quase todos os cargos mais bem pagos, sublinhando sua importância fundamental na análise de dados.

- **Python e Tableau Lideram como Ferramentas de Suporte:** Python e Tableau são fortes candidatos, reforçando seu papel como ferramentas essenciais para análise e visualização em posições de alto salário.

- **Conjuntos Diversificados de Habilidades São Valorizados:** Embora habilidades técnicas como R e Snowflake sejam críticas, a variedade de ferramentas listadas nos cargos destaca o valor de uma expertise diversificada para garantir os cargos mais bem pagos.

#### Resposta à Pergunta

Os cargos de analista de dados mais bem pagos exigem uma combinação de habilidades técnicas e analíticas, com SQL liderando o conjunto, seguido por Python, Tableau, R e Snowflake. Essas ferramentas dominam o conjunto de habilidades exigidas pelas posições mais bem remuneradas, sublinhando sua importância para garantir empregos lucrativos na área de análise de dados.

### *3. Quais são as habilidades mais procuradas para analistas de dados?*

Esta query identifica as habilidades mais procuradas para o cargo de analista de dados. Ela conta com que frequência cada habilidade aparece em todas as vagas para analistas de dados, ordena por demanda e recupera as 5 habilidades mais procuradas no mercado de trabalho.

```sql
SELECT
    skills_dim.skills AS skill_name,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY 
    skills_dim.skills
ORDER BY
    demand_count DESC
LIMIT 5;
```

A tabela abaixo lista as 5 habilidades mais procuradas para posições de analista de dados com base em sua frequência nas postagens de emprego:

| Nome da Habilidade | Contagem de Demanda |
|---------------------|---------------------|
| SQL                | 92,628             |
| Excel              | 67,031             |
| Python             | 57,326             |
| Tableau            | 46,554             |
| Power BI           | 39,468             |

Apliquei um filtro adicional para focar exclusivamente em empregos remotos, e aqui estão os resultados:

| Nome da Habilidade | Contagem de Demanda |
|---------------------|---------------------|
| SQL                | 7,291              |
| Excel              | 4,611              |
| Python             | 4,330              |
| Tableau            | 3,745              |
| Power BI           | 2,609              |

#### Principais Insights Baseados nos Resultados:

- **SQL É o Líder Indiscutível:** SQL domina ambas as categorias, aparecendo em 92,628 postagens gerais e 7,291 postagens remotas, destacando sua relevância essencial em todas as funções de analista de dados.

- **Excel Continua Sendo uma Ferramenta Chave:** Apesar dos avanços em tecnologias de dados, Excel é altamente demandado, com 67,031 mencões gerais e 4,611 mencões remotas, refletindo sua adaptabilidade para tarefas de gerenciamento e análise de dados.

- **A Flexibilidade do Python É Valorizada:** Python ocupa o terceiro lugar em ambas as categorias (57,326 menções gerais; 4,330 menções remotas), destacando sua importância para manipulação de dados, automação e análises avançadas.

- **Habilidades de Visualização São Críticas:** Ferramentas como Tableau (46,554 gerais; 3,745 remotas) e Power BI (39,468 gerais; 2,609 remotas) permanecem vitais para apresentar insights de dados de forma eficaz.

- **Empregos Remotos Têm um Perfil de Habilidades Semelhante:** Os dados de empregos remotos refletem uma hierarquia de habilidades similar às funções gerais, sugerindo que os requisitos técnicos principais permanecem consistentes, independentemente do ambiente de trabalho.

#### Resposta à Pergunta

As habilidades mais procuradas para analistas de dados são SQL, Excel, Python, Tableau e Power BI, aparecendo com mais frequência nas postagens de emprego. Essas habilidades representam as competências essenciais que os empregadores buscam, garantindo versatilidade e eficácia no gerenciamento, análise e visualização de dados.

### *4. Quais são as principais habilidades com base no salário para analistas de dados?*

Esta query identifica as principais habilidades com base no salário médio para cargos de analista de dados. Ela calcula o salário médio para cada habilidade em todas as postagens de emprego, filtra habilidades com pelo menos 3 mencões e recupera as 25 principais habilidades classificadas pelo salário médio.

```sql
SELECT
    skills_dim.skills,
    ROUND(AVG(salary_year_avg)) AS avg_salary,
    COUNT(salary_year_avg)
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' 
    AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_work_from_home = TRUE
GROUP BY
    skills_dim.skills
HAVING
    COUNT(salary_year_avg) > 3
ORDER BY
    avg_salary DESC
LIMIT 25;
```

Abaixo, temos um gráfico de barras agrupadas comparando os salários médios para habilidades entre todos os empregos e empregos remotos. O gráfico destaca as diferenças na remuneração para cada habilidade com base no tipo de emprego.

![Comparativo de Salários Médios por Habilidades: Todos os Empregos vs Empregos Remotos](<assets/comparison-of-average-salaries-per-skill.png>)<figcaption>Gráfico de barras comparando os salários médios para habilidades em todos os empregos versus empregos remotos; gerado a partir de resultados de queries SQL.</figcaption>

#### Principais Insights Baseados nos Resultados:

- **Variação Salarial Baseada em Habilidades:**
Certas habilidades, como Pandas e NumPy, apresentam salários médios significativamente mais altos em funções remotas comparadas a todos os empregos. Por exemplo, Pandas tem um salário médio de $151,821 em empregos remotos, superando a maioria das habilidades gerais.

- **Databricks Se Destaca em Ambas as Categorias:**
Databricks aparece como uma das habilidades mais bem remuneradas tanto em todos os empregos ($112,881) quanto em empregos remotos ($141,907), destacando sua relevância e demanda em ambos os contextos.

- **Consistência de Snowflake:**
Snowflake permanece como uma habilidade amplamente demandada e bem remunerada em ambas as categorias, com salários médios de aproximadamente $111,578 (todos os empregos) e $112,948 (remotos).

- **Empregos Remotos Preferem Ferramentas Especializadas:**
Empregos remotos mostram preferência por ferramentas especializadas como Pandas, NumPy e PostgreSQL, que apresentam salários médios mais altos comparados a suas contrapartes gerais.

#### Resposta à Pergunta

As principais habilidades com base no salário para cargos de analista de dados variam ligeiramente entre todos os empregos e empregos remotos. Para todos os empregos, GitLab, Kafka e PyTorch dominam as habilidades mais bem remuneradas. Em empregos remotos, habilidades como Pandas, NumPy e Databricks lideram a lista.

Esta análise destaca que, enquanto algumas habilidades são universalmente valiosas, certas ferramentas e frameworks possuem um prêmio específico em mercados de trabalho remoto. Isso pode ser devido à natureza especializada do ambiente remoto, que exige conhecimentos mais avançados ou específicos.

---

### *5. Quais são as habilidades mais ótimas para aprender?*

Esta query identifica as habilidades mais ótimas para aprender para analistas de dados, avaliando habilidades com demanda significativa (mais de 10 menções) e altos salários médios. Ela classifica as habilidades com base no salário médio e na demanda, fornecendo insights sobre quais habilidades oferecem a melhor combinação de valor e oportunidades.

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) as demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' 
    AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

Executei uma query para identificar as 25 principais habilidades com os maiores salários e demanda em todos os empregos. Em seguida, apliquei um filtro para focar apenas em empregos remotos. Usando os resultados, gerei um gráfico comparando as 4 habilidades mais bem remuneradas em ambos os contextos, destacando as diferenças de valor e demanda entre empregos gerais e remotos.

![As 4 Habilidades Mais Bem Pagas: Todos os Empregos vs Empregos Remotos](<assets/top-4-highest-salaries.png>)<figcaption>Gráfico de barras comparando as 4 habilidades mais bem pagas em todos os empregos versus empregos remotos; gerado a partir de resultados de queries SQL para destacar diferenças salariais por tipo de emprego.</figcaption>

#### Principais Insights Baseados nos Resultados:

- **Variação Salarial por Tipo de Emprego:**
Certas habilidades, como Kafka e Go, mostram salários médios significativamente mais altos em todos os empregos e empregos remotos, respectivamente. Isso indica que habilidades específicas são mais valorizadas dependendo do tipo de emprego.

- **Empregos Remotos Preferem Ferramentas Especializadas:**
Habilidades como Confluence e Hadoop aparecem de forma proeminente em empregos remotos, enfatizando a demanda por colaboração e ferramentas de processamento de dados em ambientes remotos.

- **Habilidades Bem Pagas em Comum:**
Snowflake é uma habilidade consistentemente bem remunerada em ambos os contextos, destacando seu valor universal em funções de análise de dados.

- **Frameworks Avançados em Todos os Empregos:**
Habilidades como Kafka e TensorFlow têm maior destaque em todos os empregos, sugerindo sua importância em projetos corporativos ou de análise local.

#### Resposta à Pergunta

As habilidades mais ótimas para aprender dependem de onde você deseja atuar: todos os empregos ou empregos remotos. Para todos os empregos, habilidades como Kafka, PyTorch e TensorFlow se destacam com altos salários e demanda. Em empregos remotos, habilidades como Go, Confluence e Hadoop lideram, destacando sua relevância em ambientes de trabalho flexíveis. No entanto, habilidades universalmente valiosas como Snowflake aparecem em ambos os contextos, tornando-se uma escolha forte para qualquer analista de dados que busca maximizar suas oportunidades.

## O Que Aprendi

Por meio deste projeto, aprofundei meu entendimento sobre o uso de SQL para analisar conjuntos de dados do mundo real. Alguns dos principais aprendizados incluem:

- Como escrever queries SQL complexas para extrair insights e responder perguntas de negócios.
- Técnicas para combinar conjuntos de dados utilizando **JOINs** e identificar relações significativas.
- A importância de filtrar e segmentar dados (por exemplo, empregos remotos vs. gerais) para análises mais focadas.
- Estruturar análises e resultados de forma clara e compreensível para diferentes públicos.

## Habilidades Praticadas

Este projeto me permitiu praticar e aprimorar as seguintes habilidades:

- **Proeficiência em SQL:** Escrever queries avançadas utilizando **JOIN**, **GROUP BY**, **HAVING** e **ORDER BY**.
- **Análise de Dados:** Identificar tendências e insights relacionados a salários e demanda por habilidades no mercado de trabalho.
- **Pensamento Crítico:** Interpretar os resultados das queries para gerar conclusões acionáveis.

## Conclusão

Esta análise destaca as habilidades e ferramentas críticas necessárias para o sucesso como analista de dados, tanto no mercado geral quanto em posições remotas. SQL permanece como a habilidade mais demandada e universalmente valorizada, enquanto ferramentas como Tableau, Power BI e Python são cruciais para lidar com visualização e análises avançadas. Salários altos estão associados a ferramentas especializadas como Kafka e TensorFlow, particularmente em cargos presenciais, enquanto posições remotas enfatizam colaboração e tecnologias de big data como Confluence e Hadoop. Ferramentas versáteis como Snowflake e Databricks preenchem a lacuna, oferecendo oportunidades em ambos os tipos de emprego.

### Insights:

- **SQL Lidera o Mercado:** A habilidade mais frequentemente demandada em todas as postagens de empregos, tornando-se fundamental para qualquer função de analista de dados.
- **Ferramentas de Visualização e Análise São Essenciais:** Tableau, Power BI e Python aparecem consistentemente, reforçando sua necessidade para storytelling de dados e cálculos avançados.
- **Frameworks Avançados Oferecem Salários Mais Altos:** Kafka, TensorFlow e PyTorch são altamente valorizados, recompensando a expertise em tecnologias de ponta.
- **Cargos Remotos Valorizam Colaboração e Escalabilidade:** Ferramentas como Confluence, Hadoop e Snowflake são mais prevalentes em empregos remotos, refletindo a necessidade de colaboração e processamento escalável de dados.
- **Habilidades Ideais para Aprender:** Snowflake e Databricks se destacam como habilidades universalmente valiosas, criando oportunidades em funções presenciais e remotas.

## Planos Futuros

- Adicionar e responder a mais perguntas relacionadas à análise de dados além das abordadas no vídeo.
- Otimizar e refinar queries para melhorar o desempenho.
- Explorar potenciais visualizações baseadas nos resultados da análise em SQL.

## Contato

Se tiver dúvidas ou feedback, sinta-se à vontade para entrar em contato:
[GitHub](https://github.com/faduzin) | [LinkedIn](https://www.linkedin.com/in/ericfadul/) | [eric.fadul@gmail.com](mailto:eric.fadul@gmail.com)