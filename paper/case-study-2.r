# making data set

load("08-lal.rdata")
head(lal)
lal$home_team <- substr(lal$.id, 13, 15)
lal$away_team <- substr(lal$.id, 10, 12)
lakers <- lal[,c(13, 35, 34, 12, 15, 14, 25, 29, 26, 31, 32, 33)]
write.table(lakers, file = "lakers.csv", sep = ",")

# running case study

lakers <- read.csv("lakers.csv")

# separating date and time
lakers$date <- substr(lakers$time, 1, 10)
lakers$date <- ymd(lakers$date)

time_minutes <- as.numeric(substr(lakers$time, 15, 16))
time_secs <- as.numeric(substr(lakers$time, 18, 19))
game_clock <- eminutes(time_minutes) + eseconds(time_secs)
lakers$game_time <- eminutes(12) * lakers$period - game_clock

# histogram of plays from start of game
library(ggplot2)
qplot(as.integer(game_time), data = lakers, geom = "histogram")

lakers$demo <- ymd("2010-01-01") + lakers$game_time
qplot(demo, data = lakers, geom = "histogram", binwidth = 120)
