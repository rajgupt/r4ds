# transform
library(tidyverse)
library(nycflights13)

str(flights)
colnames(flights)

## FILTER

# filter by multiple conditions
filter(flights, month == 1, day == 1)


# multi comparison filter
filter(flights, month == 1 | month == 2, day == 1)
# OR
filter(flights, month %in% c(1,2), day == 1)

# arrival delay 2 or more hrs
filter(flights, arr_delay >= 2)

# flew to IAH or HOU
filter(flights, dest %in% c("IAH", "HOU"))

# Operated by United, AMerican, Delta
filter(flights, carrier %in% c("UA", "AA", "DA"))

# arrived two hour late but didnt leave late
filter(flights, arr_delay >= 2, dep_delay == 0)

## ARRANGE

arrange(flights, desc(arr_delay))

# note: missing values are always sorted at end
df = tibble(x = c(5,2,NA))
arrange(df,x)
arrange(df,desc(x))

## SELECT

# select the listed column
select(flights, year, month, day)

# select the columns except the columns mentioned
select(flights, -c(year,day))
select(flights, -(year:day))

## RENAME

rename(flights, tail_num = tailnum)

## MUTATE

flights_sml = select(flights, 
                     year:day,
                     ends_with('delay'),
                    distance,air_time)
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60)

# if you want only new variables use trnasmute
transmute(flights_sml,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours)

# summarise
summarise(flights, 
          avg_dep_delay = mean(dep_delay, na.rm = TRUE),
          avg_arr_delay = mean(arr_delay, na.rm = TRUE))

by_month = group_by(flights, year, month)
summarise(by_month,
          monthly_avg_dep_delay = mean(dep_delay,na.rm=TRUE))


# Combining multiple options

# We want to explore relationship between 
# distance and avg delay for each location

by_dest = group_by(flights, dest)
delay = summarise(by_dest,
                  count = n(),
                  dist = mean(distance, na.rm=TRUE),
                  delay = mean(arr_delay, na.rm=TRUE))
delay = filter(delay, count > 20, dest != "HNL")

ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)
