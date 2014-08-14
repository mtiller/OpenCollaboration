within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.SingleGases;
package C2H4 "Ideal gas \"C2H4\" from NASA Glenn coefficients"
  extends Common.SingleGasNasa(
    mediumName="Ethylene",
    data=Common.SingleGasesData.C2H4,
    fluidConstants={Common.FluidData.C2H4});


  annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C2H4.png\"></HTML>"));
end C2H4;
