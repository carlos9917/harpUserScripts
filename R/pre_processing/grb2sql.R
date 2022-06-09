#!/usr/bin/env Rscript
# Read grib-files, interpolate to stations  and save it in sqlite format
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
orog_file <- CONFIG$pre$grb_orog
fcst_path <- CONFIG$verif$fcst_path
fcst_model <- CONFIG$verif$fcst_model
station_list <- CONFIG$pre$stat_list
params <- CONFIG$pre$params
lead_time_str <- CONFIG$verif$lead_time
lead_time  <- eval(parse(text = lead_time_str))
fcst_intervall <- CONFIG$verif$by_step

print(station_list)
statlist <- read.csv(file=station_list, sep=",")

for (param in params)
{
    cat("Processing ",param,"\n")
    read_forecast(
      start_date    = start_date,
      end_date      = end_date,
      fcst_model     = fcst_model,
      parameter = param,
      lead_time = lead_time,
      file_path = grb_path,
      file_template = file_template,
      by = fcst_intervall,
      file_format = "grib",
#      file_format_opts = grib_opts(param_find = list(T2m = use_grib_indicatorOfParameter(167))),
      file_format_opts = grib_opts(level_find = list(T2m = use_grib_typeOfLevel("surface", 0))),
      transformation = "interpolate",
      transformation_opts = interpolate_opts(method="bilinear", clim_file = orog_file, stations = statlist), 
      output_file_opts =  sqlite_opts(path = fcst_path),
      return_data = TRUE
    )

}
