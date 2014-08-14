within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function sv_p
  "vapour specific entropy on the boundary between regions 4 and 3 or 2"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEntropy s "specific entropy";
protected
  SI.Temperature Tsat "saturation temperature";
  SI.SpecificEnthalpy h "specific enthalpy";
algorithm
  if (p < data.PLIMIT4A) then
    Tsat := Basic.tsat(p);
    (h,s) := Isentropic.handsofpT2(p, Tsat);
  elseif (p < data.PCRIT) then
    s := sv_p_R4b(p);
  else
    s := data.SCRIT;
  end if;
end sv_p;
