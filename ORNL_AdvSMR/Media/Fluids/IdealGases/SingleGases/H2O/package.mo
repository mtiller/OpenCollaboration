within ORNL_AdvSMR.Media.Fluids.IdealGases.SingleGases;
package H2O "Ideal gas \"H2O\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="IdealGasSteam",
  data=Common.SingleGasesData.H2O,
  fluidConstants={Common.FluidData.H2O});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/H2O.png\"></HTML>"));
end H2O;
