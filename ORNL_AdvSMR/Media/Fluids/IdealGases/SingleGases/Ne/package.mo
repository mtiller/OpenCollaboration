within ORNL_AdvSMR.Media.Fluids.IdealGases.SingleGases;
package Ne "Ideal gas \"Ne\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="Neon",
  data=Common.SingleGasesData.Ne,
  fluidConstants={Common.FluidData.Ne});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/Ne.png\"></HTML>"));
end Ne;
