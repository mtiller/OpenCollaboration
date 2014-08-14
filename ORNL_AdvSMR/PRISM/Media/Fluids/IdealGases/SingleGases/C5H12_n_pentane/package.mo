within ORNL_AdvSMR.PRISM.Media.Fluids.IdealGases.SingleGases;
package C5H12_n_pentane "Ideal gas \"C5H12_n_pentane\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="N-Pentane",
  data=Common.SingleGasesData.C5H12_n_pentane,
  fluidConstants={Common.FluidData.C5H12_n_pentane});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C5H12_n_pentane.png\"></HTML>"));
end C5H12_n_pentane;
