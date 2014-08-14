within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function hvl_dp
  "derivative function for the specific enthalpy along the phase boundary"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input Common.IF97PhaseBoundaryProperties bpro "property record";
  output Real dh_dp "derivative of specific enthalpy along the phase boundary";
algorithm
  if bpro.region3boundary then
    dh_dp := ((bpro.d*bpro.pd - bpro.T*bpro.pt) + (bpro.T*bpro.pt
      *bpro.pt + bpro.d*bpro.d*bpro.pd*bpro.cv)/bpro.dpT)/(bpro.pd
      *bpro.d*bpro.d);
  else
    dh_dp := (1/bpro.d - bpro.T*bpro.vt) + bpro.cp/bpro.dpT;
  end if;
end hvl_dp;
