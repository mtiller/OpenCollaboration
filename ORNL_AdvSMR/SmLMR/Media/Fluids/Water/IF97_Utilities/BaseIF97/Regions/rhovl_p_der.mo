within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function rhovl_p_der
  extends Modelica.Icons.Function;
  input SI.Pressure p "saturation pressure";
  input Common.IF97PhaseBoundaryProperties bpro "property record";
  input Real p_der "derivative of pressure";
  output Real d_der "time derivative of density along the phase boundary";
algorithm
  d_der := if bpro.region3boundary then (p_der - bpro.pt*p_der/
    bpro.dpT)/bpro.pd else -bpro.d*bpro.d*(bpro.vp + bpro.vt/
    bpro.dpT)*p_der;
end rhovl_p_der;
