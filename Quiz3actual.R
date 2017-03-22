
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
##which gives to the row number or position as follows

##second try
q1<-select(df1,c(ACR,AGS))
q1c<-which(q1$ACR==3 & q1$AGS==6)
head(q1c,3) ## returns  [1]  125  238  262




##Question 2

dwnld1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
q2 <- file.path(getwd(), "jeff.jpg")
download.file(dwnld1, q2, mode = "wb")
img <- readJPEG(q2, native = TRUE)
quantile(img, probs = c(0.3, 0.8))



##Question 3
##Google search answer
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

##1st try

df3<-read.csv("GDP.csv" )
q3a<-tbl_df(df3)

df3b<-read.csv("EDSTATS_Country.csv" )
q3b<-tbl_df(df3b)

q33m<-merge(q3a,q3b,all = T,by=c("CountryCode"))



##second try
c11<-read.csv("GDP.csv")
c12<-read.csv("EDSTATS_Country.csv")
q11<-tbl_df(c11)
q12<-tbl_df(c12)

##make country code variable name the same (q11 named "X" and q12 named "CountryCode")
q11b<-mutate(q11,CountryCode=X)
q11c<-mutate(q11b,-X)
##Merge
m1<-merge(q11c,q12,by="CountryCode")
##make tbl_df
qm1<-tbl_df(m1)

##Figure out how many unique rows (with a factor)

t<-select(qm1,Gross.domestic.product.2012)
##View(t)

  ta<-select(t,Gross.domestic.product.2012)
 ##View(ta)
 select(unique(ta))   # A tibble: 189 × 0
 
tt<-select(qm1,Gross.domestic.product.2012,X.2)
ttt<-arrange(tt,desc(Gross.domestic.product.2012))
View(ttt)  ##find number 178 (13th lowest) St. Kitts and Nevis

##3rd Try!

c11<-read.csv("GDP.csv", stringsAsFactors = FALSE)
c12<-read.csv("EDSTATS_Country.csv", stringsAsFactors = FALSE)
q11<-tbl_df(c11)
q12<-tbl_df(c12)
q111<-filter(q11,X!="")
q1111<-select(q111, CountryCode=X, GDPranking=Gross.domestic.product.2012, Longname=X.2, GDP=X.3)
q15<-filter(q1111,GDPranking!="")


m1<-merge(q15,q12,by="CountryCode")
m2<-tbl_df(m1)
m3<-select(m2,-Longname,-(Latest.household.survey:Short.Name))
nrow(m3)  ##189 - right answer

m3b<-select(m3,-(Region:Latest.population.census))
m3b$GDPranking<-as.integer(m3b$GDPranking)
m4<-arrange(m3b,desc(GDPranking))
m4[13,]

## IN try 3 I couldn't get order right - the return shows1,10,100,101... 
                ## I tried changing to numeric and integer but data changed in value?
## - I got 2nd answer by 190-12=188 (the 13th lowest - think about it - since 1st is 190 the 2nd is 189) )

##fourth Try - changed above in read.csv to  stringsAsFactors = FALSE - then changed chr into integers
##everything above worked




##Question 4
##Google search answer
dt[, mean(rankingGDP, na.rm = TRUE), by = Income.Group]



##Third try - m4 from problem 3  looks good

m5<-arrange(m4,Income.Group)
mhoecd<-filter(m5,Income.Group=="High income: OECD")
mhnonoecd<-filter(m5,Income.Group=="High income: nonOECD")
a4a<-summarise(mhoecd,avg=mean(GDPranking))  ##OECD - 32.96667

a4b<-summarise(mhnonoecd,avg=mean(GDPranking))  ##nonOECD - 91.91304




##second try - not perfect
c11<-read.csv("GDP.csv")
c12<-read.csv("EDSTATS_Country.csv")
q11<-tbl_df(c11)
q12<-tbl_df(c12)

##make country code variable name the same (q11 named "X" and q12 named "CountryCode")
q11b<-mutate(q11,CountryCode=X)
q11c<-mutate(q11b,-X)
##Merge (trying a different order for merge - it makes a difference)
##m1<-merge(q11c,q12,by="CountryCode")
m1<-merge(q12,q11c,by="CountryCode")
##make tbl_df

qm1<-tbl_df(m1)
qm2<-select(qm1,Income.Group, Gross.domestic.product.2012)
qm3<-arrange(qm2,Income.Group)
##View(qm3) - remove empty "Income.Group" rows
qm4<-qm3[15:224,]


qm5<-arrange(qm4,Gross.domestic.product.2012)

##View(qm5) - remove empty "Gross.domestic.product.2012" rows
qm6<-qm5[22:nrow(qm5),]


qm6$Gross.domestic.product.2012<-as.integer (qm6$Gross.domestic.product.2012)
qm7<-filter(qm6,Income.Group=="High income: OECD")

summarize(qm7,mean(Gross.domestic.product.2012)) ##= 110.0667 which is reportedly wrong

qm8<-filter(qm6,Income.Group=="High income: nonOECD")

summarize(qm8,mean(Gross.domestic.product.2012))  ##= 93.73913 which is reportedly wrong




##Question 5

##Google search answer
breaks <- quantile(dt$rankingGDP, probs = seq(0, 1, 0.2), na.rm = TRUE)
dt$quantileGDP <- cut(dt$rankingGDP, breaks = breaks)
dt[Income.Group == "Lower middle income", .N, by = c("Income.Group", "quantileGDP")]


##second try - following comments from Swirl homework problem and google searches
##We need to know the value of 'count' that splits the data into the top 1% and bottom 99% of packages based
##on total downloads. In statistics, this is called the 0.99, or 99%, sample quantile. Use
##quantile(pack_sum$count, probs = 0.99) to determine this number.

##       quantile(pack_sum$count,probs=0.99)

##qm6$Gross.domestic.product.2012<-as.numeric (qm6$Gross.domestic.product.2012)
##groups<-cut(qm6$Gross.domestic.product.2012,breaks = 5)

## makes nice table but answer is still wrong?
##table(qm6$Income.Group,groups)

groups<-cut(m5$GDPranking,breaks = 5)
table_groups<-table(m5$Income.Group,groups)  ##this is right  m5 from last try question 4
                                        ## this also works - table(groups,m5$Income.Group)
