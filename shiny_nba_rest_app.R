#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)
library(ggplot2) 

start <- '7-30'
end <- '11-11'

team_analysis <- read_csv('nba_glog_14_23.csv') %>%
  filter(Days >= 0) %>%
  filter(Days <= 100) %>%
  filter(Days != 0) %>%
  mutate(Date = as.Date(Date), year= year(Date)) %>%
  filter(!(Date >= ymd(paste(year, start, sep = '-')) &
             Date <= ymd(paste(year,end, sep = '-')))) %>%
  mutate(PT_Diff = Tm_PTS - Opp_PTS)

             
ui <- fluidPage(
  
  title = "nba",
  
  plotOutput('scatter'), 
  plotOutput('density'),
  
  
 
  
  hr(), hr(),
  
  img(
    src = 'https://andscape.com/wp-content/uploads/2017/06/nbalogo.jpg?w=700',
    height = 120,
    width = 200, 
    
    
    fluidRow(
      column(6,
             selectInput('stats', 'stats:',
                         c('Tm_PTS',
                           'PT_Diff',
                           'FG%',
                           'TP%',
                           'FT%',
                           'ORB',
                           'TRB',
                           'TOV'
                         ))), 
     
   
  ),
  
  
    
 tableOutput('table'),  
 
  
           
           # selectInput('league', 'league:',
           #             c("Atlanta Hawks",
           #               "Boston Celtics",
           #               "Brooklyn Nets",
           #               "Charlotte Hornets",
           #               "Chicago Bulls",
           #               "Cleveland Cavaliers",
           #               "Dallas Mavericks",
           #               "Denver Nuggets",
           #               "Detroit Pistons",
           #               "Golden State Warriors",
           #               "Houston Rockets",
           #               "Indiana Pacers",
           #               "Los Angeles Clippers",
           #               "Los Angeles Lakers",
           #               "Memphis Grizzlies",
           #               "Miami Heat",
           #               "Milwaukee Bucks",
           #               "Minnesota Timberwolves",
           #               "New Orleans Pelicans",
           #               "New Yor Knicks",
           #               "Oklahoma City Thunder",
           #               "Orlando Magic",
           #               "Philadelphia 76ers",
           #               "Phoenix Suns",
           #               "Portland Trailblazers",
           #               "Sacramento Kings",
           #               "San Antonio Spurs",
           #               "Toronto Raptors",
           #               "Utah Jazz",
           #               "Washington Wizards"), width = 300)),
           #       
        column(3,
               checkboxInput('home', 'home/away splits')),
  
  )
)

 






      

server <- shinyServer(function(input,output){
  
output$scatter <- renderPlot({
  input_y <- input$stats

 plot <- team_analysis %>%
    filter(Days <= 3) %>%
   rename( Away_Home = 'A/H') %>%
    ggplot(aes(x=Days, y= .data[[input_y]])) +
    
    geom_jitter(alpha =.15, width = 0.2) +
    geom_smooth(method = 'lm', color = 'blue')
 if (input$home){plot = plot + facet_grid(rows = 'Away_Home') 
 }
 
 plot
 
})


output$density <- renderPlot({
  input_y <- input$stats

plot_2 <- team_analysis %>%
    filter(Days <= 3) %>%
    rename( Away_Home = 'A/H') %>%
    ggplot(aes(x=.data[[input_y]])) +
    geom_density(color = 'blue') + 
    facet_grid(rows = 'Days')
 if (input$home){plot_2 = plot_2 + facet_grid(rows = vars(Days), cols = vars(Away_Home))
    }
    
    plot_2
   
 
}) 


output$table <- renderTable({
  input_y <- input$stats

  table <- team_analysis %>%
  filter(Days <= 3) %>%
  group_by(Days) %>%
  summarise(mean = mean(.data[[input_y]], na.rm=T))




if (input$home){table = team_analysis %>%
  rename(Away_Home = 'A/H') %>%
  group_by(Days, Away_Home) %>%
  filter(Days <=3) %>%
  summarise(mean = mean(.data[[input_y]], na.rm=T)) %>%
  pivot_wider(names_from = Away_Home, values_from = mean) %>%
  rename(Away = 'A') %>%
  rename(Home = 'H') 
}


table 

}, digits = 4)
 

})
 





  
shinyApp(ui = ui, server = server) 
  













                     
                                
                                
                                
                               
                            
                                
                                
                                
                              

         
    
  





  
                                   
               
    







 
