# Z-score calculation from GWAS summary statistics for a given set of SNPs
This R-script calculates Z-scores (required for post GWAS analysis like fine-mapping & colocalization analysis) from summary statistics file using Beta values (odds-ratio) and standard error (of odds ratio) for a given set of SNPs. The SNPs as input should be given as a text file with just one column and no header. 

### Pull this repository
Go to your working directory and run:
```bash
git clone https://github.com/singharchit97/Calculate_Z-Score_GWAS && cd Calculate_Z-Score_GWAS/
```

### Configure the container
To run the commands the user will need a container that contains a number of R-libraries.

#### Building the container
If the user wants to build the container:
```bash
export SINGULARITY_PATH="/path/to/singularity-executable"
sudo $SINGULARITY_PATH/singularity build  z-score.sif container/Singularity
```
### Run the script (without singularity container)
Run the below command to see the help message on the input and output parameters required to run the script.
Note that all parameters are mandatory.
```bash
Rscript calc_z-score.R --help
```
Dummy command given below:
```bash
Rscript calc_z-score.R -f input_summary_statistics.txt -i input.snplist -s standard_error -b odds_ratio -v rs_id -z output.txt
```
### Run the script (with singularity container)
Run the below command to see the help message on the input and output parameters required to run the script.
Note that all parameters are mandatory.
```bash
singularity exec -B /mount/working/directory z-score.sif Rscript calc_z-score.R --help
```
Dummy command given below:
```bash
singularity exec -B /mount/working/directory z-score.sif Rscript calc_z-score.R -f input_summary_statistics.txt -i input.snplist -s standard_error -b odds_ratio -v rs_id -z output.txt
```
The script runs in the `Calculate_Z-Score_GWAS` directory, it will create a output text file (name as given by the user), respectively.