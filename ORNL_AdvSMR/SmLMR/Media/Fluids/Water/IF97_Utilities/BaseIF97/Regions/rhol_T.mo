within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function rhol_T "density of saturated water"
  extends Modelica.Icons.Function;
  input SI.Temperature T "temperature";
  output SI.Density d "density of water at the boiling point";
protected
  SI.Pressure p "saturation pressure";
algorithm
  p := Basic.psat(T);
  if T < data.TLIMIT1 then
    d := d1n(p, T);
  elseif T < data.TCRIT then
    d := rhol_p_R4b(p);
  else
    d := data.DCRIT;
  end if;
end rhol_T;
