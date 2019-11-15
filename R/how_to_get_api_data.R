# LOAD PACKAGES ----
library(httr)       # to retrieve data from the API
library(jsonlite)   # to parse the data
library(dplyr)      # to wrangle the data

# API KEY ----
ACCUWEATHER_KEY <- Sys.getenv("ACCUWEATHER_KEY")

# API URL ----
url <- paste0("http://dataservice.accuweather.com/forecasts/v1/daily/1day/571_pc?apikey=",ACCUWEATHER_KEY)

# REQUEST DATA ----
raw_result <- httr::GET(url)

raw_result %>% str()
raw_result$content %>% str()

# GET THE raw_result AS TEXT (JSON FORMAT)
raw_content <- httr::content(raw_result, as = 'text')
raw_content %>% str()

# USE {jsonlite} PACKAGE TO CONVERT FROM JSON TO A MORE SUITABLE R OBJECT
raw_content_from_json <- jsonlite::fromJSON(raw_content)
raw_content_from_json %>% glimpse()

forecast_df <- raw_content_from_json$DailyForecasts
forecast_df %>% View()
forecast_df %>% glimpse()


# ANOTHER WAY TO USE ----
base_url <- "http://dataservice.accuweather.com/locations/v1/cities/search"

# New York city data
ny_raw_data <- GET(base_url,
                   query = list(apikey = ACCUWEATHER_KEY,
                                q = "New York, NY"))

ny_parsed <- content(ny_raw_data, as = 'text') %>% fromJSON()

# São Paulo data
sp_parsed <- GET(base_url, 
                 query = list(apikey = ACCUWEATHER_KEY,
                              q = "São Paulo, SP")) %>% 
    content(as = 'text') %>% 
    fromJSON()


# REFERENCE ----
# https://www.infoworld.com/article/3434627/get-api-data-with-r.html?upd=1573850273051