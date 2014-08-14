within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function drhovl_dp
  extends Modelica.Icons.Function;
  input SI.Pressure p "saturation pressure";
  input Common.IF97PhaseBoundaryProperties bpro "property record";
  output Real dd_dp(unit="kg/(m3.Pa)")
    "derivative of density along the phase boundary";
algorithm
  dd_dp := if bpro.region3boundary then (1.0 - bpro.pt/bpro.dpT)
    /bpro.pd else -bpro.d*bpro.d*(bpro.vp + bpro.vt/bpro.dpT);
end drhovl_dp;
