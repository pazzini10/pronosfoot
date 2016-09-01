packages<-function(x){
  x<-as.character(match.call()[[2]])
  if (!require(x,character.only=TRUE)){
    install.packages(pkgs=x,repos="http://cran.r-project.org")
    require(x,character.only=TRUE)
  }
}
packages(shiny)
packages(formattable)
packages(plyr)
packages(reshape2)
packages(DT)
packages(datasets)
packages(rvest)
packages(stringr)
packages(httr)
packages(XML)
packages(shinythemes)

library(shiny)
library(formattable)
library(plyr) 
library(reshape2)
library(DT)
library(datasets)
library(rvest)
library(stringr)
library(httr)
library(XML)
library(shinythemes)



