##Quiz Problem 1 Getting and Cleaning Data

Get 
        url1<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv" 
        dest<-file.path(getwd(),"Quiz1_1")
        download.file(url1,dest)
        c1<-read.csv("Quiz1_1")

## find values greater than 1,000,000 (hint read pdf)
        c2<-c1$VAL[c1$VAL==24&!is.na(c1$VAL)]
        length(c2)
        
        
        
        
        
##   Problem 3 - read rows 18:23 and columns 7:15
        
        url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx "
        dest2 <- file.path(getwd(),"data2")
        download.file(url2,dest2)
        ##date1<-date()
        ##print(date1)
        
        ##STUFF ABOVE DID NOT WORK????
        
        ##I downloaded file to my directory direct from the link and started below
        
        ##xcol <- 7:15
        ##yrow <- 18:23
        ##,colIndex=xcol,rowIndex=yrow
        
        goodfile<- read.xlsx("getdata_data_DATA.gov_NGAP.xlsx", sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15,header = TRUE)
        
        sum(goodfile$Zip*goodfile$Ext,na.rm = T)
        
        
        
##   Problem 4  - how many restaurants in zipcode 21231?
        
        url3<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml" 
        
        c23 <- xmlTreeParse("url3", useInternal=TRUE)
        rootnode <- xmlRoot(c23)
        sum(xpathSApply(rootnode,"//zipcode",xmlValue) == 21231)
        
        ##ABOVE DOES NOT WORK????   BUT BELOW DOES WORK (TAKES A FEW SECONDS)
        
        c22 <-  xmlTreeParse("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml",useInternal = TRUE)
        rootnode <- xmlRoot(c22)
        sum(xpathSApply(rootnode,"//zipcode",xmlValue) == 21231)
        
        
##      Problem 5 - data.table problem
        
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",getwd())
        print(date())
        
        ##AGAIN - I COULDN'T DOWNLOAD ABOVE - I SAVED THE FILE DIRECTLY TO MY WD THROUGH WINDOWS
        
        DT = fread("getdata_data_ss06pid.csv")
        system.time(tapply(DT$pwgtp15,DT$SEX,mean))
        ##  0  0  0
        
        system.time(mean(DT[DT$SEX==1,]$pwgtp15), mean(DT[DT$SEX==2,]$pwgtp15))
        ##  .01  0.0  0.01
        
     
        
        system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
        #  0  0  0.7
        
        system.time(DT[,mean(pwgtp15),by=SEX])
        ##.02 .00  .05
        
        
        system.time(mean(DT$pwgtp15,by=DT$SEX))
        
          ##   0  0  0
        
        ## This one didn't run - system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])
        
        
##Connecting and Listing Databases - week2 reading MySQL - ##HINT - LOAD RMYSQL FIRST        

##This is a query of what databases are in this online database        
library(RMySQL)        
ucscDb<-dbConnect(MySQL(),user="genome", host="genome-mysql.cse.ucsc.edu")
result<-dbGetQuery(ucscDb,"show databases;");dbDisconnect(ucscDb);

##This is looking at one of the genome databases called "hg19"
hg19<-dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")
allTables<-dbListTables(hg19)

length(allTables)  ##(11048-big list of tables)
                ##dbDisconnect(hg19)

##This looks at one of the tables in "hg19"
dbListFields(hg19,"affyU133Plus2")  ##These are columm names of table - note that return shows 22 columns

##This gets count of the above specific table
dbGetQuery(hg19,"select count(*)from affyU133Plus2")  ##this finds the number of row (58463)
                                                        ##- these rows can be called records

## This gets/downloads a specific table - note that the table is large (58463 by 22)
affydata<-dbReadTable(hg19,"affyU133Plus2")

##Since table can be very large - sometimes only a subset of a table is wanted
## you do this as follows

query<-dbSendQuery(hg19,"select*from affyU133Plus2 where misMatches between 1 and 3")
##Note that "misMatches is a "variable or column name"
##Note that query is stored at the online db

##below retrieves query to R's environment (only the quantiles)
affyMis<-fetch(query);quantile(affyMis$misMatches)

##This fetches only a small part of the query (10rows) - 
##NOTE that to remove the query from the online server you need to run "dbClearResult(query)"
affyMisSmall<-fetch(query,n=10);dbClearResult(query);

##How to install RHDF5 package - 
##source("http://bioconductor.org/biocLite.R")
##biocLite("rhdf5")
##library(rhdf5)
##  This creats a sample for learning - 
created=h5createFile("example.h5")
created=h5createGroup("example.h5","foo")
created=h5createGroup("example.h5","baa")
created=h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5")
##now fill the groups created
A=matrix(1:10,5,2)
h5write(A,"example.h5","foo/A")
B=array(seq(.1,2,by=.01),dim = c(5,2,2))
attr(B,"scale")<-"liter"
h5write(B,"example.h5","foo/foobaa/B")
h5ls("example.h5")
##can do lots of other stuff



##webscraping - below is contecting to a page and reading lines

con = url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode=readLines(con) ##this will give warnings - I think this is OK
close(con)
htmlCode

library(XML)

url<-"https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html<- htmlTreeParse(url, useInternalNodes=T)

xpathSApply (html,"//title",xmlValue) ##doesn't work


xpathSApply (html,"//td[@id='col-citedby']",xmlValue) ##doesn't work

##this is an alternative way to webscrape - this way worked for me
library(httr)
html2=GET(url)
content2=content(html2,as="text")
parsedHtml=htmlParse(content2,asText = TRUE)
xpathSApply(parsedHtml,"//title",xmlValue)






        