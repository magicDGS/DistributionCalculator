# DistributionCalculator app: server.R
# Written by D Gomez-Sanchez

# Functions written outside for readability
source("./functions.R")

shinyServer(function(input, output) {
  #ui output
  output$options <- renderUI({
    if(input$type_pval == "both") {
      sliderInput("val",
                 em("Test value 1"),
                 min=input$mu_pval-3*input$sigma_pval,
                 max=input$mu_pval,
                 value=round(qnorm(0.025, mean=input$mu_pval, sd=input$sigma_pval), 2),
                 step=0.01)
    } else {
      sliderInput("val",
                  em("Test value"),
                  min=input$mu_pval-3*input$sigma_pval,
                  max=input$mu_pval+3*input$sigma_pval,
                  value=round(qnorm(0.05, mean=input$mu_pval, sd=input$sigma_pval, lower.tail=FALSE), 2),
                  step=0.01)
    }
  })
  output$options_2 <- renderUI({
    if(input$type_pval == "both") {
      sliderInput("val_2",
                       em("Test value 2"),
                       min=input$mu_pval,
                       max=input$mu_pval+3*input$sigma_pval,
                       value=round(qnorm(0.025, mean=input$mu_pval, sd=input$sigma_pval, lower.tail=FALSE), 2),
                       step=0.01)
    }
  })
  #plot outputs
  output$plot_bin <- renderPlot({bin(input$N_bin, input$p_bin, input$line_bin, input$mean_bin)})
  output$plot_geom <- renderPlot({geom(input$p_geom, input$line_geom, input$mean_geom, c(0,input$limit_geom))})
  output$plot_exp <- renderPlot({expon(input$b_exp, input$mean_exp, c(0,input$limit_exp), input$type_exp)})
  output$plot_poiss <- renderPlot({poiss(input$lambda_poiss, input$line_poiss, input$mean_poiss, c(0, input$limit_poiss))})
  output$plot_norm <- renderPlot({normal(input$mu_norm, input$sigma_norm, input$mean_norm, input$type_norm)})
  #p_val outputs
  output$plot_pval <- renderPlot({
    if(input$type_pval == "both") {
      normal.prob2(input$mu_pval, input$sigma_pval, input$val, input$val_2)
    } else {
      normal.prob(input$mu_pval, input$sigma_pval, input$val, (input$type_pval == "lower"))
    }
  })
  output$pvalue <- renderText({
    if(input$type_pval == "both") {
      val1 <- as.numeric(input$val)
      val2 <- as.numeric(input$val_2)
      pval <- norm.pval(input$mu_pval, input$sigma_pval, val1, val2)
      result <- paste("P(X", "<", val1, " or ", "X", ">", val2, ") = ", pval, sep="")
    } else if(input$type_pval == "upper") {
      val2 <- as.numeric(input$val)
      pval <- norm.pval(input$mu_pval, input$sigma_pval, value2=val2)
      result <- paste("P(X", "<", val2, ") = ", pval, sep="")
    } else {
      val1 <- as.numeric(input$val)
      pval <- norm.pval(input$mu_pval, input$sigma_pval, value1=val1)
      result <- paste("P(X", ">", val1, ") = ", pval, sep="")
    }
    result
  })
})
