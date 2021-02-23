---

# 00: Merge Datasets

---

The first step of the bdc workflow is to format each heterogeneous datasets (**input files**) in a standardized one using common standards and protocols. To do so, users must adjust a **configuration table** to indicate which field of each original dataset (i.e. header of columns) corresponds to each field of the configuration table. In doing so, names in the original database are translated to a predifined subset of terms regarding taxonomic names, places, and events. The terms the simplest method and structure of the Darwin Core standards, an internationally recognized and ratified data exchange format for sharing biodiversity data and metadata (see a quick reference guide [here](https://dwc.tdwg.org/terms/)). The standardization process follows current best methods for integrating biodiversity data in a common format (e.g. the GBIF Integrated Publishing Toolkit; Robertson et al. 2014; Seebens et al. 2020).

<img src="https://img.icons8.com/windows/96/000000/box-important--v1.png" width="25"/> **Important**:

-   the input files must be located in the folder ***Input_files***as **.csv** files
-   The configuration table ***DatabaseInfo.csv*** is located in the **Config** folder

Below we can find a list of fields and their description. Each field is categorized according to its importance to run the workflow. For example, the fields assigned as required contain the basic information to execute the workflow and have to be provided by users (more details below). **The workflow is adjustable**, and users can insert other fields in the Configuration table according to their needs.

Below are listed the specifications of each field of the configuration database,

-   **Field**: Name of the fields in *DatabaseInfo.csv* to be filled in.
-   **Category**: Classification of each field in *DatabaseInfo.csv*. If *required*, the field is obligatory information required to run the workflow; if *recommended*, the field is not mandatory to run the workflow but it contains important details on species records; if *additional*, the field contains information that can be provided by users. As a general guidance, be careful to include all *required* fields and suply as many *reccomended* field as possible. Fields not supplied must be filled with **NA** (not available).
-   **Description**: Description about the content of the specified field in the original database.
-   **Type**: Type of content data on the specified field in the original database.
-   **Example**: An example of a single content on the specified field in the original database.

------------------------------------------------------------------------

| Field                            | Category    | Description of DarwinCore terms (if existing)                                                                                                                                                                      | Type          | Example                                                      |
|----------------------------------|-------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|--------------------------------------------------------------|
| datasetName                      | Required    | A short name identifying the dataset                                                                                                                                                                               | Character     | GBIF                                                         |
| fileName                         | Required    | The path containg the name of the input dataset located in the Input_file folder                                                                                                                                   | Character     | Input_files/GBIF.csv                                         |
| scientificName                   | Required    | Name of the column in the original database presenting the scientific name of the taxon with or without authorship information, depending on the format of the source dataset                                      | Character     | Myrcia acuminata                                             |
| decimalLatitude                  | Required    | Name of the column in the original database presenting the geographic latitude in decimal degrees                                                                                                                  | Numeric       | -6.370833                                                    |
| decimalLongitude                 | Required    | Name of the column in the original database presenting the geographic longitude in decimal degrees                                                                                                                 | Numeric       | -3.25500                                                     |
| occurrenceID                     | Recommended | Name of the column presenting the unique identifiers in the original databases. If absent, NA.                                                                                                                     | Numeric       | 1087566037                                                   |
| basisOfRecord                    | Recommended | Name of the column in the original database presenting the specific nature of the data record                                                                                                                      | Character     | PreservedSpecimen; HumanObservation                          |
| verbatimEventDate                | Recommended | The verbatim original date-time during which an Event occurred. Information only on year of collection can be provided. Recommended best practice is to use an encoding scheme, such as ISO ISO 8601-1:201         | date; numeric | 2018-08-29T15:19 (3:19pm local time on 29 August 2018); 1970 |
| country                          | Recommended | The name of the country or major administrative unit in which the Location occurs.                                                                                                                                 | Character     | Brazil                                                       |
| state_province                   | Recommended | Name of the column in the original database presenting the name of the next smaller administrative region than country (state, province, canton,department, region, etc.) in which the Location occurs             | Character     | Rio de Janeiro                                               |
| county                           | Recommended | Name of the column in the original database presenting the full, unabbreviated name of the next smaller administrative region than stateProvince (county, shire, department, etc.) in which the Location occurs    | Character     | Goiânia                                                      |
| locality                         | Recommended | Name of the column in the original database presenting the specific description of the place where taxon was sampled                                                                                               | Character     | Serra dos Pirineus                                           |
| identified_by                    | Additional  | Name of the column in the original database presenting the list (concatenated and separated) of names of people, groups, or organizations who assigned the taxon to the subject                                    | Character     | M. Sobral                                                    |
| coordinate_uncertainty_in_meters | Additional  | Name of the column in the original database presenting the horizontal distance (in meters) from the given decimalLatitude and decimalLongitude describing the smallest circle containing the whole of the Location | Numeric       | 10                                                           |
| coordinate_precision             | Additional  | Name of the column in the original database presenting the decimal representation of the precision of the coordinates given in the decimalLatitude and decimalLongitude                                            | Numeric       | 0.0001                                                       |
| recorded_by                      | Additional  | Name of the column in the original database presenting the list (concatenated and separated) of names of people, groups, or organizations responsible for recording the original Occurrence                        | Character     | Cervi, A.C                                                   |