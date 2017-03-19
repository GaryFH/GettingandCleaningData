
##Get DATA
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "quiz3data.csv")

##Read data
c1<-read.csv("quiz3data.csv" )

##Change to data table for dpylr - Library(dplyr)
df1<-tbl_df(c1)

##select requested variables for question 1
q1<-select(df1,c(ACR,AGS))
q1b<-filter(q1,ACR==3 & AGS==6)
##The above tells you how many and is good but the 
##value (I'm guessing row number in orignial dataframe')is not there -  SO WHO CARES?



dt <- data.table(read.csv("quiz3data.csv"))
agricultureLogical <- dt$ACR == 3 & dt$AGS == 6
which(agricultureLogical)[1:3]


##Question 2

dwnld1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
q2 <- file.path(getwd(), "jeff.jpg")
download.file(dwnld1, q2, mode = "wb")
img <- readJPEG(q2, native = TRUE)
quantile(img, probs = c(0.3, 0.8))



##Question 3

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
f <- file.path(getwd(), "GDP.csv")
download.file(url, f)
dtGDP <- data.table(read.csv(f, skip = 4, nrows = 215))
dtGDP <- dtGDP[X != ""]
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", 
                                               "Long.Name", "gdp"))
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
f <- file.path(getwd(), "EDSTATS_Country.csv")
download.file(url, f)
dtEd <- data.table(read.csv(f))
dt <- merge(dtGDP, dtEd, all = TRUE, by = c("CountryCode"))
sum(!is.na(unique(dt$rankingGDP)))

dt[order(rankingGDP, decreasing = TRUE), list(CountryCode, Long.Name.x, Long.Name.y, 
                                              rankingGDP, gdp)][13]


df3<-read.csv("GDP.csv" )
q3a<-tbl_df(df3)

df3b<-read.csv("EDSTATS_Country.csv" )
q3b<-tbl_df(df3b)

q33m<-merge(q3a,q3b,all = T,by=c("CountryCode"))


##Question 4

dt[, mean(rankingGDP, na.rm = TRUE), by = Income.Group]


##Question 5

breaks <- quantile(dt$rankingGDP, probs = seq(0, 1, 0.2), na.rm = TRUE)
dt$quantileGDP <- cut(dt$rankingGDP, breaks = breaks)
dt[Income.Group == "Lower middle income", .N, by = c("Income.Group", "quantileGDP")]



