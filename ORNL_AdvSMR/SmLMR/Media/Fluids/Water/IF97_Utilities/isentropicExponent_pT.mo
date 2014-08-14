within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function isentropicExponent_pT
  "isentropic exponent as function of pressure and temperature"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output Real gamma "isentropic exponent";
algorithm
  gamma := isentropicExponent_props_pT(
                p,
                T,
                waterBaseProp_pT(
                  p,
                  T,
                  region));
  annotation (Inline=false, LateInline=true);
end isentropicExponent_pT;
