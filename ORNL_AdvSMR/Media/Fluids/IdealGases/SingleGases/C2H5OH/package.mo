within ORNL_AdvSMR.Media.Fluids.IdealGases.SingleGases;
package C2H5OH "Ideal gas \"C2H5OH\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="Ethanol",
  data=Common.SingleGasesData.C2H5OH,
  fluidConstants={Common.FluidData.C2H5OH});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C2H5OH.png\"></HTML>"));
end C2H5OH;
