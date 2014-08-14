within ORNL_AdvSMR.Media.Interfaces.Types;
record TwoPhaseTransportProps
  "defines properties on both phase boundaries, needed in the two phase region"
  extends Modelica.Icons.Record;
  Modelica.SIunits.Density d_vap "density on the dew line";
  Modelica.SIunits.Density d_liq "density on the bubble line";
  Modelica.SIunits.DynamicViscosity eta_vap "dynamic viscosity on the dew line";
  Modelica.SIunits.DynamicViscosity eta_liq
    "dynamic viscosity on the bubble line";
  Modelica.SIunits.ThermalConductivity lam_vap
    "thermal conductivity on the dew line";
  Modelica.SIunits.ThermalConductivity lam_liq
    "thermal conductivity on the bubble line";
  Modelica.SIunits.SpecificHeatCapacity cp_vap "cp on the dew line";
  Modelica.SIunits.SpecificHeatCapacity cp_liq "cp on the bubble line";
  Modelica.SIunits.MassFraction x "steam quality";
end TwoPhaseTransportProps;
