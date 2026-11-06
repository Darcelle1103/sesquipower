#' Compute complex, active, reactive and apparent power
#'
#' Computes S = U * Conj(I), then returns P = Re(S), Q = Im(S) and |S|.
#'
#' @param Voltage Complex phasor of the voltage.
#' @param Current Complex phasor of the current.
#'
#' @returns A list with the complex, active, reactive and apparent powers.
#' @export
#'
#' @examples
#' U <- 230 * exp(1i * 0)
#' I <- 10 * exp(1i * -0.5)
#' PowerCalculation(U, I)
#'
# Let's calculate the total power, the active power, and the reactive power
PowerCalculation <- function(Voltage,Current){

  SComplex <- Voltage*Conj(Current)
  ActivePower <- Re(SComplex)
  ReactivePower <- Im(SComplex)
  S <- Mod(SComplex)

  #Displaying the different powers
  list(Complex_Power=SComplex,Apparent_power=S,Active_power=ActivePower,Reactive_Power=ReactivePower)
}
