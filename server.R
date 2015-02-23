library(shiny)
library(ggplot2)
library(reshape2)

#load and clean up the data
d <- read.csv("enrolldata.csv")
d$Course <- paste0(d$Subject,"-",d$CrseNumb)

#default selections
subjects <- sort(unique(as.character(d$Subject)))
coursesdefault <- sort(unique(d$Course[d$Subject==subjects[1]&d$AcyrCode>=2010&d$AcyrCode<2015]))

shinyServer(
  function(input, output, session) {

    #initialize client UI with default selections
    updateSelectInput(session,"subject",choices=subjects,selected=subjects[1])
    updateSelectInput(session,"course",choices=c("All",coursesdefault), selected="All")
    
    #recompute info based on input from client UI
    subject <- reactive(input$subject)
    course <- reactive(input$course)
    startyear <- reactive(2015-as.numeric(input$years))
    selectdata <- reactive(if(course()=="All") {
      selectdata <- d[d$Subject==subject()&d$AcyrCode>=startyear()&d$AcyrCode<2015,]
    } else {
      selectdata <- d[d$Subject==subject()&d$AcyrCode>=startyear()&d$AcyrCode<2015&d$Course==course(),]
    })
    courses <- reactive(sort(unique(d$Course[d$Subject==subject()&d$AcyrCode>=startyear()])))
    period <- reactive({paste0(2015-input$years,"-2015")})
    title <- reactive({paste0(ifelse(course()=="All",subject(),course())," Enrollment per Term, Academic Years ",period())})
    
    #update client UI
    observe(updateSelectInput(session,"course",choices=c("All",courses()),selected=course()))
    output$title <- renderText({title()})
    output$chart <- renderPlot({
      plotdata <- aggregate(selectdata()[,c(6,7)], list(selectdata()$Term), sum)
      plotdata <- melt(plotdata, id="Group.1")
      g <- ggplot(plotdata, aes(Group.1, value, color=variable))+geom_line()
      g <- g + labs(x="Term", y="Enrollment")
      g
    })
    output$table <- renderDataTable({selectdata()[,1:7]})
  }
)