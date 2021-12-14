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

theme_set(
  theme_classic() +
  theme(legend.position = "top", 
        legend.title = element_blank(),
        panel.grid.major.y = element_line(),
        text = element_text(family = "Times New Roman"),
        plot.title = element_text(face="bold"),
        axis.title.x = element_blank(),
        axis.title.y = element_blank())
  )
g_theme <- scale_color_manual(values=c('#ff0000','#D8D8D8'))
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
  summarise(hosp = sum(hosp, na.rm = T), 
            rea = sum(rea, na.rm = T),
            HospConv = sum(HospConv, na.rm = T))

#Nouvelles admissions à l'hôpital et en réanimation (moyenné sur 7 jours)
true_data_new_hosp_rea <- data_gouv_new_hosp_rea %>% 
  filter( #enlève l'Outre-Mer car les scénarios de Pasteur uniquement pour la France Métropolitaine
         dep != 971 & dep != 972 & dep != 973 & dep != 974 & dep != 976 & dep != 978) %>% 
  group_by(date) %>% #grouper tous les départements ensembles
  summarise(incid_hosp = sum(incid_hosp, na.rm = T), 
            incid_rea = sum(incid_rea, na.rm = T)) %>%
  mutate(new_rea_right = rollmean(incid_rea, 7, na.pad = T, align = "right"),#mean of 7 last days
         new_hosp_right = rollmean(incid_hosp, 7, na.pad = T, align = "right"),
         new_rea_center = rollmean(incid_rea, 7, na.pad = T, align = "center"),#centered mean
         new_hosp_center = rollmean(incid_hosp, 7, na.pad = T, align = "center"))

#Pour l'INSERM : admissions hebdomadaire à l'hôpital
true_data_new_hosp_rea_weekly <- data_gouv_new_hosp_rea %>% 
  group_by(date) %>% #je n'ai pas filtré les outre-mer ici car pas précisé, mais ne change pas grand-chose
  summarise(incid_hosp = sum(incid_hosp, na.rm = T)) %>%
  mutate(new_hosp_week = rollsum(incid_hosp, 7, na.pad = T, align = "left")) #patients arrivés dans les 7 derniers jours)

# September 25, 2020 ------------------------------------------------------
scenario <- read_delim("2020_09_25_Pasteur/beds_rea.csv", ";", escape_double = FALSE, trim_ws = TRUE) %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))

#patients en réanimation
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value, group=pasteur, color="scénarios")) + geom_smooth(se=F) + 
  geom_line(data= true_data_beds_hosp_rea, 
            aes(x=date, y=rea, color = "réalité", group="réalité"), size = 1) +
  #see dates of partial curfew + 2 weeks after (time to see the effects on reanimations) cf dates https://fr.wikipedia.org/wiki/Chronologie_de_la_pand%C3%A9mie_de_Covid-19_en_France
  geom_vline(xintercept = as.Date("2020-10-14"), linetype = "dashed", alpha=.5) + 
  geom_vline(xintercept = as.Date("2020-10-28"), linetype = "dashed", alpha=.5) +
  xlim(as.Date("2020-09-25"), as.Date("2020-11-01"))  + g_theme +
  labs(title = "Lits de réanimation occupés",
       subtitle = "scénarios publiés par l'Institut Pasteur le 25 septembre 2020",
       caption = "Data source:")
ggsave("graphs/Pasteur_2020_Octobre/Pasteur_octobre_reanimations.png", 
       plot =g, width = w, height = h)

# October 30, 2020 --------------------------------------------------------

