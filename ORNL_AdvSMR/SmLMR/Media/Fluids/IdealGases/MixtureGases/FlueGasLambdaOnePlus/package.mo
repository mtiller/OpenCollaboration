within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.MixtureGases;
package FlueGasLambdaOnePlus "simple flue gas for over0stochiometric O2-fuel ratios"
  extends Common.MixtureGasNasa(
    mediumName="FlueGasLambda1plus",
    data={Common.SingleGasesData.N2,Common.SingleGasesData.O2,
        Common.SingleGasesData.H2O,Common.SingleGasesData.CO2},
    fluidConstants={Common.FluidData.N2,Common.FluidData.O2,Common.FluidData.H2O,
        Common.FluidData.CO2},
    substanceNames={"Nitrogen","Oxygen","Water","Carbondioxide"},
    reference_X={0.768,0.232,0.0,0.0});


  annotation (Documentation(info="<html>

</html>"));
end FlueGasLambdaOnePlus;
