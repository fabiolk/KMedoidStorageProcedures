# KMedoidStorageProcedures
 
 Trabalho realizado como parte da disciplina de banco de dados 2, onde tinha como exigencia ser implementado em storage procedures.
 
## Obejtivo
 Trabalho teve como objetivo implementar o algoritmo k-medoid com a intenção da identificação de grupos de espécies no dataset iris.
 
## Principais Tabelas
* tabela para armazenar os dados do dataset iris
* tabela para guardar dados normalizados
* tabela para guardar as id do centroid vindo da tabela iris
* tabela para guardar as distancias dos centroids para todos os outros pontos
* uma outra tabela também intitula distância porém essa agora guardando as tuplas já com uma primeira identificação de cluster (ouve a necessidade da criação dessa nova tabela pois a outra tabela distancia seria usada novamente e não poderia ter a tag de cluster)

## Principais Funções
* função para normalização do dataset
* função para escolher aleatoriamente uma tupla no dataset para ser um centroid
* função para calcular a distancia da tupla de centroid escolhida para todas as outras tuplas
* função para aplicar um tag de cluster a partir das menores distancia calculadas na função anterior
* soma de um ponto para todos os outros, a somatoria que resultar um menor valor será um próximo candidato para ser um centroid

## Chamadas de funções
* Chama a função para normalizar os dados
* Chama a função para gerar centroid, nela é passada como parâmetro a quantidade de centroid
* Chama a função que calcula a distância dos centroid escolhidos na função anterior para todos os outros, ou seja, em um dataset com 150 tuplas e 3 centroids será gerada 497 tuplas
* Chama uma função para gerar um primeiro cluster, ou seja, se foi escolhido três centroids será gerado 3 clusters, onde uma tupla fará parte de um determinado cluster caso a distancia dela seja menor comparada aos outros centroids
* Chama a função que calcula a distancia de todas para todas tuplas
* faz a soma para descobrir o proximo candidato a centroid pois após fazer a somatória a tupla que tiver menor valor de soma entre todas as outras significa que tem semelhanças logo fazem parte da mesma subespécie de iris

## Melhorias
* Evitar repetição de tabelas e funções
* Fazer interação com usuário ao invéz de passagem de parâmetro direto pela função
* Implementação de convergencia da função e redução do erro quadrático
* Implementar visualização final por gráficos
