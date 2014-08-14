within ORNL_AdvSMR.Media.Fluids.IdealGases.SingleGases;
package CL2 "Ideal gas \"Cl2\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="Chlorine",
  data=Common.SingleGasesData.CL2,
  fluidConstants={Common.FluidData.CL2});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/CL2.png\"></HTML>"));
end CL2;
