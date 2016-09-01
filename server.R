#if (Sys.info()[1] == "Windows") Sys.setlocale("LC_TIME","C")
#if (Sys.info()[1] == "Windows") Sys.setlocale("LC_ALL")
#Sys.setlocale("LC_ALL","English")
options(xtable.include.rownames=F)
library(shiny)




# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {

  source("Crawl.R")
  source("Calcul1.R")
  
  
  ##Calendrier Ligue1  
  # Return the requested dataset
  calendrierl1 <- reactive({
    switch(input$calendrierl1,
           "Journee1" = def_jour(1),
           "Journee2" = def_jour(2),
           "Journee3" = def_jour(3),
           "Journee4" = def_jour(4),
           "Journee5" = def_jour(5),
           "Journee6" = def_jour(6),
           "Journee7" = def_jour(7),
           "Journee8" = def_jour(8),
           "Journee9" = def_jour(9),
           "Journee10" = def_jour(10),
           "Journee11" = def_jour(11),
           "Journee12" = def_jour(12),
           "Journee13" = def_jour(13),
           "Journee14" = def_jour(14),
           "Journee15" = def_jour(15),
           "Journee16" = def_jour(16),
           "Journee17" = def_jour(17),
           "Journee18" = def_jour(18),
           "Journee19" = def_jour(19),
           "Journee20" = def_jour(20),
           "Journee21" = def_jour(21),
           "Journee22" = def_jour(22),
           "Journee23" = def_jour(23),
           "Journee24" = def_jour(24),
           "Journee25" = def_jour(25),
           "Journee26" = def_jour(26),
           "Journee27" = def_jour(27),
           "Journee28" = def_jour(28),
           "Journee29" = def_jour(29),
           "Journee30" = def_jour(30),
           "Journee31" = def_jour(31),
           "Journee32" = def_jour(32),
           "Journee33" = def_jour(33),
           "Journee34" = def_jour(34),
           "Journee35" = def_jour(35),
           "Journee36" = def_jour(36),
           "Journee37" = def_jour(37),
           "Journee38" = def_jour(38))
  })
  
  # Generate a summary of the dataset
  # Show the first "n" observations
  output$calendrierl1 <- renderTable({
    calendrierl1()
    
  })
  
  output$downloadData <- downloadHandler(
    filename = function() { 
      paste(input$calendrierl1, '.csv', sep=' ') 
    },
    content = function(file) {
      write.table(calendrierl1(), file, sep=";")
    }
  )
  
  output$liste_jourg <-renderUI({
    selectInput('Journee_g',
                'Journee :',
                choices = unique(as.character(classement_total[order(classement_total$journee,decreasing=TRUE),]$journee))) })

  output$liste_jour <-renderUI({
    selectInput('Journee',
                'Journee :',
                choices = unique(as.character(base_pronos_tab[order(base_pronos_tab$journee,decreasing=TRUE),]$journee))) }) 
  
  output$liste_joueur <-renderUI({
    selectInput('Nom',
                'Footix :',
                
                choices = unique(as.character(base_pronos_tab[order(base_pronos_tab$nom),]$nom))) }) 
  
  

  
  
  
  # Generate a summary of the dataset
  

  
  # Show the first "n" observations
  output$classementl1 <- DT::renderDataTable(
    DT::datatable({
      classementl1=classement_total[classement_total$journee == input$Journee_g,]
      classementl1<-  classementl1[,-2] 
      
      }
      , options = list(paging = FALSE,orderClasses = TRUE),rownames= FALSE)%>%
      
      formatPercentage('PartBonprono', 0) %>%
      formatPercentage('PartExact', 0) %>%
      formatPercentage('PartBon', 0) %>%
      formatPercentage('PartFaux', 0) 
  
  )  
  
  ##Calendrier Ligue1  
  # Return the requested dataset
  bon_equipel1 <- reactive({
    switch(input$bon_equipel1,
           "Alex" = def_eq("Alex"),
           "Anais" = def_eq("Anais"),
           "David" = def_eq("David"),
           "Edouard" = def_eq("Edouard"),
           "Florian" = def_eq("Florian"),
           "Gaetan" = def_eq("Gaetan"),
           "Martin" = def_eq("Martin"),
           "Maxime" = def_eq("Maxime"),
           "Pierre" = def_eq("Pierre"),
           "Quentin" = def_eq("Quentin"),
           "Romain" = def_eq("Romain"))
    
    
    
  })          
  
  
  
  
  
  output$bon_equipel1 <- DT::renderDataTable({
    DT::datatable(bon_equipel1(), options = list(paging = FALSE,orderClasses = TRUE),rownames= FALSE)
    
  })
  
  
  bon_playerl1 <- reactive({
    switch(input$bon_playerl1,
           "Angers SCO" = def_ply("Angers SCO"),
           "AS Monaco" = def_ply("AS Monaco"),
           "AS Nancy Lorraine" = def_ply("AS Nancy Lorraine"),
           "AS Saint-Etienne" = def_ply("AS Saint-Etienne"),
           "Dijon FCO" = def_ply("Dijon FCO"),
           "EA Guingamp" = def_ply("EA Guingamp"),
           "FC Lorient" = def_ply("FC Lorient"),
           "FC Metz" = def_ply("FC Metz"),
           "FC Nantes" = def_ply("FC Nantes"),
           "Girondins de Bordeaux" = def_ply("Girondins de Bordeaux"),
           "LOSC" = def_ply("LOSC"),
           "Montpellier Herault SC" = def_ply("Montpellier Herault SC"),
           "OGC Nice" = def_ply("OGC Nice"),
           "Olympique de Marseille" = def_ply("Olympique de Marseille"),
           "Olympique Lyonnais" = def_ply("Olympique Lyonnais"),
           "Paris Saint-Germain" = def_ply("Paris Saint-Germain"),
           "SC Bastia" = def_ply("SC Bastia"),
           "SM Caen" = def_ply("SM Caen"),
           "Stade Rennais FC" = def_ply("Stade Rennais FC"),
           "Toulouse FC" = def_ply("Toulouse FC") )
    
    
    
  })          
  
  
  
  
  
  output$bon_playerl1 <- DT::renderDataTable({
    DT::datatable(bon_playerl1(), options = list(paging = FALSE,orderClasses = TRUE),rownames= FALSE) 
    
  })
  
  top_flop <- reactive({
    switch(input$top_flop,
           "Top" = top_eq,
           "Flop" = flop_eq )
    
    
    
  })          
  
  
  
  
  
  output$top_flop <- DT::renderDataTable({
    DT::datatable(top_flop(), options = list(paging = FALSE,orderClasses = TRUE),rownames= FALSE)
    
  })
  
  
  output$pronos_joueur <- DT::renderDataTable(DT::datatable({
    
     
    base_pronos_tab <- base_pronos_tab[base_pronos_tab$journee == input$Journee,]
    base_pronos_tab <- base_pronos_tab[base_pronos_tab$nom == input$Nom,]
    base_pronos_tab<-  base_pronos_tab[,-c(1,2)]
   
    
  }, options = list(paging = FALSE,orderClasses = TRUE),rownames= FALSE))

  
})