##Week 4 work stuff
## example from before 
##download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "quiz2data.csv")
url<-"https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"

download.file (url, destfile= "Week_4_stuff",method = "curl")
cd<-read.csv("Week_4_stuff")



                ##IMPORTANT MESSAGE - THIS IS HOW I GET DOWNLOAD TO WORK:

##above didn't work but I went to the above url address and downloaded directly from explorer to my R directory
cd<-read.csv("Baltimore_Fixed_Speed_Cameras.csv",stringsAsFactors = FALSE)
cd1<-tbl_df(cd)

##FOLLOWING FROM LESSON
names(cd1) ##note some uppercase - could be hard to work with - make them all lower case as follows:
tolower(names(cd1))
##get read of periods:
cd2=strsplit(names(cd1),"\\.") ##this splits "location.1" into two parts of the same name/location in the list "location" and "1"

firstElementOnly<-function(x){x[1]}
sapply(cd2,firstElementOnly)    ##this gets rid of the "1" or ALL second components of the cd2 list

##gsub("_","",anylist/vector)  this removes all "-" from names in list 
grep("Alameda",cd1$intersection)  ##gets all values with Alameda in them  from "intersection" variable
table(grepl("Alameda",cd1$intersection))  ##returns the following: FALSE  TRUE 
                                                          ##        77     3 
cd1b<-cd1[!grepl("Alameda",cd1$intersection),]  ## removes all rows with Alameda in intersection variable
cd1c<-cd1[grepl("Alameda",cd1$intersection),]  ##return only rows with Alameda in intersection variable
grep("Alameda",cd1$intersection,value = T)  ## gives you the actual value and not just the location 
                                        ## which grep("Alameda",cd1$intersection) gives

##Library(stringr) has nchar function
nchar("Gary Hulbert") ##gives you number of characters in name - return is 12 (includes the space)
substr("Gary Hulbert",1,7)  ##gives first seven characters in name/string
paste("string1","string2")  ##returns [1] "string1 string2"
paste0("string1","string2")  ##returns [1] "string1string2"
str_trim("Gary     ")  ##returns [1] "Gary"


##lubridate time zones - http://en.wikipedia.org/wiki/List_of_tz_database_time_zones



Quiz4


##PROBLEM 1

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile="quiz4_06hid.csv")

c1<-read.csv( "quiz4_06hid.csv",stringsAsFactors = FALSE)
d1<-tbl_df(c1)
l1<-names(d1)
##from homework cd2=strsplit(names(cd1),"\\.")
l2=strsplit(l1,"wgtp")
l2[123]  ## returns: [1] ""   "15"



##PROBLEM 2
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile="quiz4b_FGDP.csv")
c21<-read.csv("quiz4b_FGDP.csv",stringsAsFactors = FALSE)
d21<-tbl_df(c21)
d22<-filter(d21,X!="")
d22b<-rename(d22,GDP=X.3)
d23<-gsub(",","",d22b$GDP)  ##removes all commas from X.3/GDP
d23<-as.integer(d23)  ##changes from characters to intergers
d24<-d23[!is.na(d23)]  ##removes missing values
d25<-d24[1:190] ##removes all GDP figures (subtotals, etc) but the 190 countries
mean(d25)  ## returns:  377652.4

##PROBLEM 3

t1<-grep("*United",d22b$X.2), 2

grep("^United",d22b$X.2), 3   ##this is answer - not sure why - what does ",3" mean?

grep("^United",d22b$X.2), 4

grep("^United$",d22b$X.2), 3


##PROBLEM 4

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


##PROBLEM 5


##Use the following code to download data on Amazon's stock 
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)  ##sampleTimes is a long list (about 2500 dates like "2010-12-13")

addmargins(table(year(sampleTimes), weekdays(sampleTimes))) ##makes table of 2007-2017(rows) & WEEKDAYS(columns)
                                                                ## Why?, How? 

## the following also works
length(sampleTimes[grep("^2012",sampleTimes)])
sum(weekdays(as.Date(sampleTimes[grep("^2012",sampleTimes)]))=="Monday")

##the following is similar and works
t1<-sampleTimes[grep("^2012",sampleTimes)]
sum(weekdays(as.Date(t1))=="Monday")
length(t1)
