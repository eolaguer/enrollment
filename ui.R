library(shiny)

shinyUI(fluidPage(
  titlePanel("Course Enrollment History"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId="subject",
                  label="Select subject:",
                  choices=c("ABCD","WXYZ"),
                  selected="ABCD"
                  ),
      selectInput(inputId="course",
                  label="Select course code:",
                  choices=c("All"),
                  selected="All"
                  ),
      sliderInput('years','Select number of years history to view:',value=3,min=1,max=10,step=1)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Chart",
                 h4(textOutput("title")),
                 plotOutput("chart")
                 ),
        tabPanel("Table",
                 h4("Detailed Enrollment Data"),
                 dataTableOutput("table")
                 ),
        tabPanel("Help", 
                 h4("Online Enrollment Management"),
                 p("Welcome, folks! This webpage is a prototype of a Course Enrollment History component of an online app that could provide multiple tools for planning and monitoring student enrollment in school courses. By sharing data with more stakeholders, it enables greater participation in management processes and more timely intervention when problems and opportunities arise."),
                 h4("Interactive Chart"),
                 p("The graph compares the Actual Enrollment (blue line) and the Maximum Enrollment (red line) for a given term within the selected academic years. This is useful for gauging how effective the school has been in utilizing the available capacity (seats)."),
                 p("To explore historical enrollment data in an intuitive and visual manner, use the dropdown menus on the left side panel to zoom in on a specific subject or course. You can also adjust the slider to expand or reduce the number of academic years analyzed by the chart."),
                 p("Don't worry if you see an error message when you choose a new subject. It just means your existing Course selection is not consistent with your new Subject selection. Just make a new Course selection to remove the error message."),
                 h4("Interactive Data Table"),
                 p("To investigate trends found in the Chart, click on the Table tab to view the detailed data underlying the Chart. The table includes enrollment data at the level of each section or class of the selected course(s) within the selected time period. The table updates in real-time in response to user selections in the same dropdown menus and sliders that control the chart."),
                 p("In addition, the user can sort the table by clicking on the up/down arrows beside each data column. The first time you click, the table will sort in ascending order for the selected column. Click again to sort in descending order for the same column. You can only sort by one column at a time."),
                 p("If the data does not fit on a single page, you can browse through the different pages by clicking on the appropriate page buttons on the lower right hand side of the data table. If you know what you're looking for, you can zoom in to data on specific classes (without browsing through each page) by entering text in the search fields found at the bottom of each column in the table.")
                 )
      )
    )
  )
))