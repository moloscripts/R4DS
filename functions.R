# basics

# Area & Circumfrence
cylinder <- function(r, h){
  # area <- pi*r*r
  # circumfrence <- 2*pi*r
  volume <- pi*r*r*h
  
  # return the outputs as vectors
  # return(c(area=area, circumfrence=circumfrence))
  
  # as a list
  # return(list(area=area, circumfrence=circumfrence))
  
  # as a df
  return(data.frame(area=area, circumfrence=circumfrence, volume=volume))
}
vl_df <- cylinder(r=4, h=10)

# Normalisaion
# Importance of Normalisation - https://stats.stackexchange.com/questions/152078/what-are-the-real-benefits-of-normalization-scaling-values-between-0-and-1-in

library(tidyverse)

data_frame <- tibble(
  c1 = rnorm(50, 5, 1.5),
  c2 = rnorm(50, 5, 1.5),
  c3 = rnorm(50, 5, 1.5)
)

# to normalise
data_frame$c1_norm <- (data_frame$c1 - min(data_frame$c1)) / (max(data_frame$c1) - min(data_frame$c1))
data_frame$c2_norm <- (data_frame$c2 - min(data_frame$c2)) / (max(data_frame$c2) - min(data_frame$c2))
data_frame$c3_norm <- (data_frame$c3 - min(data_frame$c3)) / (max(data_frame$c3) - min(data_frame$c3))

# In above, we're repeating the same code, 3 times. A function can do that
normalise <- function(x){
  re_scale <- x - min(x, na.rm = TRUE)/ (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
  return(re_scale)
}
data_frame_c1_rescaled <- normalise(data_frame$c1)

# PRACTICE
x <- (c(3.597, TRUE, na.rm = FALSE))
normalise(x)

# Calculate the variance (v)
variance <- function(y){
  n <- length(y)
  m <- mean(y)
  v = (1/(n-1)) * sum((y-m)^2)
  return(v)
}
y <- rnorm(20)
variance(y)

