within ORNL_AdvSMR.PRISM.Media.Fluids.IdealGases.SingleGases;
package C4H10_n_butane "Ideal gas \"C4H10_n_butane\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="N-Butane",
  data=Common.SingleGasesData.C4H10_n_butane,
  fluidConstants={Common.FluidData.C4H10_n_butane});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C4H10_n_butane.png\"></HTML>"));
end C4H10_n_butane;
