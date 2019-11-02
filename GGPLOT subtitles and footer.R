library(ggplot2) 
ggplot(diamonds, aes(carat, price, color = clarity)) + 
  geom_point() + 
  labs(title = "Diamonds are forever...", 
       subtitle = "Carat weight by Price", 
       caption = "caption goes here")
