# NBA_Rest_Analysis

The goal of this project was to analyze the effect of rest on the scoring performance of NBA teams.

-Data for this project was collected from basketball-reference.com. Gamelogs from NBA seasons of 2014-2020 were used.

-Days between seasons was removed. Rest, in this analysis, only includes days of rest within a season. 

-All code was written in R.


glm models was used to determine the statistical signifigance of a day of rest on NBA performance:

The results showed that a day of rest was worth .5 point of bennefit to a team's performance.

Two plots are included to visualize the relationship between days of rest and team points. The first is a scatter plot wih a linear regression line:

    The x-axis represents the variable Days, which indicates the number of days.
    The y-axis represents the variable Tm_PTS, which represents the points scored by a team.
    Each point on the plot represents a data point from the dataset. 
    A linear regression line is added to the plot to represent the estimated linear relationship between Days and Tm_PTS.
    The panels represent values of Away_Home, allowing you to compare the scatter plots and regression lines for different levels of Away_Home.

The second plot is a density plot:
    
    This plot shows the distribution of points per day of rest and whether or not the team was home or away.


Folowing the plots you will find two numerical charts. 
  
  The first chart lists the average points scored by a team per day of rest whether they are the home team or the away team
  The second chart lists the win percentage of the home team in relation to the their rest and the rest of their opponent. 






