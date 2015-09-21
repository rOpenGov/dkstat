
context("dst_get_tables")

test_that("dst_get_tables return a data.frame",{
  
  expect_equal(class(dst_get_tables(lang = "da")), "data.frame")
  expect_equal(class(dst_get_tables(lang = "en")), "data.frame")
  
})

test_that("dst_get_tables failes with wrong language input",{
  
  expect_error(dst_get_tables(lang = "uk"))
  expect_error(dst_get_tables(lang = "no"))
})


