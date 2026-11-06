test_that("VectorGeneration builds the expected phasors", {
  v <- VectorGeneration(EffectiveVoltage = 230, EffectiveIntensity = 10, ThetaI = -0.5)

  expect_equal(Mod(v$Voltage), 230)
  expect_equal(Mod(v$Current), 10)
  expect_equal(Arg(v$Current), -0.5)
})

test_that("VectorGeneration rejects invalid inputs", {
  expect_error(VectorGeneration(EffectiveVoltage = -230, EffectiveIntensity = 10, ThetaI = 0))
  expect_error(VectorGeneration(EffectiveVoltage = "abc", EffectiveIntensity = 10, ThetaI = 0))
  expect_error(VectorGeneration(EffectiveVoltage = NA, EffectiveIntensity = 10, ThetaI = 0))
})
