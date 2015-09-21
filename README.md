This package connects to the [StatBank](http://www.statistikbanken.dk/statbank5a/) API from [Statistics Denmark](http://www.dst.dk).

This package is in early *BETA* and new changes will most likely not have backward compatibility.

### A short message in Danish

Denne R Statistics pakke indeholder funktioner til at give dig adgang til data gennem API'en fra Danmarks Statistik. Funktionerne henter data fra Statistikbanken og retunerer data.frame objekter med værdierne du spørger efter i dit funktionskald.

Installation
------------

You can only install the development version from github, using Hadley Wickham's [devtools](http://cran.r-project.org/web/packages/devtools/index.html) package:

    if(!require("devtools")) install.packages("devtools")
    library("devtools")
    install_github("rOpenGov/dkstat")

Examples
--------

The default language is danish, but have got a lang parameter that you can change from "da" to "en" if you wan't the data returned in English.

### Four basic function

There are four basic functions to learn:

-   dst\_search() This function makes it possible to search through the different tables for a word or a phrase.
-   dst\_tables() This function downloads all the possible tables available.
-   dst\_meta() This function lets you download the meta data for a specific table, so you can see the description, unit, variables and values you can download data for.
-   dst\_get\_data() lets you download the actual data you wan't.

Here are a few simple examples that will go through the basics of requesting data from the StatBank and the structure of the output.

First, we'll load the package:

``` r
library(dkstat)
```

The search function
-------------------

The search function let's you.. OK, you might know this already.

Here I search for gdp in the text field of the tables.

``` r
dst_search(string = "bnp", field = "text")
```

    ##         id
    ## 396 CFABNP
    ## 901   NAN1
    ## 905  NAHL2
    ## 906  NAHO2
    ## 907 NAHD21
    ## 955   NKN1
    ## 959  NKHO2
    ## 973   NRHP
    ##                                                                  text
    ## 396                                        FoU udgifter i pct. af BNP
    ## 901 Forsyningsbalance, Bruttonationalprodukt (BNP), beskæftigelse mv.
    ## 905         1-2.1.1 Produktion, BNP og indkomstdannelse (hovedposter)
    ## 906            1-2.1.1 Produktion, BNP og indkomstdannelse (oversigt)
    ## 907                                  1 Produktion og BNP (detaljeret)
    ## 955 Forsyningsbalance, Bruttonationalprodukt (BNP), beskæftigelse mv.
    ## 959                       1-2.1.1 Produktion, BNP og indkomstdannelse
    ## 973                       1-2.1.1 Produktion, BNP og indkomstdannelse
    ##                                       unit             updated firstPeriod
    ## 396 Procent af bruttonationalprodukt (BNP) 2015-01-30T09:00:00        1997
    ## 901                                      - 2015-06-30T09:00:00        1966
    ## 905                               Mio. kr. 2015-06-30T09:00:00        1966
    ## 906                               Mio. kr. 2015-06-30T09:00:00        1995
    ## 907                               Mio. kr. 2014-11-06T09:00:00        1995
    ## 955                                      - 2015-08-31T09:00:00      1990K1
    ## 959                               Mio. kr. 2015-08-31T09:00:00      1990K1
    ## 973                                      - 2014-12-16T09:00:00        1993
    ##     latestPeriod active                                     variables
    ## 396         2013   TRUE                               pct af BNP, tid
    ## 901         2014   TRUE                   transaktion, prisenhed, tid
    ## 905         2014   TRUE                   transaktion, prisenhed, tid
    ## 906         2014   TRUE                   transaktion, prisenhed, tid
    ## 907         2013   TRUE                   transaktion, prisenhed, tid
    ## 955       2015K2   TRUE transaktion, prisenhed, sæsonkorrigering, tid
    ## 959       2015K2   TRUE transaktion, prisenhed, sæsonkorrigering, tid
    ## 973         2013   TRUE           område, transaktion, prisenhed, tid

Download the tables
-------------------

The dst\_get\_tables function downloads all the available tables that the search function use when searching for a word or a phrase.

``` r
head(dst_get_tables(lang = "da"))
```

    ##      id                                                   text  unit
    ## 1 FOLK1                            Folketal den 1. i kvartalet Antal
    ## 2 FOLK2                                     Folketal 1. januar Antal
    ## 3 FOLK3                                     Folketal 1. januar Antal
    ## 4    FT           Folketal (summariske tal fra folketællinger) Antal
    ## 5 BEF5F Personer født på Færøerne og bosat i Danmark 1. januar Antal
    ## 6 BEF5G  Personer født i Grønland og bosat i Danmark 1. januar Antal
    ##               updated firstPeriod latestPeriod active
    ## 1 2015-08-11T09:00:00      2008K1       2015K3   TRUE
    ## 2 2015-02-10T09:00:00        1980         2015   TRUE
    ## 3 2015-02-10T09:00:00        2008         2015   TRUE
    ## 4 2015-02-10T09:00:00        1769         2015   TRUE
    ## 5 2015-02-10T09:00:00        2008         2015   TRUE
    ## 6 2015-02-10T09:00:00        2008         2015   TRUE
    ##                                                                  variables
    ## 1 område,køn,alder,civilstand,herkomst,oprindelsesland,statsborgerskab,tid
    ## 2                   alder,køn,herkomst,statsborgerskab,oprindelsesland,tid
    ## 3                                    fødselsdag,fødselsmåned,fødselsår,tid
    ## 4                                                       hovedlandsdele,tid
    ## 5                                       køn,alder,forældrenes fødested,tid
    ## 6                                       køn,alder,forældrenes fødested,tid

Meta data
---------

The dst\_meta function retrieves meta data from the table you wan't to take a closer look at. It can be used to create the final request, but if you can figure out the structure of the query you can define it yourself.

We'll get some meta data from the [AULAAR table](http://www.statistikbanken.dk/AULAAR). The AULAAR table has net unemployment numbers.

``` r
aulaar_meta <- dst_meta(table = "AULAAR", lang = "da")
```

The 'dst\_meta' function returns a list with 4 objects: - basics - variables - values - basic\_query

### Basics

Let's see what the basics contains:

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
    ## [1] "2015-06-19T09:00:00"

There's a table id, a short description, a unit description and when the table was updated.

### Variables

The variables in the list has a short description of each variable as well as the id. You might want to make sure that you have supplied all the ID's where the elimination columns is equal to FALSE. The IDs where eliminnation is equal FALSE are mandatory.

``` r
aulaar_meta$variables
```

    ##       id          text elimination
    ## 1    KØN           køn        TRUE
    ## 2 PERPCT personer/pct.       FALSE
    ## 3    Tid           tid       FALSE

### Values

The values is a list object of all the values in each variable. You use the text column to construct your final query:

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
    ##  $ Tid   :'data.frame':  36 obs. of  2 variables:
    ##   ..$ id  : chr [1:36] "1979" "1980" "1981" "1982" ...
    ##   ..$ text: chr [1:36] "1979" "1980" "1981" "1982" ...

Get data
--------

You need to build your query based on the text column that each variable contains in the meta\_data$values list.

``` r
aulaar <- dst_get_data(table = "AULAAR", KØN = "Total", PERPCT = "Per cent of the labour force", Tid = 2013,
                       lang = "en")
str(aulaar)
```

    ## 'data.frame':    1 obs. of  4 variables:
    ##  $ KØN   : chr "Total"
    ##  $ PERPCT: chr "Per cent of the labour force"
    ##  $ TID   : POSIXct, format: "2013-01-01"
    ##  $ value : num 4.4

In the request above I don't supply the meta\_data to the dst\_get\_data function, but this is possible as I will show below. It's a good idea to supply the meta data to the dst\_get\_data function if you query the table more than once. If you don't supply the meta data the dst\_get\_data function will request the meta data for the table and this will be very ineffecient.

Let's query the statbank using more than one value for each variable.

``` r
folk1_meta <- dst_meta("folk1", lang = "da")

str(dst_get_data(table = "folk1", 
             OMRÅDE = c("Hele landet", "København", "Frederiksberg", "Odense"), 
             STATSB = "Danmark", 
             TID = "*", 
             lang = "da", 
             meta_data = folk1_meta))
```

    ## 'data.frame':    124 obs. of  4 variables:
    ##  $ OMRÅDE: chr  "Hele landet" "Hele landet" "Hele landet" "Hele landet" ...
    ##  $ STATSB: chr  "Danmark" "Danmark" "Danmark" "Danmark" ...
    ##  $ TID   : POSIXct, format: "2008-01-01" "2008-04-01" ...
    ##  $ value : int  5177301 5180007 5185500 5190271 5191263 5192575 5198180 5202378 5204798 5205473 ...

I can also build a query beforehand and then use the query in the query parameter. This might be a good way to split your script up into smaller pieces and make it more structured.

You might have noticed that I use the \* as a value in the TID variable. You can use the star as a alternative to writing all the text values for the variable.

``` r
my_query <- list(OMRÅDE = c("Hele landet", "København", "Frederiksberg", "Odense"),
                 STATSB = "Danmark",
                 TID = "*")

str(dst_get_data(table = "folk1", query = my_query, lang = "da"))
```

    ## 'data.frame':    124 obs. of  4 variables:
    ##  $ OMRÅDE: chr  "Hele landet" "Hele landet" "Hele landet" "Hele landet" ...
    ##  $ STATSB: chr  "Danmark" "Danmark" "Danmark" "Danmark" ...
    ##  $ TID   : POSIXct, format: "2008-01-01" "2008-04-01" ...
    ##  $ value : int  5177301 5180007 5185500 5190271 5191263 5192575 5198180 5202378 5204798 5205473 ...

``` r
str(dst_get_data(table = "AUP01", OMRÅDE = c("Hele landet"), TID = "*", lang = "da"))
```

    ## 'data.frame':    103 obs. of  3 variables:
    ##  $ OMRÅDE: chr  "Hele landet" "Hele landet" "Hele landet" "Hele landet" ...
    ##  $ TID   : POSIXct, format: "2007-01-01" "2007-02-01" ...
    ##  $ value : num  4.6 4.5 4.3 4 3.7 3.5 3.2 3 3.1 3 ...

If you run into problems, then try to set the parse\_dst\_tid parameter to FALSE as there are few datasets with non-standard date formats.

Don't hesitate to submit an issue or question on github and I'll try to help as much as I can.
