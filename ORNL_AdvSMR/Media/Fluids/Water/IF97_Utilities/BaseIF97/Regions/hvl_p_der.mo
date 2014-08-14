within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function hvl_p_der
  "derivative function for the specific enthalpy along the phase boundary"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input Common.IF97PhaseBoundaryProperties bpro "property record";
  input Real p_der "derivative of pressure";
  output Real h_der
    "time derivative of specific enthalpy along the phase boundary";
algorithm
  if bpro.region3boundary then
    h_der := ((bpro.d*bpro.pd - bpro.T*bpro.pt)*p_der + (bpro.T*bpro.pt*bpro.pt
       + bpro.d*bpro.d*bpro.pd*bpro.cv)/bpro.dpT*p_der)/(bpro.pd*bpro.d*bpro.d);
  else
    h_der := (1/bpro.d - bpro.T*bpro.vt)*p_der + bpro.cp/bpro.dpT*p_der;
  end if;
end hvl_p_der;