#Lits de réanimation
scenario <- read.csv("2020_10_30_Pasteur/beds_rea.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value-200, group=pasteur, color="scénarios")) + geom_smooth(se=F) + 
  geom_line(data= true_data_beds_hosp_rea, 
            aes(x=date, y=rea, color = "réalité", group="true data"), size = 1) +
  xlim(as.Date("2020-10-15"), as.Date("2020-12-10")) + g_theme  +
  labs(title = "Lits de réanimation occupés",
       subtitle = "scénarios de l'Institut Pasteur du 30/10/2020 après l'annonce du confinement \nnon publiés mais retranscrits par la presse",
       caption = "Data source:")
ggsave("graphs/Pasteur_2020_Novembre/Pasteur_novembre_reanimations.png", 
       plot =g, width = w, height = h)  

#Admissions en réanimation
scenario <- read.csv("2020_10_30_Pasteur/new_rea.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value-30, group=pasteur, color="scénarios")) + geom_smooth(se=F) +
  geom_line(data= true_data_new_hosp_rea, 
            aes(x=date, y=new_rea_center, color = "réalité", group="réalité"), size = 1) +
  xlim(as.Date("2020-10-15"), as.Date("2020-12-10")) + g_theme +
  labs(title = "Admissions en réanimations",
       subtitle = "scénarios de l'Institut Pasteur du 30/10/2020 après l'annonce du confinement \nnon publiés mais retranscrits par la presse",
       caption = "Data source:")
ggsave("graphs/Pasteur_2020_Novembre/Pasteur_novembre_new_reanimations.png", 
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
  annotate("text", x=as.Date("2020-12-30"), y=9800, 
           label="'Nous savons que quoi que nous fassions, près de \n9000 patients seront en réanimation à la mi-novembre'
           Emmanuel Macron, discours du 28 octobre",
           fontface = "italic", size=3, hjust=1) + ylim(0,10500) +
  xlim(as.Date("2020-10-15"), as.Date("2020-12-30")) + g_theme +
  labs(title = "Lits de réanimation occupés",
       subtitle = "Chaque point représente une projection relayée par la presse \nLa ligne horizontale correspond à la citation d'Emmanuel Macron",
       caption = "Data source:")
ggsave("graphs/media/media_novembre.png", plot =g, width = w, height = h)



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
  #confinement de 16 départements le 20 mars cf https://fr.wikipedia.org/wiki/Chronologie_de_la_pand%C3%A9mie_de_Covid-19_en_France
  #2 semaines pour voir les effets sur hospitalisations. correspond aussi au confinement général du 3 avril
  geom_vline(xintercept = date("2021-03-20"), linetype = "dashed", alpha=.5) + 
  geom_vline(xintercept = date("2021-04-03"), linetype = "dashed", alpha=.5) +
  xlim(date("2021-01-01"), date("2021-04-04")) + g_theme +
  labs(title = "Nombre hebdomadaire d'admission à l'hôpital",
       subtitle = "scénarios publiés par l'INSERM le 16 janvier 2021",
       caption = "Data source:")
ggsave("graphs/INSERM/INSERM_16_janvier.png", 
       plot =g, width = w, height = h)

#2 février
scenario <- read.csv("2021_02_02_INSERM/new_hosp_INSERM.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=scenario, value = value, -date) %>%
  ggplot(aes(date, value+1700, group=scenario, color="scenarios")) + geom_smooth(se=F) +
  geom_line(data= true_data_new_hosp_rea_weekly, 
            aes(x=date, y=new_hosp_week, color = "réalité", group="réalité"), size = 1) +
  #confinement de 16 départements le 20 mars cf https://fr.wikipedia.org/wiki/Chronologie_de_la_pand%C3%A9mie_de_Covid-19_en_France
  #2 semaines pour voir les effets sur hospitalisations. correspond aussi au confinement général du 3 avril
  geom_vline(xintercept = date("2021-03-20"), linetype = "dashed", alpha=.5) + 
  geom_vline(xintercept = date("2021-04-03"), linetype = "dashed", alpha=.5) +
  xlim(date("2021-01-01"), date("2021-04-04")) + g_theme +
  labs(title = "Nombre hebdomadaire d'admission à l'hôpital",
       subtitle = "scénarios publiés par l'INSERM le 2 février 2021",
       caption = "Data source:")
ggsave("graphs/INSERM/INSERM_02_février.png", 
       plot =g, width = w, height = h)

#14 février
scenario <- read.csv("2021_02_14_INSERM/weekly_hospital.csv", sep=";") %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=scenario, value = value, -date) %>%
  ggplot(aes(date, value+1700, group=scenario, color="scénarios")) + geom_smooth(se=F) +
  geom_line(data= true_data_new_hosp_rea_weekly, 
            aes(x=date, y=new_hosp_week, color = "réalité", group="réalité"), size = 1) +
  #confinement de 16 départements le 20 mars cf https://fr.wikipedia.org/wiki/Chronologie_de_la_pand%C3%A9mie_de_Covid-19_en_France
  #2 semaines pour voir les effets sur hospitalisations. correspond aussi au confinement général du 3 avril
  geom_vline(xintercept = date("2021-03-20"), linetype = "dashed", alpha=.5) + 
  geom_vline(xintercept = date("2021-04-03"), linetype = "dashed", alpha=.5) + 
  xlim(date("2021-01-01"), date("2021-04-04")) + g_theme +
  labs(title = "Nombre hebdomadaire d'admission à l'hôpital",
       subtitle = "scénarios publiés par l'INSERM le 14 février 2021",
       caption = "Data source:")
ggsave("graphs/INSERM/INSERM_14_février.png", 
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
       caption = "Data source:")
ggsave("graphs/media/media_fevrier.png", plot =g, width = w, height = h)


# February 8, 2021 --------------------------------------------------------
scenario <- read_delim("2021_02_08_Pasteur/new_hosp.csv", ";", escape_double = FALSE, trim_ws = TRUE) %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))

#Admissions à l'hôpital
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value-100, group=pasteur, color="scénarios")) + geom_smooth(se=F) + 
  geom_line(data= true_data_new_hosp_rea, 
            aes(x=date, y=new_hosp_right, color = "réalité", group="réalité"), size = 1) +
  #confinement de 16 départements le 20 mars cf https://fr.wikipedia.org/wiki/Chronologie_de_la_pand%C3%A9mie_de_Covid-19_en_France
  #2 semaines pour voir les effets sur hospitalisations. correspond aussi au confinement général du 3 avril
  geom_vline(xintercept = date("2021-03-20"), linetype = "dashed", alpha=.5) + 
  geom_vline(xintercept = date("2021-04-03"), linetype = "dashed", alpha=.5) +
  xlim(date("2021-01-10"), date("2021-04-04")) + g_theme +
  labs(title = "Admission journalières à l'hôpital",
       subtitle = "scénarios publiés par l'Institut Pasteur le 8 février 2021",
       caption = "Data source:")
