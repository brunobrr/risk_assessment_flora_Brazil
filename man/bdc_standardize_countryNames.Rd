% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bdc_standardize_countryNames.R
\name{bdc_standardize_countryNames}
\alias{bdc_standardize_countryNames}
\title{Standardizes country names and gets ISO code}
\usage{
bdc_standardize_countryNames(data, country = "country")
}
\arguments{
\item{data}{data.frame. Containing country names}

\item{country}{character string. The column name with the country assignment
of each record. Default = "country".}
}
\value{
A data.frame containing two columns: country_suggested (standardized
country names) and country_code (standardized iso2 country code).
}
\description{
Standardizes country names and gets country code information.
}
\details{
Country names are standardized using an exact matching against a
list of country names in several languages from Wikipedia. If any unmatched
names remain,  a fuzzy matching algorithm is used to find potential
candidates for each misspelled countries names.
}
\examples{
\dontrun{
country <- c("BOLIVIA", "bolivia", "Brasil", "Brazil", "BREZIL")
x <- data.frame(country)

bdc_standardize_countryNames(
  data = x,
  country = "country")
}

}
