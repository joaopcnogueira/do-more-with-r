library(testthat)

test_that(
    "Checking January, June and December",
    {
        expect_equal(first_of_last_month("2018-01-07"), as.Date("2017-12-01"))
        expect_equal(first_of_last_month("2018-06-05"), as.Date("2018-05-01"))
        expect_equal(first_of_last_month("2018-12-01"), as.Date("2018-11-01"))
    }
)