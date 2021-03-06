#' Identify transposed geographic coordinates
#'
#' Flags and corrects records when latitude and longitude appear to be 
#' transposed.
#'
#' @param data data.frame. Containing a unique identifier for each records,
#' geographical coordinates, and country names. Coordinates must be expressed in
#' decimal degree and in WGS84. 
#' @param id character string. The column name with a unique record identifier.
#' Default = "database_id".
#' @param sci_names character string. The column name with species scientific
#' name. Default = "scientificName".
#' @param lat character string. The column name with latitude. Coordinates must 
#' be expressed in decimal degree and in WGS84. Default = "decimalLatitude".
#' @param lon character string. The column with longitude. Coordinates must be
#' expressed in decimal degree and in WGS84. Default = "decimalLongitude".
#' @param  country character string. The column name with the country 
#' assignment of each record. Default = "country".
#
#' @details This test identifies transposed coordinates resulted from mismatches
#' between the country informed to a record and coordinates. Transposed
#' coordinates often fall outside of the indicated country (i.e., in other
#' countries or in the sea). Different coordinate transformations are
#' performed to correct country/coordinates mismatch. Importantly, verbatim
#' coordinates are replaced by the corrected ones in the returned database. A
#' database containing verbatim and corrected coordinates is created in
#' "Output/Check/01_transposed_coordinates.csv".
#' 
#' @return A data.frame containing the column 'transposed_coordinates'. Records
#' that have failed in the test are flagged as "FALSE".
#'
#' @importFrom CoordinateCleaner cc_val cc_sea
#' @importFrom dplyr filter left_join contains pull rename
#' @importFrom readr write_csv
#' @importFrom rnaturalearth ne_countries
#'
#' @export
#' 
#' @examples
#' \dontrun{
#' id <- c(1,2,3,4)
#' scientificName <- c("Rhinella major", "Scinax ruber", 
#'                     "Siparuna guianensis", "Psychotria vellosiana")
#' decimalLatitude <- c(-63.43333, -67.91667, -41.90000, -46.69778)
#' decimalLongitude <- c(-17.90000, -14.43333, -13.25000, -13.82444)
#' country <- c("BOLIVIA", "bolivia", "Brasil", "Brazil")
#' 
#' x <- data.frame(id, scientificName, decimalLatitude,
#'                 decimalLongitude, country)
#' 
#' bdc_transposed_coordinates(
#'   data = x,
#'   id = "id",
#'   sci_names = "scientificName",
#'   lat = "decimalLatitude",
#'   lon = "decimalLongitude",
#'   country = "country")
#' }
#' 
bdc_transposed_coordinates <-
  function(data,
           id = "database_id",
           sci_names = "scientificName",
           lat = "decimalLatitude",
           lon = "decimalLongitude",
           country = "country",
           countryCode = "countryCode") {
    
  minimum_colnames <- c(id, sci_names, lat, lon, country, countryCode)

  if (length(minimum_colnames) < 6) {
    stop("Fill all function arguments: id, sci_names, lon, lat, and 
         country")
  }
  
  if (!all(minimum_colnames %in% colnames(data))) {
    stop(
      "These columns names were not found in your database: ",
      paste(minimum_colnames[!minimum_colnames %in% colnames(data)], 
            collapse = ", "),
      call. = FALSE
    )
  }
 
  # Standardizing columns names
  data <- 
    data %>% 
    rename(database_id = {{ id }},
           decimalLatitude = {{lat}},
           decimalLongitude = {{lon}}, 
           scientificName = {{ sci_names }},
           country = {{ country }}, 
           countryCode = {{ countryCode }}
           )
  
  # converts coordinates columns to numeric
  data <-
    data %>%
    dplyr::mutate(
      decimalLatitude = as.numeric(decimalLatitude),
      decimalLongitude = as.numeric(decimalLongitude)
    )
  
  worldmap <- bdc_get_world_map() # get world map and country iso
  
  # Correct latitude and longitude transposed
  message("Correcting latitude and longitude transposed\n")
  corrected_coordinates <-
    bdc_correct_coordinates(
      data = data,
      x = "decimalLongitude",
      y = "decimalLatitude",
      sp = "scientificName",
      id = "database_id",
      cntr_iso2 = "countryCode",
      world_poly = worldmap,
      world_poly_iso = "iso2c"
    )

  # Exports a table with verbatim and transposed xy
  corrected_coordinates <-
    corrected_coordinates %>%
    dplyr::select(database_id, scientificName, dplyr::contains("decimal")) 
  
  corrected_coordinates %>%
    readr::write_csv(here::here("Output/Check/01_transposed_coordinates.csv"))
  
  # finding the position of records with lon/lat modified
  w <-
    which(data[, "database_id"] %in% (corrected_coordinates %>% dplyr::pull(database_id)))
  
  data[w, "decimalLatitude"] <- 
    corrected_coordinates[, "decimalLatitude_modified"]
  
  data[w, "decimalLongitude"] <- 
    corrected_coordinates[, "decimalLongitude_modified"]
  
  # Flags transposed coordinates
  data$transposed_coordinates <- TRUE
  data[w, "transposed_coordinates"] <- FALSE

  message(
    paste(
      "\nbdc_transposed_coordinates:\nCorrected",
      sum(data$transposed_coordinates == FALSE),
      "records.\nOne columns were added to the database.\nCheck database containing coordinates corrected in:\nOutput/Check/01_transposed_coordinates.csv\n"
    )
  )

  return(data)
}
