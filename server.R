

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
 

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
      write.csv(calendrierl1(), file)
    }
  )
 
  ##Calendrier Ligue1  
  # Return the requested dataset
  classementl1 <- reactive({
    switch(input$classementl1,
           "Global" = def_cl("Global"),
           "Journee1" = def_cl(1),
           "Journee2" = def_cl(2),
           "Journee3" = def_cl(3),
           "Journee4" = def_cl(4),
           "Journee5" = def_cl(5),
           "Journee6" = def_cl(6),
           "Journee7" = def_cl(7),
           "Journee8" = def_cl(8),
           "Journee9" = def_cl(9),
           "Journee10" = def_cl(10),
           "Journee11" = def_cl(11),
           "Journee12" = def_cl(12),
           "Journee13" = def_cl(13),
           "Journee14" = def_cl(14),
           "Journee15" = def_cl(15),
           "Journee16" = def_cl(16),
           "Journee17" = def_cl(17),
           "Journee18" = def_cl(18),
           "Journee19" = def_cl(19),
           "Journee20" = def_cl(20),
           "Journee21" = def_cl(21),
           "Journee22" = def_cl(22),
           "Journee23" = def_cl(23),
           "Journee24" = def_cl(24),
           "Journee25" = def_cl(25),
           "Journee26" = def_cl(26),
           "Journee27" = def_cl(27),
           "Journee28" = def_cl(28),
           "Journee29" = def_cl(29),
           "Journee30" = def_cl(30),
           "Journee31" = def_cl(31),
           "Journee32" = def_cl(32),
           "Journee33" = def_cl(33),
           "Journee34" = def_cl(34),
           "Journee35" = def_cl(35),
           "Journee36" = def_cl(36),
           "Journee37" = def_cl(37),
           "Journee38" = def_cl(38))
  })
  
  # Generate a summary of the dataset
  
  
  # Show the first "n" observations
  output$classementl1 <- DT::renderDataTable({
    DT::datatable(classementl1(), options = list(paging = FALSE,orderClasses = TRUE))
    
    
  })  
  
})
