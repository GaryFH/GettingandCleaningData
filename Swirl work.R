# Compute four values, in the following order, from
# the grouped data:
#
# 1. count = n()
# 2. unique = n_distinct(ip_id)
# 3. countries = n_distinct(country)
# 4. avg_bytes = mean(size)
#
# A few thing to be careful of:
#
# 1. Separate arguments by commas
# 2. Make sure you have a closing parenthesis
# 3. Check your spelling!
# 4. Store the result in pack_sum (for 'package summary')
#
# You should also take a look at ?n and ?n_distinct, so
# that you really understand what is going on.

pack_sum<-summarize(by_package, count=n() ,unique=n_distinct(ip_id), countries=n_distinct(country),avg_bytes=mean(size) )


##We need to know the value of 'count' that splits the data into the top 1% and bottom 99% of packages based
##on total downloads. In statistics, this is called the 0.99, or 99%, sample quantile. Use
##quantile(pack_sum$count, probs = 0.99) to determine this number

##Now we can isolate only those packages which had more than 679 total downloads. Use filter() to select all
##rows from pack_sum for which 'count' is strictly greater (>) than 679. Store the result in a new object
##called top_counts.  "top_counts<-filter(pack_sum,count>679)" - this gives 61 rows
##There are only 61 packages in our top 1%, so we'd like to see all of them. Since dplyr only shows us the
##first 10 rows, we can use the View() function to see more.  View all 61 rows with View(top_counts)
##top_counts_sorted<-arrange(top_counts,desc(count))   ---     View(top_counts_sorted)
## Perhaps we're more interested in the number of *unique* downloads on this particular day. In other words,
## if a package is downloaded ten times in one day from the same computer, we may wish to count that as only
##one download. run "quantile(pack_sum$unique,probs=.99)" then run "top_unique<-filter(pack_sum,unique>465)"
## ##then run "top_unique<-filter(pack_sum,unique>465)" then run top_unique_sorted<-arrange(top_unique,desc(unique))


##Chaining allows you to string together multiple function calls in a way that is compact
## and readable, while still accomplishing the desired result

##Our final metric of popularity is the number of distinct countries from which each package was downloaded.
##We'll approach this one a little differently to introduce you to a method called 'chaining' (or 'piping').
##Our final metric of popularity is the number of distinct countries from which each package was downloaded.
##We'll approach this one a little differently to introduce you to a method called 'chaining' (or 'piping').


# Don't change any of the code below. Just type submit()
# when you think you understand it.

# We've already done this part, but we're repeating it
# here for clarity.

by_package <- group_by(cran, package)
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))

# Here's the new bit, but using the same approach we've
# been using this whole time.

top_countries <- filter(pack_sum, countries > 60)
result1 <- arrange(top_countries, desc(countries), avg_bytes)

# Print the results to the console.
print(result1)


##In this script, we've used a special chaining operator, %>%


# Read the code below, but don't change anything. As
# you read it, you can pronounce the %>% operator as
# the word 'then'.
#
# Type submit() when you think you understand
# everything here.

result3 <-
        cran %>%
        group_by(package) %>%
        summarize(count = n(),
                  unique = n_distinct(ip_id),
                  countries = n_distinct(country),
                  avg_bytes = mean(size)
        ) %>%
        filter(countries > 60) %>%
        arrange(desc(countries), avg_bytes)

# Print result to console
print(result3)


# select() the following columns from cran. Keep in mind
# that when you're using the chaining operator, you don't
# need to specify the name of the data tbl in your call to
# select().
#
# 1. ip_id
# 2. country
# 3. package
# 4. size
#
# The call to print() at the end of the chain is optional,
# but necessary if you want your results printed to the
# console. Note that since there are no additional arguments
# to print(), you can leave off the parentheses after
# the function name. This is a convenient feature of the %>%
# operator.

cran %>%
        select(ip_id,country,package,size) %>%
        
        print

# Use mutate() to add a column called size_mb that contains
# the size of each download in megabytes (i.e. size / 2^20).
#
# If you want your results printed to the console, add
# print to the end of your chain.

cran %>%
        select(ip_id, country, package, size) %>%
        mutate(size_mb=size/2^20)

# Use filter() to select all rows for which size_mb is
# less than or equal to (<=) 0.5.
#
# If you want your results printed to the console, add
# print to the end of your chain.

cran %>%
        select(ip_id, country, package, size) %>%
        mutate(size_mb = size / 2^20) %>%
        filter(size_mb<=0.5) %>% print


# arrange() the result by size_mb, in descending order.
#
# If you want your results printed to the console, add
# print to the end of your chain.

cran %>%
        select(ip_id, country, package, size) %>%
        mutate(size_mb = size / 2^20) %>%
        filter(size_mb <= 0.5) %>%
        arrange(desc(size_mb)) %>% print


