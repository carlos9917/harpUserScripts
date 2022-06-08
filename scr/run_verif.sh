#!/usr/bin/env bash
# Some examples to run the verification scripts

# This is for ecgate/aa
module load R

cd ../R/verification
CONFIG=R/config_files/config_example.yml
INI_DATE=2022030100
END_DATE=2022033123

# some examples of point verif
#./point_verif.R -config_file $CONFIG -start_date $INI_DATE -end_date $END_DATE

#Score cards
#./create_scorecards.R -config_file $CONFIG -start_date $INI_DATE -end_date $END_DATE

