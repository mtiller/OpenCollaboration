within ORNL_AdvSMR.SmLMR.Media.Fluids.Air.MoistAir;
function enthalpyOfWater_der "Derivative function of enthalpyOfWater"
  input SI.Temperature T "Temperature";
  input Real dT(unit="K/s") "Time derivative of temperature";
  output Real dh(unit="J/(kg.s)") "Time derivative of specific enthalpy";
algorithm
  /*simple model assuming constant properties:
  heat capacity of liquid water:4200 J/kg
  heat capacity of solid water: 2050 J/kg
  enthalpy of fusion (liquid=>solid): 333000 J/kg*/

  //h:=Utilities.spliceFunction(4200*(T-273.15),2050*(T-273.15)-333000,T-273.16,0.1);
  dh := Utilities.spliceFunction_der(
    4200*(T - 273.15),
    2050*(T - 273.15) - 333000,
    T - 273.16,
    0.1,
    4200*dT,
    2050*dT,
    dT,
    0);
  annotation (Documentation(info="<html>
Derivative function for <a href=\"modelica://Modelica.Media.Air.MoistAir.enthalpyOfWater\">enthalpyOfWater</a>.

</html>"));
end enthalpyOfWater_der;
