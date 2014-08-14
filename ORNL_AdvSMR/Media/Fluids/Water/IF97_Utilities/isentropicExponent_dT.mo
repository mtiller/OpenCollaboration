within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function isentropicExponent_dT
  "isentropic exponent as function of density and temperature"
  extends Modelica.Icons.Function;
  input SI.Density d "density";
  input SI.Temperature T "temperature";
  input Integer phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output Real gamma "isentropic exponent";
algorithm
  gamma := isentropicExponent_props_dT(
    d,
    T,
    waterBaseProp_dT(
      d,
      T,
      phase,
      region));
  annotation (Inline=false, LateInline=true);
end isentropicExponent_dT;
