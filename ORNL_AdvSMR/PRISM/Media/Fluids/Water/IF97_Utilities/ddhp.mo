within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities;
function ddhp "density derivative by specific enthalpy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Integer phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SI.DerDensityByEnthalpy ddhp "density derivative by specific enthalpy";
algorithm
  ddhp := ddhp_props(
    p,
    h,
    waterBaseProp_ph(
      p,
      h,
      phase,
      region));
end ddhp;
