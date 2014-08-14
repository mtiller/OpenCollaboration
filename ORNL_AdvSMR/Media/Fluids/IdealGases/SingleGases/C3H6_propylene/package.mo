within ORNL_AdvSMR.Media.Fluids.IdealGases.SingleGases;
package C3H6_propylene "Ideal gas \"C3H6_propylene\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="Propylene",
  data=Common.SingleGasesData.C3H6_propylene,
  fluidConstants={Common.FluidData.C3H6_propylene});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C3H6_propylene.png\"></HTML>"));
end C3H6_propylene;
