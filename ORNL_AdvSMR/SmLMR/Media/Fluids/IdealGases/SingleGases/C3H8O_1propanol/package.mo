within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.SingleGases;
package C3H8O_1propanol "Ideal gas \"C3H8O_1propanol\" from NASA Glenn coefficients"
  extends Common.SingleGasNasa(
    mediumName="1-Propanol",
    data=Common.SingleGasesData.C3H8O_1propanol,
    fluidConstants={Common.FluidData.C3H7OH});


  annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C3H8O_1propanol.png\"></HTML>"));
end C3H8O_1propanol;
