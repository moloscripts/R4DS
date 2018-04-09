# st = Statistical Transformations
library(tidyverse)

# In the data diamonds, x = length in mm, y = width in mm, z = depth in mm
View(diamonds)
colnames(diamonds)

# Using stat in geom_bar generates the count of each of the variables
ggplot(diamonds, aes(cut)) + geom_bar()
ggplot(diamonds,aes(cut)) + stat_count()
str(diamonds)

#Stat Summaries
ggplot(diamonds, aes(depth)) + stat_bin(binwidth = 2)
ggplot(diamonds) + geom_bar(aes(cut, ..prop.., group = 1))
?stat_summary
# using stat_summary, for plotting various aggregates
ggplot(diamonds) + stat_summary(mapping =  aes(x=cut, y=depth),
                                fun.ymin = min,
                                fun.ymax = max,
                                fun.y = mean)

ggplot(diamonds, aes(clarity, depth)) + geom_point() + stat_summary(fun.y = "mean", 
                                                                    color = "red", 
                                                                    size = 4, geom = "point")


# Styling using color/fill aesthetics
diamonds
colnames(diamonds)
levels(diamonds$clarity)
levels(diamonds$cut)
ggplot(diamonds) + geom_bar(aes(x = cut, color = cut), show.legend = FALSE)
ggplot(diamonds) + geom_bar(aes(x = clarity, fill = clarity), show.legend = FALSE)

# Stacked Bar Chart
ggplot(diamonds) + geom_bar(aes(clarity, fill = cut))

# Stacking in bars is enabled by positional adjustment. If one doesn't want to visualise a stacked bar chart, the options, Identity, dodge or fill can be used too.
#Dodge is like split bar chart?
ggplot(diamonds, aes(cut, color = clarity)) +  geom_bar(fill = NA, position = 'identity')
ggplot(diamonds, aes(cut, color = clarity)) + geom_bar()

# Another representation
ggplot(diamonds) + geom_bar(aes(cut, fill = color), position = 'dodge')
