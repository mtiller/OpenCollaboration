within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities;
function cv_pT
  "specific heat capacity at constant volume as function of pressure and temperature"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SI.SpecificHeatCapacity cv "specific heat capacity";
algorithm
  cv := cv_props_pT(
    p,
    T,
    waterBaseProp_pT(
      p,
      T,
      region));
  annotation (InlineNoEvent=false);
end cv_pT;
