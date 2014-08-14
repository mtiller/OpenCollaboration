within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.SingleGases;
package C8H10_ethylbenz "Ideal gas \"C8H10_ethylbenz\" from NASA Glenn coefficients"
  extends Common.SingleGasNasa(
    mediumName="Ethylbenzene",
    data=Common.SingleGasesData.C8H10_ethylbenz,
    fluidConstants={Common.FluidData.C8H10_ethylbenz});


  annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C8H10_ethylbenz.png\"></HTML>"));
end C8H10_ethylbenz;
