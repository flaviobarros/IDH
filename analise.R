############### An�lise dos IDH's por pa�s de 1980 a 2013 #################

## Carregandos os pacotes necess�rios
library(xlsx)
library(plyr)
library(ggplot2)
library(reshape2)

## Lendo o conjutnos de dados
idh <- read.xlsx('IDH_1980_2013.xls', sheetIndex = 1)

## Lista dos pa�ses sem IDH no ano 2000 que constam na lista de 2013
sem_idh <- subset(x = idh, subset = is.na(X2000), select = 'Pais')
sem_idh

## Retirando os pa�ses sem IDH no ano 2000 e separando IDH 2000
idh_2000 <- subset(x=idh, subset = !is.na(X2000), select = c('Pais', 'X2000'))

## Retirando os pa�ses sem IDH no ano 2000 e separando IDH 2013
idh_2013 <- subset(x=idh, subset = !is.na(X2000), select = c('Pais', 'X2013'))

## Ordenando as duas listas pelo IDH
idh_2000 <- arrange(df = idh_2000, desc(X2000))
idh_2013 <- arrange(df = idh_2013, desc(X2013))

## Achando as posi��es do Brasil em cada tabela
which(idh_2000$Pais == 'Brazil')
which(idh_2013$Pais == 'Brazil')

## Incluindo uma vari�vel com o c�lculo das mudan�as de IDH entre 2000 e 2013
idh$Change <- idh$X2013 - idh$X1980

## Rankeando pelas maiores mudan�as de IDH entre 1980 e 2013
idh <- arrange(df = idh, desc(Change))

## O Brasil foi 22� Pa�s com maior varia��o do IDH. Vamos fazer um gr�fico com IDH dos 5 primeiros mais o Brasil
## Prepara��o dos dados
idh_top <- idh[c(1:5, which(idh$Pais == 'Brazil')),]
paises <- idh_top$Pais
idh_top <- idh_top[,-11]
idh_top <- as.data.frame(t(idh_top))
colnames(idh_top) <- paises

## Gr�fico
ggplot(data=idh_top, aes(x=rownames(idh_top))) +
  geom_point(aes(y = idh_top[,1:6], col = colnames(idh_top)))

  
  
  

