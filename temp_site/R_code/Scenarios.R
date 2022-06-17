library(readxl)
library(readr)
library(ggplot2)
library(plyr)
library(dplyr)
library(cowplot)
library(tidyverse)
library(FSA)
library(lattice)
library(effects)
library(lubridate)
library(zoo)
library(svglite)

theme_set(
  theme_classic() +
  theme(legend.position = "none", 
        legend.title = element_blank(),
        panel.grid.major.y = element_line(),
        text = element_text(family = "Times New Roman"),
        plot.title = element_text(face="bold"),
        axis.title.x = element_blank(),
        axis.title.y = element_blank())
  )
g_theme <- scale_color_manual(values=c('#ff0000','#D8D8D8'))
myred <- '#ff0000'
mygrey <- '#b4b4b4'
#height and width of graphs
w <- 5.2
h <- 6

# Réalité ---------------------------------------------------------------
#source https://www.data.gouv.fr/fr/datasets/donnees-hospitalieres-relatives-a-lepidemie-de-covid-19/
data_gouv_new_hosp_rea <- read.csv(url("https://www.data.gouv.fr/fr/datasets/r/6fadff46-9efd-4c53-942a-54aca783c30c"), sep=";") %>%
  mutate(date = as.Date(jour))
data_gouv_beds_hosp_rea <- read.csv(url("https://www.data.gouv.fr/fr/datasets/r/63352e38-d353-4b54-bfd1-f1b3ee1cabd7"), sep=";")  %>%
  mutate(date = as.Date(jour))

#Lits occupés en réanimation, hospitalisation et hospitalisation conventionnelle
true_data_beds_hosp_rea <- data_gouv_beds_hosp_rea %>%
  filter(sexe =="0", # 0 = hommes + femmes, 1=hommes, 2=femmes
         #enlève l'Outre-Mer car les scénarios de Pasteur uniquement pour la France Métropolitaine
         dep != 971 & dep != 972 & dep != 973 & dep != 974 & dep != 976 & dep != 978) %>%
  group_by(date) %>% #grouper tous les départements ensembles
  dplyr::summarise(hosp = sum(hosp, na.rm = T), 
            rea = sum(rea, na.rm = T),
            HospConv = sum(HospConv, na.rm = T))

#pour les echos pasteur 29 avril ile de france
true_data_beds_hosp_rea_IDF <- data_gouv_beds_hosp_rea %>%
  filter(sexe =="0", # 0 = hommes + femmes, 1=hommes, 2=femmes
         #enlève l'Outre-Mer car les scénarios de Pasteur uniquement pour la France Métropolitaine
         dep == 75 | dep == 92 | dep == 93 | dep == 94 | dep == 91 | dep == 95 | dep == 78 | dep == 77) %>% 
  group_by(date) %>% #grouper tous les départements ensembles
  dplyr::summarise(hosp = sum(hosp, na.rm = T), 
            rea = sum(rea, na.rm = T),
            HospConv = sum(HospConv, na.rm = T))

#Nouvelles admissions à l'hôpital et en réanimation (moyenné sur 7 jours)
true_data_new_hosp_rea <- data_gouv_new_hosp_rea %>% 
  filter( #enlève l'Outre-Mer car les scénarios de Pasteur uniquement pour la France Métropolitaine
         dep != 971 & dep != 972 & dep != 973 & dep != 974 & dep != 976 & dep != 978) %>% 
  group_by(date) %>% #grouper tous les départements ensembles
  dplyr::summarise(incid_hosp = sum(incid_hosp, na.rm = T), 
            incid_rea = sum(incid_rea, na.rm = T)) %>%
  mutate(new_rea_right = rollmean(incid_rea, 7, na.pad = T, align = "right"),#mean of 7 last days
         new_hosp_right = rollmean(incid_hosp, 7, na.pad = T, align = "right"),
         new_rea_center = rollmean(incid_rea, 7, na.pad = T, align = "center"),#centered mean
         new_hosp_center = rollmean(incid_hosp, 7, na.pad = T, align = "center"))

true_data_new_hosp_rea_no_mean <- data_gouv_new_hosp_rea %>% 
  filter( #enlève l'Outre-Mer car les scénarios de Pasteur uniquement pour la France Métropolitaine
    dep != 971 & dep != 972 & dep != 973 & dep != 974 & dep != 976 & dep != 978) %>% 
  group_by(date) %>% #grouper tous les départements ensembles
  dplyr::summarise(new_hosp = sum(incid_hosp, na.rm = T), 
            new_rea = sum(incid_rea, na.rm = T))

#Pour l'INSERM : admissions hebdomadaire à l'hôpital
true_data_new_hosp_rea_weekly <- data_gouv_new_hosp_rea %>% 
  group_by(date) %>% #je n'ai pas filtré les outre-mer ici car pas précisé, mais ne change pas grand-chose
  dplyr::summarise(incid_hosp = sum(incid_hosp, na.rm = T)) %>%
  mutate(new_hosp_week = rollsum(incid_hosp, 7, na.pad = T, align = "left")) #patients arrivés dans les 7 derniers jours)



# Avril 29 2020 Pasteur ---------------------------------------------------

