#!/usr/bin/Rscript
suppressPackageStartupMessages(library(argparser))
suppressPackageStartupMessages(library(methods))
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(dplyr))

p <- arg_parser("Calculate Z-score for SNPs")
p <-
  add_argument(p, "--file-name", help = "Name of the summary statistics file")
p <-
  add_argument(p, "--id-snplist-file", help = "file with list of SNPs for which Z-score will be calculated")
p <-
  add_argument(p, "--std-error", help = "Column name for Standard-error")
p <-
  add_argument(p, "--beta", help = "Column name for Odds-ratio")
p <-
  add_argument(p, "--variant-id", help = "Column name for SNP id")
p <- add_argument(p, "--z-file-name", help = "Output file name")

argv <- parse_args(p)

data_summary_stats <- fread(argv$f, sep = "\t", header = TRUE)
snp_list <- fread(argv$i, header = FALSE)
colnames(snp_list) <- c(argv$v)
data_summary_stats_subset <-
  semi_join(data_summary_stats, snp_list, by = argv$v)
odds_ratio <- c(argv$b)
std_error <- c(argv$s)
calc_z_score <-
  function(...) {
    data_summary_stats_subset[[odds_ratio]] <-
      as.numeric(data_summary_stats_subset[[odds_ratio]])
    data_summary_stats_subset[[std_error]] <-
      as.numeric(data_summary_stats_subset[[std_error]])
    log.OR <- log(data_summary_stats_subset[[odds_ratio]])
    lower95.log.OR <-
      (
        data_summary_stats_subset[[odds_ratio]] * exp(-1.96 * data_summary_stats_subset[[std_error]])
      )
    SE.log.OR <- (log.OR - lower95.log.OR) / 1.96
    data_summary_stats_subset$Z_score <- (log.OR / SE.log.OR)
    return(data_summary_stats_subset$Z_score)
  }
out_file <- calc_z_score(odds_ratio, std_error)
out_file <- data.frame(out_file)
colnames(out_file) <- c("Z-score")
fwrite(out_file, argv$z)