# Example code to accompany JSS paper "Dates
# and Times made Easy with lubridate"

# Run below code to get started
# install.packages("lubridate")
library(lubridate)

# Section 2. Motivation
# base R methods:
date <- as.POSIXct("01-01-2010", format = "%d-%m-%Y", tz = "UTC")
as.numeric(format(date, "%m"))
as.POSIXlt(date)$month + 1
date <- as.POSIXct(format(date, "%Y-2-%d"), tz = "UTC")
date <- seq(date, length = 2, by = "-1 day")[2]
as.POSIXct(format(as.POSIXct(date), tz = "UTC"), tz = "GMT")

# Lubridate comparison:
date <- dmy("01-01-2010")
month(date)
month(date) <- 2
date <- date - days(1)
with_tz(date, "GMT")

# Section 3. Parsing date-times
mdy("12-01-2010")  #"2010-12-01 UTC"
dmy("12-01-2010")  #"2010-01-12 UTC"
dmy(c("31.12.2010", "01.01.2011"))  #"2010-12-31 UTC" "2011-01-01 UTC"

# Section 4. Manipulating date-times
date <- now()
year(date)
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
date <- date + hours(3)

# Section 5. Arithmetic with date-times
## Section 5.1. Instants
start_2012 <- ymd_hms("2012-01-01 12:00:00")
is.instant(364)  #FALSE
is.instant(start_2012)  #TRUE

## Section 5.2. Intervals
start_2011 <- ymd_hms("2011-01-01 12:00:00")
start_2010 <- ymd_hms("2010-01-01 12:00:00")
span <- start_2011 - start_2010  #2010-01-01 12:00:00 - 2011-01-01 12:00:00
int_start(span)  #"2010-01-01 12:00:00 UTC"
int_end(span)  #"2011-01-01 12:00:00 UTC"
start_2010 + span  #"2011-01-01 12:00:00 UTC"
start_2011 + span  #"2012-01-01 12:00:00 UTC"
as.interval(difftime(start_2011, start_2010), ymd("2010-03-05"))  #2010-03-05 - 2011-03-05

## Section 5.3. Durations
duration(60)  #60s
dminutes(1)  #60s
dseconds(60)  #60s
dminutes(2)  #120s
c(1:3) * dhours(1)  #3600s (1h) 7200s (2h) 10800s (3h)
start_2011 + dyears(1)  #"2012-01-01 12:00:00 UTC"
start_2012 <- ymd_hms("2012-01-01 12:00:00")
start_2012 + dyears(1)   #"2012-12-31 12:00:00 UTC"
dweeks(1) + ddays(6) + dhours(2) + dminutes(1.5) + dseconds(3)  #1130493s (13.08d)
as.duration(span)  #31536000s (365d)

## Section 5.4. Periods
months(3)  #3 months
months(3) + days(2)  #3 months and 2 days
start_2012 + years(1)  #"2013-01-01 12:00:00 UTC"
start_2012 + dyears(1)  #"2012-12-31 12:00:00 UTC"
as.period(span)  #1 year

## Section 5.5. Division with timespans
halloween <- ymd("2010-10-31")
christmas <- ymd("2010-12-25")
interval <- interval(halloween, christmas)  #2010-10-31 - 2010-12-25
interval / dweeks(1)  #7.857143
interval / interval(halloween, halloween + weeks(1))  #7.857143
interval %% months(1)  #24 days
interval / months(1)  #1
interval %/% months(1)  #1

# Section 6. Rounding dates
april20 <- ymd_hms("2010-04-20 11:33:29")
round_date(april20, "day")  #"2010-04-20 UTC"
round_date(april20, "month")  #"2010-05-01 UTC"
ceiling_date(april20, "month") - days(1)  #"2010-04-30 UTC"

# Section 7. Time zones
date
with_tz(date, "UTC")  #"2010-01-01 15:51:48 UTC"
date
force_tz(date, "UTC")  #"2010-01-01 09:51:48 UTC"

# Section 8. Daylight savings time
dst_time <- ymd_hms("2010-03-14 01:59:59")
dst_time <- force_tz(dst_time, "America/Chicago")  #"2010-03-14 01:59:59 CST"
dst_time + dseconds(1)  #"2010-03-14 03:00:00 CDT"
dst_time + hours(2)  #"2010-03-14 03:59:59 CDT"
dst_time + dhours(2)  #"2010-03-14 04:59:59 CDT"

# Section 9. Case study 1
## Section 9.1. Thanksgiving
date <- ymd("2010-01-01")  #"2010-01-01 UTC"
month(date) <- 11  #"2010-11-01 UTC"
wday(date, label = TRUE, abbr = FALSE)  #Monday
date <- date + days(3)  #"2010-11-04 UTC"
wday(date, label = TRUE, abbr = FALSE)  #Thursday
date + weeks(3)  #"2010-11-25 UTC"

## Section 9.2. Memorial Day
date <- ymd("2010-01-01")  #"2010-01-01 UTC"
month(date) <- 5  #"2010-05-01 UTC"
date <- ceiling_date(date, "month") - days(1)  #"2010-05-31 UTC"
wday(date, label = TRUE, abbr = FALSE)  #Monday

# Section 10. Case study 2
str(lakers$date)
lakers$date <- ymd(lakers$date)
str(lakers$date)

library(ggplot2)
qplot(date, 0, data = lakers, colour = game_type)
qplot(wday(date, label = TRUE, abbr = FALSE), data = lakers, geom = "histogram")
lakers$time <- ms(lakers$time)
lakers$time <- as.duration(lakers$time)
lakers$time <- dminutes(c(12, 24, 36, 48, 53)[lakers$period]) -
  lakers$time
qplot(time, data = lakers, geom = "histogram", binwidth = 60)
lakers$minutes <- ymd("2008-01-01") + lakers$time
qplot(minutes, data = lakers, geom = "histogram", binwidth = 60)
game1 <- lakers[lakers$date == ymd("20081225"),]
attempts <- game1[game1$etype == "shot",]
attempts$wait <- c(attempts$time[1], diff(attempts$time))
qplot(as.integer(wait), data = attempts, geom = "histogram",
  binwidth = 2)
game1_scores <- ddply(game1, "team", transform, score =
  cumsum(points))
game1_scores <- game1_scores[game1_scores$team != "OFF",]
qplot(ymd("2008-01-01") + time, score, data = game1_scores,
  geom = "line", colour = team)
