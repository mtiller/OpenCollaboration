within ORNL_AdvSMR.Media.Fluids.IdealGases.SingleGases;
package C2H2_vinylidene "Ideal gas \"C2H2_vinylidene\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="Acetylene",
  data=Common.SingleGasesData.C2H2_vinylidene,
  fluidConstants={Common.FluidData.C2H2_vinylidene});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C2H2_vinylidene.png\"></HTML>"));
end C2H2_vinylidene;
