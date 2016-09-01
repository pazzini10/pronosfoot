pronos=read.table("./Pronos ligue1.csv",sep=";",header = TRUE)

#Patch pour Montpellier et les accents !!

pronos$home=as.character(pronos$home)
pronos$away=as.character(pronos$away)
pronos$home[str_sub(pronos$home, 1, 11) =="Montpellier"]  = "Montpellier Herault SC"
pronos$away[str_sub(pronos$away, 1, 11) =="Montpellier"]  = "Montpellier Herault SC"

#load("calendrier.Rda")

calendrier$home[str_sub(calendrier$home, 1, 11) =="Montpellier"] = "Montpellier Herault SC"
calendrier$away[str_sub(calendrier$away, 1, 11) =="Montpellier"] = "Montpellier Herault SC"

def_jour=function(i){
  calend=as.data.frame(calendrier[which(calendrier[,1]==i),c(2,3,4,5,6)])
  colnames(calend) <- c("Date","Heure","Domicile","Score","Exterieur")
  return(calend)
}


#setwd(dir = "C:/Users/dflouriot/Desktop/Application_prod")


#save(pronos,file="pronos.Rda")
#jointure avec les resultats





pronos_cal=merge(pronos,calendrier[,c(4,5,6,7,8)],by=c("home","away"))


pronos_cal_final=NULL
for (i in 4:14) {
  pronos_cal_f=pronos_cal[,c(1,2,3,i,15,16,17)]
  pronos_cal_f$nom=names(pronos_cal_f)[4]
  colnames(pronos_cal_f)[4] <- "pronos"
  pronos_cal_final=rbind(pronos_cal_final,pronos_cal_f)
}


pronos_cal_final <- cbind(pronos_cal_final,str_split_fixed(pronos_cal_final$pronos,"_",n = 2))
colnames(pronos_cal_final)[c(9,10)] <- c("home_pronos","away_pronos")
pronos_cal_final[,9]<-as.numeric(as.character(pronos_cal_final[,9]))
pronos_cal_final[,10]<-as.numeric(as.character(pronos_cal_final[,10]))



pronos_cal_final$points <- ifelse(
  pronos_cal_final$home_score==pronos_cal_final$home_pronos 
  &
    pronos_cal_final$away_pronos==pronos_cal_final$away_score,5,
  ifelse(
    pronos_cal_final$home_score-pronos_cal_final$away_score>0 
    &
      pronos_cal_final$home_pronos-pronos_cal_final$away_pronos>0,3,
    ifelse(
      pronos_cal_final$home_score-pronos_cal_final$away_score<0 
      &
        pronos_cal_final$home_pronos-pronos_cal_final$away_pronos<0,3,
      ifelse(
        pronos_cal_final$home_score-pronos_cal_final$away_score==0 
        &
          pronos_cal_final$home_pronos-pronos_cal_final$away_pronos==0,3,0))))



bonus=table(pronos_cal_final[which(pronos_cal_final$points>0),]$nom,pronos_cal_final[which(pronos_cal_final$points>0),]$journee)
bonus=as.data.frame(bonus)

colnames(bonus)[c(1,2,3)] <- c("nom","journee","bon_pronos")

bonus$points <- ifelse(
  bonus$bon_pronos==7,2,
  ifelse(
    bonus$bon_pronos==8,5,
    ifelse(
      bonus$bon_pronos==9,10,
      ifelse(
        bonus$bon_pronos==10,15,0))))

bonus=bonus[,-3]
bonus$score="bonus"
bonus$pronos="bonus"
bonus$home=" "
bonus$away=" "
bonus$home_score =" "
bonus$home_pronos= " "
bonus$away_score= " "
bonus$away_pronos= " "



base_pronos=rbind(pronos_cal_final,bonus)



#Classement par journee et au global



