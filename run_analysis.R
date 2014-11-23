# Import required libraries
library(reshape2) # For data casting

# This function loads and prepare the information that can be found 
# in the different data sets included in the UCI HAR data set
# Params:
# - dir: directory in which the UCI HAR data set resides
# - dataset: one of 'train' or 'test', corresponding to the data sets
# included in the UCI HAR data set
# - features: the set of required features to extract from the data set
# - activity_labels: the set of labels for the different activities
load.data <- function(dir, dataset, features, activity_labels) {
  real.dir <- file.path(dir, dataset)
  data.filename <- file.path(real.dir, paste("X_", dataset, ".txt", sep = ""))
  activities.filename <- file.path(real.dir, paste("Y_", dataset, ".txt", sep = ""))
  subjects.filename <- file.path(real.dir, paste("subject_", dataset, ".txt", sep = ""))
  
  # Read required data (features) and adjust column names
  data <- read.table(data.filename)[, features$index]
  names(data) <- features$name
  
  # Read subjects and bind them to main data frame  
  subjects <- read.table(subjects.filename)[, 1]
  names(subjects) <- c("subject")
  subjects$subject <- factor(subjects)
  data <- cbind(data, subject = subjects$subject)
  
  # Read activities and bind them to main data frame  
  activities <- read.table(activities.filename)[, 1]
  names(activities) <- c("activity")
  activities$activity <- factor(activities, levels=activity_labels$level, labels=activity_labels$label)
  data <- cbind(data, activity = activities$activity)
  
  # Return the prepared data
  data
}

# Main program entry point. Runs the prepared script in order to process
# the provided UCI HAR data set and obtain a clean, tidy data set with the
# information requested in the project
# Params:
# - dir: directory in which the UCI HAR data set resides
run.analysis <- function(dir) {
  
  # Get required features (those for mean and standard deviation)
  features.filename <- file.path(dir, "features.txt")
  features <- read.table(features.filename, col.names = c("index", "name"))
  features <- subset(features, grepl("-(mean|std)[(]", features$name))
  
  # Get activity labels
  activity_labels.filename <- file.path(dir, "activity_labels.txt")
  activity_labels <- read.table(activity_labels.filename, col.names = c('level', 'label'))
  
  # Load train and test data sets
  train <- load.data(dir, "train", features, activity_labels)
  test <- load.data(dir, "test", features, activity_labels)
  
  # Combine train and test data sets
  dataset <- rbind(train, test)
  
  # Generate the tidy data set
  melteddata <- melt(dataset, id = c("subject", "activity"))  
  tidydata <- dcast(melteddata, subject + activity ~ variable, mean)
  
  # Appropriately label the data set with descriptive variable names
  names <- names(tidydata)  
  names <- gsub('-mean', 'Mean', names)
  names <- gsub('-std', 'StdDev', names)
  names <- gsub('[()-]', '', names)
  names <- gsub('BodyBody', 'Body', names)
  names(tidydata) <- names
  
  # Finally, write the tidy data set to the filesystem
  tidydata.filename <- file.path(dir, "tidydata.txt")
  write.table(tidydata, tidydata.filename, row.names = FALSE, quote = FALSE)
  
  # Return the generated tidy data set
  tidydata
}