% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bdc_create_dir.R
\name{bdc_create_dir}
\alias{bdc_create_dir}
\title{Creates directories for saving ouptups of the bdc workflow}
\usage{
bdc_create_dir()
}
\value{
None
}
\description{
Creates directories for saving the outputs of bdc workflow, which including
databases, figures, reports, and databases which need to be checked.
}
\details{
:
Check below the folder structure created by \code{bdc_create_dir()}.\preformatted{.
└── Output
    ├── Check
    ├── Figures
    ├── Intermediate
    └── Report
}
}
\examples{
\dontrun{
bdc_create_dir()
}
}
