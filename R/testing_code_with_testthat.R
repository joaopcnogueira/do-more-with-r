# CREATE A SIMPLE FUNCTION ----
first_of_last_month <- function(mystring) {
    year <- substr(mystring, 1, 4)
    month <- as.numeric(substr(mystring, 6, 7))
    lastmonth <- stringr::str_pad(month-1, width = 2, pad = 0)
    result <- paste(year, lastmonth, "01", sep = "-")
    return(result)
}


first_of_last_month("2018-05-31")

first_of_last_month("2018-06-15")

first_of_last_month("2018-07-01")

# this time, get an unexpected result: 2018-00-01
first_of_last_month("2018-01-07")


# TEST THE FUNCTION ----
library(testthat)

test_that(
    "Checking January, June and December",
    {
        expect_equal(first_of_last_month("2018-01-07"), "2017-12-01")
        expect_equal(first_of_last_month("2018-06-05"), "2018-05-01")
        expect_equal(first_of_last_month("2018-12-01"), "2018-11-01")
    }
)


# CREATE A NEW VERSION OF THE FUNCTION ----
library(lubridate)

first_of_last_month <- function(mystring) {
    mydate <- as_date(mystring)
    mydate_first_of_month <- floor_date(mydate, "month")
    result <- mydate_first_of_month - months(1)
    return(result)
}

# TEST THE NEW FUNCTION ----
# We have put the tests into a file called tests/test_that.R
source("R/tests/test_that.R")


# REFERENCE ----
# https://www.youtube.com/watch?v=Jlk5KmOqOVA&list=PL7D2RMSmRO9JOvPC1gbA8Mc3azvSfm8Vv&index=35