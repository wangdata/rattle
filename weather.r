### Processing Weather Data ###
# Obtaining Data
today <- format(Sys.Date(), format = "%Y%m")
bom <- paste("http://www.bom.gov.au/climate/dwo/", today,
	"/text/IDCJDW2801.", today, ".csv", sep = "")
dsw <- read.csv(bom, skip = 6, check.names = FALSE)
dim(dsw)
head(names(dsw))

# Data Preprocessing
ndsw <- dsw[-c(1, 10)]
names(ndsw) <- c("Date", "MinTemp", "MaxTemp",
	"Rainfall", "Evaporation", "Sunshine",
	"WindGustDir", "WindGustSpeed", "Temp9am",
	"Humidity9am", "Cloud9am", "WindDir9am",
	"WindSpeed9am", "Pressure9am", "Temp3pm",
	"Humidity3pm", "Cloud3pm", "WindDir3pm",
	"WindSpeed3pm", "Pressure3pm")
dim(ndsw)
names(ndsw)

# Data Cleaning
vars <- c("WindGustSpeed", "WindSpeed9am", "WindSpeed3pm")
head(ndsw[vars])
class(ndsw)
apply(ndsw[vars], MARGIN = 2, FUN = class)
ndsw$WindSpeed9am <- as.character(ndsw$WindSpeed9am)
ndsw$WindSpeed3pm <- as.character(ndsw$WindSpeed3pm)
ndsw$WindGustSpeed <- as.character(ndsw$WindGustSpeed)
head(ndsw[vars])

# Missing Values
ndsw <- within(ndsw,
	{
	WindSpeed9am[WindSpeed9am == ""] <- NA
	WindSpeed3pm[WindSpeed3pm == ""] <- NA
	WindGustSpeed[WindGustSpeed == ""] <- NA
	}
)
ndsw <- within(ndsw,
	{
	WindSpeed9am[WindSpeed9am == "Calm"] <- "0"
	WindSpeed3pm[WindSpeed3pm == "Calm"] <- "0"
	WindGustSpeed[WindGustSpeed == "Calm"] <- "0"
	}
)
ndsw <- within(ndsw,
	{
	WindSpeed9am <- as.numeric(WindSpeed9am)
	WindSpeed3pm <- as.numeric(WindSpeed3pm)
	WindGustSpeed <- as.numeric(WindGustSpeed)
	}
)
apply(ndsw[vars], 2, class)
head(ndsw[vars])

levels(ndsw$WindDir9am)
ndsw <- within(ndsw,
	{
	WindDir9am[WindDir9am == " "] <- NA
	WindDir9am[is.na(WindSpeed9am) |
		(WindSpeed9am == 0)] <- NA
	WindDir3pm[WindDir3pm == " "] <- NA
	WindDir3pm[is.na(WindSpeed3pm) |
		(WindSpeed3pm == 0)] <- NA
	WindGustDir[WindGustDir == " "] <- NA
	WindGustDir[is.na(WindGustSpeed) |
		(WindGustSpeed == 0)] <- NA
	}
)

# Data Transforms
ndsw$RainToday <- ifelse(ndsw$Rainfall > 1, "Yes", "No")
vars <- c("Rainfall", "RainToday")
head(ndsw[vars])
ndsw$RainTomorrow <- c(ndsw$RainToday[2:nrow(ndsw)], NA)
vars <- c("Rainfall", "RainToday", "RainTomorrow")
head(ndsw[vars])
ndsw$RISK_MM <- c(ndsw$Rainfall[2:nrow(ndsw)], NA)
vars <- c("Rainfall", "RainToday",
	"RainTomorrow", "RISK_MM")
head(ndsw[vars])
