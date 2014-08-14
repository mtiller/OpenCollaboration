within ORNL_AdvSMR.Media.Fluids.IdealGases.SingleGases;
package C5H10_1_pentene "Ideal gas \"C5H10_1_pentene\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="1-Pentene",
  data=Common.SingleGasesData.C5H10_1_pentene,
  fluidConstants={Common.FluidData.C5H10_1_pentene});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C5H10_1_pentene.png\"></HTML>"));
end C5H10_1_pentene;
