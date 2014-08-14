within ORNL_AdvSMR.Media.Common;
record TwoPhaseTransportProps
  "defines properties on both phase boundaries, needed in the two phase region"
  extends Modelica.Icons.Record;
  SI.Density d_vap "density on the dew line";
  SI.Density d_liq "density on the bubble line";
  SI.DynamicViscosity eta_vap "dynamic viscosity on the dew line";
  SI.DynamicViscosity eta_liq "dynamic viscosity on the bubble line";
  SI.ThermalConductivity lam_vap "thermal conductivity on the dew line";
  SI.ThermalConductivity lam_liq "thermal conductivity on the bubble line";
  SI.SpecificHeatCapacity cp_vap "cp on the dew line";
  SI.SpecificHeatCapacity cp_liq "cp on the bubble line";
  SI.MassFraction x "steam quality";
end TwoPhaseTransportProps;
