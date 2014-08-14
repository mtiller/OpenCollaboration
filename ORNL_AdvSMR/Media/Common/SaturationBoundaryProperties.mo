within ORNL_AdvSMR.Media.Common;
record SaturationBoundaryProperties
  "properties on both phase boundaries, including some derivatives"

  extends Modelica.Icons.Record;
  SI.Temp_K T "Saturation temperature";
  SI.Density dl "Liquid density";
  SI.Density dv "Vapour density";
  SI.SpecificEnthalpy hl "Liquid specific enthalpy";
  SI.SpecificEnthalpy hv "Vapour specific enthalpy";
  Real dTp "derivative of temperature w.r.t. saturation pressure";
  Real ddldp "derivative of density along boiling curve";
  Real ddvdp "derivative of density along dew curve";
  Real dhldp "derivative of specific enthalpy along boiling curve";
  Real dhvdp "derivative of specific enthalpy along dew curve";
  SI.MassFraction x "vapour mass fraction";
end SaturationBoundaryProperties;
