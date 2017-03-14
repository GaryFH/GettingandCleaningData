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
        
        url2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx "
        dest2<-file.path(getwd(),"Quiz1_2")
        download.file(url2,dest2)
        date1<-date()
        print(date1)
        ##STUFF ABOVE DID NOT WORK?  I downloaded file to my directory and started below
        
        
        xcol<-7:15
        yrow<-18:23
                ##,colIndex=xcol,rowIndex=yrow
        cc1<-read.xlsx(file="getdata_data_DATA.gov_NGAP.xlsx",sheetIndex = 1,colIndex = xcol,rowIndex = yrow,header = TRUE)
        
        sum(cc1$Zip*cc1$Ext,na.rm = T)
        
        
##   Problem 4  - how many restaurants in zipcode 21231?
        
        url3<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml" 
        
        c22 <- xmlTreeParse(url3,useInternal=TRUE)
        rootNode<-xmlRoot(c22)
        xmlName(rootNode)
        
        c1<-read.csv("Quiz1_3")
        