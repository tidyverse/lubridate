Date related queries to R-Help 
(Also the help desk article in RNews 4/1 contains info on dates)
---------------------------------------------------
- make R recognize dates as dates
			newDate <- as.Date(result[,"Date"], "%d.%m.%y")) 
- subset my data based on its date column
- get as.POSIXct() to recognize my data format
- retain the date class? e.g Unlist() drops the class attribute
	and ifelse(d > "1996-1-1", "1996-1-1", d)  doesn not work
- convert a date to a year + decimal (e.g. 2000-07-01 ~ 2000.4953)
- compute any date from a specified start point
- determine the weekday of any date
			as.numeric(format(d, "%w")) # 0 = Sunday
			# or
			format(d, "%a") 
			# or
			weekdays(d)
- use a date value as an index in a for loop
- general frustration of R not recognizing dates imported from excel
- extract year and week information from a date
