library(tidyverse)

mpg
?mpg

cars
?cars

View(mpg)

head(cars, 4)
tail(cars)

ggplot(data=mpg) + geom_point(mapping=aes (x=displ, y=hwy))
#geom is how the data is displayed, aes is what is displayed 

ggplot(data=mpg) #doesn't run anything

ggplot(data=mpg)+ geom_point(mapping=aes (x=cyl, y=hwy))

ggplot(data=mpg)+ geom_point(mapping=aes (x=class, y=drv))
#All the points are on top of each other

ggplot(data=mpg) + geom_point(mapping=aes (x=displ, y=hwy, color=class, size=cyl))
#Changes color and size based on variables, based on preset colors and sizes. 

ggplot(data=mpg) + geom_point(mapping=aes (x=displ, y=hwy, color=class, size=cyl), shape=1)
#Makes it an open circle

?geom_point
#gives info about what options you can use

ggplot(data=mpg)+ 
  geom_point(mapping=aes (x=cyl, y=hwy, color=year))

ggplot(data=mpg)+ 
  geom_point(mapping=aes (x=cyl, y=hwy),color="blue")
#color needs to be outside of the aes brackets in order to change all the data points 

ggplot(data=mpg) + 
  geom_point(mapping=aes (x=displ, y=hwy, color=class, size=cyl), shape=1) +
  geom_smooth(mapping = aes(x=displ, y=hwy))
#Every geom layer should be on a new line, geom_smooth adds a trendline 

ggplot(data=mpg, mapping = aes(x=displ, y=hwy)) + 
  geom_point(mapping=aes (color=class, size=cyl), shape=1) +
  geom_smooth()+
  facet_wrap(~year, nrow=2)+ 
  theme_classic()
#Moving mqpping to the ggplot level makes x=displ and y=hw the default
# the facet wrap function splits the data based on year 
#Make sure to add + for every layer 

ggsave(filename = "MPG Plot 2.png", width = 8, height = 4)

#You could also just have the file name first because it is the first argument 
# expected and it expects the first plot