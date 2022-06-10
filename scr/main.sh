#/bin/bash 
 
#This part is only for running in SLURP at ecmwf
#SBATCH --error=main.err
#SBATCH --output=main.out
#SBATCH --job-name=harp_user_scripts

set -x  

source config.sh

######## remove this 
export RUN_POINT_VERF=yes
export RUN_POINT_VERF_LOCAL=no
export RUN_VOBS2SQL=no
export RUN_VFLD2SQL=no
export SCORECARDS=no
######## remove this 

$R_DIR/point_verif/create_scorecards.R
exit 
 
if [ "$RUN_VOBS2SQL" == "yes" ]; then 
   $R_DIR/point_pre_processing/vobs2sql.R  
fi 

if [ "$RUN_VFLD2SQL" == "yes" ]; then 
    $R_DIR/point_pre_processing/vfld2sql.R 
fi 
 

if [ "$RUN_POINT_VERF" == "yes" ]; then 
   $R_DIR/point_verif/point_verif.R 
fi 

if [ "$RUN_POINT_VERF_LOCAL" == "yes" ]; then 
   $R_DIR/point_verif/point_verif_local.R   
fi 

if [ "$SCORECARDS" == "yes" ]; then 
   $R_DIR/point_verif/create_scorecards.R   
fi 











