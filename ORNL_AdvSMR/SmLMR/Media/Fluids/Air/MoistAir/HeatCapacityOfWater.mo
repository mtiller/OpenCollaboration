within ORNL_AdvSMR.SmLMR.Media.Fluids.Air.MoistAir;
function HeatCapacityOfWater
  "Return specific heat capacity of water (liquid only) as a function of temperature T"
  extends Modelica.Icons.Function;
  input Temperature T "Temperature";
  output SpecificHeatCapacity cp_fl "Specific heat capacity of liquid";
algorithm
  cp_fl := 1e3*(4.2166 - (T - 273.15)*(0.0033166 + (T - 273.15)*(0.00010295 - (
    T - 273.15)*(1.3819e-6 + (T - 273.15)*7.3221e-9))));
  annotation (Documentation(info="<html>
The specific heat capacity of water (liquid and solid) is calculated using a
                 polynomial approach and data from VDI-Waermeatlas 8. Edition (Db1)
</html>"), smoothOrder=2);
end HeatCapacityOfWater;
