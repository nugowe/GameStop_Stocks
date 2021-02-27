 
library(shiny)
library(bslib)
library(quantmod)


ui <- fluidPage(
    theme = bslib::bs_theme(version = 4, bootswatch = "cyborg"),
    
    HTML('<center><img src="Gamestop.png"></center>'),
    
    fluidPage(align = "center",
              
              plotOutput('GameStock')
              
              ),

    fluidPage(align = "center",
              dateRangeInput('dateRange',
                             label = '',
                             start = '2007-01-03', end = Sys.Date()
              ),
              
              
              ),
    fluidPage(align = "center",
              verbatimTextOutput("dateRangeText")
              
              )
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$dateRangeText  <- renderText({
        paste( 
              paste(as.character(input$dateRange))
        )
    })
    
    output$GameStock <- renderPlot({
        getSymbols("GME", src = "yahoo")
        chartSeries(GME, subset = paste0(input$dateRange[1],"::", input$dateRange[2], "'"))
        
        
        
       
        
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
