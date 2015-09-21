
context("dst_get_data")

test_that("dst_get_data returns an error when the limit is reached.", {
  
  expect_error(dst_get_data(table = "folk1",
                            query = list(CIVILSTAND = "*", 
                                            STATSB = "*", 
                                            HERKOMST = c("Personer med dansk oprindelse", "Efterkommere"),
                                            TID = "*",
                                            ALDER = "*"), lang = "da"))
  
})


test_that("dst_get_data is parsing the data correctly when 'en' and 'da' are selected as language. The API returns decimal numbers with both , and .", {
  
  expect_equal(class(dst_get_data("AUP01", ALDER = "*", TID = "*", lang = "da")$value), "numeric")
  
})
