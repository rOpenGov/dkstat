


context("dst_value_limit")

test_that("dst_value_limit returns the correct value.", {
  
  expect_equal(dst_value_limit(query = list(CIVILSTAND = "*", 
                                            STATSB = "*", 
                                            HERKOMST = c("Personer med dansk oprindelse", "Efterkommere")), 
                               dst_meta = dst_meta("folk1", lang = "da")), 3318)
  
  
})

