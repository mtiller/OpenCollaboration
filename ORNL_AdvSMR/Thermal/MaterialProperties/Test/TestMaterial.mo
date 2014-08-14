within ORNL_AdvSMR.Thermal.MaterialProperties.Test;
model TestMaterial
  import Modelica.SIunits.*;
  replaceable Metals.CarbonSteel_A106C Material(npol=3) constrainedby
    Interfaces.PartialMaterial "Material model";
  Temp_K T;
  Temp_C T_C;
  Stress E;
equation
  T_C = 21 + 500*time;
  T = Modelica.SIunits.Conversions.from_degC(T_C);
  Material.T = T;
  E = Material.yieldStress;
end TestMaterial;
