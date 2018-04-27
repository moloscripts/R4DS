# dt = Data Transformations
# Process of transoforming your data to suite the form/shape you need for analysis and visualisations
# Transformation will be done using dplyr package

# install.packages('nycflights13')
# nycflights13::flights contains 336,776 flights that departed from NYC in 2013

library(tidyverse)
library(dplyr)
library(nycflights13)
nycflights13::flights
View(flights)
colnames(flights)
str(flights)
dim(flights)

# filter
# Flights that departed either in November or in December
jan1 <- filter(flights, month==1, day == 1)
filter(flights, month==11 | month ==12)
filter(flights, month %in% c(11,12))

# To find flights that weren’t delayed (on arrival or departure) by more than two hours
filter(flights, !(arr_delay > 120 | dep_delay>120))
filter(flights, arr_delay<=120 & dep_delay<=120)

filter(flights, arr_delay >= 120)
filter(flights, dest == 'IAH' | dest == 'HOU')
filter(flights, carrier == 'UA' | carrier =='AA' | carrier == 'DL')
filter(flights, month == c(7:9))
filter(flights, arr_delay > 120 & dep_delay<=0)
filter(flights, dep_delay >= 120 )
filter(flights, !dep_delay >= 120 )
# filter(flights, time_hour == c("2013-12-31 23:00:00":"2013-01-01 06:00:00"))
# flights %>% filter(between(date, as.Date('2013-12-31 23:00:00'), as.Date('2013-01-01 06:00:00')))
filter(flights, is.na(flights$dep_time))
filter(flights, is.na(dep_time))

# arrange & select
arrange(flights, year, desc(month), day)
arrange(flights, desc(is.na(dep_time)))
arrange(flights, desc(dep_delay))
select(flights, year, month, day)


# Select columns that end with "delay"
flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time)
mutate(flights_sml,
       gain = arr_delay-dep_delay,
       speed_in_mins = distance/air_time * 60,
       hours = air_time / 60,
       gain_per_hr = gain/hours)

flights_gains <- transmute(flights_sml,
       gain = arr_delay-dep_delay,
       speed_in_mins = distance/air_time * 60,
       hours = air_time / 60,
       gain_per_hr = gain/hours)
View(flights_gains)

by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))
by_day


# relationship between the distance and average delay for each location.
del <- flights %>%
  group_by(dest) %>%
  summarise(
            count = n(),
            dist = mean(distance, na.rm = TRUE),
            delay = mean(arr_delay, na.rm = TRUE))

delayy <- filter(del, count>20, dest != 'HNL')
ggplot(delayy, aes(x=dist, y=delay)) + geom_point(aes(size=count), alpha = 1/3) + geom_smooth(se=FALSE)

# Cancelled & Not Cancelled Flights
canclled <- flights %>%
  filter(is.na(dep_time),is.na(arr_time))
not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))

# Planes that have the highest average delays, identified by tail number
delays <- not_cancelled %>%
  group_by(tailnum)%>%
  summarise(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )
View(delays)
ggplot(delays, aes(x=delay)) + geom_freqpoly(binwidth = 10)
ggplot(delays, aes(x = n, y = delay)) + geom_point()

# Much greater variation in the delays when there are a few flights.Whenever you plot a mean (other summary) vs the group size, variation decreases as the sample size increases.
ggplot(delays, aes(x = n, y = delay)) + geom_point(alpha = 1/10)

# Counting the Distinct Values
# Which destinations have the most carriers?

# Group By Destination
# Summarise the unique carriers in each of the destinations and return their counts
# arrange the unique carriers in descending order. 
carriers_dest <- not_cancelled %>%
  group_by(dest) %>%
  summarise(carrier = n_distinct(carrier)) %>%
  arrange(desc(carrier))
View(carriers_dest)

by_origin <- not_cancelled %>%
  group_by(origin) %>%
  tally()
View(by_origin)

