within ORNL_AdvSMR.Media.Fluids;
package Air "Air as mixture of O2, N2, Ar and H2O"
import Modelica.Media.IdealGases.*;


extends Common.MixtureGasNasa(
  mediumName="Air",
  data={Common.SingleGasesData.O2,Common.SingleGasesData.H2O,Common.SingleGasesData.Ar,
      Common.SingleGasesData.N2},
  fluidConstants={Common.FluidData.O2,Common.FluidData.H2O,Common.FluidData.Ar,
      Common.FluidData.N2},
  substanceNames={"Oxygen","Water","Argon","Nitrogen"},
  reference_X={0.23,0.015,0.005,0.75});
end Air;
