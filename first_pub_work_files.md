Test Publication - course work notes
================

###### example from before

##### download.file("<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv>", destfile = "quiz2data.csv")

##### url&lt;-"<https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD>"

##### download.file (url, destfile= "Week\_4\_stuff",method = "curl")

##### cd&lt;-read.csv("Week\_4\_stuff") - NOTE THE CODE DID NOT WORK FOR ME

``` r
library(dplyr)
```

    ## Warning: package 'dplyr' was built under R version 3.3.3

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(stringr)
library(lubridate)
```

    ## 
    ## Attaching package: 'lubridate'

    ## The following object is masked from 'package:base':
    ## 
    ##     date

                ##IMPORTANT MESSAGE - THIS IS HOW I GET DOWNLOAD TO WORK:

above didn't work but I went to the above url address and downloaded directly from explorer to my R directory
-------------------------------------------------------------------------------------------------------------

``` r
cd<-read.csv("Baltimore_Fixed_Speed_Cameras.csv",stringsAsFactors = FALSE)
cd1<-tbl_df(cd)
```

FOLLOWING FROM LESSON
---------------------

``` r
names(cd1) ##note some uppercase - could be hard to work with - make them all lower case as follows:
```

    ## [1] "address"      "direction"    "street"       "crossStreet" 
    ## [5] "intersection" "Location.1"

``` r
tolower(names(cd1))
```

    ## [1] "address"      "direction"    "street"       "crossstreet" 
    ## [5] "intersection" "location.1"

get read of periods:
--------------------

``` r
cd2=strsplit(names(cd1),"\\.") ##this splits "location.1" into two parts of the same name/location in the list "location" and "1"

firstElementOnly<-function(x){x[1]}
sapply(cd2,firstElementOnly)    ##this gets rid of the "1" or ALL second components of the cd2 list
```

    ## [1] "address"      "direction"    "street"       "crossStreet" 
    ## [5] "intersection" "Location"

gsub("\_","",anylist/vector) this removes all "-" from names in list
--------------------------------------------------------------------

``` r
grep("Alameda",cd1$intersection)  ##gets all values with Alameda in them  from "intersection" variable
```

    ## [1]  4  5 36

``` r
table(grepl("Alameda",cd1$intersection))  ##returns the following: FALSE  TRUE 
```

    ## 
    ## FALSE  TRUE 
    ##    77     3

``` r
                                                          ##        77     3 
cd1b<-cd1[!grepl("Alameda",cd1$intersection),]  ## removes all rows with Alameda in intersection variable
cd1c<-cd1[grepl("Alameda",cd1$intersection),]  ##return only rows with Alameda in intersection variable
grep("Alameda",cd1$intersection,value = T)  ## gives you the actual value and not just the location 
```

    ## [1] "The Alameda  & 33rd St"   "E 33rd  & The Alameda"   
    ## [3] "Harford \n & The Alameda"

``` r
                                        ## which grep("Alameda",cd1$intersection) gives
```

Library(stringr) has nchar function
-----------------------------------

``` r
nchar("Gary Hulbert") ##gives you number of characters in name - return is 12 (includes the space)
```

    ## [1] 12

``` r
substr("Gary Hulbert",1,7)  ##gives first seven characters in name/string
```

    ## [1] "Gary Hu"

``` r
paste("string1","string2")  ##returns [1] "string1 string2"
```

    ## [1] "string1 string2"

``` r
paste0("string1","string2")  ##returns [1] "string1string2"
```

    ## [1] "string1string2"

``` r
str_trim("Gary     ")  ##returns [1] "Gary"
```

    ## [1] "Gary"

lubridate time zones - <http://en.wikipedia.org/wiki/List_of_tz_database_time_zones>
------------------------------------------------------------------------------------

Misc examples
=============

### PROBLEM 1

``` r
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile="quiz4_06hid.csv")

