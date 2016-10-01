# COURSE: Developing Data Products by Johns Hopkins University
# Peer-graded Assignment: Course Project: Shiny Application and Reproducible Pitch
# Author: Francisco González Alonso
# Date: 2016/09/25
# Comments: Web app in shiny for Course Project of Developing Data Products 
# course.

# This is the user-interface definition for my BMI-calculator Shiny web application.

library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Body Mass Index - CALCULATOR"),
  
  
  sidebarLayout(
    
    sidebarPanel(
      
      # Text input for username
      textInput(inputId="name", label = "Input Your name:"),
      
      # Slider input for height
      sliderInput("height", "Height (Centimeters):",
                  min = 1,
                  max = 250,
                  value = 172
      ),
      
      # Slider input for Weight
      sliderInput("weight", " Weight (Kilograms):",
                  min = 1,
                  max = 150,
                  value = 70
      ), 
      
      # Action button to tigger the actions
      actionButton("goButton", "Calculate!")
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      
      # text output for name and instructions of app.
      textOutput('textOutputName'),
      
      # text output for BMC 
      textOutput('textOutputIMC'),
      
      # text output for Body Mass Class message
      textOutput('textOutputMSG'),
      
      # Plot for BMC class vs BMC user
      imageOutput("BMCPlot"),
      
      # text output for Recomendation Weight
      textOutput('textOutputRCM')
      
    )
    
    
  )
  
))

