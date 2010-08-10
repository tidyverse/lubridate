# R code to accompany
# Date and Times Made Easy with lubridate
# by Garrett Grolemund and Hadley Wickham

# 1. Introduction
# _______________________________________________________________
# no code, but please load the lubridate package
library(lubridate)


# 2. Motivation
# _______________________________________________________________
# base R examples
date <- as.POSIXct("01-01-2010", format = "%d-%m-%Y", tz = "UTC")
as.numeric(format(date, "%m"))
as.POSIXlt(date)$month + 1
date <- as.POSIXct(format(date, "%Y-2-%d"))

# lubridate examples
date <- dmy("01-01-2010")
month(date)
month(date) <- 2

# additional base R examples
seq(date, length = 2, by = "-1 day")[2]
as.POSIXct(format(as.POSIXct(date). tz = "UTC"), tz = "GMT")

# additional lubridate examples
date - days(1)
with_tz(date, "GMT")

# Table 1 
# (Primarily for reference and comparison. Please see remainder 
# of paper for explanations)
# now (system time zone)
now()
Sys.time()

# today (system time zone)
today()
Sys.Date()

# origin
origin
structure(0, class = "Date")
structure(0, class = c("POSIXt", "POSIXct"))

# x days since origin
  x <- 3
origin + days(x)
structure(floor(x), class = "Date")
structure(x*24*60*60, class = c("POSIXt", "POSIXct"))

# next day
date + days(1)
  date <- as.Date(date)
date + 1
  date <- as.POSIXct(date)
seq(date, length = 2, by = "day")[2]

# previous day
date - days(1)
  date <- as.Date(date)
date - 1
  date <- as.POSIXct(date)
seq(date, length = 2, by = "-1 day")[2]

# x days since date (day exactly 24 hours)
date + edays(1)
seq(date, length = 2, by = paste(x, "day"))[2]

# x days (allowing for DST) 
# i.e, calculated by clock time
date + days(x)
  date <- as.Date(date)
date + floor(x)
  date <- as.POSIXct(date)
seq(date, length = 2, by = paste(x, "DSTday"))[2]

# display date in new time zone (TZ = GMT)
with_tz(date, "GMT")
as.POSIXct(format(as.POSIXct(date), tz = "GMT"), tz = "GMT")

# keep clock time, replace time zone
force_tz(date, tz = "GMT")

# sequence
date + c(0:9) * days(1)
  date <- as.Date(date)
seq(date, length = 10, by = "day")
  date <- as.POSIXct(date)
seq(date, length = 10, by = "DSTday")

# every second week
date + c(0:2) * weeks(2)
  date <- as.Date(date)
seq(date, length = 3, by = "2 week")
  date <- as.POSIXct(date)
seq(date, length = 3, by = "2 week")

# first day of month
floor_date(date, "month")
  date <- as.Date(date)
as.Date(format(date, "%Y-%m-01"))
  date <- as.POSIXct(date)
as.POSIXct(format(date, "%Y-%m-01"))

# round to nearest first of month
round_date(date, "month")

# extract year value
year(date)
  date <- as.Date(date)
as.numeric(format(date, "%Y"))
  date <- as.POSIXct(date)
as.numeric(format(date, "%Y"))

# change year value
z <- 2000
year(date) <- z
  date <- as.Date(date)
as.Date(format(date, "z-%m-%d"))
  date <- as.POSIXct(date)
as.POSIXct(format(date, "z-%m-%d"))

# day of week
wday(date) # Sun = 1
  date <- as.Date(date)
as.numeric(format(date, "%w")) # Sun = 0
  date <- as.POSIXct(date)
as.numeric(format(date, "%w")) # Sun = 0

# day of year
yday(date)
  date <- as.Date(date)
as.numeric(format(date, "%j")) 
  date <- as.POSIXct(date)
as.numeric(format(date, "%j"))

# express as decimal of year
decimal_date(date)

# Parse z = "1970-10-15"
  z <- "1970-10-15"
ymd(z)
as.Date(z)
as.POSIXct(z)

# Parse z = "10/15/1970"
  z <- "10/15/1970"
mdy(z)
as.Date(z, "%m/%d/%Y")
as.POSIXct(strptime(z, "%m/%d/%Y"))

# Parse z = 15101970
  z <- 15101970
dmy(z)
as.Date(as.character(z), format = "%d/%m/%Y")
as.POSIXct(as.character(z), tz = "UTC", format = "%d/%m/%Y")

# 1 second
seconds(1)
as.difftime(1, unit = "secs")

#5 days, 3 hours and - 1 minute
new_duration(day = 5, hour = 3, minute = -1)
as.difftime(60*24*5 + 60*3 - 1, unit = "mins")

# 1 month
months(1)

# 1 year
years(1)





# 3. Parsing date-times
# ______________________
mdy("12-01


