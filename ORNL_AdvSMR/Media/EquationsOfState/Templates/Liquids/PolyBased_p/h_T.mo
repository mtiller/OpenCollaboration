within ORNL_AdvSMR.Media.EquationsOfState.Templates.Liquids.PolyBased_p;
function h_T "Pressure independant enthalpy function"
  input Units.Temperature T "Temperature";
  output Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
algorithm
  h := data.reference_h + Poly.integralValue(
    data.polyHeatCapacity,
    T,
    T0);
end h_T;
