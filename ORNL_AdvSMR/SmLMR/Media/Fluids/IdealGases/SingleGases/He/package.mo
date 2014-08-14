within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.SingleGases;
package He "Ideal gas \"He\" from NASA Glenn coefficients"
  extends Common.SingleGasNasa(
    mediumName="Helium",
    data=Common.SingleGasesData.He,
    fluidConstants={Common.FluidData.He});


  annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/He.png\"></HTML>"));
end He;
