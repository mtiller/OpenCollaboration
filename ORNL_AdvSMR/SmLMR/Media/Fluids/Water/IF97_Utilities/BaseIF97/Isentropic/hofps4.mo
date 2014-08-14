within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Isentropic;
function hofps4 "isentropic specific enthalpy in region 4 h(p,s)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  output SI.SpecificEnthalpy h "specific enthalpy";
protected
  SI.Temp_K Tsat "saturation temperature";
  SI.MassFraction x "dryness fraction";
  SI.SpecificEntropy sl "saturated liquid specific entropy";
  SI.SpecificEntropy sv "saturated vapour specific entropy";
  SI.SpecificEnthalpy hl "saturated liquid specific enthalpy";
  SI.SpecificEnthalpy hv "saturated vapour specific enthalpy";
algorithm
  if (p <= data.PLIMIT4A) then
    Tsat := Basic.tsat(p);
    (hl,sl) := handsofpT1(p, Tsat);
    (hv,sv) := handsofpT2(p, Tsat);
  elseif (p < data.PCRIT) then
    sl := Regions.sl_p_R4b(p);
    sv := Regions.sv_p_R4b(p);
    hl := Regions.hl_p_R4b(p);
    hv := Regions.hv_p_R4b(p);
  end if;
  x := max(min(if sl <> sv then (s - sl)/(sv - sl) else 1.0,
    1.0), 0.0);
  h := hl + x*(hv - hl);
end hofps4;