#classement=as.data.frame(apply(as.matrix(base_pronos$points), 2, function(x) tapply(x, c(base_pronos$nom,base_pronos$journee) , sum,na.rm=TRUE)))
cl_j=aggregate(base_pronos$points,list(nom=base_pronos$nom,journee=base_pronos$journee),sum,na.rm=TRUE)
cl_g=aggregate(base_pronos$points,list(nom=base_pronos$nom),sum,na.rm=TRUE)
cl_g$journee="Global"

names(cl_g)[2]<-"points"
names(cl_j)[3]<-"points"

cl_f=rbind(cl_g,cl_j)


#count gives you n-way frequency o/p for all pairs. 
comp_j=count(pronos_cal_final,vars = c("journee","nom","points"))

comp_j=dcast(comp_j, journee + nom ~ points, value.var="freq", fill=0)

colnames(comp_j)[c(3,4,5)]<- c("Faux","Bon","Exact")
comp_j=comp_j[,-6]

comp_g=count(pronos_cal_final,vars = c("nom","points"))

comp_g=dcast(comp_g, nom ~ points, value.var="freq", fill=0)

colnames(comp_g)[c(2,3,4)]<- c("Faux","Bon","Exact")
comp_g=comp_g[,-5]
comp_g$journee="Global"

comp_f=rbind(comp_g,comp_j)

comp_f$bon_prono=comp_f$Bon+comp_f$Exact
comp_f$bon_prono_exact=comp_f$Exact
comp_f$bon_prono_pas_exact=comp_f$Bon
comp_f$prono_faux=comp_f$Faux

comp_f=comp_f[order(comp_f$bon_prono,decreasing = TRUE),]

comp_f$part_bon_prono=percent(comp_f$bon_prono/(comp_f$bon_prono+comp_f$prono_faux),digits=0)
comp_f$part_bon_prono_exact=percent(comp_f$bon_prono_exact/(comp_f$bon_prono+comp_f$prono_faux),digits=0)
comp_f$part_bon_prono_pas_exact=percent(comp_f$bon_prono_pas_exact/(comp_f$bon_prono+comp_f$prono_faux),digits=0)
comp_f$part_prono_faux=percent(comp_f$prono_faux/(comp_f$bon_prono+comp_f$prono_faux),digits=0)

classement_total=merge(cl_f,comp_f,by=c("nom","journee"))

#Rename base_pronos

colnames(classement_total)[c(1:14)]<- c("V1","V2","V3","V4","V5","V6","V7","V8","V9","V10","V11","V12","V13","V14")
classement_total$Nom=classement_total$V1
classement_total$journee=classement_total$V2
classement_total$Points=classement_total$V3
classement_total$Bonprono=classement_total$V7
classement_total$Exact=classement_total$V6
classement_total$Bon=classement_total$V5
classement_total$Faux=classement_total$V4
classement_total$PartBonprono=classement_total$V11
classement_total$PartExact=classement_total$V12
classement_total$PartBon=classement_total$V13
classement_total$PartFaux=classement_total$V14


classement_total=classement_total[,-c(1:14)]
classement_total=classement_total[order(classement_total$journee,classement_total$Points,decreasing = TRUE),]

def_cl=function(i){
  clls=classement_total[which(classement_total[,2]==i),-2]
  return(clls)}

## Top Flop

# Top Flop Par joueur



comp_eq=count(pronos_cal_final,vars = c("home","nom","points"))
comp_eq=dcast(comp_eq, home + nom ~ points, value.var="freq", fill=0)
colnames(comp_eq)[c(1,3,4,5)]<- c("Equipe","Faux","Bon","Exact")
comp_eq=comp_eq[,-6]

comp_eq2=count(pronos_cal_final,vars = c("away","nom","points"))
comp_eq2=dcast(comp_eq2, away + nom ~ points, value.var="freq", fill=0)
colnames(comp_eq2)[c(1,3,4,5)]<- c("Equipe","Faux","Bon","Exact")
comp_eq2=comp_eq2[,-6]

