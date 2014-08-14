within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function h_pT "specific enthalpy as function or pressure and temperature"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "Temperature";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SI.SpecificEnthalpy h "specific enthalpy";
algorithm
  h := h_props_pT(
                p,
                T,
                waterBaseProp_pT(
                  p,
                  T,
                  region));
end h_pT;
