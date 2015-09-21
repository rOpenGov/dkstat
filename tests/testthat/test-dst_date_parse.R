context("dst_date_parse")

test_that("dst_date_parse gives the correct class.", {
  
  exp_dates <- c("POSIXct", "POSIXt")
  
  # Daily
  expect_equal(class(dst_date_parse(dst_date = "2000M01D01")), exp_dates)
  expect_equal(class(dst_date_parse(dst_date = c("2000M01D20", "2000M02D21", "2000M03D23", "2000M04D24"))), exp_dates)
  
  # Monthly
  expect_equal(class(dst_date_parse(dst_date = "2000M01")), exp_dates)
  expect_equal(class(dst_date_parse(dst_date = c("2000M01", "2000M02", "2000M03", "2000M04", "2000M10", "2000M11"))), exp_dates)
  
  # Quarterly
  expect_equal(class(dst_date_parse(dst_date = "2000Q1")), exp_dates)
  expect_equal(class(dst_date_parse(dst_date = "2000Q2")), exp_dates)
  expect_equal(class(dst_date_parse(dst_date = "2000Q3")), exp_dates)
  expect_equal(class(dst_date_parse(dst_date = "2000Q4")), exp_dates)
  expect_equal(class(dst_date_parse(dst_date = c("2000Q1", "2000Q2", "2000Q3", "2000Q4"))), exp_dates)
  
  # Yearly
  expect_equal(class(dst_date_parse(dst_date = "2000")), exp_dates)
  expect_equal(class(dst_date_parse(dst_date = c("2000", "2000", "2000", "2000"))), exp_dates)
  
  expect_equal(class(dst_date_parse(dst_date = c("2015H1", "2015H2"))), exp_dates)
  expect_equal(as.character(dst_date_parse(dst_date = c("2015H1", "2015H2"))), c("2015-01-01", "2015-07-01"))
  
})


test_that("Test that dst_date_parse stops when the input is bad.", {
  
  # Daily
  expect_error(dst_date_parse(dst_date = "2000M01D35"))
  expect_error(dst_date_parse(dst_date = "2000M10D40"))
  
  # Monthly
  expect_error(dst_date_parse(dst_date = "20000M01"))
  expect_error(dst_date_parse(dst_date = "2000M101"))
  expect_error(dst_date_parse(dst_date = "2000M13"))
  
  # Quarterly
  expect_error(dst_date_parse(dst_date = "2000Q0"))
  expect_error(dst_date_parse(dst_date = "2000Q5"))
  
  # Yearly
  expect_error(dst_date_parse(dst_date = "20000"))
  expect_error(dst_date_parse(dst_date = "200"))
  
})
