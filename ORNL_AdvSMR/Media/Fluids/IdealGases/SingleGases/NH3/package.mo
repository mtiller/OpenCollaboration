within ORNL_AdvSMR.Media.Fluids.IdealGases.SingleGases;
package NH3 "Ideal gas \"NH3\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="IdealGasAmmonia",
  data=Common.SingleGasesData.NH3,
  fluidConstants={Common.FluidData.NH3});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/NH3.png\"></HTML>"));
end NH3;
