#install.packages(c("rvest","stringr"))



fetch_l1_calendar <- function(saison=100){
  
  calendar=NULL # initialisaiton du data.frame de sortie
  
  # boucle sur les journee
  for (j in 1:38){
    #j=2
    #saison=100
    # creation de l'url de requete
    url <- paste0("http://www.lfp.fr/ligue1/competitionPluginCalendrierResultat/changeCalendrierJournee?sai=",saison,"&jour=",j)
    
    # extraction du code html
    site <- read_html(url)
    #save(site,file="site") 
    # nombre de jour dans la journee
    site %>% 
      html_node("body") %>%
      as.character() %>%
      str_count("<h4>") -> n_day
    
    # pour chaque jour recuperation de la date et des match
    for (i in 1:n_day){
      
      # xpath match
      xpath<-paste0('//*[@id="tableaux_rencontres"]/div/table[',i,']')
      
      # xpath date
      xpath2<-paste0('//*[@id="tableaux_rencontres"]/div/h4[',i,']')
      
      # recuperation des matchs
      site %>% 
        html_node("body") %>%
        html_node(xpath=xpath) %>%
        html_table -> temp
      
      # recuperation de la date
      site %>% 
        html_node("body") %>%
        html_node(xpath=xpath2) %>%
        html_text -> temp2
      
      calendar <- rbind(calendar,cbind(j,temp2,temp))
      
    }
  }
  
  # supression des variables inutiles
  calendar <- calendar[,c(1,2,3,4,6,8)]
  
  # renomage des colones
  colnames(calendar) <- c("journee","date","time","home","score","away")
  
  # separation du score en deux variables
  calendar <- cbind(calendar,str_split_fixed(calendar$score," - ",n = 2))
  
  # supression de l'ancienne colone de score
  #calendar <- calendar[,-5]
  
  # renomage des colones de scores
  colnames(calendar)[c(7,8)] <- c("home_score","away_score")
  calendar[,7]<-as.numeric(as.character(calendar[,7]))
  calendar[,8]<-as.numeric(as.character(calendar[,8]))
  
  # rajout du numero de la journee
  
  return(calendar)
}

##################
#   Saison
#
# 100 : 2016/2017
# 84  : 2015/1016
# 83  : 2014/2015
# ....
#
##################

calendrier=fetch_l1_calendar(saison=100)
#load("pronos.Rda")
#load("calendrier.Rda")



