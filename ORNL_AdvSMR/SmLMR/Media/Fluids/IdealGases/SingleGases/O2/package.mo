within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.SingleGases;
package O2 "Ideal gas \"O2\" from NASA Glenn coefficients"
  extends Common.SingleGasNasa(
    mediumName="Oxygen",
    data=Common.SingleGasesData.O2,
    fluidConstants={Common.FluidData.O2});


  annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/O2.png\"></HTML>"));
end O2;
