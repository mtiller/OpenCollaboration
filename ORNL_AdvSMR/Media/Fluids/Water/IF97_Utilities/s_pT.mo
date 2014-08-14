within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function s_pT "temperature as function of pressure and temperature"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SI.SpecificEntropy s "specific entropy";
algorithm
  s := s_props_pT(
    p,
    T,
    waterBaseProp_pT(
      p,
      T,
      region));
  annotation (InlineNoEvent=false);
end s_pT;
