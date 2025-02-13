# dkstat_groups.R
# This file is found in
# https://github.com/rOpenGov/dkstat/blob/main/data-raw/dkstat_groups.R and
# https://github.com/rOpenGov/geodk/blob/main/data-raw/dkstat_groups.R. If you
# change anything in either file, please remember to change in both places.

## Municipality groups - KOMGRP
create_groups <- function(x) {

  levels <- x |>
    dplyr::filter(NIVEAU == 1) |>
    unique() |>
    dplyr::pull(name)

  id <- 0
  groups <- numeric(nrow(x))

  for (i in 1:nrow(x)) {
    if (x$NIVEAU[i] == 1) {
      id <- id + 1
    }

    groups[i] <- id
  }

  x$group <- groups
  x$level <- levels[groups]
  return(x)
}

# I have contacted the consultant in charge of the classification and requested
# a download-link / api-access to not have to distribute the csv-file alongside
# the package source code.
# https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/kommunegrupper
komgrp <- readr::read_csv2("data-raw/komgrp.csv") |>
  dplyr::select(KODE, NIVEAU, TITEL) |>
  dplyr::mutate(
    name = paste(KODE, TITEL)
  ) |>
  create_groups() |>
  dplyr::group_by(level) |>
  dplyr::filter(NIVEAU == 2) |>
  dplyr::summarise(
    list = list({
      values <- TITEL
      names(values) <- paste(KODE, TITEL, sep = " ")
      as.list(values)
    })
  ) |>
  tibble::deframe()

usethis::use_data(komgrp, compress = "xz", overwrite = TRUE, internal = TRUE)


# Municipality groups with "Hele landet" as well
kom_omraade <- c(
  "000 Hele landet",
  "1 Hovedstadskommuner",
  "2 Storbykommuner",
  "3 Provinsbykommuner",
  "4 Oplandskommuner",
  "5 Landkommuner",
  "101 København",
  "147 Frederiksberg",
  "155 Dragør",
  "185 Tårnby",
  "165 Albertslund",
  "151 Ballerup",
  "153 Brøndby",
  "157 Gentofte",
  "159 Gladsaxe",
  "161 Glostrup",
  "163 Herlev",
  "167 Hvidovre",
  "169 Høje-Taastrup",
  "183 Ishøj",
  "173 Lyngby-Taarbæk",
  "175 Rødovre",
  "187 Vallensbæk",
  "201 Allerød",
  "240 Egedal",
  "210 Fredensborg",
  "250 Frederikssund",
  "190 Furesø",
  "270 Gribskov",
  "260 Halsnæs",
  "217 Helsingør",
  "219 Hillerød",
  "223 Hørsholm",
  "230 Rudersdal",
  "400 Bornholm",
  "411 Christiansø",
  "253 Greve",
  "259 Køge",
  "350 Lejre",
  "265 Roskilde",
  "269 Solrød",
  "320 Faxe",
  "376 Guldborgsund",
  "316 Holbæk",
  "326 Kalundborg",
  "360 Lolland",
  "370 Næstved",
  "306 Odsherred",
  "329 Ringsted",
  "330 Slagelse",
  "340 Sorø",
  "336 Stevns",
  "390 Vordingborg",
  "420 Assens",
  "430 Faaborg-Midtfyn",
  "440 Kerteminde",
  "482 Langeland",
  "410 Middelfart",
  "480 Nordfyns",
  "450 Nyborg",
  "461 Odense",
  "479 Svendborg",
  "492 Ærø",
  "530 Billund",
  "561 Esbjerg",
  "563 Fanø",
  "607 Fredericia",
  "510 Haderslev",
  "621 Kolding",
  "540 Sønderborg",
  "550 Tønder",
  "573 Varde",
  "575 Vejen",
  "630 Vejle",
  "580 Aabenraa",
  "710 Favrskov",
  "766 Hedensted",
  "615 Horsens",
  "707 Norddjurs",
  "727 Odder",
  "730 Randers",
  "741 Samsø",
  "740 Silkeborg",
  "746 Skanderborg",
  "706 Syddjurs",
  "751 Aarhus",
  "657 Herning",
  "661 Holstebro",
  "756 Ikast-Brande",
  "665 Lemvig",
  "760 Ringkøbing-Skjern",
  "779 Skive",
  "671 Struer",
  "791 Viborg",
  "810 Brønderslev",
  "813 Frederikshavn",
  "860 Hjørring",
  "849 Jammerbugt",
  "825 Læsø",
  "846 Mariagerfjord",
  "773 Morsø",
  "840 Rebild",
  "787 Thisted",
  "820 Vesthimmerlands",
  "851 Aalborg"
)

usethis::use_data(kom_omraade, compress = "xz", overwrite = TRUE, internal = TRUE)
