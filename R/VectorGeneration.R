#' Generate voltage and current phasors
#'Builds the complex phasors of the voltage and the current from their
#' RMS values and their phase angles.
#' @param EffectiveVoltage RMS voltage, in volts.
#' @param EffectiveIntensity RMS current, in amperes.
#' @param ThetaU Phase angle of the voltage, in radians.
#' @param ThetaI  Phase angle of the current, in radians.
#'
#' @returns A list with the complex voltage and the complex current.
#' @export
#'
#' @examples
#' VectorGeneration(230, 10, 0, -0.5)
#'
# Generation of the complex current and voltage vectors
VectorGeneration <- function(EffectiveVoltage,EffectiveIntensity,ThetaU=0,ThetaI=0) {

  #Let's check if the current and RMS voltage are numbers
  if (!is.numeric(EffectiveVoltage) || length(EffectiveVoltage) != 1L ||
      !is.finite(EffectiveVoltage) || EffectiveVoltage <= 0) {
    stop("EffectiveVoltage must be strictly positive.")
  }
  if (!is.numeric(EffectiveIntensity) || length(EffectiveIntensity) != 1L ||
      !is.finite(EffectiveIntensity) || EffectiveIntensity <= 0) {
    stop("EffectiveIntensity must be strictly positive.")
  }

  #Let's check that the angles are in radians
  if (!is.numeric(ThetaU) || length(ThetaU) != 1L ||
      !is.finite(ThetaU)) {
    stop("ThetaU must be an angle in radians.")
  }

  if (!is.numeric(ThetaI) || length(ThetaI) != 1L ||
      !is.finite(ThetaI)) {
    stop("ThetaI must be an angle in radians.")
  }

  # Construction of complex vectors
  U <- EffectiveVoltage*exp(1i*ThetaU)
  I <- EffectiveIntensity*exp(1i*ThetaI)

  # Return U and I
  return(list(Voltage=U, Current=I))

}
