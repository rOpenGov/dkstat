dst_tidy <- function(table) {
  out <- table |>
    tidy_decide_agg_type() |>
    dplyr::rename(
      agegroup = ALDER,
      time = TID,
      value = value
    ) |>
    dplyr::mutate(
      area_num = strsplit(area, " ")[[1]][1] |>
        as.numeric()
    )

  class(out) <- c("dkstat", class(out))
}

tidy_decide_agg_type <- function(table) {
  if ("KOMGRP" %in% colnames(table)) {
    table |>
      dplyr::mutate(
        area_agg_cat = "municipality",
      ) |>
      dplyr::rename(
        area = KOMGRP
      )
  }
}

tidy_municipalities <- function(table) {
  table |>
    dplyr::mutate(
      area_type = dplyr::if_else(
        strsplit(area, " ")[[1]][1] |>
          as.numeric() < 99, "Aggregate"
      )
    )
}

dst_tidy_gpt <- function(table) {
  table |>
    dplyr::rename(
      area = KOMGRP,
      agegroup = ALDER,
      time = TID,
      value = value
    ) |>
    dplyr::mutate(
      # Extract the number from the start of area
      area_num = as.numeric(sub(" .*", "", area)),
      # Create area type classification
      area_type = dplyr::case_when(
        area_num == 0 ~ "National",
        area_num >= 1 & area_num <= 10 ~ "Municipality group",
        area_num >= 100 & area_num <= 999 ~ "Municipality",
        TRUE ~ NA_character_
      ),
      # Remove the numbers and leading space from area names
      area = sub("^[0-9]+ ", "", area)
    ) |>
    dplyr::select(-area_num)  # Remove the temporary number column
}
