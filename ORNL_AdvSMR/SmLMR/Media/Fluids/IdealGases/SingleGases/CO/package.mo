within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.SingleGases;
package CO "Ideal gas \"CO\" from NASA Glenn coefficients"
  extends Common.SingleGasNasa(
    mediumName="Carbon Monoxide",
    data=Common.SingleGasesData.CO,
    fluidConstants={Common.FluidData.CO});


  annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/CO.png\"></HTML>"));
end CO;
