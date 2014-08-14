within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.SingleGases;
package CO2 "Ideal gas \"CO2\" from NASA Glenn coefficients"
  extends Common.SingleGasNasa(
    mediumName="Carbon Dioxide",
    data=Common.SingleGasesData.CO2,
    fluidConstants={Common.FluidData.CO2});


  annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/CO2.png\"></HTML>"));
end CO2;
