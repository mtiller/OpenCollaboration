within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function rhol_p_R4b
  "explicit approximation of liquid density on the boundary between regions 4 and 3"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.Density dl "liquid density";
protected
  Real x "auxiliary variable";
algorithm
  if (p < data.PCRIT) then
    x := Modelica.Math.acos(p/data.PCRIT);
    dl := (1 + x*(1.903224079094824 + x*(-2.5314861802401123 +
      x*(-8.191449323843552 + x*(94.34196116778385 + x*(-369.3676833623383
       + x*(796.6627910598293 + x*(-994.5385383600702 + x*(
      673.2581177021598 + (-191.43077336405156 +
      0.00052536560808895*x)*x)))))))))*data.DCRIT;
  else
    dl := data.DCRIT;
  end if;
end rhol_p_R4b;
