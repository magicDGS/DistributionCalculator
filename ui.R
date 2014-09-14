# DistributionCalculator app: ui.R
# Written by D Gomez-Sanchez

library(markdown)

shinyUI(
  bootstrapPage(
    navbarPage("Distribution Calculator",
            tabPanel("Documentation",
                     includeMarkdown("README.md")),
            navbarMenu("Distributions",
                       tabPanel("Binomial", headerPanel(h3("Binomial distribution")),
                               sidebarLayout(
                                 sidebarPanel(
                                   h4("Parameters"),
                                   sliderInput("p_bin", em("p"), value=0.2, min=0.05, max=1, step=0.05),
                                   sliderInput("N_bin", em("N"), value=10, min=1, max=100, step=1),
                                   h4("Visualization options"),
                                   checkboxInput(inputId="line_bin", label="Lines", value=FALSE),
                                   checkboxInput(inputId="mean_bin", label="Mean/Variance", value=FALSE)
                                 ),
                                 mainPanel(
                                   h4("Distribution"),
                                   plotOutput("plot_bin"),
                                   h4("Characteristics"),
                                   includeMarkdown("./Distributions/Binomial.md")
                                 )
                               )
                       ),
                       tabPanel("Geometric", headerPanel(h3("Geometric distribution")),
                                sidebarLayout(
                                  sidebarPanel(
                                    h4("Parameters"),
                                    sliderInput("p_geom", em("p"), value=0.2, min=0.05, max=1, step=0.05),
                                    h4("Visualization options"),
                                    checkboxInput(inputId="line_geom", label="Lines", value=FALSE),
                                    checkboxInput(inputId="mean_geom", label="Mean/Variance", value=FALSE),
                                    sliderInput("limit_geom", em("Plot limit"),min=5, max=1000, value = 20, step=5)
                                  ),
                                  mainPanel(
                                    h4("Distribution"),
                                    plotOutput("plot_geom"),
                                    h4("Characteristics"),
                                    includeMarkdown("./Distributions/Geometric.md")
                                  )
                                )
                       ),
                       tabPanel("Exponential", headerPanel(h3("Exponential distribution")),
                                sidebarLayout(
                                  sidebarPanel(
                                    h4("Parameters"),
                                    sliderInput("b_exp", em("b"), value=0.2, min=0.05, max=1, step=0.05),
                                    h4("Visualization options"),
                                    radioButtons("type_exp", label = em("Function"), choices = list("Density" = "dens", "CDF" = "cdf"), selected = "dens"),
                                    checkboxInput(inputId="mean_exp", label="Mean/Variance", value=FALSE),
                                    sliderInput("limit_exp", em("Plot limit"),min=2, max=20, value = 20, step=2)
                                    
                                  ),
                                  mainPanel(
                                    h4("Distribution/CDF"),
                                    plotOutput("plot_exp"),
                                    h4("Characteristics"),
                                    includeMarkdown("./Distributions/Exponential.md")
                                  )
                                )
                       ),
                       tabPanel("Poisson", headerPanel(h3("Poisson distribution")),
                                sidebarLayout(
                                  sidebarPanel(
                                    h4("Parameters"),
                                    sliderInput("lambda_poiss", em(HTML("&lambda;")), value=2, min=1, max=100, step=1),
                                    h4("Visualization options"),
                                    checkboxInput(inputId="line_poiss", label="Lines", value=FALSE),
                                    checkboxInput(inputId="mean_poiss", label="Mean/Variance", value=FALSE),
                                    sliderInput("limit_poiss", em("Plot limit"),min=10, max=200, value = 10, step=10)
                                  ),
                                  mainPanel(
                                    h4("Distribution"),
                                    plotOutput("plot_poiss"),
                                    h4("Characteristics"),
                                    includeMarkdown("./Distributions/Poisson.md")
                                  )
                                )
                       ),
                       tabPanel("Normal",headerPanel(h3("Normal distribution")),
                                sidebarLayout(
                                  sidebarPanel(
                                    h4("Parameters"),
                                    sliderInput("mu_norm", em(HTML("&mu;")), value=2, min=-10, max=10, step=1),
                                    sliderInput("sigma_norm", em(HTML("&sigma;")), value=2, min=1, max=40, step=1),
                                    h4("Visualization options"),
                                    radioButtons("type_norm", label = em("Function"), choices = list("Density" = "dens", "CDF" = "cdf"), selected = "dens"),
                                    checkboxInput(inputId="mean_norm", label="Mean/Variance", value=FALSE)
                                  ),
                                  mainPanel(
                                    h4("Distribution"),
                                    plotOutput("plot_norm"),
                                    h4("Characteristics"),
                                    includeMarkdown("./Distributions/Normal.md")
                                  )
                                )
                       )
            ),
            navbarMenu("Probabilities",
              tabPanel("Explanation",
                       includeMarkdown("Probabilities.md")),
              tabPanel("Normal example",headerPanel(h3("Normal distribution")),
                       sidebarLayout(
                         sidebarPanel(
                           h4("Parameters"),
                           sliderInput("mu_pval", em(HTML("&mu;")), value=0, min=-10, max=10, step=1),
                           sliderInput("sigma_pval", em(HTML("&sigma;")), value=1, min=1, max=40, step=1),
                           h4("Visualization options"),
                           radioButtons("type_pval", label = em("Test"), choices = list("Upper tail" = "upper", "Lower tail" = "lower", "Both" = "both"), selected = "upper"),
                           uiOutput("options"),
                           uiOutput("options_2")
                           #numericInput("val", "Test value", min=mu_pval-3*sigma_pval, max=mu_pval-3*sigma_pval, value=0)
                         ),
                         mainPanel(
                           h4("Probability region"),
                           plotOutput("plot_pval"),
                           h4("Result"),
                           h3(textOutput("pvalue"), align="center")
                         )
                       )
                       
              )
            )
    )
  )
)

