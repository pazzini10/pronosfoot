

 
source("Crawl.R")
def_jour=function(i){
calend=calendrier[which(calendrier[,1]==i),c(2,3,4,5,6)]
return(calend)}


pronos=read.table("./Pronos ligue1.csv",sep=";",header = TRUE)
 

#jointure avec les résultats

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
summary(bonus)
test=pronos_cal_final[which(pronos_cal_final$nom=="Maxime"),]
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


summary(pronos_cal_final)
summary(bonus)
base_pronos=rbind(pronos_cal_final,bonus)



#Classement par journée et au global

 

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

classement_total=classement_total[order(classement_total$journee,classement_total$points,decreasing = TRUE),]

def_cl=function(i){
  clls=classement_total[which(classement_total[,2]==i),-c(2,8,9,10)]
  return(clls)}