ggsave("graphs/Pasteur_2021_Février/Pasteur_2021_Février.png", 
       plot =g, width = w, height = h)


# July 26, 2021 -----------------------------------------------------------
#!! nécessité d'aligner les lits de réa à +200 dans leur scénario pour matcher avec vraies données

#Nouvelles admissions à l'hôpital
scenario <- read_delim("2021_07_26_Pasteur/new_hospital.csv", ";", escape_double = FALSE, trim_ws = TRUE) %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value, group=pasteur, color="scénarios")) + geom_smooth(se=F) +
  geom_line(data= true_data_new_hosp_rea, 
            aes(x=date, y=new_hosp_right, color = "réalité", group="réalité"), size = 1) +
  xlim(date("2021-07-15"), date("2021-10-10")) + g_theme +
  labs(title = "Admission journalières à l'hôpital",
       subtitle = "scénarios publiés par l'Institut Pasteur le 26 juillet 2021",
       caption = "Data source:")
ggsave("graphs/Pasteur_2021_Juillet/Pasteur_2021_juillet_new_hospital.png", 
       plot =g, width = w, height = h) 
    
#admissions en soins critiques
scenario <- read_delim("2021_07_26_Pasteur/new_SC.csv", ";", escape_double = FALSE, trim_ws = TRUE) %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value, group=pasteur, color="scénarios")) + geom_smooth(se=F) + 
  geom_line(data= true_data_new_hosp_rea, 
            aes(x=date, y=new_rea_right, color = "réalité", group="réalité"), size=1) +
  xlim(date("2021-07-15"), date("2021-10-10")) + g_theme +
  labs(title = "Admissions en soins critiques",
       subtitle = "scénarios publiés par l'Institut Pasteur le 26 juillet 2021",
       caption = "Data source:")
ggsave("graphs/Pasteur_2021_Juillet/Pasteur_2021_juillet_new_reanimation.png", 
       plot =g, width = w, height = h)
    
#Lits de soins critiques
scenario <- read_delim("2021_07_26_Pasteur/beds_SC.csv", ";", escape_double = FALSE, trim_ws = TRUE) %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value+300, group=pasteur, color="scénarios")) + geom_smooth(se=F) + 
  geom_line(data= true_data_beds_hosp_rea, 
            aes(x=date, y=rea, color = "réalité", group="réalité"), size=1) +
  xlim(as.Date("2021-07-15"), as.Date("2021-10-10")) + g_theme +
  labs(title = "Lits de soins critiques occupés",
       subtitle = "scénarios publiés par l'Institut Pasteur le 26 juillet 2021",
       caption = "Data source:")
