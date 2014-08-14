within ORNL_AdvSMR.PRISM.Media.Fluids.IdealGases.SingleGases;
package C2H6 "Ideal gas \"C2H6\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="Ethane",
  data=Common.SingleGasesData.C2H6,
  fluidConstants={Common.FluidData.C2H6});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C2H6.png\"></HTML>"));
end C2H6;
