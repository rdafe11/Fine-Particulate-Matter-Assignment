# Coursera Exploratory Data Analysis Assignment
# Plot 5: 

# Directions 

# You must address the following questions and tasks in your exploratory analysis.
# For each question/task you will need to make a single plot. Unless specified, 
# you can use any plotting system in R to make your plot.

# How have emissions from motor vehicle sources changed from 1999–2008 in 
# Baltimore City?

# Step 1: Set WD and Bring in data
# Note: The rds file stores, connects, and saves R objects
setwd("~/Desktop")
NEI <- readRDS("summarySCC_PM25.rds") # Bring in data
SCC <- readRDS("Source_Classification_Code.rds")

# Step 2: "Clean" the Data
library(dplyr)
library(stringr)
library(ggplot2)
NE_data <- tbl_df(NEI) # Usable data frame form w/ dplyr package
SC_data <- tbl_df(SCC)

data <- merge(NE_data, SC_data, by.x="SCC", by.y="SCC", all=TRUE) 
# Merge the data frames
data <- data %>% filter(data$fips == "24510") # Subset the data for Baltimore City
data$year <- as.character(data$year) # Convert year variable to character
sub_data <- data %>% group_by(year, EI.Sector) %>% summarize(Emissions= sum(Emissions, na.rm=TRUE))
sub <- sub_data %>% filter(EI.Sector=="Mobile - Locomotives" | 
  EI.Sector=="Mobile - Non-Road Equipment - Diesel" | 
  EI.Sector== "Mobile - Non-Road Equipment - Gasoline" | 
  EI.Sector== "Mobile - Non-Road Equipment - Other" |
  EI.Sector== "Mobile - On-Road Diesel Heavy Duty Vehicles" | 
  EI.Sector=="Mobile - On-Road Diesel Light Duty Vehicles" | 
  EI.Sector== "Mobile - On-Road Gasoline Heavy Duty Vehicles" | 
  EI.Sector=="Mobile - On-Road Gasoline Light Duty Vehicles")    

sub_data <- sub %>% group_by(year) %>% summarize(Emissions= sum(Emissions, na.rm=TRUE))


# Step 3: Create the plot
png(filename= "plot5.png", width=480, height=480, units="px") # Set image format
graph <- ggplot(data=sub_data, aes(x=year, y=Emissions, fill=year)) 
graph <- graph+ geom_bar(stat="identity", position=position_dodge()) 
graph <- graph+ ggtitle("Baltimore Emissions via Automobile")
graph <- graph+ geom_bar(color="black", stat="identity")+ scale_fill_hue(name="Year")
graph <- graph+ xlab("Year") + ylab("Mobile Emmisions PM[2.5] (Tons)") 
print(graph) # Check Graphics
dev.off() # Close Graphics and Show Plot in WD








