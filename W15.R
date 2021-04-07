library(tidytuesdayR)
library(tidyverse)

# download data ----
df <- tt_load(2021, week = 15)

# get data ----
brazil_loss <- df$brazil_loss %>% 
  pivot_longer(commercial_crops:small_scale_clearing) %>% 
  mutate(value = value / 100000,
         name = str_replace_all(name, "_", " "),
         name = str_to_sentence(name))

# plot data ----
ggplot(brazil_loss, aes(x = year, y = value, fill = name)) + 
  geom_area() + 
  labs(title = "Brazilian forest area lost, by hundred of thousands of hectares",
       subtitle = "Deforestation for <span style='color:#F0C9AA'>pasture</span> 
       remains the largest driver of lost forest area, followed by 
       <span style='color:#E5A568'>small scale clearing</span>, <br>
       <span style='color:#EEC494'>selective logging</span>, 
       <span style='color:#899DA4'>commerical crops</span>, 
       <span style='color:#C23D20'>mining</span>, 
       <span style='color:#DC863B'>tree plantations including palm</span>, 
       <span style='color:#9C7D78'>fire</span>, 
       <span style='color:#F6E4C1'>roads</span>, 
       <span style='color:#D25838'>natural disturbances</span>, <br>
       <span style='color:#E19171'>other infrastructure</span>, and 
       <span style='color:#AF5D4C'>flooding due to dams</span>",
       x = "Year",
       y = "",
       fill = "") + 
  theme_minimal() + 
  theme(legend.position = "none",
        panel.grid = element_blank(),
        plot.background = element_rect("#FFFEF7"),
        plot.title.position = "plot",
        plot.title = element_text(lineheight = 1.5, size = 16),
        plot.subtitle = ggtext::element_markdown(lineheight = 1.2, size = 13),
        axis.text = element_text(size = 11),
        axis.title = element_text(size = 11)) + 
  scale_fill_manual(values = wesanderson::wes_palette("Royal1", 11, type = "continuous")) + 
  scale_x_continuous(breaks = seq(2001, 2013, 2))
