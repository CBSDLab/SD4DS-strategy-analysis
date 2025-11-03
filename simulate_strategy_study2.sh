#!/bin/bash
#SBATCH -N 1
#SBATCH -c 1
#SBATCH -t 1:00:00
#SBATCH --output=my.stdout 
#SBATCH --mail-user=<your email address>
#SBATCH --mail-type=ALL 
#SBATCH --job-name="strategy analysis study 2"

#SBATCH -o serial-R.out%j # capture jobid in output file name

# run simulation study using AWK script
awk -f simulate_scenarios.awk -v MODEL="limits to growth v2.stmx" strategy_study2.csv

# load R module to process results
module load R/4.1.2-foss-2021b
Rscript process_results_v2.R

# copy processed results to study results file
cp study_results.csv strategy_study2_results.csv
