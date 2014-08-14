within ORNL_AdvSMR.Media.Fluids.Simple_Air_Models.MoistAir;
function enthalpyOfWater
  "Computes specific enthalpy of water (solid/liquid) near atmospheric pressure from temperature T"
  input SI.Temperature T "Temperature";
  output SI.SpecificEnthalpy h "Specific enthalpy of water";
algorithm
  /*simple model assuming constant properties:
  heat capacity of liquid water:4200 J/kg
  heat capacity of solid water: 2050 J/kg
  enthalpy of fusion (liquid=>solid): 333000 J/kg*/

  h := Utilities.spliceFunction(
    4200*(T - 273.15),
    2050*(T - 273.15) - 333000,
    T - 273.16,
    0.1);
  annotation (derivative=enthalpyOfWater_der, Documentation(info="<html>
Specific enthalpy of water (liquid and solid) is computed from temperature using constant properties as follows:<br>
<ul>
<li>  heat capacity of liquid water:4200 J/kg
<li>  heat capacity of solid water: 2050 J/kg
<li>  enthalpy of fusion (liquid=>solid): 333000 J/kg
</ul>
Pressure is assumed to be around 1 bar. This function is usually used to determine the specific enthalpy of the liquid or solid fraction of moist air.
</html>"));
end enthalpyOfWater;
