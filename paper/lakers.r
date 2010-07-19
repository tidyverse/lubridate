# getting and cleaning data

file.names <- list.files()
file.names2 <- file.names[substr(file.names, 10, 12) == "LAL" | substr(file.names, 13, 15) == "LAL"]

options(stringsAsFactors = F)

data <- list()
for (i in 1:length(file.names2)){
  data[[i]]<- read.csv(file.names2[i])
  data[[i]]$date <- rep(substr(file.names2[i], 1, 8), nrow(data[[i]]))
  data[[i]]$home <- rep(substr(file.names2[i], 13, 15), nrow(data[[i]]))
  data[[i]]$away <- rep(substr(file.names2[i], 10, 12), nrow(data[[i]]))
}

lal <- data[[1]]
for(j in 2:length(file.names2))
  lal <- rbind(lal, data[[j]])

lakers <- lal[,c(33, 19, 16, 12, 11, 14, 13, 24, 28, 25, 30, 31, 32)]

to_expand <- which(nchar(lakers$time) < 5)
lakers$time[to_expand]  <- paste("0", lakers$time[to_expand], sep = "")

frees <- which(lakers$etype == "free throw" & lakers$result == "made")
lakers$points[frees] <- 1
lakers$points[is.na(lakers$points)] <- 0


write.table(lakers, file = "lakers.csv", sep = ",")


# running case study

lakers <- read.csv("lakers.csv", stringsAsFactors = F)

# histogram of dates played
# parsing dates
lakers$date <- ymd(lakers$date)
qplot(date, 0, data = lakers, geom = "point", colour = lakers$home == "LAL") + scale_colour_discrete(name = "Venue", labels = c("home game", "away game"))
ggsave("dates-points.png", width = 8, height = 4)

qplot(wday(date, label = T, abbr = F), data = lakers, geom = "histogram")
ggsave("weekdays-histogram.png", width = 8, height = 4)


# creating time variable with durations
time_min <- as.numeric(substr(lakers$time, 1 , 2))
time_sec <- as.numeric(substr(lakers$time, 4 , 5))
lakers$time <- eminutes(time_min) + eseconds(time_sec)
lakers$time <- eminutes(12) * lakers$period - lakers$time

# histogram of plays from start of game
library(ggplot2)
qplot(as.integer(time), data = lakers, geom = "histogram", binwidth = 60)
ggsave("play-time-histogram.png", width = 8, height = 4)

lakers$demo <- ymd("2008-01-01") + lakers$time
qplot(demo, data = lakers, geom = "histogram", binwidth = 60)
ggsave("play-time-histogram2.png", width = 8, height = 4)

# picking out one game to examine
game1 <- lakers[lakers$date == ymd("20081028"),]


# histogram of waiting times between plays for one game
attempts <- game1[game1$etype == "shot",]
attempts$wait <- attempts$time - c(eseconds(0), attempts$time[-nrow(attempts)])

qplot(as.integer(wait), data = attempts, geom = "histogram", binwidth = 2)
ggsave("wait-histogram.png", width = 8, height = 4)

# histogram of seconds until first score
scores <- lakers[lakers$etype == "jump ball" | lakers$result == "made",]
start <- which(scores$time == eseconds(0))
first <- scores$time[start + 1]
qplot(as.integer(first), geom = "histogram", binwidth = 2)
ggsave("first-histogram.png", width = 8, height = 4)

# cumulative score graph

game1_scores <- ddply(game1, "team", transform, score = cumsum(points))
game1_scores <- game1_scores[game1_scores$team != "OFF",]

qplot(ymd("2008-01-01") + time, score, data = game1_scores, geom = "line", colour = team)
ggsave("score-comparison.png", width = 8, height = 4)




