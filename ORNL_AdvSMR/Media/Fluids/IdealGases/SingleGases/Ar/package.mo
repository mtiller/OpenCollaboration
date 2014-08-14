within ORNL_AdvSMR.Media.Fluids.IdealGases.SingleGases;
package Ar "Ideal gas \"Ar\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="Argon",
  data=Common.SingleGasesData.Ar,
  fluidConstants={Common.FluidData.Ar});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/Ar.png\"></HTML>"));
end Ar;
