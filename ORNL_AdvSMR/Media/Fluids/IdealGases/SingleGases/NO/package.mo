within ORNL_AdvSMR.Media.Fluids.IdealGases.SingleGases;
package NO "Ideal gas \"NO\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="Nitric Oxide",
  data=Common.SingleGasesData.NO,
  fluidConstants={Common.FluidData.NO});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/NO.png\"></HTML>"));
end NO;
