#'  Size capacitors for reactive power compensation
#'
#' Computes the capacity of each capacitor needed to bring the reactive
#' power down to a target value.
#'
#' @param ReactivePower Current reactive power, in var.
#' @param Voltage  RMS voltage, in volts.
#' @param frequency Network frequency, in hertz (default 50).
#' @param DesiredReactivePower Target reactive power after compensation, in var.
#' @param NumberOfCapacitors Number of identical capacitors connected in parallel.
#'
#' @returns A list with the compensation power, the number of capacitors
#'   and the capacity of each capacitor, in microfarads.
#' @export
#'
#' @examples
#'  \dontrun{
#' OptimizeReactivePower(1103, 230)
#' }
#'
#Reactive Power Optimization
OptimizeReactivePower <- function(ReactivePower, Voltage , frequency = 50,DesiredReactivePower=0,NumberOfCapacitors=0) {

  # Check of the value entered by the user
  if (is.na(DesiredReactivePower) || DesiredReactivePower < 0) {
    stop("Desired reactive power invalid, please enter a  positive number.")
  }

  if (DesiredReactivePower >= ReactivePower) {
    stop("The desired power must be lower than the current power.")
  }

  #Calculation of the compensation power
  ReactivePowerCompensation <- ReactivePower-DesiredReactivePower


  if (is.na(NumberOfCapacitors) || NumberOfCapacitors < 0 || NumberOfCapacitors != round(NumberOfCapacitors)) {
    stop("Invalid number of capacitors, enter an integer greater than or equal to 0 .")
  }

  # Reactive power by capacitor
  Qu <- ReactivePowerCompensation / NumberOfCapacitors

  # Capacity of each capacitor
  C <- Qu / (2 * pi * frequency * Voltage^2)

  # Conversion to microfarads
  CmicroF <- C * 1e6

  #Displaying results

  cat("The power to compensate is:", ReactivePowerCompensation,"Var\n")
  cat("Capacity of each capacitor:",
      round(CmicroF, 2), "\u00b5F\n")

  return(list(
    Initial_Reactive_Power = ReactivePower, Desired_Reactive_Power = DesiredReactivePower,  Reactive_Power_Compensation = ReactivePowerCompensation,
    Number_of_capacitors = NumberOfCapacitors,
    Unit_capacity = CmicroF
  ))

}
