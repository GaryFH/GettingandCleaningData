
##WEEK 3 

##work - Subsetting 
##lecture example - review subsetting

set.seed(150)

x<-data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
x<-x[sample(1:5),]
x$var2[c(1,3)]=NA
x

x[,1] ##opens first column

x[,"var1"] ##same as above

x[1:2,"var2"]## first two rows of 2nd column

x[(x$var1<=3 & x$var3>11),]  ##subset by logical expression - A


x[(x$var1<=3 | x$var3>14),] 

x[which(x$var2>8),]   ##note doesn't return NA's
x[(x$var2>8)& !is.na(x$var2),]  ##this does work(is the same as which statement)
                                ##   x[x$var2>,] doesn't work due to NA's 

sort(x$var1)   ##[1] 1 2 3 4 5
sort(-x$var1)  ##[1] -5 -4 -3 -2 -1
sort(x$var1,decreasing=T) ##[1] 5 4 3 2 1
sort(x$var2,na.last = T )   ##7  8  9 NA NA
sort(x$var2,na.last = T,decreasing = T )  ##[1]  9  8  7 NA NA
sort(x$var2,na.last = F,decreasing = T )  ##[1] NA NA  9  8  7

x[order(x$var1),]  ##this gives increasing order    
x[order(-x$var1),] ##this gives reverse/decreasing order

x[order(x$var1,x$var3),] ##only sorts var3 if there are multiple var1 values that indentical


library(plyr)
arrange(x,var1)  ##same as  x[order(x$var1),]
arrange(x,desc(var1))##desc means descending - it appears that so does "arrange(x,-var1)"


##   #####THIS IS IMPORTANT FEATURE TO ADD A ROW TO A DATAFRAME#######
x$var4<-rnorm(5)  ##this puts whatever you have at right (in this case "rnorm(5)") 
                ##into dataframe and a new variable "var4" - this is useful for things
                ## such as x$var4<- ((x$var3^2+x$var2^2)^.5)-3
                ##CAREFUL - THIS CHANGES "X" to a new dataframe
Y<-cbind(x,rnorm(5))  ##  this also adds a column/variable but assigns
                        ## it to a new variable instead of changing x


##Summarizing data


if(!file.exist("./data")){dir.create("./data")}   ##This insures data exists?
fileUrl<-"https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
dest22 <- file.path(getwd(),"databalt")
download.file(fileUrl,dest22,method = "curl")
restData<-read.csv("databalt")
##the above worked OK
##you can look at "restData with head, summary(includes frequency),str,quantile
##you can make tables out of variables (gives frequency info) i.e. tb1<-table(restData$zipCode,useNA="ifany")


tb1<-table(restData$zipCode) ##table adds frequency to zip codes
df1<-as.data.frame(tb1)     ##dataframe makes frequecy the second variable
ordofzipfreq<-df1[order(-df1[2]),]  ##this orders "large to small" freqency of zip codes
                         ##this is in a data frame and can be combined with other dataframes

##tb1<-table(restData$zipCode,useNA="ifany")  the useNA="ifany" will add a na collum with frequency

##BELOW IS A TWO DIMENSION(VARIABLE) TABLE
tb2<-table(restData$councilDistrict,restData$zipCode)  
##This gives number of restaurant in for each district(rows) in a zipcode(columns) 
##(looks like matrix)

tb3<-table(restData$zipCode, restData$councilDistrict)
##same info but rows and columns reversed


sum(is.na(restData$councilDistrict))  ##na's are zero therefore sum is number of na's
any(is.na(restData$councilDistrict))  ## logical expression (returns T or F)
all(is.na(restData$council>0))  ## also returns (T or F)

colSums(is.na(restData))##returns sum of all NA's in every column(variable)

all(colSums(is.na(restData))==0) ##tells you TRUE(no missing values in entire dataset)
                                ## or FALSE (some columns have NA's)

table(restData$zipCode=="21212")
table(restData$zipCode %in% c("21212","21213","21214")) ##this asks if any values of leftside 
##are the same value as on the right side (like == but good for multiple values)-returns TorF

gg<-restData[restData$zipCode %in% c("21212","21213","21214"),]##gg is subset of  
##restData with the above four zipcodes (again if only one zip then == would also work)

