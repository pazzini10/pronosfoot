library(shiny)

# Define UI for dataset viewer application
shinyUI(navbarPage(style = "color:white; font-family:'Comic Sans MS'", 
                      "Pronos footix",
                   
                   tabPanel("Calendrier et Resultats",                 
                            fluidPage(theme=shinytheme("flatly"),
                              
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
                     fluidRow(uiOutput("liste_jourg")
                              
                              
                              
                              
                     )
                     
                     # Show a summary of the dataset and an HTML table with the requested
                     # number of observations
                     ,fluidRow(
                       
                       DT::dataTableOutput("classementl1") 
                       
                     )
                     
                     
                     
                     
                   )),
                   tabPanel("Pronos", fluidPage(
                     fluidRow(column(4,uiOutput("liste_jour"))
                              ,
                              column(4,uiOutput("liste_joueur"))
                              
                              
                              
                              
                              
                     )
                     
                     # Show a summary of the dataset and an HTML table with the requested
                     # number of observations
                     ,fluidRow(
                       
                       DT::dataTableOutput("pronos_joueur") 
                       
                     )
                     
                     
                     
                     
                   ))
                   ,tabPanel("Top Flop", 
                             tabsetPanel("Top Flop.x",
                                         tabPanel("Footix", fluidPage(
                                           fluidRow(
                                             selectInput("bon_equipel1", " ", 
                                                         choices = c(
                                                           "Alex",
                                                           "Anais",
                                                           "David",
                                                           "Edouard",
                                                           "Florian",
                                                           "Gaetan",
                                                           "Martin",
                                                           "Maxime",
                                                           "Pierre",
                                                           "Quentin",
                                                           "Romain"))
                                             
                                             
                                             
                                           )
                                           
                                           # Show a summary of the dataset and an HTML table with the requested
                                           # number of observations
                                           ,fluidRow(
                                             
                                             DT::dataTableOutput("bon_equipel1") 
                                             
                                           )
                                         )),
                                         tabPanel("Equipe", fluidPage(
                                           fluidRow(
                                             selectInput("bon_playerl1", " ", 
                                                         choices = c(
                                                           "Angers SCO",
                                                           "AS Monaco",
                                                           "AS Nancy Lorraine",
                                                           "AS Saint-Etienne",
                                                           "Dijon FCO",
                                                           "EA Guingamp",
                                                           "FC Lorient",
                                                           "FC Metz",
                                                           "FC Nantes",
                                                           "Girondins de Bordeaux",
                                                           "LOSC",
                                                           "Montpellier Herault SC",
                                                           "OGC Nice",
                                                           "Olympique de Marseille",
                                                           "Olympique Lyonnais",
                                                           "Paris Saint-Germain",
                                                           "SC Bastia",
                                                           "SM Caen",
                                                           "Stade Rennais FC",
                                                           "Toulouse FC"
                                                         ))
                                             
                                             
                                             
                                           )
                                           
                                           # Show a summary of the dataset and an HTML table with the requested
                                           # number of observations
                                           ,fluidRow(
                                             
                                             DT::dataTableOutput("bon_playerl1") 
                                             
                                           )
                                         )),
                                         tabPanel("Top/Flop", fluidPage(
                                           fluidRow(
                                             selectInput("top_flop", " ", 
                                                         choices = c(
                                                           "Top",
                                                           "Flop"
                                                         ))
                                             
                                             
                                             
                                           )
                                           
                                           # Show a summary of the dataset and an HTML table with the requested
                                           # number of observations
                                           ,fluidRow(
                                             
                                             DT::dataTableOutput("top_flop") 
                                             
                                           )
                                         ))
                                         
                                         
                                         
                                         
                                         
                                         
                             )
                             
                             
                             
                   )
                   
                   
                   
))