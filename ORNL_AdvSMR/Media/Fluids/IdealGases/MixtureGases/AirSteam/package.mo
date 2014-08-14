within ORNL_AdvSMR.Media.Fluids.IdealGases.MixtureGases;
package AirSteam "air and steam mixture (no condensation!, pseudo-mixture)"
extends Common.MixtureGasNasa(
  mediumName="MoistAir",
  data={Common.SingleGasesData.H2O,Common.SingleGasesData.Air},
  fluidConstants={Common.FluidData.H2O,Common.FluidData.N2},
  substanceNames={"Water","Air"},
  reference_X={0.0,1.0});


annotation (Documentation(info="<html>

</html>"));
end AirSteam;
