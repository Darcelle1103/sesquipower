test_that("CalculateEnergyCost computes the energies", {
  res <- CalculateEnergyCost(ActivePower = 2000, ReactivePower = 1000, times = 2)

  expect_equal(res$Active_energy, 4)                 # kWh
  expect_equal(res$Total_energy, sqrt(4^2 + 2^2))    # kVAh, et non 4 + 2
})

test_that("the default duration is 720 hours", {
  res <- CalculateEnergyCost(ActivePower = 500, ReactivePower = 300)
  expect_equal(res$Active_energy, 500 * 720 / 1000)
})

test_that("the tariff tier depends on the energy", {
  # 110 kWh : première tranche (50)
  res1 <- CalculateEnergyCost(ActivePower = 1000, ReactivePower = 100, times = 110)
  expect_equal(res1$Actual_consumption, 110 * 50)

  # 111 kWh : deuxième tranche (79)
  res2 <- CalculateEnergyCost(ActivePower = 1000, ReactivePower = 100, times = 111)
  expect_equal(res2$Actual_consumption, 111 * 79)

  # 360 kWh : deuxième tranche, et énergie totale entre 400 et 800 : tranche à 94
  res3 <- CalculateEnergyCost(ActivePower = 500, ReactivePower = 300)
  expect_equal(res3$Actual_consumption, res3$Active_energy * 79)
  expect_equal(res3$Total_consumption, res3$Total_energy * 94)
})

test_that("CalculateEnergyCost rejects invalid inputs", {
  expect_error(CalculateEnergyCost(2000, 1000, times = 0))
  expect_error(CalculateEnergyCost("abc", 1000, 2))
  expect_error(CalculateEnergyCost(0, 1000, 2))
  expect_error(CalculateEnergyCost(2000, NA, 2))
  expect_error(CalculateEnergyCost(2000, -1000, 2))   # votre fonction refuse Q <= 0
})
