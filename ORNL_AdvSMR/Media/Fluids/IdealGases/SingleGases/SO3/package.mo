within ORNL_AdvSMR.Media.Fluids.IdealGases.SingleGases;
package SO3 "Ideal gas \"SO3\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="Sulfur Trioxide",
  data=Common.SingleGasesData.SO3,
  fluidConstants={Common.FluidData.SO3});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/SO3.png\"></HTML>"));
end SO3;
