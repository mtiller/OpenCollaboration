within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.SingleGases;
package C6H14_n_hexane "Ideal gas \"C6H14_n_hexane\" from NASA Glenn coefficients"
  extends Common.SingleGasNasa(
    mediumName="N-Hexane",
    data=Common.SingleGasesData.C6H14_n_hexane,
    fluidConstants={Common.FluidData.C6H14_n_hexane});


  annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C6H14_n_hexane.png\"></HTML>"));
end C6H14_n_hexane;
