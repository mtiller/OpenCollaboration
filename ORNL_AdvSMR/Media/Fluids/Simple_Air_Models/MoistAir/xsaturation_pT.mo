within ORNL_AdvSMR.Media.Fluids.Simple_Air_Models.MoistAir;
function xsaturation_pT
  "Return absolute humitity per unit mass of dry air at saturation as a function of pressure p and temperature T"
  input AbsolutePressure p "Pressure";
  input SI.Temperature T "Temperature";
  output MassFraction x_sat "Absolute humidity per unit mass of dry air";
algorithm
  x_sat := k_mair*saturationPressure(T)/max(100*Constants.eps, p -
    saturationPressure(T));
  annotation (smoothOrder=2, Documentation(info="<html>
Absolute humidity per unit mass of dry air at saturation is computed from pressure and temperature.
</html>"));
end xsaturation_pT;
