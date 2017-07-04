# R for Data Science

library(tidyverse)
mpg

# scatter between displ and hwy
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy))


# scatter with color by class
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, color = class))

# scatter with size by class
ggplot(data = mpg) +
geom_point(mapping = aes(x=displ, y=hwy, size = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, alpha = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
# dev.off()

