within ORNL_AdvSMR.Media.Fluids.IdealGases.MixtureGases;
package CombustionAir "Air as mixture of N2 and O2"
extends Common.MixtureGasNasa(
  mediumName="CombustionAirN2O2",
  data={Common.SingleGasesData.N2,Common.SingleGasesData.O2},
  fluidConstants={Common.FluidData.N2,Common.FluidData.O2},
  substanceNames={"Nitrogen","Oxygen"},
  reference_X={0.768,0.232});


annotation (Documentation(info="<html>

</html>"));
end CombustionAir;
