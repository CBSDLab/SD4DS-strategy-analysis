# Read in the results from the simulation study and 
# and process them into the desired format
#
# Created by: Peter S. Hovmand Apr 20, 2025
# Revised by: Peter S. Hovmand Oct 5, 2025 to include all variables
#             Peter S. Hovmand Nov 2, 2025 to fix memory issue with R

library(fs)
library(readr)

# This searches for the results files with filenames in the form of Results_ 
# which includes Results_1.csv, Results_10.csv, etc. but excludes Results.csv
# since this only a temporary results file
results_list <- list.files(pattern="Results_")

# The results_list object is not sorted in the order of the simulation 
# runs, hence the files are read in a numeric order
for (i in 1:length(results_list)) {
  # Read in the .csv file for simulation run i
  tmp<-read_csv(file=paste0("Results_",i,".csv"), show_col_types = FALSE)
  
  # Process the data for simulation run i
  tmp_df <- data.frame(Run = i,
                       tmp)
  # Append the processed data for simulation run i to the study file. Note
  # appending this to the file versus a working data frame avoids the problem
  # of R running out of memory
  write_csv(tmp_df, file = "study_results.csv", append = TRUE)
}

# Clean up the drive by deleting the individual simulation study results
file_delete(results_list)
