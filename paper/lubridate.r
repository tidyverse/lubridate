# R code to accompany
# Date and Times Made Easy with lubridate
# by Garrett Grolemund and Hadley Wickham

# 1. Introduction
# _______________________________________________________________
# no code, but please load the lubridate package
# install.packages("lubridate")
# library(lubridate)


# 2. Motivation
# _______________________________________________________________
# base R examples
date <- as.POSIXct("01-01-2010", format = "%d-%m-%Y", tz = "UTC")
as.numeric(format(date, "%m"))
as.POSIXlt(date)$month + 1
date <- as.POSIXct(format(date, "%Y-2-%d"), tz = "UTC")
date <- seq(date, length = 2, by = "-1 day")[2]
as.POSIXct(format(as.POSIXct(date), tz = "UTC"), tz = "GMT")

# lubridate examples
date <- dmy("01-01-2010")
month(date)
month(date) <- 2
date <- date - days(1)
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
as.Date(format(date, "2000-%m-%d"))
  date <- as.POSIXct(date)
as.POSIXct(format(date, "2000-%m-%d"))

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
as.Date(as.character(z), format = "%d%m%Y")
as.POSIXct(as.character(z), tz = "UTC", format = "%d%m%Y")

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
# _______________________________________________________________
mdy("12-01-2010")
dmy("12-01-2010")
dmy(c("31.12.2010", "01.01.2011"))


# 4. Manipulating date-times
# _______________________________________________________________
date <- now() # will show as your system time
year(date)
minute(date)
month(date)
month(date, label = TRUE)
month(date, label = TRUE, abbr = FALSE)
wday(date, label = TRUE, abbr = FALSE)

day(date) <- 5
dates <- ymd_hms("2010-01-01 01:00:00", "2010-01-01 01:30:00")
minute(dates) <- mean(minute(dates))
day(date) <- 30
day(date) <- 1
month(date) <- month(date) + 1
day(date) <- day(date) - 1
update(date, year = 2010, month = 1, day = 1)
hour(date) <- 12

date + hours(3)


# 5. Math with date-times
# ________________________________________________________________

# 5.1 Instants
start_2012 <- ymd_hms("2012-01-01 12:00:00")
is.instant(364)
is.instant(start_2012)
round_date(start_2012, "day")
now()
today()

# 5.2 Intervals
start_2011 <- ymd_hms("2011-01-01 12:00:00")
start_2010 <- ymd_hms("2010-01-01 12:00:00")
span <- start_2011 - start_2010
start_2010 + span

# 5.3 Durations
eminutes(1)
eseconds(60)
eminutes(2)
c(1:3) * ehours(1)
start_2011 + eyears(1)
start_2012 + eyears(1)
eweeks(1) + edays(6) + ehours(2) + eminutes(1.5) + eseconds(3)
as.duration(span)

# 5.4 Periods
months(3)
months(3) + days(2)
start_2012 + years(1)
start_2012 + eyears(1)
as.period(span)



# 6. Time zones
# _______________________________________________________________
date
with_tz(date, "UTC")

date
force_tz(date, "UTC")


# 7. Daylight savings time
# _______________________________________________________________
dst_time <- ymd_hms("2010-03-14 01:59:59")
dst_time <- force_tz(dst_time, "America/Chicago") # Note: Time 
# zone names are operating system dependent and are not standard 
# across all operating systems. See ?timezone for details.

dst_time + eseconds(1)
dst_time + hours(2)
dst_time + ehours(2)


# 8. Case study 1
# _______________________________________________________________
# 8.1 Thanksgiving
date <- ymd("2010-01-01")
month(date) <- 11
wday(date, label = T, abbr = F)
date <- date + days(3)
wday(date, label = T, abbr = F)
date + weeks(3)

# 8.2 Memorial Day
date <- ymd("2010-01-01")
date <- date + months(5) - days(1)
wday(date, label = T, abbr = F)


# 9. Case study 2
# _______________________________________________________________
str(lakers$date)
lakers$date <- ymd(lakers$date)
str(lakers$date)

# to use qplot we must first install and load the ggplot2 package
# install.packages("ggplot2")
library(ggplot2)
qplot(date, 0, data = lakers, colour = game_type)

qplot(wday(date, label = T), data = lakers, geom = "histogram")

lakers$time <- ms(lakers$time)
lakers$time <- as.duration(lakers$time)
lakers$time <- eminutes(12) * lakers$period - lakers$time
lakers <- subset(lakers, period != 5)



qplot(as.integer(time), data = lakers, geom = "histogram", 
	binwidth = 60)
lakers$demo <- ymd("2008-01-01") + lakers$time
qplot(demo, data = lakers, geom = "histogram", binwidth = 60)

game1 <- lakers[lakers$date == ymd("20081028"),]
attempts <- game1[game1$etype == "shot",]
attempts$wait <- c(attempts$time[1], diff(attempts$time))
qplot(as.integer(wait), data = attempts, geom = "histogram", 
	binwidth = 2)
game1_scores <- ddply(game1, "team", transform, score = 
	cumsum(points))
game1_scores <- game1_scores[game1_scores$team != "OFF",]
qplot(demo, score, data = game1_scores, geom = 
	"line", colour = team)