ggsave("graphs/Pasteur_2021_Juillet/Pasteur_2021_juillet_reanimation_beds.png", 
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
       subtitle = "Chaque point représente une projection relayée par la presse",
       caption = "Data source:")
ggsave("graphs/media/media_juillet_hosp.png", plot =g, width = w, height = h)

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
       subtitle = "Chaque point représente une projection relayée par la presse",
       caption = "Data source:")
ggsave("graphs/media/media_juillet_SC.png", plot =g, width = w, height = h)

# August 5, 2021 ----------------------------------------------------------
#pareil, besoin d'aligner leurs lits de réa à +200

#Admissions à l'hopital
scenario <- read_delim("2021_08_05_Pasteur/new_hosp.csv", ";", escape_double = FALSE, trim_ws = TRUE) %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value, group=pasteur, color="scénarios")) + geom_line(size=1) + 
  geom_line(data= true_data_new_hosp_rea, 
            aes(x=date, y=new_hosp_center, color = "réalité", group="réalité"), size=1) +
  xlim(date("2021-07-15"), date("2021-10-10")) + ylim(0,2500) + g_theme +
  labs(title = "Admissions à l'hôpital",
       subtitle = "scénarios publiés par l'Institut Pasteur le 5 août 2021",
       caption = "Data source:")
ggsave("graphs/Pasteur_2021_Aout/Pasteur_2021_aout_new_hosp.png", 
       plot =g, width = w, height = h)
    
#Admissions en soins critiques
scenario <- read_delim("2021_08_05_Pasteur/new_SC.csv", ";", escape_double = FALSE, trim_ws = TRUE) %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=pasteur, value = value, -date) %>%
  ggplot(aes(date, value, group=pasteur, color="scénarios")) + geom_line(size=1) +
  geom_line(data= true_data_new_hosp_rea, 
            aes(x=date, y=new_rea_center, color = "réalité", group="réalité"), size=1) +
  xlim(date("2021-07-15"), date("2021-10-10")) + ylim(0,600) + g_theme +
  labs(title = "Admissions en soins critiques",
       subtitle = "scénarios publiés par l'Institut Pasteur le 5 août 2021",
       caption = "Data source:")
ggsave("graphs/Pasteur_2021_Aout/Pasteur_2021_aout_new_reanimation.png", 
       plot =g, width = w, height = h)
    
#Lits de soins critiques
scenario <- read_delim("2021_08_05_Pasteur/beds_SC.csv", ";", escape_double = FALSE, trim_ws = TRUE) %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=scenarios, value = value, -date) %>%
  ggplot(aes(date, value, group=scenarios, color="scénarios")) + geom_smooth(se=F) + 
  geom_line(data= true_data_beds_hosp_rea, 
            aes(x=date, y=rea, color = "réalité", group="réalité"), size=1) +
  xlim(date("2021-07-15"), date("2021-10-10")) + g_theme +
  labs(title = "Lits de soins critiques",
       subtitle = "scénarios publiés par l'Institut Pasteur le 5 août 2021",
       caption = "Data source:")
ggsave("graphs/Pasteur_2021_Aout/Pasteur_2021_aout_reanimation.png", 
       plot =g, width = w, height = h)
    
#Hospitalisation conventionnelle
scenario <- read_delim("2021_08_05_Pasteur/beds_hosp.csv", ";", escape_double = FALSE, trim_ws = TRUE) %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y", optional = T))
g <- scenario %>%
  gather(key=scenarios, value = value, -date) %>%
  ggplot(aes(date, value, group=scenarios, color="scénarios")) + geom_smooth(se=F) + 
  geom_line(data= true_data_beds_hosp_rea, 
            aes(x=date, y=HospConv, color = "réalité", group="réalité"), size=1) +
  xlim(date("2021-07-15"), date("2021-10-10")) + g_theme +
  labs(title = "Lits en hospitalisation conventionnelle",
       subtitle = "scénarios publiés par l'Institut Pasteur le 5 août 2021",
       caption = "Data source:")
ggsave("graphs/Pasteur_2021_Aout/Pasteur_2021_aout_hospconv.png", 
       plot =g, width = w, height = h)


