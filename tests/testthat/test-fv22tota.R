test_that("Tables with identifyers with the same name but different ids are parsed properly", {
  # This tests that the issue in https://github.com/rOpenGov/dkstat/issues/24
  # does not occur

  table <- dst_get_data(
    table = "FV22TOTA",
    VALRES = "*",
    OMRÅDE = "*",
    Tid = "*",
    lang = "da",
    format = "BULK"
  )

  expect_equal(nrow(unique(table)), nrow(table))
  expect_equal(nrow(table) - nrow(unique(table)), 0)

})
