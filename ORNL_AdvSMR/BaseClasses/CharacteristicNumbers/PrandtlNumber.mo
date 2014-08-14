within ORNL_AdvSMR.BaseClasses.CharacteristicNumbers;
function PrandtlNumber "Return Prandlt number from c_p, mu and k"
  input Modelica.SIunits.SpecificHeatCapacity c_p
    "Fluid specific heat capacity";
  input Modelica.SIunits.DynamicViscosity mu "Dynamic (absolute) viscosity";
  input Modelica.SIunits.ThermalConductivity k "Fluid thermal conductivity";
  output Modelica.SIunits.PrandtlNumber Pr "Prandtl number";
algorithm
  Pr := c_p*mu/k;

end PrandtlNumber;
