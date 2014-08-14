within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.SingleGases;
package C7H16_n_heptane "Ideal gas \"C7H16_n_heptane\" from NASA Glenn coefficients"
  extends Common.SingleGasNasa(
    mediumName="N-Heptane",
    data=Common.SingleGasesData.C7H16_n_heptane,
    fluidConstants={Common.FluidData.C7H16_n_heptane});


  annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C7H16_n_heptane.png\"></HTML>"));
end C7H16_n_heptane;
