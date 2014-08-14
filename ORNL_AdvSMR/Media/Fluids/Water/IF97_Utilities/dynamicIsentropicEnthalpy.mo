within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function dynamicIsentropicEnthalpy
  "isentropic specific enthalpy from p,s and good guesses of d and T"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  input SI.Density dguess "good guess density, e.g., from adjacent volume";
  input SI.Temperature Tguess
    "good guess temperature, e.g., from adjacent volume";
  input Integer phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output SI.SpecificEnthalpy h "specific enthalpy";
algorithm
  h := BaseIF97.Isentropic.water_hisentropic_dyn(
    p,
    s,
    dguess,
    Tguess,
    0);
end dynamicIsentropicEnthalpy;
