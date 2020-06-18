# Coursera Exploratory Data Analysis Assignment
# Plot 2: 

# Directions 

# You must address the following questions and tasks in your exploratory analysis.
# For each question/task you will need to make a single plot. Unless specified, 
# you can use any plotting system in R to make your plot.

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.


# Step 1: Set WD and Bring in data
# Note: The rds file stores, connects, and saves R objects
setwd("~/Desktop")
NEI <- readRDS("summarySCC_PM25.rds") # Bring in data


# Step 2: "Clean" the Data
library(dplyr)
data <- tbl_df(NEI) # Usable data frame form w/ dplyr package
data <- data %>% filter(data$fips == "24510") # Subset the data for Maryland

data <- with(data, aggregate(Emissions, by = list(year), sum))
# Use with() to combine/sum the Emissions by year in seperate list
names(data)[1] <- "Year" # Rename the Column
names(data)[2] <- "Emissions" # Rename the Column

# Step 3: Create the plot
png(filename= "plot2.png", width=480, height=480, units="px") # Set image format
par(mar=c(5, 5, 4.1, 3)) # Adjust the Margin sizes
plot(data, type= "b", pch= 15, col= "turquoise2", yaxt="n", xaxt="n",
     xlab="Years", ylab= "Total Emissions PM2.5(Tons)")
title(main="Maryland's Emmisions by Years", col.main="turquoise2")
axis(2, at=c(seq(from=1000,to=4000, by=200)), cex.axis=.55 ) # Add Y axis labels
axis(1, at= c(1999, 2002, 2005, 2008), cex.axis=.90) # Add X axis Labels
dev.off() # Close Graphics and Show Plot in WD
