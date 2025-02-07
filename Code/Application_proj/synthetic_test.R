### clear workspace
rm(list = ls())

### load necessary CRAN libraries
library(MASS)
library(tidyverse)
library(largeList)
library(parallel)
library(Rcpp)

### load my own library
install.packages('../OutDetectR_1.0.tar.gz', repos = NULL, type = 'source')
library(OutDetectR)

version_check()

### set up parameters
# sample size for sampling procedure
sample_size <- 100

# generate synthetic test set
test_obj <- generate_set_2(n_obs = 1000)

saveRDS(test_obj, file = 'Results/synth_input.RDS')

# save in largeList format on NvME SSD
OutDetectR::largeListify(
  func_dat = test_obj$data,
  path = '~/Documents/tmp_data/synth_data.llo'
)

# get measuring intervals
synth_ints <- OutDetectR::measuring_int_mat(test_obj$data)

# get unique measuring intervals
unique_intervals <- OutDetectR::unique_intervals(synth_ints)

### Use Sampling procedure for reduced data set
# create cluster
cl <- makeForkCluster(5)

# set different seeds just to be sure
clusterCall(cl = cl, fun = function(i) {
  set.seed(as.numeric(Sys.getpid()))
  print(as.numeric(Sys.getpid()))}
)

# try using the sampling procedure
test_procedure <- OutDetectR::stretch_sample_detection(
  cl = cl, list_path = '~/Documents/tmp_data/synth_data.llo',
  measuring_intervals = synth_ints, lambda = 1.05,
  sample_size = sample_size, expn = 5, alpha = 0.05, B = 100, gamma = 0.05,
  debug = TRUE
)

stopCluster(cl)

saveRDS(test_procedure, file = 'Results/synth_sample.RDS')

# check full set at once
full_test <- OutDetectR::detection_wrap(func_dat = test_obj$data, ids = test_obj$ids, 
                                        alpha = 0.05, B = 100, gamma = 0.05)


saveRDS(full_test, file = 'Results/synth_full.RDS')
