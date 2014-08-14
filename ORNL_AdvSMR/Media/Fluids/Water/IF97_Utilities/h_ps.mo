within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function h_ps "specific enthalpy as function or pressure and temperature"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  input Integer phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SI.SpecificEnthalpy h "specific enthalpy";
algorithm
  h := h_props_ps(
    p,
    s,
    waterBaseProp_ps(
      p,
      s,
      phase,
      region));
end h_ps;
