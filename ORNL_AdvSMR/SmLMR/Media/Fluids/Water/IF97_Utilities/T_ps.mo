within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function T_ps "temperature as function of pressure and specific entropy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  input Integer phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SI.Temperature T "Temperature";
algorithm
  T := T_props_ps(
                p,
                s,
                waterBaseProp_ps(
                  p,
                  s,
                  phase,
                  region));
end T_ps;
