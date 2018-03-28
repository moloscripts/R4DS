library(tidyverse)
library(datasets)

# Rename  Columns for my ease. f_e = fuel efficiency
?mpg
col_new_names <- c("car","model","engine_displacement","year","cylinders","transmission","drv","f_e_city","f_e_highway","fuel_type","car_type")
colnames(mpg) <- col_new_names
View(mpg)

# Relationship btn displacement & fuel efficiency on the highway
ggplot(mpg) + geom_point(aes(x = engine_displacement, y = f_e_highway))
?geom_point

# Aesthetics
# Add a third dimension(color/size) to the scatter plot using other present variables in mpg
# Discrete variables/values is best represented with alpha aesthetic, visualising using transparency/?
# Shape aeshetic can accomodate at most 6 levels of observations

ggplot(mpg) + geom_point(aes(x = engine_displacement, y = f_e_highway), color = 'brown', stroke = 2)
ggplot(mpg) + geom_point(aes(x = engine_displacement, y = f_e_highway, color = car_type))
ggplot(mpg) + geom_point(aes(x = engine_displacement, y = f_e_highway, color = fuel_type))
ggplot(mpg) + geom_point(aes(x = engine_displacement, y = f_e_highway, color = car_type, alpha = fuel_type))
ggplot(mpg) + geom_point(aes(x = engine_displacement, y = f_e_highway, color = car_type, shape = fuel_type))

# Facets works best with categorical variables, creating subplots based on the various categories of the observations
ggplot(mpg) + geom_point(aes(x = engine_displacement, y = f_e_highway, color = fuel_type)) + facet_wrap(~car_type, nrow = 2)
ggplot(mpg) + geom_point(aes(x = engine_displacement, y = f_e_highway, color = fuel_type)) + facet_wrap(~transmission)
ggplot(mpg) + geom_point(aes(x = engine_displacement, y = f_e_highway, color = fuel_type)) + facet_wrap(~drv)

# Combine two categorical variables using facet_grid(variable plotted on row ~ variable plotted column)
ggplot(mpg) + geom_point(aes(x = engine_displacement, y = f_e_highway, color = fuel_type)) + facet_grid(drv ~ cylinders)
ggplot(mpg) + geom_point(aes(x = engine_displacement, y = f_e_highway, color = car_type)) + facet_grid(cylinders ~ .)

# Smooth geom()
# linetype aesthetic does not support many variables. group aesthetic doesn't have a legend

ggplot(mpg) + geom_smooth(aes(x = engine_displacement, y = f_e_highway))
ggplot(mpg) + geom_smooth(aes(x = engine_displacement, y = f_e_city, linetype = drv))
ggplot(mpg) + geom_smooth(aes(x= engine_displacement, y = f_e_city, group = drv))
ggplot(mpg) + geom_smooth(aes(x= engine_displacement, y = f_e_city, color = drv), show.legend = FALSE)

# Using multiple geoms in one plot
ggplot(mpg, aes(x = engine_displacement, y = f_e_city)) + geom_point(aes(color = drv)) + geom_smooth()
ggplot(mpg, aes(x = engine_displacement, y = f_e_city, color = drv)) + geom_point() + geom_smooth(se = FALSE)









