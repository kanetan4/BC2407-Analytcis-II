############################## Activity 1 ############################## 

# Question 1
"Confidence is measure of how often the consequent (second half of the question) 
is true, given that the antecedent (first half of the question) is also true. 
This measure is useful because a large value of Confidence means the rule is 
pointing to a strong association between the antecedent and the consequent"

"Also means the number of times that the if-then statement is true"

"eg. If there is a high value of confidence for Conf(X -> Y) = P(contains Y|contains X),
then there is a strong association that given that contains X, there is a high
chance that it contains Y, counting the number of times that if it contains X,
it also contains Y"

# Question 2
"Support is an indication of how frequently the combination of items appear in 
the dataset. How frequently certain combinations of items in both antecedent and 
consequent occur together in the data.

Higher Support means more occurences of both occuring at the same time"

# Question 3
"Lift is generated using Support and Confidence and is one of the major 
parameters to filter the generated rules.

Lift is a measure of how predictive the rule is compared to random associations.
Defined as the ratio of observe confidence to expected confidence. When lift is 
greater than 1, the resulting rule is better at predicting the result that a
random guess."

# Question 4
"The Apriori Algorithm calculates the number of occurences of a 1 item basket and
increases the number of items in the basket until the maximum. Counts the number of
occurence of each basket of items"

# Question 5


# Question 6


############################## Activity 2 ##############################\

# Question 1
library(data.table)
library(tidyr)
setwd('/Users/kane/Desktop/NTU BCG/Year 2 Sem 2/BC2407 Analytics II/BC2407 Course Materials/S3 Association Rules')
milk = fread('milk.csv')
View(milk)

# Create long data format, wide is default
milklong = melt(milk, na.rm = FALSE, id = 'ID')
View(milklong)
milklong2 <- subset(milklong,value == 1 )
View(milklong2)


# Generating long rules
write.table(milklong2, file = tmp <- file(), row.names = FALSE)
milklong3 <- read.transactions(tmp, format = "single", header = TRUE, cols = c("ID", "variable"))
View(milklong3)

milklong_rules <- apriori(data = milklong3, parameter = list(minlen = 2, supp=0.4, conf = 0.3, target = "rules"))
summary(milklong_rules)
milklong_rules2 <-inspect(sort(milklong_rules, by ="confidence"))


# Generating wide rules
milk_wide <- data.frame(lapply(milk,factor))
milk_wide <- milk_wide[,-1]
milk_wide_trans <- as(milk_wide,"transactions")

milk_wide_rules <- apriori(data = milk_wide_trans, parameter = list(minlen = 2, supp=0.4, conf = 0.3, target = "rules")) #supp 0.4, conf 0.3
summary(milk_wide_rules) #total 65 rules, many as expected of the data mining techinque, threshold settings

#Inspect top 3 rules by Lift 
inspect(head(milk_wide_rules, n = 3, by ="lift"))
#Inspect top 3 rules by Confidence
inspect(head(milk_widedata_rules, n = 3, by ="confidence"))

milk_widedata_ruletable <- inspect(milk_widedata_rules)

"It seems that using long data format, lesser set of association rules with the same support threshold
cause of difference is, long data format -> 0s are removed, therefore non-occurrence of a factor is NOT part of 
association rules when it could possibly be
Long data format only includes presence of a factor in the rule

As explained earlier, if absence of a factor is important to the company and absence of factor being part of rules
helpful, might be better to explore wide data format with categorical YES/NO. Eg Presence of bread and no milk =>butter."

############################## Activity 3 ############################## 
