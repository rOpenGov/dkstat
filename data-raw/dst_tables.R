tables_en <- dst_get_tables(lang = "en")

usethis::use_data(tables_en, overwrite = TRUE)

tables_da <- dst_get_tables(lang = "da")

usethis::use_data(tables_da, overwrite = TRUE)
