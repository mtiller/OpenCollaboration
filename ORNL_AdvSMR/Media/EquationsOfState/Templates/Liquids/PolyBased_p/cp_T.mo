within ORNL_AdvSMR.Media.EquationsOfState.Templates.Liquids.PolyBased_p;
function cp_T "Pressure independant specific heat capacity function"
  input Modelica.SIunits.Temperature T "Temperature";
  output Modelica.SIunits.SpecificHeatCapacity cp "Specific heat capacity";
algorithm
  cp := Poly.evaluate(data.polyHeatCapacity, T);
end cp_T;
