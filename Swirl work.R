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

# Repeat your calls to gather() and separate(), but this time
# use the %>% operator to chain the commands together without
# storing an intermediate result.
#
# If this is your first time seeing the %>% operator, check
# out ?chain, which will bring up the relevant documentation.
# You can also look at the Examples section at the bottom
# of ?gather and ?separate.
#
# The main idea is that the result to the left of %>%
# takes the place of the first argument of the function to
# the right. Therefore, you OMIT THE FIRST ARGUMENT to each
# function.
#
students2 %>%
        gather(sex_class,count,-grade) %>%
        separate(sex_class, c("sex", "class")) %>%
        print


## longway step 1 res<-gather(students2,sex_class,count,-grade)
##         step 2 separate(data=res,col=sex_class, into= c("sex","class")) 



# Repeat your calls to gather() and separate(), but this time
# use the %>% operator to chain the commands together without
# storing an intermediate result.
#
# If this is your first time seeing the %>% operator, check
# out ?chain, which will bring up the relevant documentation.
# You can also look at the Examples section at the bottom
# of ?gather and ?separate.
#
# The main idea is that the result to the left of %>%
# takes the place of the first argument of the function to
# the right. Therefore, you OMIT THE FIRST ARGUMENT to each
# function.
#
students2 %>%
        gather(sex_class,count,-grade) %>%
        separate(sex_class, c("sex", "class")) %>%
        print


# Call gather() to gather the columns class1
# through class5 into a new variable called class.
# The 'key' should be class, and the 'value'
# should be grade.
#
# tidyr makes it easy to reference multiple adjacent
# columns with class1:class5, just like with sequences
# of numbers.
#
# Since each student is only enrolled in two of
# the five possible classes, there are lots of missing
# values (i.e. NAs). Use the argument na.rm = TRUE
# to omit these values from the final result.
#
# Remember that when you're using the %>% operator,
# the value to the left of it gets inserted as the
# first argument to the function on the right.
#
# Consult ?gather and/or ?chain if you get stuck.
#
students3 %>%
        gather(class,grade,class1:class5,-name,-test, na.rm= TRUE) %>%
        print


##gather(sex_class,count,-grade)


# This script builds on the previous one by appending
# a call to spread(), which will allow us to turn the
# values of the test column, midterm and final, into
# column headers (i.e. variables).
#
# You only need to specify two arguments to spread().
# Can you figure out what they are? (Hint: You don't
# have to specify the data argument since we're using
# the %>% operator.
#
students3 %>%
        gather(class, grade, class1:class5, na.rm = TRUE) %>%
        spread(test,grade) %>%
        print

##first argument is the variable(test) whose values will become new variable names and
##the second argument(grade) variable that contains the values going to the new variables


# We want the values in the class columns to be
# 1, 2, ..., 5 and not class1, class2, ..., class5.
#
# Use the mutate() function from dplyr along with
# parse_number(). Hint: You can "overwrite" a column
# with mutate() by assigning a new value to the existing
# column instead of creating a new column.
#
# Check out ?mutate and/or ?parse_number if you need
# a refresher.
#
students3 %>%
        gather(class, grade, class1:class5, na.rm = TRUE) %>%
        spread(test, grade) %>%
        ### Call to 
        mutate(class=parse_number(class))  %>%
        print


# Complete the chained command below so that we are
# selecting the id, name, and sex column from students4
# and storing the result in student_info.
#
student_info <- students4 %>%
        select(id ,name ,sex ) %>%
        print

# Add a call to unique() below, which will remove
# duplicate rows from student_info.
#
# Like with the call to the print() function below,
# you can omit the parentheses after the function name.
# This is a nice feature of %>% that applies when
# there are no additional arguments to specify.
#
student_info <- students4 %>%
        select(id, name, sex) %>%
        unique %>%
        print

# select() the id, class, midterm, and final columns
# (in that order) and store the result in gradebook.
#
gradebook <- students4 %>%
        select(id,class,midterm,final) %>%
        print


# Accomplish the following three goals:
#
# 1. select() all columns that do NOT contain the word "total",
# since if we have the male and female data, we can always
# recreate the total count in a separate column, if we want it.
# Hint: Use the contains() function, which you'll
# find detailed in 'Special functions' section of ?select.
#
# 2. gather() all columns EXCEPT score_range, using
# key = part_sex and value = count.
#
# 3. separate() part_sex into two separate variables (columns),
# called "part" and "sex", respectively. You may need to check
# the 'Examples' section of ?separate to remember how the 'into'
# argument should be phrased.
#
sat %>%  select(-contains("total")) %>%
        gather(part_sex,count, -score_range) %>%
        separate(part_sex,c("part","sex")) %>%
        print
# Append two more function calls to accomplish the following:
#
# 1. Use group_by() (from dplyr) to group the data by part and
# sex, in that order.
#
# 2. Use mutate to add two new columns, whose values will be
# automatically computed group-by-group:
#
#   * total = sum(count)
#   * prop = count / total
#
sat %>%
        select(-contains("total")) %>%
        gather(part_sex, count, -score_range) %>%
        separate(part_sex, c("part", "sex")) %>% 
        group_by(part,sex) %>%  mutate(total=sum(count),prop=count/total) %>% print







