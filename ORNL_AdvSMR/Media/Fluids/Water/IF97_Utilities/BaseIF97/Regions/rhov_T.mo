within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function rhov_T "density of saturated vapour"
  extends Modelica.Icons.Function;
  input SI.Temperature T "temperature";
  output SI.Density d "density of steam at the condensation point";
protected
  SI.Pressure p "saturation pressure";
algorithm

  // assert(T <= data.TCRIT,"input temperature has to be below the critical temperature");
  p := Basic.psat(T);
  if T < data.TLIMIT1 then
    d := d2n(p, T);
  elseif T < data.TCRIT then
    d := rhov_p_R4b(p);
  else
    d := data.DCRIT;
  end if;
end rhov_T;
