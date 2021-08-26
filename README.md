# KMedoidStorageProcedures
 
 Trabalho realizado como parte da disciplina de banco de dados 2, tinha como exigência ser implementado em storage procedures.
 
## Objetivo

 Implementar o algoritmo k-medoid com a intenção de identificar grupos de espécies no dataset iris.
 
## Principais Tabelas
* Tabela para armazenar os dados do dataset iris
* Guardar dados normalizados
* Guardar as id dos centroid vindo da tabela iris
* Guardar as distâncias dos centroids para todos os outros pontos
* Tabela intitulada distância, que guarda as tuplas já com uma primeira identificação de cluster (houve a necessidade da criação dessa nova tabela pois a outra tabela distância seria usada novamente e não poderia ter a tag de cluster)

## Principais Funções
* Função para normalização do dataset
* Escolher aleatoriamente uma tupla no dataset para ser um centroid
* Calcular a distância da tupla de centroid escolhida para todas as outras tuplas
* Aplicar um tag de cluster a partir das menores distância calculadas na função anterior
* Soma de um ponto para todos os outros, a somatória que resultar em menor valor será um próximo candidato para ser um centroid

## Chamadas de funções
* Chama a função para normalizar os dados
* Gerar centroid, nela é passada como parâmetro a quantidade de centroidS
* Calcula a distância dos centroid escolhidos na função anterior para todos os outros, ou seja, em um dataset com 150 tuplas e 3 centroids será gerada 497 tuplas
* Gerar um primeiro cluster, ou seja, se foi escolhido três centroids será gerado 3 clusters, onde uma tupla fará parte de um determinado cluster caso a distância dela seja menor comparada aos outros centroids
* Calcula a distância de todas para todas tuplas
* Faz a soma para descobrir o próximo candidato a centroid, pois após fazer a somatória a tupla que tiver menor valor de soma entre todas as outras mostra que tem semelhanças. Logo fazem parte da mesma subespécie de iris

## Melhorias
* Evitar repetição de tabelas e funções
* Fazer interação com usuário ao invés de passagem de parâmetro direto pela função
* Implementação de convergência da função e redução do erro quadrático
* Implementar visualização final por gráficos

