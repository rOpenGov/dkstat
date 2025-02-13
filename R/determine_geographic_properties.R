# determine_geographic_properties.R
# This file contains the logic to decide what kind of geographic information is
# included in a given dataset. The function is mainly used in
# `dst_get_all_data()`

determine_geographic_properties <- function(df) {
  clnms <- colnames(df)

  if (is_geographic(clnms)) {
    chosen_constructor <- choose_geo_class(df, clnms)
    chosen_constructor(df)
  } else {
    return(df)
  }
}

is_geographic <- function(varnames) {
  # If any of the variable names are recorded as geographic, return TRUE
  any(varnames %in% geo_vars)
}

choose_geo_class <- function(df, clnms) {
  g_vars <- intersect(geo_vars, clnms)

  if (g_vars == "OMRÅDE") {
    if (identical(unique(df$OMRÅDE), geographic_vectors[["kom_omraade"]])) {
      new_dkstat_kom_omraade
    } else if (identical(unique(df$OMRÅDE), geographic_vectors[["komgrp"]])) {
      new_dkstat_KOMGRP
    }
  }

  if (g_vars == "KOMGRP") {
    if (identical(unique(df$KOMGRP), geographic_vectors[["kom_omraade"]])) {
      new_dkstat_kom_omraade
    } else if (identical(unique(df$KOMGRP), geographic_vectors[["komgrp"]])) {
      new_dkstat_KOMGRP
    }
  }

}
