within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.SingleGases;
package F2 "Ideal gas \"F2\" from NASA Glenn coefficients"
  extends Common.SingleGasNasa(
    mediumName="Fluorine",
    data=Common.SingleGasesData.F2,
    fluidConstants={Common.FluidData.F2});


  annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/F2.png\"></HTML>"));
end F2;
