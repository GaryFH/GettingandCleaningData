##Quiz Problem 1 Getting and Cleaning Data

Get data
        url1<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv" 
        dest<-file.path(getwd(),"Quiz1_1")
        download.file(url1,dest)
        c1<-read.csv("Quiz1_1")

## find values greater than 1,000,000 (hint read pdf)
        c2<-c1$VAL[c1$VAL==24&!is.na(c1$VAL)]
        length(c2)
        
##   Problem 3 - read rows 18:23 and columns 7:15
        
        url2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
        dest2<-file.path(getwd(),"Quiz1_2")
        download.file(url2,dest2)
        xcol<-7:15
        yrow<-18:23
        cc1<-read.xlsx("Quiz1_2",colIndex=xcol,rowIndex=yrow)
        
        
        
        