c1<-read.csv( "quiz4_06hid.csv",stringsAsFactors = FALSE)
d1<-tbl_df(c1)
l1<-names(d1)
##from homework cd2=strsplit(names(cd1),"\\.")
l2=strsplit(l1,"wgtp")
l2[123]  ## returns: [1] ""   "15"
```

    ## [[1]]
    ## [1] ""   "15"

### PROBLEM 2

``` r
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile="quiz4b_FGDP.csv")
c21<-read.csv("quiz4b_FGDP.csv",stringsAsFactors = FALSE)
d21<-tbl_df(c21)
d22<-filter(d21,X!="")
d22b<-rename(d22,GDP=X.3)
d23<-gsub(",","",d22b$GDP)  ##removes all commas from X.3/GDP
d23<-as.integer(d23)  ##changes from characters to intergers
```

    ## Warning: NAs introduced by coercion

``` r
d24<-d23[!is.na(d23)]  ##removes missing values
d25<-d24[1:190] ##removes all GDP figures (subtotals, etc) but the 190 countries
mean(d25)  ## returns:  377652.4
```

    ## [1] 377652.4

PROBLEM 3
---------

``` r
## Following from last quiz problem 3

c11<-read.csv("GDP.csv", stringsAsFactors = FALSE)
c12<-read.csv("EDSTATS_Country.csv", stringsAsFactors = FALSE)
q11<-tbl_df(c11)
q12<-tbl_df(c12)
q111<-filter(q11,X!="")
q1111<-select(q111, CountryCode=X, GDPranking=Gross.domestic.product.2012, Longname=X.2, GDP=X.3)
q15<-filter(q1111,GDPranking!="")  ## rename() instead of select() would have kept all variables
m1<-merge(q15,q12,by="CountryCode")
m2<-tbl_df(m1)

##NEW STUFF

June<-grepl("june",tolower(m2$Special.Notes))
yrend<-grepl("fiscal year end",tolower(m2$Special.Notes))
table(yrend,June)
```

    ##        June
    ## yrend   FALSE TRUE
    ##   FALSE   155    3
    ##   TRUE     18   13

PROBLEM 5
---------

``` r
##Use the following code to download data on Amazon's stock 
library(quantmod)
```

    ## Warning: package 'quantmod' was built under R version 3.3.3

    ## Loading required package: xts

    ## Warning: package 'xts' was built under R version 3.3.3

    ## Loading required package: zoo

    ## Warning: package 'zoo' was built under R version 3.3.3

    ## 
    ## Attaching package: 'zoo'

    ## The following objects are masked from 'package:base':
    ## 
    ##     as.Date, as.Date.numeric

    ## 
    ## Attaching package: 'xts'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     first, last

    ## Loading required package: TTR

    ## Warning: package 'TTR' was built under R version 3.3.3

    ## Version 0.4-0 included new data defaults. See ?getSymbols.

``` r
amzn = getSymbols("AMZN",auto.assign=FALSE)
```

    ##     As of 0.4-0, 'getSymbols' uses env=parent.frame() and
    ##  auto.assign=TRUE by default.
    ## 
    ##  This  behavior  will be  phased out in 0.5-0  when the call  will
    ##  default to use auto.assign=FALSE. getOption("getSymbols.env") and 
    ##  getOptions("getSymbols.auto.assign") are now checked for alternate defaults
    ## 
    ##  This message is shown once per session and may be disabled by setting 
    ##  options("getSymbols.warning4.0"=FALSE). See ?getSymbols for more details.

``` r
sampleTimes = index(amzn)  ##sampleTimes is a long list (about 2500 dates like "2010-12-13")

addmargins(table(year(sampleTimes), weekdays(sampleTimes))) 
```

    ##       
    ##        Friday Monday Thursday Tuesday Wednesday  Sum
    ##   2007     51     48       51      50        51  251
    ##   2008     50     48       50      52        53  253
    ##   2009     49     48       51      52        52  252
    ##   2010     50     47       51      52        52  252
    ##   2011     51     46       51      52        52  252
    ##   2012     51     47       51      50        51  250
    ##   2013     51     48       50      52        51  252
    ##   2014     50     48       50      52        52  252
    ##   2015     49     48       51      52        52  252
    ##   2016     51     46       51      52        52  252
    ##   2017     14     12       15      15        15   71
    ##   Sum     517    486      522     531       533 2589

``` r
##makes table of 2007-2017(rows) & WEEKDAYS(columns)
```

the following also works
------------------------

``` r
length(sampleTimes[grep("^2012",sampleTimes)])
```

    ## [1] 250

``` r
sum(weekdays(as.Date(sampleTimes[grep("^2012",sampleTimes)]))=="Monday")
```

    ## [1] 47

the following is similar and works
----------------------------------

``` r
t1<-sampleTimes[grep("^2012",sampleTimes)]
sum(weekdays(as.Date(t1))=="Monday")
```

    ## [1] 47

``` r
length(t1)
```

    ## [1] 250
