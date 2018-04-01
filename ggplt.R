library(tidyverse)
library(data.table)
data("diamonds")

# https://www3.nd.edu/~steve/computing_with_data/11_geom_examples/ggplot_examples.html

# CONVERT diamonds from DF to DT
setDT(diamonds)

#Due to the many rows, I'll analyse the Fair Diamonds  only
fair_diamonds = diamonds[cut=='Fair']
dim(fair_diamonds)
levels(fair_diamonds$color)
View(fair_diamonds)

# From this, one can say that green color diamonds that have the least size in carats, are the most expensive
# Smoothing layer shows the general trend of the data. in this, the smoothness has used the curves of the colors and showing the expensiveness
# A good way to compare and contrast multiple trends
# The gray area around the curve is the confidence interval - Level of uncertainity in the Smoothing Curve.
# Confidence interval - Range of Values so that there is a probability that the value of a parameter lies in tha
# se = FALSE <-  remove the confidence interval, method='lm' (linear model)<- draws the best fit straight line
# To remove the scatterplot layer, one removes  geom_point() function
# One can style the scatter plots using themes, just after the smoothing. 
# For Exponential, non-linear data, you might want to use a log scale scale_y_log10() or scale_x_log10()

# Facet wraping. Dividing the plots into multiple plots one for each level e.g. (key) 
# There are no pink VVS1 diamonds  
# For other options use the  + and look for functions

ggplot(fair_diamonds, aes(x = carat, price, color = color)) + geom_point() +geom_smooth(level=0.1)
ggplot(fair_diamonds, aes(x = carat, y = price, color = color)) + geom_point() +geom_smooth(se = FALSE) 
ggplot(fair_diamonds, aes(x = carat, y = price, color = color)) + geom_point() +geom_smooth(se = FALSE, method = 'lm')
ggplot(fair_diamonds, aes(x = carat, y = price, color = color)) + geom_smooth(level = 0.2) + theme_minimal()
ggplot(fair_diamonds, aes(x = carat, y = price, color = color)) + geom_point() + geom_smooth() + scale_x_log10()
ggplot(fair_diamonds, aes(x = carat, y = price, color = color)) + geom_smooth(level = 0.2) + theme_minimal() + ggtitle("Fair Cut Diamonds") + xlab('Weight (carats)') + ylab('Price ($)')
ggplot(fair_diamonds, aes(x = carat, y = price, color = color)) + geom_smooth(level = 0.1) + facet_wrap(~ clarity)

View(diamonds)
# Make it interactive. The Whole Diamonds Data Set
ggplot(diamonds, aes(x = carat, price, color=color)) + geom_point(aes(text = paste("Clarity: ", clarity)), size = 3) +
  facet_wrap(~ cut) + theme_minimal(base_size = 9) + geom_smooth(level = 0.3)

# Other Relationships e.g Distribution of the size of the diamonds 
ggplot(diamonds, aes(x = carat) ) + geom_histogram(binwidth = 0.04, aes(fill = color)) +scale_x_continuous(limits = c(0,3))
ggplot(fair_diamonds, aes(x = carat)) + geom_histogram(binwidth = 0.05)
ggplot(fair_diamonds, aes(x = carat)) + geom_density()

pcarat <- ggplot(fair_diamonds, aes(x=carat))
pcarat + geom_density()