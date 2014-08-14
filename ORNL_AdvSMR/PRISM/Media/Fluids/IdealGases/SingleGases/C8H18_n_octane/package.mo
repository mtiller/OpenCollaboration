within ORNL_AdvSMR.PRISM.Media.Fluids.IdealGases.SingleGases;
package C8H18_n_octane "Ideal gas \"C8H18_n_octane\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="N-Octane",
  data=Common.SingleGasesData.C8H18_n_octane,
  fluidConstants={Common.FluidData.C8H18_n_octane});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C8H18_n_octane.png\"></HTML>"));
end C8H18_n_octane;
