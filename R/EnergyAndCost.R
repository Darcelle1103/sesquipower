#'  Compute energies and tariff-based cost
#'
#' Converts active and reactive powers into energies over a given duration
#' and applies a tiered tariff to obtain the cost.
#'
#' @param ActivePower Active power, in watts.
#' @param ReactivePower Reactive power, in var.
#' @param times Duration, in hours.
#'
#' @returns A list with the energies and the costs.
#' @export
#'
#' @examples
#' CalculateEnergyCost(2018, 1103, 2)
#'
#Calculation of energy in kilowatt/hour for active and total power (active and reactive) as well as the cost of these energies
CalculateEnergyCost <- function(ActivePower,ReactivePower,times=720){

  #Vérifions que t est un nombre strictement positif

  if (!is.numeric(times) || length(times) != 1L ||
      !is.finite(times) || times <= 0) {
    stop("times must be strictly positive.")
  }

  if (!is.numeric(ActivePower) || length(ActivePower) != 1L ||
      !is.finite(ActivePower) || ActivePower <= 0) {
    stop("ActivePower must be a complex number.")
  }

  if (!is.numeric(ReactivePower) || length(ReactivePower) != 1L ||
      !is.finite(ReactivePower) || ReactivePower <= 0) {
    stop("ReactivePower  must be a complex number.")
  }
  # Energy Calculations
  ActiveEnergy <- (ActivePower*times)/1000
  ReactiveEnergy <- (ReactivePower*times)/1000
  TotalEnergy <- sqrt(ActiveEnergy^2 + ReactiveEnergy^2)

  #Cost calculation
  if (ActiveEnergy <= 110) {
    ActivePrice <- ActiveEnergy * 50
  } else if (ActiveEnergy <= 400) {
    ActivePrice <- ActiveEnergy * 79
  } else if (ActiveEnergy <= 800) {
    ActivePrice <- ActiveEnergy * 94
  } else {
    ActivePrice <- ActiveEnergy * 99
  }


  if (TotalEnergy <= 110) {
    TotalPrice <- TotalEnergy * 50
  } else if (TotalEnergy <= 400) {
    TotalPrice <- TotalEnergy * 79
  } else if (TotalEnergy <= 800) {
    TotalPrice <- TotalEnergy * 94
  } else {
    TotalPrice <- TotalEnergy * 99
  }


  #Display the different energies and the different costs
  list(Active_energy=ActiveEnergy,Total_energy=TotalEnergy,Actual_consumption=ActivePrice,Total_consumption=TotalPrice)

}
