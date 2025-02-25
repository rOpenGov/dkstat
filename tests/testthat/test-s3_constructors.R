test_that("new_dkstat_Denmark_municipality_07 assigns the class properly", {
  df <- data.frame(
    x = 1:999,
    y = 999:1
  ) |>
    new_dkstat_Denmark_municipality_07()

  expect_s3_class(df, "dkstat_Denmark_municipality_07")
})

test_that("new_dkstat_KOMGRP assigns the class properly", {
  df <- data.frame(
    x = 1:999,
    y = 999:1
  ) |>
    new_dkstat_KOMGRP()

  expect_s3_class(df, "dkstat_KOMGRP")
})

test_that("new_dkstat_kom_omraade assigns the class properly", {
  df <- data.frame(
    x = 1:999,
    y = 999:1
  ) |>
    new_dkstat_kom_omraade()

  expect_s3_class(df, "dkstat_kom_omraade")
})

test_that("new_dkstat_Verden_dk2 assigns the class properly", {
  df <- data.frame(
    x = 1:999,
    y = 999:1
  ) |>
    new_dkstat_Verden_dk2()

  expect_s3_class(df, "dkstat_Verden_dk2")
})

test_that("new_dkstat_denmark_cities_19 assigns the class properly", {
  df <- data.frame(
    x = 1:999,
    y = 999:1
  ) |>
    new_dkstat_denmark_cities_19()

  expect_s3_class(df, "dkstat_denmark_cities_19")
})

test_that("new_dkstat_denmark_parish_23_4c assigns the class properly", {
  df <- data.frame(
    x = 1:999,
    y = 999:1
  ) |>
    new_dkstat_denmark_parish_23_4c()

  expect_s3_class(df, "dkstat_denmark_parish_23_4c")
})

test_that("new_dkstat_denmark_municipalitygroups_24 assigns the class properly", {
  df <- data.frame(
    x = 1:999,
    y = 999:1
  ) |>
    new_dkstat_denmark_municipalitygroups_24()

  expect_s3_class(df, "dkstat_denmark_municipalitygroups_24")
})

test_that("new_dkstat_Denmark_region_07 assigns the class properly", {
  df <- data.frame(
    x = 1:999,
    y = 999:1
  ) |>
    new_dkstat_Denmark_region_07()

  expect_s3_class(df, "dkstat_Denmark_region_07")
})

test_that("new_dkstat_Denmark_rural_07 assigns the class properly", {
  df <- data.frame(
    x = 1:999,
    y = 999:1
  ) |>
    new_dkstat_Denmark_rural_07()

  expect_s3_class(df, "dkstat_Denmark_rural_07")
})

test_that("new_dkstat_denmark_multimember_constituency_23 assigns the class properly", {
  df <- data.frame(
    x = 1:999,
    y = 999:1
  ) |>
    new_dkstat_denmark_multimember_constituency_23()

  expect_s3_class(df, "dkstat_denmark_multimember_constituency_23")
})

test_that("new_dkstat_denmark_deanary_23 assigns the class properly", {
  df <- data.frame(
    x = 1:999,
    y = 999:1
  ) |>
    new_dkstat_denmark_deanary_23()

  expect_s3_class(df, "dkstat_denmark_deanary_23")
})

test_that("new_dkstat_europe_dk assigns the class properly", {
  df <- data.frame(
    x = 1:999,
    y = 999:1
  ) |>
    new_dkstat_europe_dk()

  expect_s3_class(df, "dkstat_europe_dk")
})

test_that("new_dkstat_Verden_dk assigns the class properly", {
  df <- data.frame(
    x = 1:999,
    y = 999:1
  ) |>
    new_dkstat_Verden_dk()

  expect_s3_class(df, "dkstat_Verden_dk")
})

test_that("new_dkstat_Europa_DK3 assigns the class properly", {
  df <- data.frame(
    x = 1:999,
    y = 999:1
  ) |>
    new_dkstat_Europa_DK3()

  expect_s3_class(df, "dkstat_Europa_DK3")
})

test_that("new_dkstat_Denmark_county assigns the class properly", {
  df <- data.frame(
    x = 1:999,
    y = 999:1
  ) |>
    new_dkstat_Denmark_county()

  expect_s3_class(df, "dkstat_Denmark_county")
})

test_that("new_dkstat_Verden_dk4 assigns the class properly", {
  df <- data.frame(
    x = 1:999,
    y = 999:1
  ) |>
    new_dkstat_Verden_dk4()

  expect_s3_class(df, "dkstat_Verden_dk4")
})
