#!/usr/bin/env Rscript
# Read vfld data and save it in sqlite format
library(harp)
library(argparse)
library(here)
library(yaml)

parser <- ArgumentParser()


parser$add_argument("-config_file", type="character",
    default="config_examples/config.yml",
    help="Last date to process [default %(default)s]",
    metavar="String")

args <- parser$parse_args()

# source yml file
config_file <- args$config_file
CONFIG <- yaml.load_file(here(config_file))

# The following variables are expected to change for each user / use case
# Some defined in config file above, some command-line arguments

start_date <- CONFIG$pre$start_date
end_date <- CONFIG$pre$end_date
fclen <- CONFIG$pre$fclen
grb_path <- CONFIG$pre$grb_path
file_template <- CONFIG$pre$grb_template
fcst_path <- CONFIG$verif$fcst_path
fcst_model <- CONFIG$verif$fcst_model
params <- CONFIG$pre$params
lead_time_str <- CONFIG$verif$lead_time
lead_time  <- eval(parse(text = lead_time_str))


for (param in params)
{
    cat("Processing ",param,"\n")
    read_forecast(
      start_date    = start_date,
      end_date      = end_date,
      fcst_model     = fcst_model,
      parameter = param,
      lead_time = lead_time,
      file_path = vfld_path,
      file_template = file_template,
      file_format = "grb",
      output_file_opts =  sqlite_opts(path = fcst_path),
      return_data = TRUE
    )

}
