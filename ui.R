library(shiny)

# Define UI for dataset viewer application
shinyUI(navbarPage("Pronos entre amis",
  
  tabPanel("Calendrier et Resultats",                 
           fluidPage(
  
  # Application title
  
  
  # Sidebar with controls to select a dataset and specify the number
  # of observations to view
             fluidRow(
    selectInput("calendrierl1", "Choisis ta journee:", 
                choices = c(
                  "Journee1",
                  "Journee2",
                  "Journee3",
                  "Journee4",
                  "Journee5",
                  "Journee6",
                  "Journee7",
                  "Journee8",
                  "Journee9",
                  "Journee10",
                  "Journee11",
                  "Journee12",
                  "Journee13",
                  "Journee14",
                  "Journee15",
                  "Journee16",
                  "Journee17",
                  "Journee18",
                  "Journee19",
                  "Journee20",
                  "Journee21",
                  "Journee22",
                  "Journee23",
                  "Journee24",
                  "Journee25",
                  "Journee26",
                  "Journee27",
                  "Journee28",
                  "Journee29",
                  "Journee30",
                  "Journee31",
                  "Journee32",
                  "Journee33",
                  "Journee34",
                  "Journee35",
                  "Journee36",
                  "Journee37",
                  "Journee38")),
    downloadButton('downloadData', 'Download')                
  )
,fluidRow(
  
  tableOutput("calendrierl1") )))

,tabPanel("Classement", fluidPage(
 fluidRow(
    selectInput("classementl1", "Choisis ta journee:", 
                choices = c(
                  "Global",
                  "Journee1",
                  "Journee2",
                  "Journee3",
                  "Journee4",
                  "Journee5",
                  "Journee6",
                  "Journee7",
                  "Journee8",
                  "Journee9",
                  "Journee10",
                  "Journee11",
                  "Journee12",
                  "Journee13",
                  "Journee14",
                  "Journee15",
                  "Journee16",
                  "Journee17",
                  "Journee18",
                  "Journee19",
                  "Journee20",
                  "Journee21",
                  "Journee22",
                  "Journee23",
                  "Journee24",
                  "Journee25",
                  "Journee26",
                  "Journee27",
                  "Journee28",
                  "Journee29",
                  "Journee30",
                  "Journee31",
                  "Journee32",
                  "Journee33",
                  "Journee34",
                  "Journee35",
                  "Journee36",
                  "Journee37",
                  "Journee38"))
    
    
    
  )
  
  # Show a summary of the dataset and an HTML table with the requested
  # number of observations
 ,fluidRow(
   
   DT::dataTableOutput("classementl1") 
   
 )
    
    
    
  
)




)


))