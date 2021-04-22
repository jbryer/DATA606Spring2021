poverty <- read.table("https://raw.githubusercontent.com/jbryer/DATA606Spring2021/master/course_data/poverty.txt", h = T, sep = "\t")
names(poverty) <- c("state", "metro_res", "white", "hs_grad", "poverty", "female_house")
poverty <- poverty[,c(1,5,2,3,4,6)]
head(poverty)

# Sample size
n <- nrow(poverty)
# Total variance for the outcome variable
SSy <- sum((poverty$poverty - mean(poverty$poverty))^2)

# Start with one predictor
lm.out1 <- lm(poverty ~ female_house, data = poverty)
summary(lm.out1)
anova(lm.out1)
# Note that F-statistic is the same summary(lm.out1).
# From the ANOVA output, it is the ratio of mean square model
# (i.e. female_house here) to mean square error/residual.
132.568 / 7.095

# However, this only works with one predictor.
SSresid <- sum(lm.out1$residuals^2)
SSmodel <- SSy - SSresid
k <- length(lm.out1$coefficients) - 1
((SSmodel) / k) / (SSresid / (n - (k + 1)))


lm.out2 <- lm(poverty ~ female_house + white, data = poverty)
summary(lm.out2)
anova(lm.out2)

# How is the F-Statistic calculated
# Ho: All coefficients are zero
# Ha: At least one coefficient is nonzero
n <- nrow(poverty)
SSresid <- sum(lm.out2$residuals^2)
SSy <- sum((poverty$poverty - mean(poverty$poverty))^2)
SSmodel <- SSy - SSresid
k <- length(lm.out2$coefficients) - 1
((SSmodel) / k) / (SSresid / (n - (k + 1)))
