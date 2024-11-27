


context("dst_value_limit")

test_that("dst_value_limit returns the correct value.", {

  expect_equal(dst_value_limit(query = list(CIVILSTAND = "*",
                                            ALDER = "*",
                                            OMRÅDE = c(
                                              "Hele landet",
                                              "København",
                                              "Dragør",
                                              "Albertslund",
                                              "Christiansø",
                                              "Køge",
                                              "Glostrup",
                                              "Faaborg-Midtfyn",
                                              "Holstebro",
                                              "Læsø"
                                            )),
                               dst_meta = dst_meta("folk1a", lang = "da")), 6350)


})

