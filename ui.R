
library(bslib)
library(shiny)
library(lubridate)
library(DT)

fluidPage(
  tags$style(HTML("
    .shiny-input-container { width: 100% !important; }
    .checkbox-inline { font-size: 18px; }
    label { font-size: 18px; }
  ")),
  
  titlePanel("Walk Log"),
  
  dateInput(
    inputId = "date",
    label = "Date",
    value = Sys.Date()),
  
  selectizeInput("time_of_walk", "Time of Walk",
                 choices = c("Morning", "Midday", "Afternoon", "Evening")),
  
  checkboxGroupInput("human_participants", "Human Participants",
                     choices = c("Melanie", "Jennifer", "Grace", "Sebastian", "Anna", "Other")),
  conditionalPanel(
    condition = "input.human_participants.includes('Other')",
    textInput("human_other", "Please specify")
  ),
  
  checkboxGroupInput("canine_participants", "Canine Participants",
                     choices = c("Rock", "Piper", "Josie", "Other")),
  conditionalPanel(
    condition = "input.canine_participants.includes('Other')",
    textInput("canine_other", "Please specify")
  ),
  
  checkboxGroupInput("animal_sightings", "Animal Sightings of Note",
                     choices = c("Deer", "Coyote", "Snake", "Owl", "Other")),
  conditionalPanel(
    condition = "input.animal_sightings.includes('Other')",
    textInput("animal_other", "Please specify")
  ),
  
  actionButton("save", "Save Walk"),
  
  hr(),
  
  DTOutput("walk_table"),
  actionButton("delete", "Delete Selected Row")
)

