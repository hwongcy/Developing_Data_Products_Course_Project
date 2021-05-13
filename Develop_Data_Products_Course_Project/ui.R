#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Developing Data Products Course Project"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("in_samp",
                        "Number of Samples:",
                        min = 1000,
                        max = 5000,
                        value = 2000),
            sliderInput("in_exp",
                        "Number of Exponentials:",
                        min = 10,
                        max = 50,
                        value = 40),
            selectInput("in_lamb",
                        "Lambda:",
                        choices = list("0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8", "0.9"),
                        selected = "0.2"),
            #            sliderInput("in_lamb",
            #                        "What is the Lambda?",
            #                        min = 0.1,
            #                        max = 0.5,
            #                        value = 0.2),
            br(),
            submitButton("Submit"),
            
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            
            br(),
            em("Theoretical Mean: "),
            textOutput("out_theoretical_mean"),
            em("Theoretical SD: "),
            textOutput("out_theoretical_sd"),
            
            br(),
            em("Samples Mean: "),
            textOutput("out_sample_mean"),
            em("Samples SD: "),
            textOutput("out_sample_sd")
        )
    )
))
