test_that("PowerCalculation gives the expected powers", {
  U <- 230 * exp(1i * 0)
  I <- 10 * exp(1i * -0.5)
  pw <- PowerCalculation(U, I)

  expect_equal(pw$Active_power, 2300 * cos(0.5))
  expect_equal(pw$Reactive_Power, 2300 * sin(0.5))
  expect_equal(pw$Apparent_power, 2300)
})

test_that("P^2 + Q^2 equals S^2", {
  pw <- PowerCalculation(230 * exp(1i * 0.3), 8 * exp(1i * -0.4))
  expect_equal(pw$Active_power^2 + pw$Reactive_Power^2, pw$Apparent_power^2)
})
