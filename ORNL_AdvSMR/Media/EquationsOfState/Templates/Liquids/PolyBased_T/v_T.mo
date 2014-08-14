within ORNL_AdvSMR.Media.EquationsOfState.Templates.Liquids.PolyBased_T;
function v_T "Pressure independant specific volume"
  input Modelica.SIunits.Temperature T "Temperature";
  output Units.SpecificVolume v "Specifc volume";
algorithm
  v := 1/max(Poly.evaluate(data.polyDensity, T), limits.DMIN);
end v_T;