data(UCBAdmissions)  ##data() originally intended for datasets included in 
        ## "R" for use as examples - it brings the inbedded data set into your environment
DF=as.data.frame(UCBAdmissions)
summary(DF)

##Cross tabs
xt<-xtabs(Freq~Gender + Admit,data=DF)##Freq,Gender&Admit or variable in DF
##freq is the data used in table, gender is rows (2 rows - M or F)
##Admit is columns (2 columns "admitted or rejected" this adds up all the freq for each case
                ##top row-    Gender   Admitted Rejected   
                ##middlerow-   Male       1198     1493
                ##bottom row-  Female      557     1278


##Flat tables
warpbreaks$replicate<-rep(1:9,len=54)  
##this added a 4th column named "replicate" to warpbreaks

xt1=xtabs(breaks~.,data=warpbreaks)  ##this put info from breaks variable as the values
        ##in the table with wool type as rows and tension as colums (2 by 2 table of data)
        ##and does it for each unique value of replicate for a total of 9(not 54) - 2x2 tables
        ##  NOTE that ".,data" refers to all the other variables (other than "breaks")
        ##  Since there are three other variable and tables only use two variables
        ##  the last variable "replicates" causes the data to be split into 9 separate 
        ##  tables associated with the 9 unique values of replicate
        ##  Since this can be confusing - ftable() puts all 3 variables into a 
        ## table with two different row headings (wool type and tension) and
        ## the nine values of replicate as the column header - SEE BELOW

##COMPARE THE FOLLOWING - SEE COMMENTS ABOVE
ftable(xt1)
##vrs
xt1


object.size()            ##give size in bytes
object.size(x,units="Mb")## gives size in megabytes


##CREATING NEW VARIABLES - REASONS INCLUDE:
        ##adding missing indicators?
        ##"Cutting up" quantitative variables in factors (or bins/ranges) (ex. pH from 7-7.99, 8-8.99...)
        ##Applying transforms?


##Back to baltimore data set above
##creating sequences examples as follows
s1<- seq(1,10,by=2)

s2<-seq(1,10,length=3)

x<-c(1,3,8,25,100)
seq(along=x) ##makes vector 1,2,3...length(x) - useful in looping and indexing?


## Note "nearMe" is being created below
restData$nearMe=restData$neighborhood %in% c("Roland Park","Homeland")
##creats var "nearMe from the above two values of "neighborhood"  Note that with "=" nearMe is
##a logical variable(T or F) and if a "<-" is used nearMe's value is the neighborhood name 
table(restData$nearMe) # sums up False and True for everyvalue in the entire dataset that are
                ##within the desired area:    FALSE  TRUE 
                                ##            1314    13


##Creating binary variables
restData$zipWrong=ifelse(restData$zipCode<0,TRUE,FALSE) ##(vector 1,327 T's/F's - "ugly")
table(restData$zipWrong,restData$zipCode<0)##table will sum up T's & F's
##      FALSE  TRUE 
##      1314    13


## For easy cutting use Hmisc package

library(Hmisc)
restData$zipGroups = cut2(restData$zipCode,g=4)
table(restData$zipGroups)  ##easier to read a table

##Change a variables class for easier handling - 
##example below changes zipcodes from int to factor (numeric to charactor can be useful)
##restData$zcf<-factor(restData$zipCode) - this makes new variable as factors
##restData$zcf[1:10]  this returns first 10 values



##RESHAPE DATA (goal is "tidy data" - 1) One variable per column.  
        ##    2) One variable per row.  3) One type of observation per table/file.

library(reshape2)
##head(mtcars)
##              Melting Data frames - reshapes
mtcars$carname<-rownames(mtcars) ## this adds a column  (now 12 not 11)
              ## - and gives it a name and the values are the old rownames
              ##note that rownames were not a variable and should have been to be tidy
                ## I don't know why the old row names became the values under "carname"???

carmelt<-melt(mtcars,id=c("carname","gear","cyl"),measure.vars = c("mpg","hp"))
##above creats id variables and measure variables,  "id" variables become the only variables kept
##in the melted df and the "measure" variables become row data under a new, catch all, varible 
## called "variable"  and all the data that was under mpg & hp is now under a new variable 
##called "value" it appears that the other variable disappear. 

