within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities;
function cp_pT
  "specific heat capacity at constant pressure as function of pressure and temperature"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SI.SpecificHeatCapacity cp "specific heat capacity";
algorithm
  cp := cp_props_pT(
    p,
    T,
    waterBaseProp_pT(
      p,
      T,
      region));
  annotation (InlineNoEvent=false);
end cp_pT;
