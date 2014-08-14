within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.SingleGases;
package SO2 "Ideal gas \"SO2\" from NASA Glenn coefficients"
  extends Common.SingleGasNasa(
    mediumName="Sulfur Dioxide",
    data=Common.SingleGasesData.SO2,
    fluidConstants={Common.FluidData.SO2});


  annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/SO2.png\"></HTML>"));
end SO2;