#reanimation
scenario <- read.csv("2020_04_29_Pasteur/beds_rea.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))

g <- scenario %>%
  gather(key=scenarios, value = value, -date) %>%
  ggplot(aes(date, value, group=scenarios, color="scénarios")) + geom_smooth(se=F) + 
  geom_line(data= true_data_beds_hosp_rea_IDF, 
            aes(x=date, y=rea, color = "réalité", group="réalité"), size=1) +
  annotate('text', x = as.Date("2020-03-27"), y = 500, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  annotate('text', x = as.Date("2020-06-01"), y = 1500, label = "scénarios", color = mygrey, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2020-03-19"), date("2020-06-28")) + g_theme +
  labs(title = "Lits de réanimation en Ile-de-France",
       subtitle = "scénarios non publiés de l'Institut Pasteur \n",
       caption = "\nSource: non publié mais retranscrit dans Les Echos le 29 avril 2020\n'Malades : les premières prévisions pour fin juin'
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2020_Avril/Pasteur_2020_Avril_reanimations.png", 
       plot =g, width = w, height = h) 
ggsave("../images/Pasteur_2020_Avril/Pasteur_2020_Avril_reanimations.svg", 
       plot =g, width = w, height = h) 
#hospitalisation conventionnelle : les données d'hospitalisation conventionnelle ne commencent qu'en 2021 : voir si on peut les chopper
# scenario <- read.csv("2020_04_29_Pasteur/beds_hosp_conv.csv", sep=";") %>%
#   mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
# 
# scenario %>%
#   gather(key=scenarios, value = value, -date) %>%
#   ggplot(aes(date, value, group=scenarios, color="scénarios")) + geom_smooth(se=F) + 
#   geom_line(data= true_data_beds_hosp_rea_IDF, 
#             aes(x=date, y=HospConv, color = "réalité", group="réalité"), size=1) +
#   # annotate('text', x = as.Date("2021-07-20"), y = 1200, label = "réalité", color = myred, fontface = "bold",
#   #          family = "Times New Roman") + 
#   # annotate('text', x = as.Date("2021-08-20"), y = 5800, label = "scénarios", color = mygrey, fontface = "bold",
#   #          family = "Times New Roman") +
#   xlim(date("2020-03-19"), date("2020-06-28")) + g_theme +
#   labs(title = "Lits de soins critiques",
#        subtitle = "scénarios non publiés de l'Institut Pasteur, retranscrit dans les Echos le 29 avril 2020\n",
#        caption = "\nSource: Les Echos \nhttps://www.lesechos.fr/idees-debats/editos-analyses/pourquoi-philippe-a-douche-les-francais-1199309")


# September 25, 2020 ------------------------------------------------------
# scenario <- read.csv("2020_09_25_Pasteur/beds_rea.csv", sep=";") %>%
#   mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
# 
# #patients en réanimation
# g <- scenario %>%
#   gather(key=pasteur, value = value, -date) %>%
#   ggplot(aes(date, value, group=pasteur, color="scénarios")) + geom_smooth(se=F) + 
#   geom_line(data= true_data_beds_hosp_rea, 
#             aes(x=date, y=rea, color = "réalité", group="réalité"), size = 1) +
#   #see dates of partial curfew + 2 weeks after (time to see the effects on reanimations) cf dates https://fr.wikipedia.org/wiki/Chronologie_de_la_pand%C3%A9mie_de_Covid-19_en_France
#   geom_vline(xintercept = as.Date("2020-10-14"), linetype = "dashed", alpha=.5) + 
#   geom_vline(xintercept = as.Date("2020-10-28"), linetype = "dashed", alpha=.5) +
#   xlim(as.Date("2020-09-25"), as.Date("2020-11-01"))  + g_theme +
#   labs(title = "Lits de réanimation occupés",
#        subtitle = "scénarios publiés par l'Institut Pasteur le 25 septembre 2020",
#        caption = "Source")
# ggsave("../images/Pasteur_2020_Octobre/Pasteur_octobre_reanimations.png", 
#        plot =g, width = w, height = h)

# October 30, 2020 --------------------------------------------------------

#Lits de réanimation
scenario <- read.csv("2020_10_30_Pasteur/beds_rea.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value-200, group=pasteur, color="scénarios")) + geom_smooth(se=F) + 
  geom_line(data= true_data_beds_hosp_rea, 
            aes(x=date, y=rea, color = "réalité", group="true data"), size = 1) +
  annotate('text', x = as.Date("2020-10-18"), y = 1400, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2020-11-10"), y = 7000, label = "scénarios", color = mygrey, fontface = "bold",
           family = "Times New Roman") + 
  xlim(as.Date("2020-10-15"), as.Date("2020-12-10")) + g_theme  +
  labs(title = "Lits de réanimation occupés",
       subtitle = "scénarios de l'Institut Pasteur du 30/10/2020 après l'annonce du confinement \n",
       caption = "\nSource: non publié mais retranscrit dans Les Echos le 3 novembre \n'Covid : la décrue dans les servies de réanimation espérée en France dans une dizaine de jours'
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2020_Novembre/Pasteur_novembre_reanimations.png", 
       plot =g, width = w, height = h) 
ggsave("../images/Pasteur_2020_Novembre/Pasteur_novembre_reanimations.svg", 
       plot =g, width = w, height = h) 

#Admissions en réanimation
scenario <- read.csv("2020_10_30_Pasteur/new_rea.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value-30, group=pasteur, color="scénarios")) + geom_smooth(se=F) +
  geom_line(data= true_data_new_hosp_rea, 
            aes(x=date, y=new_rea_center, color = "réalité", group="réalité"), size = 1) +
  annotate('text', x = as.Date("2020-10-18"), y = 170, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2020-10-28"), y = 500, label = "scénarios", color = mygrey, fontface = "bold",
           family = "Times New Roman") + 
  xlim(as.Date("2020-10-15"), as.Date("2020-12-10")) + g_theme +
  labs(title = "Admissions en réanimations",
       subtitle = "scénarios de l'Institut Pasteur du 30/10/2020 après l'annonce du confinement\n",
       caption = "\nSource:  non publié mais retranscrit dans Les Echos le 3 novembre \n'Covid : la décrue dans les servies de réanimation espérée en France dans une dizaine de jours'
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2020_Novembre/Pasteur_novembre_new_reanimations.png", 
       plot =g, width = w, height = h)
ggsave("../images/Pasteur_2020_Novembre/Pasteur_novembre_new_reanimations.svg", 
       plot =g, width = w, height = h)

#media graph
media <- read.csv("medias.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T)) %>%
  filter(rapport == "Pasteur 30 octobre")
g <- ggplot(media) + 
  geom_jitter(aes(date, chiffres, color = "relayé par la presse"), size = 1.5, width = 3, height = 200) +
  geom_line(data= true_data_beds_hosp_rea, 
            aes(x=date, y=rea, color = "réalité", group="true data"), size = 1) +
  geom_hline(yintercept = 9000, linetype = "dashed", alpha=.5) +
  annotate('text', x = as.Date("2020-10-18"), y = 1400, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate("text", x=as.Date("2020-12-30"), y=9800, 
           label="'Nous savons que quoi que nous fassions, près de \n9000 patients seront en réanimation à la mi-novembre'
           Emmanuel Macron, discours du 28 octobre",
           fontface = "italic", size=3, hjust=1) + ylim(0,10500) +
  xlim(as.Date("2020-10-15"), as.Date("2020-12-30")) + g_theme +
  labs(title = "Lits de réanimation occupés",
       subtitle = "Chaque point représente une projection relayée par la presse \nLa ligne horizontale correspond à la citation d'Emmanuel Macron\n",
       caption = "")
ggsave("../images/media/media_novembre.png", plot =g, width = w, height = h)
ggsave("../images/media/media_novembre.svg", plot =g, width = w, height = h)




# January 12 Conseil Scientifique -----------------------------------------
#Lits de réanimation

#SC 12
scenario <- read.csv("2021_01_12_Conseil_Scientifique/beds_SC_12.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value-200, group=pasteur, color="scénarios")) + geom_smooth(se=F) + 
  geom_line(data= true_data_beds_hosp_rea %>% filter(date < as.Date("2021-03-27")), 
            aes(x=date, y=rea, color = "réalité", group="true data"), size = 1) +
  annotate('text', x = as.Date("2020-10-18"), y = 1400, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2020-11-10"), y = 7000, label = "scénarios", color = mygrey, fontface = "bold",
           family = "Times New Roman") + 
  xlim(as.Date("2021-01-01"), as.Date("2021-05-01")) + ylim (0, 15000) + g_theme  +
  labs(title = "Lits de réanimation occupés, R = 1.2",
       subtitle = "Conseil Scientifique rapport 12 janvier \n",
       caption = "\nSource: Conseil Scientifique rapport 12 janvier \n
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2020_Novembre/Pasteur_novembre_reanimations.png", 
       plot =g, width = w, height = h) 
ggsave("../images/Pasteur_2020_Novembre/Pasteur_novembre_reanimations.svg", 
       plot =g, width = w, height = h) 

#SC 15
scenario <- read.csv("2021_01_12_Conseil_Scientifique/beds_SC_15.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value-200, group=pasteur, color="scénarios")) + geom_smooth(se=F) + 
  geom_line(data= true_data_beds_hosp_rea %>% filter(date < as.Date("2021-03-27")), 
            aes(x=date, y=rea, color = "réalité", group="true data"), size = 1) +
  annotate('text', x = as.Date("2020-10-18"), y = 1400, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2020-11-10"), y = 7000, label = "scénarios", color = mygrey, fontface = "bold",
           family = "Times New Roman") + 
  xlim(as.Date("2021-01-01"), as.Date("2021-05-01")) + ylim (0, 40000) + g_theme  +
  labs(title = "Lits de réanimation occupés, R = 1.5",
       subtitle = "Conseil Scientifique rapport 12 janvier \n",
       caption = "\nSource: Conseil Scientifique rapport 12 janvier \n
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2020_Novembre/Pasteur_novembre_reanimations.png", 
       plot =g, width = w, height = h) 
ggsave("../images/Pasteur_2020_Novembre/Pasteur_novembre_reanimations.svg", 
       plot =g, width = w, height = h) 





# Jan/Feb 2021, INSERM -----------------------------------------------
#problème : au calibrage sur les données témoins, les données gouvernementales
#sont plus élevées que celles de l'INSERM d'environ 1700 : on rajoute un offset 

#16 janvier
scenario <- read.csv("2021_01_16_INSERM/weekly_hospital.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=scenario, value = value, -date) %>%
  ggplot(aes(date, value+1700, group=scenario, color="scénarios")) + geom_smooth(se=F) +
  geom_line(data= true_data_new_hosp_rea_weekly, 
            aes(x=date, y=new_hosp_week, color = "réalité", group="true data"), size = 1) +
  annotate('text', x = as.Date("2021-01-05"), y = 7000, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-02-01"), y = 25000, label = "scénarios", color = mygrey, fontface = "bold",
           family = "Times New Roman") + 
  #confinement de 16 départements le 20 mars cf https://fr.wikipedia.org/wiki/Chronologie_de_la_pand%C3%A9mie_de_Covid-19_en_France
  #2 semaines pour voir les effets sur hospitalisations. correspond aussi au confinement général du 3 avril
  xlim(date("2021-01-01"), date("2021-03-27")) + g_theme +
  labs(title = "Nombre hebdomadaire d'admission à l'hôpital",
       subtitle = "scénarios publiés par l'INSERM le 16 janvier 2021\n",
       caption = "\nSource: rapport #26 de l'INSERM \nwww.epicx-lab.com/covid-19.html
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/INSERM/INSERM_16_janvier.png", 
       plot =g, width = w, height = h)
ggsave("../images/INSERM/INSERM_16_janvier.svg", 
       plot =g, width = w, height = h)

#2 février
scenario <- read.csv("2021_02_02_INSERM/new_hosp_INSERM.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=scenario, value = value, -date) %>%
  ggplot(aes(date, value+1700, group=scenario, color="scenarios")) + geom_smooth(se=F) +
  geom_line(data= true_data_new_hosp_rea_weekly, 
            aes(x=date, y=new_hosp_week, color = "réalité", group="réalité"), size = 1) +
  annotate('text', x = as.Date("2021-01-05"), y = 7000, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-02-15"), y = 25000, label = "scénarios", color = mygrey, fontface = "bold",
           family = "Times New Roman") + 
  #confinement de 16 départements le 20 mars cf https://fr.wikipedia.org/wiki/Chronologie_de_la_pand%C3%A9mie_de_Covid-19_en_France
  #2 semaines pour voir les effets sur hospitalisations. correspond aussi au confinement général du 3 avril
  xlim(date("2021-01-01"), date("2021-03-27")) + g_theme +
  labs(title = "Nombre hebdomadaire d'admission à l'hôpital",
       subtitle = "scénarios publiés par l'INSERM le 2 février 2021\n",
       caption = "\nSource: rapport #28 de l'INSERM \nwww.epicx-lab.com/covid-19.html
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/INSERM/INSERM_02_février.png", 
       plot =g, width = w, height = h)
ggsave("../images/INSERM/INSERM_02_février.svg", 
       plot =g, width = w, height = h)

#14 février
scenario <- read.csv("2021_02_14_INSERM/weekly_hospital.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=scenario, value = value, -date) %>%
  ggplot(aes(date, value+1700, group=scenario, color="scénarios")) + geom_smooth(se=F) +
  geom_line(data= true_data_new_hosp_rea_weekly, 
            aes(x=date, y=new_hosp_week, color = "réalité", group="réalité"), size = 1) +
  annotate('text', x = as.Date("2021-01-05"), y = 7000, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-02-27"), y = 25000, label = "scénarios", color = mygrey, fontface = "bold",
           family = "Times New Roman") + 
  #confinement de 16 départements le 20 mars cf https://fr.wikipedia.org/wiki/Chronologie_de_la_pand%C3%A9mie_de_Covid-19_en_France
  #2 semaines pour voir les effets sur hospitalisations. correspond aussi au confinement général du 3 avril
  xlim(date("2021-01-01"), date("2021-03-27")) + g_theme +
  labs(title = "Nombre hebdomadaire d'admission à l'hôpital",
       subtitle = "scénarios publiés par l'INSERM le 14 février 2021\n",
       caption = "\nSource: rapport #29 de l'INSERM \nwww.epicx-lab.com/covid-19.html
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/INSERM/INSERM_14_février.png", 
       plot =g, width = w, height = h)
ggsave("../images/INSERM/INSERM_14_février.svg", 
       plot =g, width = w, height = h)

#media graph
media <- read.csv("medias.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T)) %>%
  filter(rapport == "INSERM")
g <- ggplot(media) + 
  geom_jitter(aes(date, chiffres, color = "relayé par la presse"), size = 1.5, width=4, height=500) +
  geom_line(data= true_data_new_hosp_rea_weekly, 
            aes(x=date, y=new_hosp_week, color = "réalité", group="true data"), size = 1) +
  xlim(as.Date("2021-01-01"), as.Date("2021-04-01")) + g_theme +
  labs(title = "Nouvelles hospitalisations hebdomadaires",
       subtitle = "Chaque point représente une projection relayée par la presse",
       caption = "Source")
ggsave("../images/media/media_fevrier.png", plot =g, width = w, height = h)


# February 8, 2021 --------------------------------------------------------
scenario <- read.csv("2021_02_08_Pasteur/new_hosp.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))

#Admissions à l'hôpital
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value-100, group=pasteur, color="scénarios")) + geom_smooth(se=F) + 
  geom_line(data= true_data_new_hosp_rea, 
            aes(x=date, y=new_hosp_right, color = "réalité", group="réalité"), size = 1) +
  annotate('text', x = as.Date("2021-01-15"), y = 1100, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-03-01"), y = 2500, label = "scénarios", color = mygrey, fontface = "bold",
           family = "Times New Roman") + 
  #confinement de 16 départements le 20 mars cf https://fr.wikipedia.org/wiki/Chronologie_de_la_pand%C3%A9mie_de_Covid-19_en_France
  #2 semaines pour voir les effets sur hospitalisations. correspond aussi au confinement général du 3 avril
  xlim(date("2021-01-10"), date("2021-03-27")) + g_theme +
  labs(title = "Admission journalières à l'hôpital",
       subtitle = "scénarios publiés par l'Institut Pasteur le 8 février 2021\n",
       caption = "\nSource: Institut Pasteur Rapport du 8 Février \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/impact-variant/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2021_Février/Pasteur_2021_Février.png", 
       plot =g, width = w, height = h)
ggsave("../images/Pasteur_2021_Février/Pasteur_2021_Février.svg", 
       plot =g, width = w, height = h)


# February 23, 2021 -------------------------------------------------------
#besoin de réaligner leurs données sur la réalité (ne compte surement pas exactement la meme chose)
scenario <- read.csv("2021_02_23_Pasteur/new_hosp.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))

#Admissions à l'hôpital
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value+350, group=pasteur, color="scénarios")) + geom_smooth(se=F) + 
  geom_line(data= true_data_new_hosp_rea, 
            aes(x=date, y=new_hosp_right, color = "réalité", group="réalité"), size = 1) +
  annotate('text', x = as.Date("2021-01-15"), y = 1100, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-03-01"), y = 900, label = "scénario", color = mygrey, fontface = "bold",
           family = "Times New Roman") + 
  #confinement de 16 départements le 20 mars cf https://fr.wikipedia.org/wiki/Chronologie_de_la_pand%C3%A9mie_de_Covid-19_en_France
  #2 semaines pour voir les effets sur hospitalisations. correspond aussi au confinement général du 3 avril
  xlim(date("2021-01-10"), date("2021-03-27")) + g_theme +
  labs(title = "Admission journalières à l'hôpital",
       subtitle = "scénarios publiés par l'Institut Pasteur le 23 février 2021\n",
       caption = "\nSource: Institut Pasteur Rapport du 23 Février \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/impact-variant/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2021_Février/Pasteur_2021_Fevrier_bis.png", 
       plot =g, width = w, height = h)
ggsave("../images/Pasteur_2021_Février/Pasteur_2021_Fevrier_bis.svg", 
       plot =g, width = w, height = h)



# Avril 26, 2021 ----------------------------------------------------------
#besoin de réaligner leurs données sur la réalité (ne compte surement pas exactement la meme chose)
scenario <- read.csv("2021_04_26_Pasteur/new_hosp.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))

g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value+100, group=pasteur, color="scénarios")) + geom_smooth(se=F) +
  geom_line(data= true_data_new_hosp_rea, 
            aes(x=date, y=new_hosp_right, color = "réalité", group="réalité"), size = 1) +
  annotate('text', x = as.Date("2021-05-20"), y = 400, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-05-15"), y = 1700, label = "scénarios", color = mygrey, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2021-03-15"), date("2021-06-15")) + ylim(0,2200) + g_theme +
  labs(title = "Admissions journalières à l'hôpital",
       subtitle = "scénarios publiés par l'Institut Pasteur le 26 avril 2021\n",
       caption = "\nSource: Institut Pasteur Rapport 26 avril \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/delta-variant-dynamic/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2021_Avril/Pasteur_2021_avril_new_hospital.png", 
       plot =g, width = w, height = h) 
ggsave("../images/Pasteur_2021_Avril/Pasteur_2021_avril_new_hospital.svg", 
       plot =g, width = w, height = h) 



# July 26, 2021 -----------------------------------------------------------
#!! nécessité d'aligner les lits de réa à +200 dans leur scénario pour matcher avec vraies données

#Nouvelles admissions à l'hôpital
scenario <- read.csv("2021_07_26_Pasteur/new_hospital.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value, group=pasteur, color="scénarios")) + geom_smooth(se=F) +
  geom_line(data= true_data_new_hosp_rea, 
            aes(x=date, y=new_hosp_right, color = "réalité", group="réalité"), size = 1) +
  annotate('text', x = as.Date("2021-08-20"), y = 400, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-08-15"), y = 3200, label = "scénarios", color = mygrey, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2021-07-15"), date("2021-10-10")) + g_theme +
  labs(title = "Admission journalières à l'hôpital",
       subtitle = "scénarios publiés par l'Institut Pasteur le 26 juillet 2021\n",
       caption = "\nSource: Institut Pasteur Rapport 26 juillet \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/delta-variant-dynamic/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2021_Juillet/Pasteur_2021_juillet_new_hospital.png", 
       plot =g, width = w, height = h) 
ggsave("../images/Pasteur_2021_Juillet/Pasteur_2021_juillet_new_hospital.svg", 
       plot =g, width = w, height = h) 
    
#admissions en soins critiques
scenario <- read.csv("2021_07_26_Pasteur/new_SC.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value, group=pasteur, color="scénarios")) + geom_smooth(se=F) + 
  geom_line(data= true_data_new_hosp_rea, 
            aes(x=date, y=new_rea_right, color = "réalité", group="réalité"), size=1) +
  annotate('text', x = as.Date("2021-08-20"), y = 80, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-08-15"), y = 800, label = "scénarios", color = mygrey, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2021-07-15"), date("2021-10-10")) + g_theme +
  labs(title = "Admissions en soins critiques",
       subtitle = "scénarios publiés par l'Institut Pasteur le 26 juillet 2021\n",
       caption = "\nSource: Institut Pasteur Rapport 26 juillet \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/delta-variant-dynamic/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2021_Juillet/Pasteur_2021_juillet_new_reanimation.png", 
       plot =g, width = w, height = h)
ggsave("../images/Pasteur_2021_Juillet/Pasteur_2021_juillet_new_reanimation.svg", 
       plot =g, width = w, height = h)
    
#Lits de soins critiques
scenario <- read.csv("2021_07_26_Pasteur/beds_SC.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value+200, group=pasteur, color="scénarios")) + geom_smooth(se=F) + 
  geom_line(data= true_data_beds_hosp_rea, 
            aes(x=date, y=rea, color = "réalité", group="réalité"), size=1) +
  annotate('text', x = as.Date("2021-08-30"), y = 1000, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-08-25"), y = 9500, label = "scénarios", color = mygrey, fontface = "bold",
           family = "Times New Roman") +
  xlim(as.Date("2021-07-15"), as.Date("2021-10-10")) + g_theme +
  labs(title = "Lits de soins critiques occupés",
       subtitle = "scénarios publiés par l'Institut Pasteur le 26 juillet 2021\n",
       caption = "\nSource: Institut Pasteur Rapport 26 juillet \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/delta-variant-dynamic/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2021_Juillet/Pasteur_2021_juillet_reanimation_beds.png", 
       plot =g, width = w, height = h)
ggsave("../images/Pasteur_2021_Juillet/Pasteur_2021_juillet_reanimation_beds.svg", 
       plot =g, width = w, height = h)

#media admissions hopital
media <- read.csv("medias.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T)) %>%
  filter(rapport == "Pasteur juillet",
         type_chiffre != "lits soins critiques")
g <- ggplot(media) + 
  geom_jitter(aes(date, chiffres, color = "relayé par la presse"), size = 1.5, width=4, height=100) +
  geom_line(data= true_data_new_hosp_rea, 
            aes(x=date, y=new_hosp_center, color = "réalité", group="true data"), size = 1) +
  xlim(as.Date("2021-07-01"), as.Date("2021-10-01")) + g_theme +
  labs(title = "Nouvelles hospitalisations quotidiennes",
       subtitle = "Chaque point représente une projection relayée par la presse\n",
       caption = "\nSource: Institut Pasteur Rapport 26 juillet \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/delta-variant-dynamic/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/media/media_juillet_hosp.png", plot =g, width = w, height = h)

#media lits soins critiques
media <- read.csv("medias.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T)) %>%
  filter(rapport == "Pasteur juillet",
         type_chiffre == "lits soins critiques")
g <- ggplot(media) + 
  geom_jitter(aes(date, chiffres, color = "relayé par la presse"), size = 1.5, width=1, height=100) +
  geom_line(data= true_data_beds_hosp_rea, 
            aes(x=date, y=rea, color = "réalité", group="true data"), size = 1) +
  xlim(as.Date("2021-07-01"), as.Date("2021-10-01")) + g_theme +
  labs(title = "Lits de soins critiques occupés",
       subtitle = "Chaque point représente une projection relayée par la presse\n",
       caption = "\nSource: Institut Pasteur Rapport 26 juillet \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/delta-variant-dynamic/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/media/media_juillet_SC.png", plot =g, width = w, height = h)

# August 5, 2021 ----------------------------------------------------------
#pareil, besoin d'aligner leurs lits de réa à +200

#Admissions à l'hopital
scenario <- read.csv("2021_08_05_Pasteur/new_hosp.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value, group=pasteur, color="scénarios")) + geom_line(size=1) + 
  geom_line(data= true_data_new_hosp_rea, 
            aes(x=date, y=new_hosp_center, color = "réalité", group="réalité"), size=1) +
  annotate('text', x = as.Date("2021-08-05"), y = 400, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-08-13"), y = 1900, label = "scénarios", color = mygrey, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2021-07-15"), date("2021-10-10")) + ylim(0,2500) + g_theme +
  labs(title = "Admissions à l'hôpital",
       subtitle = "scénarios publiés par l'Institut Pasteur le 5 août 2021\n",
       caption = "\nSource: Institut Pasteur Rapport 5 août \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/delta-variant-dynamic/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2021_Aout/Pasteur_2021_aout_new_hosp.png", 
       plot =g, width = w, height = h)
ggsave("../images/Pasteur_2021_Aout/Pasteur_2021_aout_new_hosp.svg", 
       plot =g, width = w, height = h)
    
#Admissions en soins critiques
scenario <- read.csv("2021_08_05_Pasteur/new_SC.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value, group=pasteur, color="scénarios")) + geom_line(size=1) +
  geom_line(data= true_data_new_hosp_rea, 
            aes(x=date, y=new_rea_center, color = "réalité", group="réalité"), size=1) +
  annotate('text', x = as.Date("2021-08-15"), y = 120, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-08-15"), y = 500, label = "scénarios", color = mygrey, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2021-07-15"), date("2021-10-10")) + ylim(0,600) + g_theme +
  labs(title = "Admissions en soins critiques",
       subtitle = "scénarios publiés par l'Institut Pasteur le 5 août 2021\n",
       caption = "\nSource: Institut Pasteur Rapport 5 août \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/delta-variant-dynamic/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2021_Aout/Pasteur_2021_aout_new_reanimation.png", 
       plot =g, width = w, height = h)
ggsave("../images/Pasteur_2021_Aout/Pasteur_2021_aout_new_reanimation.svg", 
       plot =g, width = w, height = h)
    
#Lits de soins critiques
scenario <- read.csv("2021_08_05_Pasteur/beds_SC.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=scenarios, value = value, -date) %>%
  ggplot(aes(date, value, group=scenarios, color="scénarios")) + geom_smooth(se=F) + 
  geom_line(data= true_data_beds_hosp_rea, 
            aes(x=date, y=rea, color = "réalité", group="réalité"), size=1) +
  annotate('text', x = as.Date("2021-07-20"), y = 1200, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-08-20"), y = 5800, label = "scénarios", color = mygrey, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2021-07-15"), date("2021-10-10")) + g_theme +
  labs(title = "Lits de soins critiques",
       subtitle = "scénarios publiés par l'Institut Pasteur le 5 août 2021\n",
       caption = "\nSource: Institut Pasteur Rapport 5 août \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/delta-variant-dynamic/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2021_Aout/Pasteur_2021_aout_reanimation.png", 
       plot =g, width = w, height = h)
ggsave("../images/Pasteur_2021_Aout/Pasteur_2021_aout_reanimation.svg", 
       plot =g, width = w, height = h)
    
#Hospitalisation conventionnelle
scenario <- read.csv("2021_08_05_Pasteur/beds_hosp.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=scenarios, value = value, -date) %>%
  ggplot(aes(date, value, group=scenarios, color="scénarios")) + geom_smooth(se=F) + 
  geom_line(data= true_data_beds_hosp_rea, 
            aes(x=date, y=HospConv, color = "réalité", group="réalité"), size=1) +
  annotate('text', x = as.Date("2021-08-15"), y = 3000, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-08-18"), y = 18000, label = "scénarios", color = mygrey, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2021-07-15"), date("2021-10-10")) + g_theme +
  labs(title = "Lits en hospitalisation conventionnelle",
       subtitle = "scénarios publiés par l'Institut Pasteur le 5 août 2021\n",
       caption = "\nSource: Institut Pasteur Rapport 5 août \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/delta-variant-dynamic/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2021_Aout/Pasteur_2021_aout_hospconv.png", 
       plot =g, width = w, height = h)
ggsave("../images/Pasteur_2021_Aout/Pasteur_2021_aout_hospconv.svg", 
       plot =g, width = w, height = h)


# October 10 2021 ---------------------------------------------------------

#Admissions à l'hopital
scenario <- read.csv("2021_10_04_Pasteur/new_hosp.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value+30, group=pasteur, color="scénarios")) + geom_smooth(se=F) + 
  geom_line(data= true_data_new_hosp_rea, 
            aes(x=date, y=new_hosp_center, color = "réalité", group="réalité"), size=1) +
  annotate('text', x = as.Date("2021-11-28"), y = 1100, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-12-07"), y = 600, label = "scénarios", color = mygrey, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2021-09-15"), date("2021-12-20")) + ylim(0,1400) + g_theme +
  labs(title = "Admissions à l'hôpital",
       subtitle = "scénarios publiés par l'Institut Pasteur le 4 octobre 2021\n",
       caption = "\nSource: Institut Pasteur Rapport 4 octobre \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/fall-winter-scenarios/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2021_Octobre/Pasteur_2021_octobre_new_hosp.png", 
       plot =g, width = w, height = h)
ggsave("../images/Pasteur_2021_Octobre/Pasteur_2021_octobre_new_hosp.svg", 
       plot =g, width = w, height = h)



# December 06, 2021 short term projection Pasteur -------------------------

#Admissions journalières à l'hopital
#+40% à 14 jours
scenario <- read.csv("2021_12_06_projection_pasteur/new_hosp.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- ggplot(data = scenario, aes(x = date)) +
  geom_smooth(aes(y=projection, color="projection"), size=1, se=F) +
  geom_line(aes(y=reality, color = " réalité"), size=1) +
  annotate('text', x = as.Date("2021-12-05"), y = 1420, label = "projection à 2 semaines\nsurestimation +40%", color = '#515a5a', fontface = "italic",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-12-10"), y = 900, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2021-11-01"), date("2021-12-20")) + g_theme + ylim(0, NA) +
  labs(title = "Admissions journalières à l'hôpital",
       subtitle = "Projection de l'Institut Pasteur du 6 décembre 2021\n",
       caption = "\nSource: Projection à cour terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2021_Decembre_projection/Pasteur_2021_decembre_projection_new_hosp.png", 
       plot =g, width = w, height = h)
ggsave("../images/Pasteur_2021_Decembre_projection/Pasteur_2021_decembre_projection_new_hosp.svg", 
       plot =g, width = w, height = h)

#Admissions en soins critiques
#+45%
scenario <- read.csv("2021_12_06_projection_pasteur/new_SC.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- ggplot(data = scenario, aes(x = date)) +
  geom_smooth(aes(y=projection, color="projection"), size=1, se=F) +
  geom_line(aes(y=reality, color = " réalité"), size=1) +
  annotate('text', x = as.Date("2021-12-05"), y = 350, label = "projection à 2 semaines \nsurestimation +45%", color = '#515a5a', fontface = "italic",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-12-12"), y = 230, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2021-11-01"), date("2021-12-20")) + g_theme + ylim(0, NA) +
  labs(title = "Admissions journalières en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 6 décembre 2021\n",
       caption = "\nSource: Projection à cour terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2021_Decembre_projection/Pasteur_2021_decembre_projection_new_SC.png", 
       plot =g, width = w, height = h)
ggsave("../images/Pasteur_2021_Decembre_projection/Pasteur_2021_decembre_projection_new_SC.svg", 
       plot =g, width = w, height = h)


#Lits l'hopital
#+40%
scenario <- read.csv("2021_12_06_projection_pasteur/beds_hosp.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- ggplot(data = scenario, aes(x = date)) +
  geom_smooth(aes(y=projection, color="projection"), size=1, se=F) +
  geom_line(aes(y=reality, color = " réalité"), size=1) +
  annotate('text', x = as.Date("2021-12-07"), y = 11000, label = "projection à 2 semaines\nsurestimation +40%", color = '#515a5a', fontface = "italic",
           family = "Times New Roman") +
  annotate('text', x = as.Date("2021-12-12"), y = 6900, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2021-11-01"), date("2021-12-20")) + g_theme + ylim(0, NA) +
  labs(title = "Lits occupés en hospitalisation conventionnelle",
       subtitle = "Projection de l'Institut Pasteur du 6 décembre 2021\n",
       caption = "\nSource: Projection à cour terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2021_Decembre_projection/Pasteur_2021_decembre_projection_beds_hosp.png", 
       plot =g, width = w, height = h)
ggsave("../images/Pasteur_2021_Decembre_projection/Pasteur_2021_decembre_projection_beds_hosp.svg", 
       plot =g, width = w, height = h)


#Lits en soins critiques
#+30% à 14 jours
scenario <- read.csv("2021_12_06_projection_pasteur/beds_SC.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- ggplot(data = scenario, aes(x = date)) +
  geom_smooth(aes(y=projection, color="projection"), size=1, se=F) +
  geom_line(aes(y=reality, color = " réalité"), size=1) +
  annotate('text', x = as.Date("2021-12-08"), y = 3700, label = "projection à 2 semaines\nsurestimation +30%", color = '#515a5a', fontface = "italic",
           family = "Times New Roman") +
  annotate('text', x = as.Date("2021-12-15"), y = 2500, label = "réalité", color = myred, fontface = "bold",
          family = "Times New Roman") + 
  xlim(date("2021-11-01"), date("2021-12-20")) + g_theme + ylim(0, NA) +
  labs(title = "Lits occupés en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 6 décembre 2021\n",
       caption = "\nSource: Projection à cour terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2021_Decembre_projection/Pasteur_2021_decembre_projection_beds_SC.png", 
       plot =g, width = w, height = h)
ggsave("../images/Pasteur_2021_Decembre_projection/Pasteur_2021_decembre_projection_beds_SC.svg", 
       plot =g, width = w, height = h)



# January 7, 2022 Pasteur Omicron -----------------------------------------
#Lits de soins critiques
# scenario <- read.csv("2022_01_07_Pasteur/beds_SC_high_VE.csv", sep=";") %>%
#   mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T)) %>%
#   gather(key=scenarios, value = value, -date)
# scenario_peu_probables <- read.csv("2022_01_07_Pasteur/beds_SC_peu_probable_high_VE.csv", sep=";") %>%
#   mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T)) %>%
#   gather(key=scenarios, value = value, -date)
# 
# #all scenarios
# scenario_peu_probables %>%
#   ggplot(aes(date, value, group=scenarios)) + geom_line(color = "#cacfd2", size=1, linetype = "dashed") + 
#   geom_line(data= scenario, 
#             aes(x=date, value, group=scenarios), color = mygrey, size=1) +
#   geom_line(data= true_data_beds_hosp_rea, 
#             aes(x=date, y=rea, color = myred, group="réalité"), size=1) +
#   annotate('text', x = as.Date("2022-01-20"), y = 2000, label = "réalité", color = myred, fontface = "bold",
#            family = "Times New Roman") +
#   annotate('text', x = as.Date("2022-03-15"), y = 5800, label = "scénarios \n'probables'", color = mygrey, fontface = "bold",
#            family = "Times New Roman") +
#   annotate('text', x = as.Date("2021-12-25"), y = 5800, label = "scénarios \n'moins probables'", color = mygrey, fontface = "bold",
#            family = "Times New Roman") +
#   annotate('text', x = as.Date("2022-01-25"), y = 7500, label = "hypothèses fausses'", color = myred, fontface = "bold",
#            size = 10, alpha = .3,
#            family = "Times New Roman") +
#   xlim(date("2021-12-01"), date("2022-04-01")) +
#   labs(title = "Lits de soins critiques",
#        subtitle = "scénarios publiés par l'Institut Pasteur le 7 janvier 2022\n",
#        caption = "\nSource: Institut Pasteur Rapport 7 janvier \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/omicron-variant-epidemic/
#        https://evaluation-modelisation-covid.github.io/france/")
# ggsave("../images/Pasteur_2022_Fevrier/Pasteur_2022_fevrier_SC_all.png", 
#        plot =g, width = w, height = h)
# ggsave("../images/Pasteur_2022_Fevrier/Pasteur_2022_fevrier_SC_all.svg", 
#        plot =g, width = w, height = h)


#high VE all
scenario <- read.csv("2022_01_07_Pasteur/beds_SC_high_VE.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T)) %>%
  gather(key=scenarios, value = value, -date)
scenario_peu_probables <- read.csv("2022_01_07_Pasteur/beds_SC_peu_probable_high_VE.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T)) %>%
  gather(key=scenarios, value = value, -date)
g <- scenario_peu_probables %>%
  ggplot(aes(date, value, group=scenarios)) + geom_line(color = "#cacfd2", size=1, linetype = "dashed") + 
  geom_line(data= scenario, 
            aes(x=date, value, group=scenarios), color = mygrey, size=1) +
  geom_line(data= true_data_beds_hosp_rea, 
            aes(x=date, y=rea, color = myred, group="réalité"), size=1) +
  annotate('text', x = as.Date("2022-01-20"), y = 2800, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  annotate('text', x = as.Date("2022-03-20"), y = 4400, label = "scénarios \n'probables'", color = mygrey, fontface = "bold",
           family = "Times New Roman") +
  annotate('text', x = as.Date("2021-12-25"), y = 5800, label = "scénarios \n'moins probables'", color = mygrey, fontface = "bold",
           family = "Times New Roman") +
  annotate('text', x = as.Date("2022-01-30"), y = 9000, label = "hypothèse fausse :\nefficacité vaccinale 85%", 
           color = myred, fontface = "bold",
           size = 10, alpha = .4,
           family = "Times New Roman") +
  xlim(date("2021-12-01"), date("2022-04-01")) + ylim(0,10000) +
  labs(title = "Lits de soins critiques",
       subtitle = "scénarios publiés par l'Institut Pasteur le 7 janvier 2022\n",
       caption = "\nSource: Institut Pasteur Rapport 7 janvier \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/omicron-variant-epidemic/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2022_Fevrier/Pasteur_2022_fevrier_SC_highVE.png", 
       plot =g, width = w, height = h)
ggsave("../images/Pasteur_2022_Fevrier/Pasteur_2022_fevrier_SC_highVE.svg", 
       plot =g, width = w, height = h)

#low VE all
scenario <- read.csv("2022_01_07_Pasteur/beds_SC_low_VE.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T)) %>%
  gather(key=scenarios, value = value, -date)
scenario_peu_probables <- read.csv("2022_01_07_Pasteur/beds_SC_peu_probable_low_VE.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T)) %>%
  gather(key=scenarios, value = value, -date)
g <- scenario_peu_probables %>%
  ggplot(aes(date, value, group=scenarios)) + geom_line(color = "#cacfd2", size=1, linetype = "dashed") + 
  geom_line(data= scenario, 
            aes(x=date, value, group=scenarios), color = mygrey, size=1) +
  geom_line(data= true_data_beds_hosp_rea, 
            aes(x=date, y=rea, color = myred, group="réalité"), size=1) +
  annotate('text', x = as.Date("2022-01-20"), y = 2800, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  annotate('text', x = as.Date("2022-03-20"), y = 4400, label = "scénarios \n'probables'", color = mygrey, fontface = "bold",
           family = "Times New Roman") +
  annotate('text', x = as.Date("2021-12-25"), y = 5800, label = "scénarios \n'moins probables'", color = mygrey, fontface = "bold",
           family = "Times New Roman") +
  annotate('text', x = as.Date("2022-01-30"), y = 9000, label = "hypothèse (moins) fausse :\nefficacité vaccinale 60%", 
           color = myred, fontface = "bold",
           size = 10, alpha = .4,
           family = "Times New Roman") +
  xlim(date("2021-12-01"), date("2022-04-01")) + ylim(0,10000) +
  labs(title = "Lits de soins critiques",
       subtitle = "scénarios publiés par l'Institut Pasteur le 7 janvier 2022\n",
       caption = "\nSource: Institut Pasteur Rapport 7 janvier \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/omicron-variant-epidemic/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/Pasteur_2022_Fevrier/Pasteur_2022_fevrier_SC_lowVE.png", 
       plot =g, width = w, height = h)
ggsave("../images/Pasteur_2022_Fevrier/Pasteur_2022_fevrier_SC_lowVE.svg", 
       plot =g, width = w, height = h)

# #high VE
# scenario <- read.csv("2022_01_07_Pasteur/beds_SC_high_VE.csv", sep=";") %>%
#   mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
# g <- scenario %>%
#   gather(key=pasteur, value = value, -date) %>%
#   ggplot(aes(date, value, group=pasteur, color="scénarios")) + geom_line(size=1) + 
#   geom_line(data= true_data_beds_hosp_rea, 
#             aes(x=date, y=rea, color = "réalité", group="réalité"), size=1) +
#   annotate('text', x = as.Date("2022-01-20"), y = 2000, label = "réalité", color = myred, fontface = "bold",
#            family = "Times New Roman") +
#   annotate('text', x = as.Date("2022-03-15"), y = 5600, label = "scénarios", color = mygrey, fontface = "bold",
#            family = "Times New Roman") +
#   annotate('text', x = as.Date("2021-12-01"), y = 7000, label = 
#              "Efficacité contre infection Omicron\n2 doses : <6 mois : 55% ; >6 mois : 25%\n3 doses : <6 mois : 85% ; >6 mois : 70%", 
#            color = "black", fontface = "bold", size = 2.9, hjust = 0,
#            family = "Times New Roman") +
#   xlim(date("2021-12-01"), date("2022-04-01")) + ylim(0, 8000) + g_theme +
#   labs(title = "Lits de soins critiques, hypothèses vaccination standard",
#        subtitle = "scénarios publiés par l'Institut Pasteur le 7 janvier 2022\n",
#        caption = "\nSource: Institut Pasteur Rapport 7 janvier \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/omicron-variant-epidemic/
#        https://evaluation-modelisation-covid.github.io/france/")
# ggsave("../images/Pasteur_2022_Fevrier/Pasteur_2022_fevrier_SC_high_VE.png", 
#        plot =g, width = w, height = h)
# ggsave("../images/Pasteur_2022_Fevrier/Pasteur_2022_fevrier_SC_high_VE.svg", 
#        plot =g, width = w, height = h)
# 
# #low VE
# scenario <- read.csv("2022_01_07_Pasteur/beds_SC_low_VE.csv", sep=";") %>%
#   mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
# g <- scenario %>%
#   gather(key=pasteur, value = value, -date) %>%
#   ggplot(aes(date, value, group=pasteur, color="scénarios")) + geom_line(size=1) + 
#   geom_line(data= true_data_beds_hosp_rea, 
#             aes(x=date, y=rea, color = "réalité", group="réalité"), size=1) +
#   annotate('text', x = as.Date("2022-01-20"), y = 2000, label = "réalité", color = myred, fontface = "bold",
#            family = "Times New Roman") +
#   annotate('text', x = as.Date("2022-03-15"), y = 5600, label = "scénarios", color = mygrey, fontface = "bold",
#            family = "Times New Roman") +
#   annotate('text', x = as.Date("2021-12-01"), y = 7000, label = 
#              "Efficacité contre infection Omicron\n2 doses : <6 mois : 40% ; >6 mois : 10%\n3 doses : <6 mois : 60% ; >6 mois : 40%", 
#            color = "black", fontface = "bold", size = 2.9, hjust = 0,
#            family = "Times New Roman") +
#   xlim(date("2021-12-01"), date("2022-04-01")) + ylim(0, 8000) + g_theme +
#   labs(title = "Lits de soins critiques, hypothèses vaccination pessimiste",
#        subtitle = "scénarios publiés par l'Institut Pasteur le 7 janvier 2022\n",
#        caption = "\nSource: Institut Pasteur Rapport 7 janvier \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/omicron-variant-epidemic/
#        https://evaluation-modelisation-covid.github.io/france/")
# ggsave("../images/Pasteur_2022_Fevrier/Pasteur_2022_fevrier_SC_low_VE.png", 
#        plot =g, width = w, height = h)
# ggsave("../images/Pasteur_2022_Fevrier/Pasteur_2022_fevrier_SC_low_VE.svg", 
#        plot =g, width = w, height = h)


# #both VE on 1 graph
# scenario_high <- read.csv("2022_01_07_Pasteur/beds_SC_high_VE.csv", sep=";") %>%
#   mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T)) %>%
#   gather(key=scenarios, value = value, -date)
# scenario_low <- read.csv("2022_01_07_Pasteur/beds_SC_low_VE.csv", sep=";") %>%
#   mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T)) %>%
#   gather(key=scenarios, value = value, -date)

#différenciés
# g <- scenario_high %>%
#   ggplot(aes(date, value, group=scenarios)) + geom_line(color = mygrey, size=1, linetype = "dashed") + 
#   geom_line(data= scenario_low, 
#             aes(x=date, value, group=scenarios), color = mygrey, size=1) +
#   geom_line(data= true_data_beds_hosp_rea, 
#             aes(x=date, y=rea, color = myred, group="réalité"), size=1) +
#   annotate('text', x = as.Date("2022-01-20"), y = 3000, label = "réalité", color = myred, fontface = "bold",
#            family = "Times New Roman") +
#   annotate('text', x = as.Date("2022-03-08"), y = 6700, label = "Faible \nefficacité\n vaccinale", color = mygrey, fontface = "bold",
#            family = "Times New Roman") +
#   annotate('text', x = as.Date("2022-02-25"), y = 1300, label = "Haute \nefficacité\n vaccinale", color = mygrey, fontface = "bold",
#            family = "Times New Roman") +
#   xlim(date("2021-12-01"), date("2022-04-01")) +
#   labs(title = "Lits de soins critiques",
#        subtitle = "scénarios publiés par l'Institut Pasteur le 7 janvier 2022\n",
#        caption = "\nSource: Institut Pasteur Rapport 7 janvier \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/omicron-variant-epidemic/
#        https://evaluation-modelisation-covid.github.io/france/")
# ggsave("../images/Pasteur_2022_Fevrier/Pasteur_2022_fevrier_SC_both_VE.png", 
#        plot =g, width = w, height = h)
# ggsave("../images/Pasteur_2022_Fevrier/Pasteur_2022_fevrier_SC_both_VE.svg", 
#        plot =g, width = w, height = h)

# #non différenciés
# g <- scenario_high %>%
#   ggplot(aes(date, value, group=scenarios)) + geom_line(color = mygrey, size=1) + 
#   geom_line(data= scenario_low, 
#             aes(x=date, value, group=scenarios), color = mygrey, size=1) +
#   geom_line(data= true_data_beds_hosp_rea, 
#             aes(x=date, y=rea, color = myred, group="réalité"), size=1) +
#   annotate('text', x = as.Date("2022-01-20"), y = 3000, label = "réalité", color = myred, fontface = "bold",
#            family = "Times New Roman") +
#   annotate('text', x = as.Date("2022-03-15"), y = 5000, label = "scénarios", color = mygrey, fontface = "bold",
#            family = "Times New Roman") +
#   xlim(date("2021-12-01"), date("2022-04-01")) +
#   labs(title = "Lits de soins critiques",
#        subtitle = "scénarios publiés par l'Institut Pasteur le 7 janvier 2022\n",
#        caption = "\nSource: Institut Pasteur Rapport 7 janvier \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/omicron-variant-epidemic/
#        https://evaluation-modelisation-covid.github.io/france/")
# ggsave("../images/Pasteur_2022_Fevrier/Pasteur_2022_fevrier_SC_both_VE.png", 
#        plot =g, width = w, height = h)
# ggsave("../images/Pasteur_2022_Fevrier/Pasteur_2022_fevrier_SC_both_VE.svg", 
#        plot =g, width = w, height = h)





# Short term April-Mai --------------------------------------------------------
scenario <- read.csv("short_term/new_SC/2021_04_02.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- ggplot(data= true_data_new_hosp_rea_no_mean) +
  geom_line(aes(x=date, y=new_rea), color = myred, alpha = .2, size = .5) +
  geom_line(data = scenario, aes(x = date, y=projection, color="projection"), size=2.5) +
  geom_line(data = scenario, aes(x = date , y=reality, color = " réalité"), size=1) +
  geom_vline(xintercept = as.Date("2021-03-29"), linetype = "dashed", alpha=.5) + 
  annotate('text', x = as.Date("2021-03-28"), y = 20, label = "date de la\nprojection", color = mygrey, fontface = "bold",
           family = "Times New Roman", hjust = "right", vjust = "bottom") +
  annotate('text', x = as.Date("2021-04-17"), y = 480, label = "projection", color = mygrey, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-04-10"), y = 380, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2021-03-01"), date("2021-05-15")) + g_theme + ylim(0, 670) + 
  labs(title = "Admissions journalières en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 28 mars 2021\n",
       caption = "\nSource: Projection à court terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/short_term/2021_april_may/new_SC/2021_04_02_new_SC.png", 
       plot =g, width = w, height = h)
ggsave("../images/short_term/2021_april_may/new_SC/2021_04_02_new_SC.svg", 
       plot =g, width = w, height = h)

scenario <- read.csv("short_term/new_SC/2021_04_12.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- ggplot(data= true_data_new_hosp_rea_no_mean) +
  geom_line(aes(x=date, y=new_rea), color = myred, alpha = .2, size = .5) +
  geom_line(data = scenario, aes(x = date, y=projection, color="projection"), size=2.5) +
  geom_line(data = scenario, aes(x = date , y=reality, color = " réalité"), size=1) +
  geom_vline(xintercept = as.Date("2021-04-08"), linetype = "dashed", alpha=.5) + 
  annotate('text', x = as.Date("2021-04-07"), y = 20, label = "date de la\nprojection", color = mygrey, fontface = "bold",
           family = "Times New Roman", hjust = "right", vjust = "bottom") +
  annotate('text', x = as.Date("2021-04-26"), y = 470, label = "projection", color = mygrey, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-04-17"), y = 380, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2021-03-01"), date("2021-05-15")) + g_theme + ylim(0, 670) +
  labs(title = "Admissions journalières en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 08 avril 2021\n",
       caption = "\nSource: Projection à court terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/short_term/2021_april_may/new_SC/2021_04_12_new_SC.png", 
       plot =g, width = w, height = h)
ggsave("../images/short_term/2021_april_may/new_SC/2021_04_12_new_SC.svg", 
       plot =g, width = w, height = h)

scenario <- read.csv("short_term/new_SC/2021_04_20.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- ggplot(data= true_data_new_hosp_rea_no_mean) +
  geom_line(aes(x=date, y=new_rea), color = myred, alpha = .2, size = .5) +
  geom_line(data = scenario, aes(x = date, y=projection, color="projection"), size=2.5) +
  geom_line(data = scenario, aes(x = date , y=reality, color = " réalité"), size=1) +
  geom_vline(xintercept = as.Date("2021-04-16"), linetype = "dashed", alpha=.5) + 
  annotate('text', x = as.Date("2021-04-15"), y = 20, label = "date de la\nprojection", color = mygrey, fontface = "bold",
           family = "Times New Roman", hjust = "right", vjust = "bottom") +
  annotate('text', x = as.Date("2021-05-07"), y = 330, label = "projection", color = mygrey, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-04-23"), y = 420, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2021-03-01"), date("2021-05-15")) + g_theme + ylim(0, 670) +
  labs(title = "Admissions journalières en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 16 avril 2021\n",
       caption = "\nSource: Projection à court terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/short_term/2021_april_may/new_SC/2021_04_20_new_SC.png", 
       plot =g, width = w, height = h)
ggsave("../images/short_term/2021_april_may/new_SC/2021_04_20_new_SC.svg", 
       plot =g, width = w, height = h)

scenario <- read.csv("short_term/new_SC/2021_04_26.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- ggplot(data= true_data_new_hosp_rea_no_mean) +
  geom_line(aes(x=date, y=new_rea), color = myred, alpha = .2, size = .5) +
  geom_line(data = scenario, aes(x = date, y=projection, color="projection"), size=2.5) +
  geom_line(data = scenario, aes(x = date , y=reality, color = " réalité"), size=1) +
  geom_vline(xintercept = as.Date("2021-04-23"), linetype = "dashed", alpha=.5) + 
  annotate('text', x = as.Date("2021-04-22"), y = 20, label = "date de la\nprojection", color = mygrey, fontface = "bold",
           family = "Times New Roman", hjust = "right", vjust = "bottom") +
  annotate('text', x = as.Date("2021-05-10"), y = 350, label = "projection", color = mygrey, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-04-29"), y = 220, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2021-03-01"), date("2021-05-15")) + g_theme + ylim(0, 670) +
  labs(title = "Admissions journalières en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 23 avril 2021\n",
       caption = "\nSource: Projection à court terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/short_term/2021_april_may/new_SC/2021_04_26_new_SC.png", 
       plot =g, width = w, height = h)
ggsave("../images/short_term/2021_april_may/new_SC/2021_04_26_new_SC.svg", 
       plot =g, width = w, height = h)

scenario <- read.csv("short_term/new_SC/2021_05_04.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- ggplot(data= true_data_new_hosp_rea_no_mean) +
  geom_line(aes(x=date, y=new_rea), color = myred, alpha = .2, size = .5) +
  geom_line(data = scenario, aes(x = date, y=projection, color="projection"), size=2.5) +
  geom_line(data = scenario, aes(x = date , y=reality, color = " réalité"), size=1) +
  geom_vline(xintercept = as.Date("2021-04-30"), linetype = "dashed", alpha=.5) + 
  annotate('text', x = as.Date("2021-04-29"), y = 20, label = "date de la\nprojection", color = mygrey, fontface = "bold",
           family = "Times New Roman", hjust = "right", vjust = "bottom") +
  annotate('text', x = as.Date("2021-05-12"), y = 310, label = "projection", color = mygrey, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-05-10"), y = 140, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2021-03-01"), date("2021-05-15")) + g_theme + ylim(0, 670) +
  labs(title = "Admissions journalières en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 30 avril 2021\n",
       caption = "\nSource: Projection à court terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/short_term/2021_april_may/new_SC/2021_05_04_new_SC.png", 
       plot =g, width = w, height = h)
ggsave("../images/short_term/2021_april_may/new_SC/2021_05_04_new_SC.svg", 
       plot =g, width = w, height = h)



# Short term May-June ----------------------------------------------------------
scenario <- read.csv("short_term/new_SC/2021_05_11.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
ggplot(data= true_data_new_hosp_rea_no_mean) +
  geom_line(aes(x=date, y=new_rea), color = myred, alpha = .2, size = .5) +
  geom_line(data = scenario, aes(x = date, y=projection, color="projection"), size=2.5) +
  geom_line(data = scenario, aes(x = date , y=reality, color = " réalité"), size=1) +
  annotate('text', x = as.Date("2021-12-05"), y = 1420, label = "projection à 2 semaines\nsurestimation +40%", color = '#515a5a', fontface = "italic",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-12-10"), y = 900, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  geom_vline(xintercept = as.Date("2021-05-11"), linetype = "dashed", alpha=.5) + 
  xlim(date("2021-05-01"), date("2021-06-30")) + g_theme + ylim(0, 400) + 
  labs(title = "Admissions journalières en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 5 mai 2021\n",
       caption = "\nSource: Projection à court terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")

#Reprendre les mesures
scenario <- read.csv("short_term/new_SC/2021_05_18.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
ggplot(data= true_data_new_hosp_rea_no_mean) +
  geom_line(aes(x=date, y=new_rea), color = myred, alpha = .2, size = .5) +
  geom_line(data = scenario, aes(x = date, y=projection, color="projection"), size=2.5) +
  geom_line(data = scenario, aes(x = date , y=reality, color = " réalité"), size=1) +
  annotate('text', x = as.Date("2021-12-05"), y = 1420, label = "projection à 2 semaines\nsurestimation +40%", color = '#515a5a', fontface = "italic",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-12-10"), y = 900, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  geom_vline(xintercept = as.Date("2021-05-18"), linetype = "dashed", alpha=.5) + 
  xlim(date("2021-05-01"), date("2021-06-30")) + g_theme + ylim(0, 400) + 
  labs(title = "Admissions journalières en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 18 mai 2021\n",
       caption = "\nSource: Projection à court terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")

#reprendre les mesures
scenario <- read.csv("short_term/new_SC/2021_05_26.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
ggplot(data= true_data_new_hosp_rea_no_mean) +
  geom_line(aes(x=date, y=new_rea), color = myred, alpha = .2, size = .5) +
  geom_line(data = scenario, aes(x = date, y=projection, color="projection"), size=2.5) +
  geom_line(data = scenario, aes(x = date , y=reality, color = " réalité"), size=1) +
  annotate('text', x = as.Date("2021-12-05"), y = 1420, label = "projection à 2 semaines\nsurestimation +40%", color = '#515a5a', fontface = "italic",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-12-10"), y = 900, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  geom_vline(xintercept = as.Date("2021-05-26"), linetype = "dashed", alpha=.5) + 
  xlim(date("2021-05-01"), date("2021-06-30")) + g_theme + ylim(0, 400) + 
  labs(title = "Admissions journalières en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 26 mai 2021\n",
       caption = "\nSource: Projection à court terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")

scenario <- read.csv("short_term/new_SC/2021_05_31.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
ggplot(data= true_data_new_hosp_rea_no_mean) +
  geom_line(aes(x=date, y=new_rea), color = myred, alpha = .2, size = .5) +
  geom_line(data = scenario, aes(x = date, y=projection, color="projection"), size=2.5) +
  geom_line(data = scenario, aes(x = date , y=reality, color = " réalité"), size=1) +
  annotate('text', x = as.Date("2021-12-05"), y = 1420, label = "projection à 2 semaines\nsurestimation +40%", color = '#515a5a', fontface = "italic",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-12-10"), y = 900, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  geom_vline(xintercept = as.Date("2021-05-31"), linetype = "dashed", alpha=.5) + 
  xlim(date("2021-05-01"), date("2021-06-30")) + g_theme + ylim(0, 400) + 
  labs(title = "Admissions journalières en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 31 mai 2021\n",
       caption = "\nSource: Projection à court terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")

scenario <- read.csv("short_term/new_SC/2021_06_07.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
ggplot(data= true_data_new_hosp_rea_no_mean) +
  geom_line(aes(x=date, y=new_rea), color = myred, alpha = .2, size = .5) +
  geom_line(data = scenario, aes(x = date, y=projection, color="projection"), size=2.5) +
  geom_line(data = scenario, aes(x = date , y=reality, color = " réalité"), size=1) +
  annotate('text', x = as.Date("2021-12-05"), y = 1420, label = "projection à 2 semaines\nsurestimation +40%", color = '#515a5a', fontface = "italic",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-12-10"), y = 900, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  geom_vline(xintercept = as.Date("2021-06-07"), linetype = "dashed", alpha=.5) + 
  xlim(date("2021-05-01"), date("2021-06-30")) + g_theme + ylim(0, 400) + 
  labs(title = "Admissions journalières en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 6 juin 2021\n",
       caption = "\nSource: Projection à court terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")

scenario <- read.csv("short_term/new_SC/2021_06_15.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
ggplot(data= true_data_new_hosp_rea_no_mean) +
  geom_line(aes(x=date, y=new_rea), color = myred, alpha = .2, size = .5) +
  geom_line(data = scenario, aes(x = date, y=projection, color="projection"), size=2.5) +
  geom_line(data = scenario, aes(x = date , y=reality, color = " réalité"), size=1) +
  annotate('text', x = as.Date("2021-12-05"), y = 1420, label = "projection à 2 semaines\nsurestimation +40%", color = '#515a5a', fontface = "italic",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-12-10"), y = 900, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  geom_vline(xintercept = as.Date("2021-06-15"), linetype = "dashed", alpha=.5) + 
  xlim(date("2021-05-01"), date("2021-06-30")) + g_theme + ylim(0, 400) + 
  labs(title = "Admissions journalières en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 15 juin 2021\n",
       caption = "\nSource: Projection à court terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")


# Short term August -------------------------------------------------------
scenario <- read.csv("short_term/new_SC/2021_08_24.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
ggplot(data= true_data_new_hosp_rea_no_mean) +
  geom_line(aes(x=date, y=new_rea), color = myred, alpha = .2, size = .5) +
  geom_line(data = scenario, aes(x = date, y=projection, color="projection"), size=2.5) +
  geom_line(data = scenario, aes(x = date , y=reality, color = " réalité"), size=1) +
  annotate('text', x = as.Date("2021-12-05"), y = 1420, label = "projection à 2 semaines\nsurestimation +40%", color = '#515a5a', fontface = "italic",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-12-10"), y = 900, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  geom_vline(xintercept = as.Date("2021-08-20"), linetype = "dashed", alpha=.5) + 
  xlim(date("2021-07-15"), date("2021-09-30")) + g_theme + ylim(0, 250) + 
  labs(title = "Admissions journalières en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 20 août 2021\n",
       caption = "\nSource: Projection à court terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")

scenario <- read.csv("short_term/new_SC/2021_08_31.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
ggplot(data= true_data_new_hosp_rea_no_mean) +
  geom_line(aes(x=date, y=new_rea), color = myred, alpha = .2, size = .5) +
  geom_line(data = scenario, aes(x = date, y=projection, color="projection"), size=2.5) +
  geom_line(data = scenario, aes(x = date , y=reality, color = " réalité"), size=1) +
  annotate('text', x = as.Date("2021-12-05"), y = 1420, label = "projection à 2 semaines\nsurestimation +40%", color = '#515a5a', fontface = "italic",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-12-10"), y = 900, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  geom_vline(xintercept = as.Date("2021-08-27"), linetype = "dashed", alpha=.5) + 
  xlim(date("2021-07-01"), date("2021-09-30")) + g_theme + ylim(0, 250) + 
  labs(title = "Admissions journalières en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 27 août 2021\n",
       caption = "\nSource: Projection à court terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")


# Short term December -----------------------------------------------------
scenario <- read.csv("short_term/new_SC/2021_11_25.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- ggplot(data= true_data_new_hosp_rea_no_mean) +
  geom_line(aes(x=date, y=new_rea), color = myred, alpha = .2, size = .5) +
  geom_line(data = scenario, aes(x = date, y=projection, color="projection"), size=2.5) +
  geom_line(data = scenario, aes(x = date , y=reality, color = " réalité"), size=1) +
  annotate('text', x = as.Date("2021-11-18"), y = 5, label = "date de la\nprojection", color = mygrey, fontface = "bold",
           family = "Times New Roman", hjust = "right", vjust = "bottom") +
  annotate('text', x = as.Date("2021-12-05"), y = 160, label = "projection", color = mygrey, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-11-28"), y = 210, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  geom_vline(xintercept = as.Date("2021-11-19"), linetype = "dashed", alpha=.5) + 
  xlim(date("2021-11-01"), date("2021-12-25")) + g_theme + ylim(0, 410) +
  labs(title = "Admissions journalières en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 19 novembre 2021\n",
       caption = "\nSource: Projection à court terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/short_term/2021_december/new_SC/2021_11_25_new_SC.png", 
       plot =g, width = w, height = h)
ggsave("../images/short_term/2021_december/new_SC/2021_11_25_new_SC.svg", 
       plot =g, width = w, height = h)

scenario <- read.csv("short_term/new_SC/2021_11_30.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- ggplot(data= true_data_new_hosp_rea_no_mean) +
  geom_line(aes(x=date, y=new_rea), color = myred, alpha = .2, size = .5) +
  geom_line(data = scenario, aes(x = date, y=projection, color="projection"), size=2.5) +
  geom_line(data = scenario, aes(x = date , y=reality, color = " réalité"), size=1) +
  geom_vline(xintercept = as.Date("2021-11-26"), linetype = "dashed", alpha=.5) + 
  annotate('text', x = as.Date("2021-11-25"), y = 5, label = "date de la\nprojection", color = mygrey, fontface = "bold",
           family = "Times New Roman", hjust = "right", vjust = "bottom") +
  annotate('text', x = as.Date("2021-12-15"), y = 280, label = "projection", color = mygrey, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-12-06"), y = 250, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2021-11-01"), date("2021-12-25")) + g_theme + ylim(0, 410) +
  labs(title = "Admissions journalières en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 26 novembre 2021\n",
       caption = "\nSource: Projection à court terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/short_term/2021_december/new_SC/2021_11_30_new_SC.png", 
       plot =g, width = w, height = h)
ggsave("../images/short_term/2021_december/new_SC/2021_11_30_new_SC.svg", 
       plot =g, width = w, height = h)

scenario <- read.csv("short_term/new_SC/2021_12_06.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- ggplot(data= true_data_new_hosp_rea_no_mean) +
  geom_line(aes(x=date, y=new_rea), color = myred, alpha = .2, size = .5) +
  geom_line(data = scenario, aes(x = date, y=projection, color="projection"), size=2.5) +
  geom_line(data = scenario, aes(x = date , y=reality, color = " réalité"), size=1) +
  geom_vline(xintercept = as.Date("2021-12-03"), linetype = "dashed", alpha=.5) + 
  annotate('text', x = as.Date("2021-12-02"), y = 5, label = "date de la\nprojection", color = mygrey, fontface = "bold",
           family = "Times New Roman", hjust = "right", vjust = "bottom") +
  annotate('text', x = as.Date("2021-12-21"), y = 340, label = "projection", color = mygrey, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-12-15"), y = 230, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  xlim(date("2021-11-01"), date("2021-12-25")) + g_theme + ylim(0, 410) +
  labs(title = "Admissions journalières en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 3 décembre 2021\n",
       caption = "\nSource: Projection à court terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/short_term/2021_december/new_SC/2021_12_06_new_SC.png", 
       plot =g, width = w, height = h)
ggsave("../images/short_term/2021_december/new_SC/2021_12_06_new_SC.svg", 
       plot =g, width = w, height = h)

scenario <- read.csv("short_term/new_SC/2021_12_13.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- ggplot(data= true_data_new_hosp_rea_no_mean) +
  geom_line(aes(x=date, y=new_rea), color = myred, alpha = .2, size = .5) +
  geom_line(data = scenario, aes(x = date, y=projection, color="projection"), size=2.5) +
  geom_line(data = scenario, aes(x = date , y=reality, color = " réalité"), size=1) +
  annotate('text', x = as.Date("2021-12-09"), y = 5, label = "date de la\nprojection", color = mygrey, fontface = "bold",
           family = "Times New Roman", hjust = "right", vjust = "bottom") +
  annotate('text', x = as.Date("2021-12-21"), y = 380, label = "projection", color = mygrey, fontface = "bold",
           family = "Times New Roman") + 
  annotate('text', x = as.Date("2021-12-20"), y = 230, label = "réalité", color = myred, fontface = "bold",
           family = "Times New Roman") +
  geom_vline(xintercept = as.Date("2021-12-10"), linetype = "dashed", alpha=.5) + 
  xlim(date("2021-11-01"), date("2021-12-25")) + g_theme + ylim(0, 410) +
  labs(title = "Admissions journalières en soins critiques",
       subtitle = "Projection de l'Institut Pasteur du 10 décembre 2021\n",
       caption = "\nSource: Projection à court terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
       https://evaluation-modelisation-covid.github.io/france/")
ggsave("../images/short_term/2021_december/new_SC/2021_12_13_new_SC.png", 
       plot =g, width = w, height = h)
ggsave("../images/short_term/2021_december/new_SC/2021_12_13_new_SC.svg", 
       plot =g, width = w, height = h)

 # scenario <- read.csv("short_term/new_SC/2021_12_20.csv", sep=";") %>%
 #   mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
 # ggplot(data = scenario, aes(x = date)) +
 #   geom_line(aes(y=projection, color="projection"), size=2.5, se=F) +
 #   geom_line(aes(y=reality, color = " réalité"), size=1) +
 #   annotate('text', x = as.Date("2021-12-05"), y = 1420, label = "projection à 2 semaines\nsurestimation +40%", color = '#515a5a', fontface = "italic",
 #            family = "Times New Roman") +
 #   annotate('text', x = as.Date("2021-12-10"), y = 900, label = "réalité", color = myred, fontface = "bold",
 #            family = "Times New Roman") +
 #   geom_vline(xintercept = as.Date("2021-12-20"), linetype = "dashed", alpha=.5) +
 #   xlim(date("2021-11-01"), date("2021-12-31")) + g_theme + ylim(0, 500) +
 #   labs(title = "Admissions journalières à l'hôpital",
 #        subtitle = "Projection de l'Institut Pasteur du 20 décembre 2021\n",
 #        caption = "\nSource: Projection à cour terme des besoins hospitaliers, Institut Pasteur \nhttps://modelisation-covid19.pasteur.fr/realtime-analysis/hospital/
 #        https://evaluation-modelisation-covid.github.io/france/")
