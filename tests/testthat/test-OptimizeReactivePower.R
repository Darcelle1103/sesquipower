# La fonction affiche du texte avec cat() : on le masque pendant les tests
quiet <- function(expr) {
  utils::capture.output(res <- expr)
  res
}

test_that("OptimizeReactivePower sizes the capacitors", {
  Q <- 2300 * sin(0.5)
  res <- quiet(OptimizeReactivePower(ReactivePower = Q, Voltage = 230,
                                     DesiredReactivePower = 0, NumberOfCapacitors = 2))

  expect_equal(res$Reactive_Power_Compensation, Q)
  expect_equal(res$Number_of_capacitors, 2)
  expect_equal(res$Unit_capacity, (Q / 2) / (2 * pi * 50 * 230^2) * 1e6)
})

test_that("a non-zero target reduces the compensation", {
  res <- quiet(OptimizeReactivePower(ReactivePower = 1100, Voltage = 230,
                                     DesiredReactivePower = 500, NumberOfCapacitors = 1))
  expect_equal(res$Reactive_Power_Compensation, 600)
  expect_equal(res$Unit_capacity, 600 / (2 * pi * 50 * 230^2) * 1e6)
})

test_that("the total capacity does not depend on the number of capacitors", {
  r1 <- quiet(OptimizeReactivePower(ReactivePower = 1100, Voltage = 230,
                                    DesiredReactivePower = 0, NumberOfCapacitors = 1))
  r4 <- quiet(OptimizeReactivePower(ReactivePower = 1100, Voltage = 230,
                                    DesiredReactivePower = 0, NumberOfCapacitors = 4))
  expect_equal(r1$Unit_capacity, 4 * r4$Unit_capacity)
})

test_that("the capacity is inversely proportional to the frequency", {
  r50 <- quiet(OptimizeReactivePower(1100, 230, frequency = 50,
                                     DesiredReactivePower = 0, NumberOfCapacitors = 2))
  r60 <- quiet(OptimizeReactivePower(1100, 230, frequency = 60,
                                     DesiredReactivePower = 0, NumberOfCapacitors = 2))
  expect_equal(r60$Unit_capacity, r50$Unit_capacity * 50 / 60)
})

test_that("OptimizeReactivePower rejects invalid inputs", {
  # puissance souhaitée trop grande, négative ou manquante
  expect_error(OptimizeReactivePower(ReactivePower = 1100, Voltage = 230,
                                     DesiredReactivePower = 1100, NumberOfCapacitors = 2))
  expect_error(OptimizeReactivePower(ReactivePower = 1100, Voltage = 230,
                                     DesiredReactivePower = -5, NumberOfCapacitors = 2))
  expect_error(OptimizeReactivePower(ReactivePower = 1100, Voltage = 230,
                                     DesiredReactivePower = NA, NumberOfCapacitors = 2))
  # nombre de condensateurs non entier, négatif ou manquant
  expect_error(OptimizeReactivePower(ReactivePower = 1100, Voltage = 230,
                                     DesiredReactivePower = 0, NumberOfCapacitors = 2.5))
  expect_error(OptimizeReactivePower(ReactivePower = 1100, Voltage = 230,
                                     DesiredReactivePower = 0, NumberOfCapacitors = -1))
  expect_error(OptimizeReactivePower(ReactivePower = 1100, Voltage = 230,
                                     DesiredReactivePower = 0, NumberOfCapacitors = NA))
})
