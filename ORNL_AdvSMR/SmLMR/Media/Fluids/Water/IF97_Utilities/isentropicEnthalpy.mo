within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function isentropicEnthalpy
  "isentropic specific enthalpy from p,s (preferably use dynamicIsentropicEnthalpy in dynamic simulation!)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  input Integer phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SI.SpecificEnthalpy h "specific enthalpy";
algorithm
  h := isentropicEnthalpy_props(
                p,
                s,
                waterBaseProp_ps(
                  p,
                  s,
                  phase,
                  region));
end isentropicEnthalpy;
