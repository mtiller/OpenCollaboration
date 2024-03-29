within ORNL_AdvSMR.Media.Fluids.IdealGases.SingleGases;
package N2 "Ideal gas \"N2\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="Nitrogen",
  data=Common.SingleGasesData.N2,
  fluidConstants={Common.FluidData.N2});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/N2.png\"></HTML>"));
end N2;
