# harp installation instructions

The instructions for installing harp can be found [here](https://harphub.github.io/harp/)
and in the [2022 tutorial page](https://harphub.github.io/harp-training-2022/about.html).

## Setup your environment
As described in section 1.5 of this [tutorial](https://harphub.github.io/harp_tutorial),
it is not a bad idea to isolate your harp installation using the *renv* package. 
This might be a good idea if you want to test different versions of harp. 
The instructions should be as follows (TO CHECK!)
```
install.packages("renv")
renv::init()
renv::install("remotes")
renv::install("harphub/harp")
renv::install_github("harphub/Rgrib2")
renv::install("ncdf4")
renv::install("tidyverse")
renv::install("here")
renv::snapshot()
```
