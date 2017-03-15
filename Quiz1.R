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
library(RMySQL)        
ucscDb<-dbConnect(MySQL(),user="genome", host="genome-mysql.cse.ucsc.edu")
result<-dbGetQuery(ucscDb,"show databases;");dbDisconnect(ucscDb);
        