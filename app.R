library(ellmer)
library(shiny)
library(bslib)
library(querychat)

OPENAI_API_KEY <- Sys.getenv("OPENAI_API_KEY")

querychat_config <- querychat_init(mtcars)

ui <- page_sidebar(
  sidebar = querychat_sidebar("chat"),
  DT::DTOutput("dt")
)

server <- function(input, output, session) {
  
  querychat <- querychat_server("chat", querychat_config)
  
  output$dt <- DT::renderDT({
    DT::datatable(querychat$df())
  })
}

shinyApp(ui, server)
