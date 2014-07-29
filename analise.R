############### Análise dos IDH's por país de 1980 a 2013 #################

## Carregandos os pacotes necessários
library(xlsx)
library(plyr)
library(ggplot2)
library(reshape2)

## Lendo o conjutnos de dados
idh <- read.xlsx('IDH_1980_2013.xls', sheetIndex = 1)

## Lista dos países sem IDH no ano 2000 que constam na lista de 2013
sem_idh <- subset(x = idh, subset = is.na(X2000), select = 'Pais')
sem_idh

## Retirando os países sem IDH no ano 2000 e separando IDH 2000
idh_2000 <- subset(x=idh, subset = !is.na(X2000), select = c('Pais', 'X2000'))

## Retirando os países sem IDH no ano 2000 e separando IDH 2013
idh_2013 <- subset(x=idh, subset = !is.na(X2000), select = c('Pais', 'X2013'))

## Ordenando as duas listas pelo IDH
idh_2000 <- arrange(df = idh_2000, desc(X2000))
idh_2013 <- arrange(df = idh_2013, desc(X2013))

## Achando as posições do Brasil em cada tabela
which(idh_2000$Pais == 'Brazil')
which(idh_2013$Pais == 'Brazil')

## Incluindo uma variável com o cálculo das mudanças de IDH entre 2000 e 2013
idh$Change <- idh$X2013 - idh$X1980

## Rankeando pelas maiores mudanças de IDH entre 1980 e 2013
idh <- arrange(df = idh, desc(Change))

## O Brasil foi 22º País com maior variação do IDH. Vamos fazer um gráfico com IDH dos 5 primeiros mais o Brasil
## Preparação dos dados
idh_top <- idh[c(1:5, which(idh$Pais == 'Brazil')),]
idh_top <- idh_top[,-11]
idh_top <- melt(idh_top, id.vars = 'Pais')
colnames(idh_top) <- c('Pais', 'Ano', 'IDH')

## Gráfico
ggplot(data=idh_top, title='teste',aes(x = Ano, y = IDH, group = Pais, color = Pais)) +
  geom_point() + geom_line() + ggtitle('IDH vs Anos')

  
  
  


