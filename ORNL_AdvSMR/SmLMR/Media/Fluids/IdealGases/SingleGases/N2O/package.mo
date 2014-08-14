within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.SingleGases;
package N2O "Ideal gas \"N2O\" from NASA Glenn coefficients"
  extends Common.SingleGasNasa(
    mediumName="Nitrous Oxide",
    data=Common.SingleGasesData.N2O,
    fluidConstants={Common.FluidData.N2O});


  annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/N2O.png\"></HTML>"));
end N2O;
