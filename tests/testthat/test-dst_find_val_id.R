test_that("dst_find_val_id returns proper information on wrongly specified variable values", {
  # See issue #19 https://github.com/rOpenGov/dkstat/issues/19

  folk1a_meta <- dst_meta("folk1a", lang = "da")

  expect_error(dst_get_data(
    table = "folk1a",
    Tid = "*",
    CIVILSTAND = "*",
    ALDER = "*",
    OMRÅDE = c("Hele landets verden", "København K", "Dragør", "Albertslund"),
    lang = "da",
    meta_data = folk1a_meta
  ))

  expect_snapshot_error(
    dst_get_data(
      table = "folk1a",
      Tid = "*",
      CIVILSTAND = "*",
      ALDER = "*",
      OMRÅDE = c("Hele landets verden", "København K", "Dragør", "Albertslund"),
      lang = "da",
      meta_data = folk1a_meta
    )
  )

})
