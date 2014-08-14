within ORNL_AdvSMR.Media.Fluids.IdealGases.SingleGases;
package CH4 "Ideal gas \"CH4\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="Methane",
  data=Common.SingleGasesData.CH4,
  fluidConstants={Common.FluidData.CH4});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/CH4.png\"></HTML>"));
end CH4;
