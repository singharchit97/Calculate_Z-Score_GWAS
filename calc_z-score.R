#!/usr/bin/Rscript
library(argparser)
library(methods)

p <- arg_parser("Calculate Z-score for SNPs")
p <- add_argument(p, "--file-name", help = "Name of the summary statistics file")
p <- add_argument(p, "--id-snplist-file", help = "file with list of SNPs for which Z-score will be calculated")
p <- add_argument(p, "--std-error", help = "Column name for Standard-error")
p <- add_argument(p, "--odds-ration", help = "Column name for Odds-ratio")
p <- add_argument(p, "--variant-id", help = "Column name for SNP id")
p <- add_argument(p, "--z-file-name", help = "Output file name")

argv <- parse_args(p)

data_summary_stats <- read.table(argv$f, sep = " ", header = TRUE)
snp_list <- read.table(argv$i, header = FALSE)
data_summary_stats_subset <- data_summary_stats[data_summary_stats$argv$v == snp_list]
calc_z-score <- function(data_summary_stats_subset, std_error, odds_ratio){
  for (snp in 1: length(data_summary_stats_subset) {   
    data_summary_stats_subset$z-score[snp] <- log(data_summary_stats_subset$odds_ratio[snp]) / (log(data_summary_stats_subset$odds_ratio[snp]) - (data_summary_stats_subset$odds_ratio[snp] * exp(-1.96 * data_summary_stats_subset$std_error[snp]) / 1.96))) 
  }
  return(data_summary_stats_subset$z-score)
}
out_file <- calc_z-score(data_summary_stats_subset, argv$s, argv$o)
write.csv(out_file, "argv$z", sep = " ", header = "TRUE")
