within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function p_dT "pressure as function of density and temperature"
  extends Modelica.Icons.Function;
  input SI.Density d "density";
  input SI.Temperature T "Temperature";
  input Integer phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SI.Pressure p "pressure";
algorithm
  p := p_props_dT(
                d,
                T,
                waterBaseProp_dT(
                  d,
                  T,
                  phase,
                  region));
end p_dT;
