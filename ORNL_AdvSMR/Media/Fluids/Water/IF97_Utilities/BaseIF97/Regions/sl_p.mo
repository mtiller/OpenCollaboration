within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function sl_p
  "liquid specific entropy on the boundary between regions 4 and 3 or 1"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEntropy s "specific entropy";
protected
  SI.Temperature Tsat "saturation temperature";
  SI.SpecificEnthalpy h "specific enthalpy";
algorithm
  if (p < data.PLIMIT4A) then
    Tsat := Basic.tsat(p);
    (h,s) := Isentropic.handsofpT1(p, Tsat);
  elseif (p < data.PCRIT) then
    s := sl_p_R4b(p);
  else
    s := data.SCRIT;
  end if;
end sl_p;
