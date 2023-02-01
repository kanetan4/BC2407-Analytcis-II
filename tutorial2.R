library(data.table)
setwd('/Users/kane/Desktop/NTU BCG/Year 2 Sem 2/BC2407 Analytics II/BC2407 Course Materials/S2 Review of Basic Analytics')

flat = fread('resale-flat-prices-2019.csv')
flat$flat_type = factor(flat$flat_type)

