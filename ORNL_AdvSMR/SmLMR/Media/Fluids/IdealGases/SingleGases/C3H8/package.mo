within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.SingleGases;
package C3H8 "Ideal gas \"C3H8\" from NASA Glenn coefficients"
  extends Common.SingleGasNasa(
    mediumName="Propane",
    data=Common.SingleGasesData.C3H8,
    fluidConstants={Common.FluidData.C3H8});


  annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C3H8.png\"></HTML>"));
end C3H8;
