# Coursera Exploratory Data Analysis Assignment
# Plot 4: 

# Directions 

# You must address the following questions and tasks in your exploratory analysis.
# For each question/task you will need to make a single plot. Unless specified, 
# you can use any plotting system in R to make your plot.

# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

# Step 1:
# Note: The rds file stores, connects, and saves R objects
setwd("~/Desktop")
NEI <- readRDS("summarySCC_PM25.rds") # Bring in data
SCC <- readRDS("Source_Classification_Code.rds")

# Step 2: "Clean" the Data
library(dplyr)
library(ggplot2)
NE_data <- tbl_df(NEI) # Usable data frame form w/ dplyr package
SC_data <- tbl_df(SCC) # Usable data frame form w/ dplyr package

data <- merge(NE_data, SC_data, by.x="SCC", by.y="SCC", all=TRUE) 
# Merge the data frames

data$year <- as.character(data$year) # Convert year variable to character
sub_data <- data %>% group_by(year, EI.Sector) %>% summarize(Emissions= sum(Emissions, na.rm=TRUE))
sub_data <- sub_data %>% filter(EI.Sector== "Fuel Comb - Comm/Institutional - Coal")
# Subset the coal related sources
sub_data <- sub_data[-c(5),]  # Remove Unwanted Row

# Step 3: Create the plot
png(filename= "plot4.png", width=480, height=480, units="px") # Set image format
graph <- ggplot(data=sub_data, aes(x=year, y=Emissions, fill=year)) 
graph <- graph+ geom_bar(stat="identity", position=position_dodge()) 
graph <- graph+ ggtitle("Emissions via Coal Related Sources")
graph <- graph+ geom_bar(color="black", stat="identity")+ scale_fill_hue(name="Year")
graph <- graph+ xlab("Year") + ylab("Coal Emmisions (Tons)") 
graph <- graph+ scale_y_continuous(breaks=c(0,1000,3000,5000, 7000, 9000, 11,000))
print(graph) # Check Graphics
dev.off() # Close Graphics and Show Plot in WD






