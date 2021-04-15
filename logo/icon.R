library(HistData)
library(tidyverse)
library(ggforce)
library(magick)

Nightingale %>% 
  filter(between(Date,as.Date("1854-04-01"),as.Date("1855-03-01"))) %>% 
  mutate(total = sqrt(1000*Disease/Army/pi),
         battle = sqrt(1000*(Wounds+Other)/Army/pi),
         Month = fct_inorder(as.factor(paste(Month,Year)))) %>% 
  select(Month,total,battle) %>%
  gather("cause","radius",2:3) %>% 
  mutate_at("radius",{function(.)./max(.)}) %>% 
  mutate(radius = ifelse(Month %in% c("Apr 1854","May 1854","Jun 1854"),
                         radius*1.4,radius)) %>% 
  ggplot(aes(x=Month,y=radius,fill=cause,order=cause)) + 
  geom_bar(stat="identity",position="identity",width=1,color="yellow",size=1.5) + 
  scale_fill_manual(values=c("red","black")) + 
  coord_polar(theta="x",start=-pi/2) + theme_void() + 
  theme(legend.position="none",
        line=element_blank(),rect=element_blank(),
        text=element_blank(),title=element_blank(),
        plot.background=element_rect(fill="yellow",colour="yellow"))
ggsave("coxcomb.svg",width=6,height=6)

ggplot() + 
  geom_regon(aes(x0=0,y0=0,r=1,sides=6,angle=0),fill="yellow",color="black",size=12) +
  coord_fixed(ratio=1) + theme_void()
ggsave("hex.svg",bg="transparent",width=6,height=6)

(hex = image_read("hex.svg",density=600))
(coxcomb = image_trim(image_transparent(image_read("coxcomb.svg",density=600),color="yellow")))
offset = paste0(sprintf("%+1d",as.numeric(round(c(-.03,.02)*image_info(coxcomb)[c(2,3)]))),collapse="")
( logo = image_composite(hex,coxcomb,gravity="Center",offset=offset) )

image_write(image_transparent(logo,color="white"),path="logo.png",format="png",density=1000)
