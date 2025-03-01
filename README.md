Statistics Denmark StatBank API connection
================

# dkstat <a href='https://ropengov.github.io/dkstat/'><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

[![rOG-badge](https://ropengov.github.io/rogtemplate/reference/figures/ropengov-badge.svg)](http://ropengov.org/)
[![Codecov test
coverage](https://codecov.io/gh/ropengov/dkstat/graph/badge.svg)](https://app.codecov.io/gh/ropengov/dkstat)
[![R-CMD-check](https://github.com/rOpenGov/dkstat/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/rOpenGov/dkstat/actions/workflows/R-CMD-check.yaml)
[![dkstat status
badge](https://ropengov.r-universe.dev/dkstat/badges/version)](https://ropengov.r-universe.dev/dkstat)
<!-- badges: end -->

This package connects to the
[StatBank](http://www.statistikbanken.dk/statbank5a/) API from
[Statistics Denmark](http://www.dst.dk).

This package is in early *BETA* and new changes will most likely not
have backward compatibility.

### A short message in Danish

Denne R Statistics pakke indeholder funktioner til at give dig adgang
til data gennem API’en fra Danmarks Statistik. Funktionerne henter data
fra Statistikbanken og retunerer data.frame objekter med værdierne du
spørger efter i dit funktionskald.

## Installation

You can install `{dkstat}` from r-universe with:

``` r
install.packages(
  "dkstat",
  repos = c(
    ropengov = "https://ropengov.r-universe.dev",
    getOption("repos")
  )
)
```

You can install the latest development version of `{dkstat}` from
[GitHub](https://github.com/rOpenGov/dkstat) with:

``` r
# install.packages("devtools")
devtools::install_github("rOpenGov/dkstat")
```

## Examples

The default language is danish, but have got a lang parameter that you
can change from “da” to “en” if you wan’t the data returned in English.

### Four basic function

There are four basic functions to learn:

- dst_search() This function makes it possible to search through the
  different tables for a word or a phrase.
- dst_tables() This function downloads all the possible tables
  available.
- dst_meta() This function lets you download the meta data for a
  specific table, so you can see the description, unit, variables and
  values you can download data for.  
- dst_get_data() lets you download the actual data you wan’t.

Here are a few simple examples that will go through the basics of
requesting data from the StatBank and the structure of the output.

First, we’ll load the package:

``` r
library(dkstat)
```

## The search function

The search function let’s you.. OK, you might know this already.

Here I search for gdp in the text field of the tables.

``` r
dst_search(string = "bnp", field = "text")
```

    ##          id
    ## 569    NAN1
    ## 573    NKN1
    ## 578   NAHL2
    ## 581   NKHO2
    ## 584   NAHO2
    ## 587  NAHD21
    ## 656    NRHP
    ## 657   VNRHP
    ## 1223 CFABNP
    ##                                                                                   text
    ## 569  Forsyningsbalance, bruttonationalprodukt (BNP),økonomisk vækst, beskæftigelse mv.
    ## 573                  Forsyningsbalance, Bruttonationalprodukt (BNP), beskæftigelse mv.
    ## 578                          1-2.1.1 Produktion, BNP og indkomstdannelse (hovedposter)
    ## 581                                        1-2.1.1 Produktion, BNP og indkomstdannelse
    ## 584                             1-2.1.1 Produktion, BNP og indkomstdannelse (oversigt)
    ## 587                                                   1 Produktion og BNP (detaljeret)
    ## 656                                        1-2.1.1 Produktion, BNP og indkomstdannelse
    ## 657                           Versionstabel NRHP - Produktion, BNP og indkomstdannelse
    ## 1223                                                        FoU udgifter i pct. af BNP
    ##             unit             updated firstPeriod latestPeriod active
    ## 569            - 2025-02-20T08:00:00        1966         2024   TRUE
    ## 573            - 2025-02-20T08:00:00      1990K1       2024K4   TRUE
    ## 578     Mio. kr. 2025-02-20T08:00:00        1966         2024   TRUE
    ## 581     Mio. kr. 2025-02-20T08:00:00      1990K1       2024K4   TRUE
    ## 584     Mio. kr. 2025-02-20T08:00:00        1995         2024   TRUE
    ## 587     Mio. kr. 2024-06-28T08:00:00        1995         2023   TRUE
    ## 656            - 2024-10-28T08:00:00        1993         2023   TRUE
    ## 657            - 2024-10-28T08:00:00        1993         2023   TRUE
    ## 1223 Pct. af bnp 2023-12-14T08:00:00        1997         2022   TRUE
    ##                                          variables
    ## 569                    transaktion, prisenhed, tid
    ## 573  transaktion, prisenhed, sæsonkorrigering, tid
    ## 578                    transaktion, prisenhed, tid
    ## 581  transaktion, prisenhed, sæsonkorrigering, tid
    ## 584                    transaktion, prisenhed, tid
    ## 587                    transaktion, prisenhed, tid
    ## 656            område, transaktion, prisenhed, tid
    ## 657   version, område, transaktion, prisenhed, tid
    ## 1223                               pct af BNP, tid

## Download the tables

The dst_get_tables function downloads all the available tables that the
search function use when searching for a word or a phrase.

``` r
head(dst_get_tables(lang = "da"))
```

    ##         id                            text  unit             updated
    ## 1   FOLK1A Befolkningen den 1. i kvartalet Antal 2025-02-11T08:00:00
    ## 2  FOLK1AM   Befolkningen den 1. i måneden Antal 2025-02-11T08:00:00
    ## 3  BEFOLK1          Befolkningen 1. januar Antal 2025-02-11T08:00:00
    ## 4  BEFOLK2          Befolkningen 1. januar Antal 2025-02-11T08:00:00
    ## 5    FOLK3          Befolkningen 1. januar Antal 2025-02-11T08:00:00
    ## 6 FOLK3FOD          Befolkningen 1. januar Antal 2025-02-11T08:00:00
    ##   firstPeriod latestPeriod active                             variables
    ## 1      2008K1       2025K1   TRUE       område,køn,alder,civilstand,tid
    ## 2     2021M10      2025M01   TRUE                  område,køn,alder,tid
    ## 3        1971         2025   TRUE              køn,alder,civilstand,tid
    ## 4        1901         2025   TRUE                         køn,alder,tid
    ## 5        2008         2025   TRUE fødselsdag,fødselsmåned,fødselsår,tid
    ## 6        2008         2025   TRUE  fødselsdag,fødselsmåned,fødeland,tid

## Meta data

The dst_meta function retrieves meta data from the table you wan’t to
take a closer look at. It can be used to create the final request, but
if you can figure out the structure of the query you can define it
yourself.

We’ll get some meta data from the [AULAAR
table](http://www.statistikbanken.dk/AULAAR). The AULAAR table has net
unemployment numbers.

``` r
aulaar_meta <- dst_meta(table = "AULAAR", lang = "da")
```

The ‘dst_meta’ function returns a list with 4 objects: - basics -
variables - values - basic_query

### Basics

Let’s see what the basics contains:

``` r
aulaar_meta$basics
```

    ## $id
    ## [1] "AULAAR"
    ## 
    ## $text
    ## [1] "Fuldtidsledige (netto)"
    ## 
    ## $description
    ## [1] "Fuldtidsledige (netto) efter køn, personer/pct. og tid"
    ## 
    ## $unit
    ## [1] "Antal"
    ## 
    ## $updated
    ## [1] "2024-04-16T08:00:00"
    ## 
    ## $footnote
    ## NULL

There’s a table id, a short description, a unit description and when the
table was updated.

### Variables

The variables in the list has a short description of each variable as
well as the id. You might want to make sure that you have supplied all
the ID’s where the elimination columns is equal to FALSE. The IDs where
eliminnation is equal FALSE are mandatory.

``` r
aulaar_meta$variables
```

    ##       id          text elimination
    ## 1    KØN           køn        TRUE
    ## 2 PERPCT personer/pct.       FALSE
    ## 3    Tid           tid       FALSE

### Values

The values is a list object of all the values in each variable. You use
the text column to construct your final query:

``` r
str(aulaar_meta$values)
```

    ## List of 3
    ##  $ KØN   :'data.frame':  3 obs. of  2 variables:
    ##   ..$ id  : chr [1:3] "TOT" "M" "K"
    ##   ..$ text: chr [1:3] "I alt" "Mænd" "Kvinder"
    ##  $ PERPCT:'data.frame':  2 obs. of  2 variables:
    ##   ..$ id  : chr [1:2] "L10" "L9"
    ##   ..$ text: chr [1:2] "Procent af arbejdsstyrken" "Ledige (1000 personer)"
    ##  $ Tid   :'data.frame':  45 obs. of  2 variables:
    ##   ..$ id  : chr [1:45] "1979" "1980" "1981" "1982" ...
    ##   ..$ text: chr [1:45] "1979" "1980" "1981" "1982" ...

## Get data

You need to build your query based on the text column that each variable
contains in the meta_data\$values list.

``` r
aulaar <- dst_get_data(
  table = "AULAAR", KØN = "Total", PERPCT = "Per cent of the labour force", Tid = 2013,
  lang = "en"
)
str(aulaar)
```

    ## 'data.frame':    1 obs. of  4 variables:
    ##  $ KØN   : chr "TOT Total"
    ##  $ PERPCT: chr "L10 Per cent of the labour force"
    ##  $ TID   : POSIXct, format: "2013-01-01"
    ##  $ value : num 4.4

In the request above I don’t supply the meta_data to the dst_get_data
function, but this is possible as I will show below. It’s a good idea to
supply the meta data to the dst_get_data function if you query the table
more than once. If you don’t supply the meta data the dst_get_data
function will request the meta data for the table and this will be very
ineffecient.

Let’s query the statbank using more than one value for each variable.

``` r
folk1a_meta <- dst_meta("folk1a", lang = "da")

str(dst_get_data(
  table = "folk1a",
  Tid = "*",
  CIVILSTAND = "*",
  ALDER = "*",
  OMRÅDE = c("Hele landet", "København", "Dragør", "Albertslund"),
  lang = "da",
  meta_data = folk1a_meta
))
```

    ## Classes 'dkstat_Denmark_municipality_07' and 'data.frame':   175260 obs. of  5 variables:
    ##  $ TID       : POSIXct, format: "2008-01-01" "2008-01-01" ...
    ##  $ CIVILSTAND: chr  "TOT I alt" "TOT I alt" "TOT I alt" "TOT I alt" ...
    ##  $ ALDER     : chr  "IALT Alder i alt" "IALT Alder i alt" "IALT Alder i alt" "IALT Alder i alt" ...
    ##  $ OMRÅDE    : chr  "000 Hele landet" "101 København" "155 Dragør" "165 Albertslund" ...
    ##  $ value     : int  5475791 509861 13261 27602 64412 7986 121 295 65722 7097 ...

I can also build a query beforehand and then use the query in the query
parameter. This might be a good way to split your script up into smaller
pieces and make it more structured.

You might have noticed that I use the \* as a value in the TID variable.
You can use the star as a alternative to writing all the text values for
the variable.

``` r
my_query <- list(
  OMRÅDE = c("Hele landet", "København", "Frederiksberg", "Odense"),
  CIVILSTAND = "Ugift",
  TID = "*"
)

str(dst_get_data(table = "folk1a", query = my_query, lang = "da"))
```

    ## Classes 'dkstat_Denmark_municipality_07' and 'data.frame':   276 obs. of  4 variables:
    ##  $ OMRÅDE    : chr  "000 Hele landet" "000 Hele landet" "000 Hele landet" "000 Hele landet" ...
    ##  $ CIVILSTAND: chr  "U Ugift" "U Ugift" "U Ugift" "U Ugift" ...
    ##  $ TID       : POSIXct, format: "2008-01-01" "2008-04-01" ...
    ##  $ value     : int  2552700 2563134 2564705 2568255 2575185 2584993 2584560 2588198 2593172 2604129 ...

``` r
str(dst_get_data(table = "AUP01", OMRÅDE = c("Hele landet"), TID = "*", lang = "da"))
```

    ## Classes 'dkstat_Denmark_municipality_07' and 'data.frame':   90 obs. of  3 variables:
    ##  $ OMRÅDE: chr  "000 Hele landet" "000 Hele landet" "000 Hele landet" "000 Hele landet" ...
    ##  $ TID   : POSIXct, format: "2017-07-01" "2017-08-01" ...
    ##  $ value : num  4 4.1 3.9 4 4 4.1 4.2 4.2 4.1 3.7 ...

If you run into problems, then try to set the parse_dst_tid parameter to
FALSE as there are few datasets with non-standard date formats.

Don’t hesitate to submit an issue or question on github and I’ll try to
help as much as I can.
