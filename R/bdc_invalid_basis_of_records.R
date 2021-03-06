#' Identify records from doubtful source (e.g., 'fossil', MachineObservation') 
#'
#' Identify records with informed basis of records (i.e., the records type, for
#' example, a specimen, a human observation, or a fossil specimen) no
#' interpretable, that do not comply with Darwin Core recommended vocabulary, or
#' unrealible or unsuitable for certain analyses.
#'
#' @param data data.frame. Containing information on basis of records.
#' @param basisOfRecord character string. The column name with information on
#' basis of records. Default = "basisOfRecord".
#' @param names_to_keep character string. Elements of the column BasisOfRecords
#' to keep. Default is 'all', which considers a selected list of recommended
#' standard Darwin Core classes (and their spelling variations, see details).
#' By default, records missing (i.e., NA) or with "unknown" information on
#' basis of records are kept.
#' 
#' @details Users are encourage to select the set of basis of records classes
#' to keep. Default = c("Event","HUMAN_OBSERVATION", "HumanObservation",
#' "LIVING_SPECIMEN", "LivingSpecimen", "MACHINE_OBSERVATION",
#' "MachineObservation", "MATERIAL_SAMPLE", "O", "Occurrence",
#' "MaterialSample", "OBSERVATION", "Preserved Specimen",
#' "PRESERVED_SPECIMEN", "preservedspecimen Specimen", "Preservedspecimen",
#' "PreservedSpecimen", "preservedspecimen", "S", "Specimen", "Taxon",
#' "UNKNOWN", "", NA)
#' 
#' @return A data.frame contain the column '.invalid_basis_of_records'. Records
#' that have failed in the test are flagged as "FALSE".
#' @importFrom dplyr mutate filter select distinct
#'
#' @export
#'
#' @examples
#' \dontrun{
#' x <- data.frame(recod_types = c("FOSSIL_SPECIMEN", "UNKNOWN", "RON", NA, "Specimen", "PRESERVED_SPECIMEN"))
#' bdc_invalid_basis_of_records(data = x, basisOfRecord = "recod_types", names_to_keep = "all")
#' }
bdc_invalid_basis_of_records <-
  function(data,
           basisOfRecord = "basisOfRecord",
           names_to_keep = "all") {
    
    if (names_to_keep == "all") {
      names_to_keep <-
        c(
          "Event",
          "HUMAN_OBSERVATION",
          "HumanObservation",
          "LIVING_SPECIMEN",
          "LivingSpecimen",
          "MACHINE_OBSERVATION",
          "MachineObservation",
          "MATERIAL_SAMPLE",
          "O",
          "Occurrence",
          "MaterialSample",
          "OBSERVATION",
          "Preserved Specimen",
          "PRESERVED_SPECIMEN",
          "preservedspecimen Specimen",
          "Preservedspecimen",
          "PreservedSpecimen",
          "preservedspecimen",
          "S",
          "Specimen",
          "Taxon",
          "UNKNOWN",
          "",
          NA
        )
    }
    
    data <-
      data %>%
      dplyr::mutate(.invalid_basis_of_records = .data[[basisOfRecord]] %in%
                    names_to_keep)
    
    removed <-
      data %>%
      dplyr::filter(.invalid_basis_of_records == FALSE) %>%
      dplyr::select(.data[[basisOfRecord]]) %>%
      dplyr::distinct()
    
    message(
      paste(
        "\nbdc_invalid_basis_of_records:\nFlagged",
        sum(data$.invalid_basis_of_records == FALSE),
        "of the following specific nature:\n",
        removed,
        "\nOne column was added to the database.\n"
      )
    )
    return(data)
  }

