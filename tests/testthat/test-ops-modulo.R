context("Modulo operations")

test_that("modulo operations return correct class", {
        int <- ymd("2010-01-01") %--% ymd("2011-01-01")

        expect_error(int %% int)
        expect_is(int %% months(1), "Interval")
        expect_is(int %% ddays(10), "Interval")

        expect_error(months(3) %% int)
        expect_is(days(3) %% hours(2), "Period")
        expect_error(days(5) %% dminutes(300))

        expect_error(dyears(3) %% int)
        expect_error(ddays(2) %% weeks(1))
        expect_is(ddays(3) %% ddays(1), "Duration")

})


test_that("modulo operations synchronize with integer division", {
        int <- ymd("2010-01-01") %--% ymd("2011-01-01")
        int2 <- interval(int_start(int) + int %/% years(2) * years(2), int_end(int))
        int3 <- interval(int_start(int) + int %/% dweeks(20) * dweeks(20), int_end(int))

        expect_error(int %% int)
        expect_equal(int %% years(2), int2)
        expect_equal(int %% dweeks(20), int3)

        expect_error(years(2) %% int)
        expect_equal(years(2) %% months(5) + years(2) %/% months(5) * months(5), years(2))
        expect_error(years(2) %% dweeks(20))

        expect_error(dweeks(20) %% int)
        expect_error(dweeks(20) %% years(2))
        expect_equal(dweeks(20) %% ddays(20) + dweeks(20) %/% ddays(20) * ddays(20), dweeks(20))

})


test_that("modulo operations work for vectors", {
        int <- ymd("2010-01-01") %--% ymd("2011-01-01")
        int2 <- ymd("2009-01-01") %--% ymd("2011-01-01")
        int3 <- interval(int_start(int) + int %/% years(2) * years(2), int_end(int))
        int4 <- interval(int_start(int) + int %/% dweeks(20) * dweeks(20), int_end(int))

        expect_error(c(int, int) %% int2)
        expect_equal(c(int, int) %% years(2), c(int3, int3))
        expect_equal(c(int, int) %% dweeks(20), c(int4, int4))

        expect_error(int %% c(int2, int2))
        expect_equal(int %% years(c(2, 2)), c(int3, int3))
        expect_equal(int %% dweeks(c(20, 20)), c(int4, int4))

        expect_error(years(2:3) %% int)
        expect_equal(years(2:3) %% months(5) + years(2:3) %/% months(5) * months(5), years(2:3))
        expect_error(years(2:3) %% dweeks(20))
        expect_error(years(2) %% c(int, int))
        expect_equal(years(2) %% months(5:6) + years(2) %/% months(5:6) * months(5:6), years(c(2, 2)))
        expect_error(years(2) %% dweeks(20:21))

        expect_error(dweeks(20:21) %% int)
        expect_error(dweeks(20:21) %% years(2))
        expect_equal(dweeks(20:21) %% ddays(20) + dweeks(20:21) %/% ddays(20) * ddays(20), dweeks(20:21))
        expect_error(dweeks(20) %% c(int, int))
        expect_error(dweeks(20) %% years(2:3))
        expect_equal(dweeks(20) %% ddays(20:21) + dweeks(20) %/% ddays(20:21) * ddays(20:21), c(dweeks(20), dweeks(20)))


})
