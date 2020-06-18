# Coursera Exploratory Data Analysis Assignment
# Plot 1: 

# Directions 

# You must address the following questions and tasks in your exploratory analysis.
# For each question/task you will need to make a single plot. Unless specified, 
# you can use any plotting system in R to make your plot.

# Have total emissions from PM2.5 decreased in the United States from 1999 to 
# 2008? 

# Using the base plotting system, make a plot showing the total PM2.5 
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.


# Step 1: Set WD and Bring in data
# Note: The rds file stores, connects, and saves R objects
setwd("~/Desktop")
NEI <- readRDS("summarySCC_PM25.rds") # Bring in data


# Step 2: "Clean" the Data
data <- with(NEI, aggregate(Emissions, by = list(year), sum))
# Use with() to combine/sum the Emissions by year in seperate list
names(data)[1] <- "Year" # Rename the Column
names(data)[2] <- "Emissions" # Rename the Column
                                        
# Step 3: Create the plot
png(filename= "plot1.png", width=480, height=480, units="px") # Set image format
par(mar=c(5, 5, 4.1, 3)) # Adjust the Margin sizes
plot(data, type= "b", pch= 15, col= "palevioletred1", yaxt="n", xaxt="n",
     xlab="Years", ylab= "Emissions (Tons)")
title(main="Plot of Total Emmisions by Years", col.main="palevioletred1")
axis(2, at=c(3E06, 4E06, 5E06, 6E06, 7E06, 8E06), cex.axis=.75) # Add Y axis labels
axis(1, at= c(1999, 2002, 2005, 2008), cex.axis=.90) # Add X axis Labels
dev.off() # Close Graphics and Show Plot in WD




