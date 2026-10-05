library(readr)

readInletOutlet <- function(postProcDir = "postProcessing/samplePatches") {
   base_dir <- postProcDir
  latest_time <- max(as.numeric(list.files(base_dir)), na.rm = TRUE)
  path_latest <- file.path(base_dir, as.character(latest_time))
  
  read_val <- function(patch, field, col_idx) {
    file_path <- file.path(path_latest, paste0(field, "_", patch, ".raw"))
    df <- read_table(file_path, show_col_types = FALSE, comment = "#", col_names = FALSE)
    return(df[[col_idx]])
  }
  
  # Read height coordinate (z) once from the first file (assumed identical everywhere)
  z_coords <- read_val("inletProfile", "k", 3)
  
  # Bind columns side-by-side
  fieldsInOut <- data.frame(
    z              = z_coords,
    kInlet         = read_val("inletProfile", "k", 4),
    UxInlet        = read_val("inletProfile", "U", 4),
    epsilonInlet   = read_val("inletProfile", "epsilon", 4),
    kOutlet        = read_val("outletProfile", "k", 4),
    UxOutlet       = read_val("outletProfile", "U", 4),
    epsilonOutlet  = read_val("outletProfile", "epsilon", 4)
  )

  return(fieldsInOut)
}
