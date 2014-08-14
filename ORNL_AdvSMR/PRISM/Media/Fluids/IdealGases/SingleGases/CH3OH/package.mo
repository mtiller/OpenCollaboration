within ORNL_AdvSMR.PRISM.Media.Fluids.IdealGases.SingleGases;
package CH3OH "Ideal gas \"CH3OH\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="Methanol",
  data=Common.SingleGasesData.CH3OH,
  fluidConstants={Common.FluidData.CH3OH});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/CH3OH.png\"></HTML>"));
end CH3OH;
