# dst_map.R
# This file is created to get all the map-levels provided by the API. They are
# used for the integration with `{geodk}`

# Load package
devtools::load_all(".")

# Define custom function to get metadata (this is extracted from dst_meta())
get_meta <- function(table, lang = "da") {
  dkstat_url <- paste0("http://api.statbank.dk/v1/tableinfo/", table, "?")
  dkstat_url <- httr::parse_url(url = dkstat_url)

  ## Insert query
  dkstat_url$query <- list("lang" = lang, "format" = "JSON")

  ## Get data
  meta <- httr::GET(url = dkstat_url)

  ## Parse from JSON
  meta <- jsonlite::fromJSON(
    txt = httr::content(meta, as = "text"),
    simplifyDataFrame = TRUE
  )

  return(meta)
}

# Get all tables
tbls <- dst_get_tables()$id

# Define empty map list
maps <- list()

# Loop for getting map label for each table
for (table in tbls) {
  cat("Processing:", table, "\n")
  x <- get_meta(table) |>
    dst_meta_map()
  if (!"map" %in% colnames(x$variables)) {
    cat(table, "does not have a geographic label", "\n")
  } else {
    cat(table, "has", x$variables$map, "\n")
    maps[table] <- x$variables$map
    print(maps)
  }
}

# Get a unique list of all the levels
map_levels <- maps |>
  unname() |>
  unlist() |>
  unique()

# Get a flat list
flat <- unlist(maps)

# Extract the name-value pairs for the first observation of each map-type
map_types <- maps[match(map_levels, flat)]


muni <- flat[flat %in% map_levels[1]] |>
  names()
