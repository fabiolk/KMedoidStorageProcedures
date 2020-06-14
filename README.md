# KMedoidStorageProcedures
 
 Trabalho realizado como parte da disciplina de banco de dados 2, onde tinha como exigencia ser implementado em storage procedures.
 
## Obejtivo
 Trabalho teve como objetivo implementar o algoritmo k-medoid com a intenção da identificação de grupos de espécies no dataset iris.
 
## Tabelas
* tabela para armazenar os dados do dataset iris
* a tabela para guardar dadso nosrmalizados
* tabela para guardar as id do centroid vindo da tabela iris

## Funções
* função para normalização do dataset
* função para escolher aleatoriamente uma tupla no dataset
* função para calcular a distancia da tupla escolhida para todas as outras tuplas
* soma de um ponto para todos os outros, a somatoria que resultar um menor valor será um próximo candidato para ser um centroid

# Chamadas de funções
* Chama a função para normalizar os dados
* Chama a função para gerar centroid, nela é passada como parâmetro a quantidade de centroid
* Chama a função que calcula a distância dos centroid escolhidos na função anterior para todos os outros, ou seja, em um dataset com 150 tuplas e 3 centroids será gerada 497 tuplas
* Chama uma função para gerar um primeiro cluster, ou seja, se foi escolhido três centroids será gerado 3 clusters, onde uma tupla fará parte de um determinado cluster caso a distancia dela seja menor comparada aos outros centroids
* Chama a função que calcula a distancia de todas para todas tuplas
* faz a soma para descobrir o proximo candidato a centrois pois apos fazer a somatoria a tupla que tiver menor valor de soma entre todas as outras significa que tem semelhanças logo fazem parte da mesma subespécie de iris
