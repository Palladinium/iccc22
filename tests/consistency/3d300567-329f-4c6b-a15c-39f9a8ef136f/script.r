data <- read.csv("data.csv", header=T)
data_a <- data$consistency_low
data_b <- data$consistency_high

out <- t.test(data_a, data_b, paired=TRUE, alternative="two.sided")
out

library(broom)

write.csv(tidy(out), "out.csv")