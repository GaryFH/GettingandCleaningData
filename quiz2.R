

###Quiz 2

##problem 1

# Find OAuth settings for github:
# http://developer.github.com/v3/oauth/
github <- oauth_endpoints("github")

# Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "f8fed260cc49d329e13a",
                   secret = "85df01178aaf40fd09a4e8a10c2064c59b59e278")

# Get OAuth credentials
github_token <- oauth2.0_token(github, myapp)

# Use the API
gtoken <- config(token = github_token)
req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
stop_for_status(req)
repo_list <- content(req)

answer1 <- c() 
for (i in 1:length(repo_list)) {
        repo <- repo_list[[i]]
        if (repo$name == "datasharing") {
                answer1 = repo
                break
        }
}
# Expected output: The repository 'datasharing' was created at 2013-11-07T13:25:07Z
if (length(answer1) == 0) {
        msg("No such repository found: 'datasharing'")
} else {
        msg("The repository 'datasharing' was created at", answer1$created_at)
}

##Above did not work - try below

##library(httr)
##oauth_endpoints("github")

## <oauth_endpoint>
##  authorize: https://github.com/login/oauth/authorize
##  access:    https://github.com/login/oauth/access_token

gitapp <- oauth_app("github", key = "f8fed260cc49d329e13a", secret = 85df01178aaf40fd09a4e8a10c2064c59b59e278")

github_token <- oauth2.0_token(oauth_endpoints("github"), gitapp)

gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)
content(req)

##neither above - both Did not work

##Problem 2

library(sqldf)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "quiz2data.csv")
                    
 acs <- read.csv("quiz2data.csv")
## above works I can read and get a acs of 14931 rows and 239 columns

sqldf("select pwgtp1 from acs where AGEP < 50")

## above gets error "Error in .local(drv, ...) :Failed to connect to database: Error: Can't connect to MySQL server on 'localhost' (0)
Error in !dbPreExists : invalid argument type"



##Problem 4

        p4url <- url("http://biostat.jhsph.edu/~jleek/contact.html")
        p4dat <- readLines(p4url)
        close(pfurl)
        c(nchar(p4dat[10]), nchar(p4dat [20]), nchar(p4dat[30]), nchar(p4dat [100]))

##answer is "[1] 45 31  7 25 "



##Problem 5

        p5url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
        p5wid <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)
        p5f <- read.fwf(p5url, p5wid, header = FALSE, skip = 4)
        sum(p5f$V8)

##Answer "[1] 32426.7"