com_eq_f=rbind(comp_eq,comp_eq2)
eq_1=aggregate(com_eq_f$Exact,list(nom=com_eq_f$nom,equipe=com_eq_f$Equipe),sum,na.rm=TRUE)
names(eq_1)[3]<-"Exact"
eq_2=aggregate(com_eq_f$Bon,list(nom=com_eq_f$nom,equipe=com_eq_f$Equipe),sum,na.rm=TRUE)
names(eq_2)[3]<-"Bon"
eq_3=aggregate(com_eq_f$Faux,list(nom=com_eq_f$nom,equipe=com_eq_f$Equipe),sum,na.rm=TRUE)
names(eq_3)[3]<-"Faux"
cl_eq=merge(eq_1,eq_2,by=c("nom","equipe"))
cl_eq=merge(cl_eq,eq_3,by=c("nom","equipe"))

cl_eq$Bon_pronos=cl_eq$Exact+cl_eq$Bon
cl_eq$points=cl_eq$Exact*5+cl_eq$Bon*3
colnames(cl_eq)[c(1,2,3,4,5,6,7)]<- c("V1","V2","V3","V4","V5","V6","V7")
cl_eq$Nom=cl_eq$V1
cl_eq$Equipe=cl_eq$V2
cl_eq$Points=cl_eq$V7
cl_eq$BonPronos=cl_eq$V6
cl_eq$Exact=cl_eq$V3
cl_eq$Bon=cl_eq$V4
cl_eq$Faux=cl_eq$V5
cl_eq=cl_eq[,-c(1:7)]

cl_eq=cl_eq[order(cl_eq$Nom,cl_eq$Points,decreasing = TRUE),]

def_eq=function(i){
  cleq=cl_eq[which(cl_eq[,1]==i),-1]
  return(cleq)}

# Top Flop Par equipe


cl_eq_pl=cl_eq[order(cl_eq$Equipe,cl_eq$Points,decreasing = TRUE),]
cl_eq_pl$Equipe=as.character(cl_eq_pl$Equipe)


 
def_ply=function(i){
  cleqi=cl_eq_pl[which(cl_eq_pl[,2]==i),-2]
  return(cleqi)}



# Meilleure / Pire equipes



top_eq <- cl_eq_pl[order(cl_eq_pl$Nom,cl_eq_pl$Points,decreasing=TRUE),]

top_eq <- top_eq[!duplicated(top_eq$Nom),]
top_eq=top_eq[order(top_eq$Points,decreasing = TRUE),]

flop_eq <- cl_eq_pl[order(cl_eq_pl$Nom,cl_eq_pl$Points,decreasing=FALSE),]

flop_eq <- flop_eq[!duplicated(flop_eq$Nom),]
flop_eq=flop_eq[order(flop_eq$Points,decreasing = TRUE),]

# Les pronos de tous les joueurs



base_pronos$pronostics=paste(base_pronos$home_pronos,"-",base_pronos$away_pronos)
base_pronos_tab=base_pronos[,-c(4,6,7,9,10)]

colnames(base_pronos_tab)[c(1,2,3,4,5,6,7)]<- c("V1","V2","V3","V4","V5","V6","V7")
base_pronos_tab$journee=base_pronos_tab$V3
base_pronos_tab$nom=base_pronos_tab$V5
base_pronos_tab$Domicile=base_pronos_tab$V1
base_pronos_tab$Score=base_pronos_tab$V4
base_pronos_tab$Exterieur=base_pronos_tab$V2
base_pronos_tab$Pronos=base_pronos_tab$V7
base_pronos_tab$Points=base_pronos_tab$V6
base_pronos_tab=base_pronos_tab[,-c(1:7)]
base_pronos_tab$Pronos[base_pronos_tab$Score =="bonus"] = "bonus"
base_pronos_tab$Score[base_pronos_tab$Pronos =="bonus"] = " "





  
