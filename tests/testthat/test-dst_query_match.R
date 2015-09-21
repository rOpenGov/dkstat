

context("dst_query_match")

test_that("The function fails when mandatory values are not supplied.",{
  
  expect_error(dst_query_match(table = "NRHP", meta_data = NULL, lang = "en", query = list(TRANSAKT = "P.1 Output", Tid = "1993")))
})