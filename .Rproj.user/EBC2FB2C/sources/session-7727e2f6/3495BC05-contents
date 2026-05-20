library(shiny)
library(DT)

WALK_FILE <- "walks.csv"

server <- function(input, output, session) {
  
  # Load existing data if file exists, otherwise start empty
  walks <- reactiveVal({
    if (file.exists(WALK_FILE)) {
      read.csv(WALK_FILE)
    } else {
      data.frame(
        Date = character(),
        Time = character(),
        Humans = character(),
        Dogs = character(),
        Animals = character()
      )
    }
  })
  
  observeEvent(input$save, {
    
    humans <- input$human_participants
    if ("Other" %in% humans) humans <- c(humans[humans != "Other"], input$human_other)
    
    dogs <- input$canine_participants
    if ("Other" %in% dogs) dogs <- c(dogs[dogs != "Other"], input$canine_other)
    
    animals <- input$animal_sightings
    if ("Other" %in% animals) animals <- c(animals[animals != "Other"], input$animal_other)
    
    new_row <- data.frame(
      Date = format(input$date),
      Time = input$time_of_walk,
      Humans = paste(humans, collapse = ", "),
      Dogs = paste(dogs, collapse = ", "),
      Animals = paste(animals, collapse = ", ")
    )
    updated <- rbind(walks(), new_row)
    walks(updated)
    write.csv(updated, WALK_FILE, row.names = FALSE)
    
    updateCheckboxGroupInput(session, "human_participants", selected = character(0))
    updateCheckboxGroupInput(session, "canine_participants", selected = character(0))
    updateCheckboxGroupInput(session, "animal_sightings", selected = character(0))
  })
  
  observeEvent(input$delete, {
    selected <- input$walk_table_rows_selected
    if (!is.null(selected)) {
      updated <- walks()[-selected, ]
      row.names(updated) <- NULL        # reset row numbers
      walks(updated)
      write.csv(updated, WALK_FILE, row.names = FALSE)
    }
  })
  
  output$walk_table <- renderDT({
    walks()
  })
  
  observeEvent(input$delete, {
    selected <- input$walk_table_rows_selected
    if (!is.null(selected)) {
      updated <- walks()[-selected, ]
      walks(updated)
      write.csv(updated, WALK_FILE, row.names = FALSE)
    }
  })
  
}