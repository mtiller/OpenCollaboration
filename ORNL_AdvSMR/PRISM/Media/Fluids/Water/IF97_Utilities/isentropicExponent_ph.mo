within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities;
function isentropicExponent_ph
  "isentropic exponent as function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Integer phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output Real gamma "isentropic exponent";
algorithm
  gamma := isentropicExponent_props_ph(
    p,
    h,
    waterBaseProp_ph(
      p,
      h,
      phase,
      region));
  annotation (Inline=false, LateInline=true);
end isentropicExponent_ph;
