# Getting and Cleaning Data Project

## Introduction

This repository contains my work for the course project for the "Getting and Cleaning Data" course on Coursera.

## Project purpose

The purpose of the project is to demonstrate the student ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. The student will be graded by peers on a series of yes/no questions related to the project. The student will be required to submit: 

  1. A tidy data set as described below. 
  2. A link to the Github repository with the script for performing the analysis.
  3. A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

The student should also include a README.md in the repo with the scripts. This file must explain how all of the scripts work and how they are connected.

## Project description

One of the most exciting areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The student should create one R script called run_analysis.R that does the following: 

  * Merges the training and the test sets to create one data set.
  * Extracts only the measurements on the mean and standard deviation for each measurement. 
  * Uses descriptive activity names to name the activities in the data set
  * Appropriately labels the data set with descriptive variable names. 
  * From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## About the run_analysis.R script

According to the provided instructions, I created a script called run_analysis.R which will merge the test and training sets together. This script provide a main entry point, the function `run.analysis`. This function requires a single parameter, the folder in which the "UCI HAR Dataset" have been extracted. The following code snipplet exemplifies a typical script invocation:

```r
source('run_analysis.R')
tidydata <- run.analysis('./UCI HAR Dataset')
```

As a result of such invocation, the script will create a tidy data set containing the means of all the columns per test subject and per activity. This tidy data set will be written to a file called `tidydata.txt` in the UCI HAR Dataset folder, which can also be found in this repository. As a convenience, the `run.analysis` function will return the tidy data set for further processing, if required.

## About the Code Book

The CodeBook.md file explains the data sets included in the UCI HAR Dataset and the transformations performed on them, and the resulting data and variables.