head(carmelt)  #shows make up of new data frame


##Casting data frames (into new shapes)

cylData<-dcast(carmelt,cyl~variable)  ##returns cyl variable on left with the 
## different types of variables as columns for a total of 3 columns
## the cyl column as all three types of cyl and the other columns so the total 
## number of mpg or hp values/observtions (for a nice 3 x 3 table)


cylData<-dcast(carmelt,cyl~variable,mean)   ## like above but instead of values in columns
## being the number of values it gives a average of the respective values.


##AVERAGEING VALUES

head(InsectSprays) ##2 columns: 1) count of insects,  2) type of spray (several types"A thru F")

tapply(InsectSprays$count,InsectSprays$spray,sum)  ##sums all the counts for each spray type
##ABOVE IS VERY CLEVER

spIns = split(InsectSprays$count,InsectSprays$spray)
spIns   ##returns what looks like a list(row) of all counts for each type of spray 
## next lapply the sum of all the lists in spIns
spIns2<-lapply(spIns,sum)
spIns2

df1<-as.data.frame(spIns)
sapply(df1,sum) ##this does the same as above two methods

sapply(spIns,sum)##this works directly on spIns as a "list"


##another way is with plyr package
ddply(InsectSprays,.(spray),summarize,sum=sum(count))   #did not work-this seems overly hard?  Why?




##              dplyr stuff - ABOUT WORKING WITH DATA FRAMES MORE EFFICENTLY/FAST

##assumes tidy data (1 observation/row,  1 variable/column, etc)
## find out about your df - remember "names(df)-gives you variable names


##chicago<-readRDS("chicago.rds") - used as a example but didn't tell how to download



##      dplyr SELECT FUNCTION
## is one of dplyr's good applications/verb - JUST USE NAMES - NO "" 
##head(select(df,name1:name5)) or head(select(df,name1)) or 
##head(select(df,c(name1, name3,name5))
##head(select(df,-(name1:name5)) - GIVES YOU ALL COLUMNS EXCEPT THOSE NAMED


##      dplyr FILTER FUNCTION
##df1<-filter(chicago, name1>30)   returns only rows with name1>30
##df2<-filter(chicago, name1>30&name2<80) can subset rows based on more than one column values



##      dplyr ARRANGE FUNCTION  reorders the rows based on the values of a column
## dfa<-arrange(df,name1)        reorders df from low to high for values in name1
## dfa<-arrange(df,desc(name1)   reorders df from high to low for values in name1


##      dplyr RENAME FUNCTION renames variables easily
## dfa<-rename(df,newname=oldname, newname2=oldname2) keep going and rename all columns if you want


##      dplyr MUTATE FUNCTION   transforms exising variable or creats new variables
## dfa<-mutate(df,newvariable=existing variable-mean(exvar,na.rm=T))  
                 ## creates a new variable in this case using mean of another variable



##      dplyr GROUP_BY FUNCTION  allows you to split a df
## dfdd<-mutate(df,newname=factor(1*(name1>80),labels=c("cold","hot)))
                        ##if name1>80 newname's value is "hot" otherwise it's "cold"
##dfnewdataframe<-group_by(df,newname)
        ##above makes Group - newname and returns df based on newname being hot or cold
##summarize(dfdd, name1=mean(name1,na.rm=T), createnewname=max(name2))
     ##this returns two columns(as named above) with only 2 rows of values labeled(hot & cold)


##dplyr allows you to combine steps with "%>%"
##example: df %>% mutate(something) %>% group_by(something) %>% summarize(something)

##dplyr plays well with data.table and SQL interface for relational databases via DBI package


        ## MERGING DATA
##note that dplyr has "join"  faster but less flexible

##arrange(join(df1,df2,common_ID)) - returns left col(common_ID),df1 columns,df2 columns


##merging multiple dataframes with dplyr
##dfList=list(df1,df2,df3,etc) (this assumes some common variable names)
##join_all(dflist)

## Swirl HOW TO LOAD NEW STUFF - install_course("Getting and Cleaning Data")



