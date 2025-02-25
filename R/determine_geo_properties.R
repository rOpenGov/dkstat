# determine_geo_properties.R
# This file contains the logic to decide what kind of geographic information is
# included in a given dataset. The function is mainly used in
# `dst_get_data()` - Thus affecting `dst_get_all_data()`

determine_geo_properties <- function(table, df) {
  clnms <- colnames(df)

  meta <- dst_meta(table, lang = "da", geo = TRUE)

  if (is_geographic(meta)) {
    chosen_constructor <- choose_geo_class(meta)
    chosen_constructor(df)
  } else {
    df
  }
}

# Check if the metadata indicates a geographic variable
is_geographic <- function(meta) {
  if (is.null(meta)) {
    FALSE
  } else if (!is.null(meta)) {
    TRUE
  }
}

# Choose a class constructor
choose_geo_class <- function(meta) {
  # Get the map variable
  meta_class <- meta$variables$map

  # Paste class constructor name prefix with class name and get function
  paste0("new_dkstat_", meta_class) |>
    get()
}
