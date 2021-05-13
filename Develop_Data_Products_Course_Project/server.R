#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
    
    output$distPlot <- renderPlot({
        
        set.seed(20210504)
        
        sample.size <- input$in_samp
        n <- input$in_exp
        lambda <- as.numeric(input$in_lamb)
        sample.simulated <- replicate(sample.size, rexp(n, lambda))
        
        exponential.mean <- apply(sample.simulated, 2, mean)
        
        theoretical.mean <- 1/lambda
        theoretical.var <- ((1/lambda)^2)/n
        theoretical.sd <- 1/(lambda*sqrt(n))
        
        sample.mean <- mean(exponential.mean)
        sample.var <- var(exponential.mean)
        sample.sd <- sd(exponential.mean)

        output$out_sample_mean <- renderText(sample.mean)
        output$out_sample_sd <- renderText(sample.sd)
        output$out_theoretical_mean <- renderText(theoretical.mean)
        output$out_theoretical_sd <- renderText(theoretical.sd)
        
        g <- ggplot(data.frame(exponential.mean),
                    aes(x = exponential.mean)) +
            geom_histogram(aes(y = ..density..),
                           color = "black",
                           bins = 40) +
            stat_function(fun = dnorm,
                          args = list(mean = theoretical.mean,
                                      sd = theoretical.sd),
                          color = "blue",
                          size = 3) +
            stat_function(fun = dnorm,
                          args = list(mean = sample.mean,
                                      sd = sample.sd),
                          color = "yellow",
                          size = 1) +
            labs(y = "Density", x = "Mean")
        g
        
    })
    
})
