# Coursera Exploratory Data Analysis Assignment
# Plot 3: 

# Directions 

# You must address the following questions and tasks in your exploratory analysis.
# For each question/task you will need to make a single plot. Unless specified, 
# you can use any plotting system in R to make your plot.

# Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in emissions
# from 1999–2008 for Baltimore City? 

# Which have seen increases in emissions from 1999–2008? Use the ggplot2 
# plotting system to make a plot answer this question.

# Step 1: Set WD and Bring in data
# Note: The rds file stores, connects, and saves R objects
setwd("~/Desktop")
NEI <- readRDS("summarySCC_PM25.rds") # Bring in data

# Step 2: "Clean" the Data
library(dplyr)
library(ggplot2)
data <- tbl_df(NEI) # Usable data frame form w/ dplyr package
data <- data %>% filter(data$fips == "24510") # Subset the data for Baltimore City
data$year <- as.character(data$year) # Convert year variable to character
sub_data <- data %>% group_by(year, type) %>% summarize(Emissions= sum(Emissions))
# Subset the data based on year and type

# Step 3: Create the plot
png(filename= "plot3.png", width=480, height=480, units="px") # Set image format
baltimore<- qplot(year, Emissions, data=sub_data, color=type, size=I(3),
                  main= "Emission's Trend in Baltimore City across Type" )
baltimore <- baltimore+ geom_smooth(aes(group=type), method="loess", se=FALSE)
baltimore <- baltimore+ facet_wrap(~type)
print(baltimore) # Check Graphics
dev.off() # Close Graphics and Show Plot in WD



# Alternative 1:
qplot(x=year, y= Emissions, data= sub_data, facets= .~type,
      col=type, main= "Emission's Trend in Baltimore City across Type",
      size=I(5))


# Alternative 2:
q <- ggplot(sub_data, aes(year, Emissions, color=type))
p <- q + geom_point() + facet_wrap(~type) + theme(axis.text.x= element_text(angle=45, size=10)) 

# Alternative 3:
baltimore<- qplot(year, Emissions, data=sub_data, color=type, size=I(3),
                  main= "Emission's Trend in Baltimore City across Type" )
baltimore <- baltimore+ geom_smooth(aes(group=type), method="lm", se=FALSE)
baltimore <- baltimore+ facet_wrap(~type)
print(baltimore)


