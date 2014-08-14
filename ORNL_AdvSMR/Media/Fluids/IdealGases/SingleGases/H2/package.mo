within ORNL_AdvSMR.Media.Fluids.IdealGases.SingleGases;
package H2 "Ideal gas \"H2\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="Hydrogen",
  data=Common.SingleGasesData.H2,
  fluidConstants={Common.FluidData.H2});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/H2.png\"></HTML>"));
end H2;
