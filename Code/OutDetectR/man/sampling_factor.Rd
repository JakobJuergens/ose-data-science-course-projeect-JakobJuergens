% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sampling_auxiliary.R
\name{sampling_factor}
\alias{sampling_factor}
\title{This function determines the factor for stretch_sample_detection
if sample_size > n_comparables}
\usage{
sampling_factor(n_comparables, sample_size, n_samples)
}
\arguments{
\item{n_comparables:}{number of comparable observations}

\item{sample_size:}{chosen sample size for sampling procedure}

\item{n_samples:}{chosen number of samples}
}
\value{
An integer that's used for weighing the non-sampled steps in
stretch_sample_detection
}
\description{
This function determines the factor for stretch_sample_detection
if sample_size > n_comparables
}
