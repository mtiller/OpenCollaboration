within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.SingleGases;
package NO2 "Ideal gas \"NO2\" from NASA Glenn coefficients"
  extends Common.SingleGasNasa(
    mediumName="Nitrogen Dioxide",
    data=Common.SingleGasesData.NO2,
    fluidConstants={Common.FluidData.NO2});


  annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/NO2.png\"></HTML>"));
end NO2;
