within ORNL_AdvSMR.PRISM.Media.Common;
record SaturationProperties "properties in the two phase region"
  extends Modelica.Icons.Record;
  SI.Temp_K T "temperature";
  SI.Density d "density";
  SI.Pressure p "pressure";
  SI.SpecificEnergy u "specific inner energy";
  SI.SpecificEnthalpy h "specific enthalpy";
  SI.SpecificEntropy s "specific entropy";
  SI.SpecificHeatCapacity cp "heat capacity at constant pressure";
  SI.SpecificHeatCapacity cv "heat capacity at constant volume";
  SI.SpecificHeatCapacity R "gas constant";
  SI.RatioOfSpecificHeatCapacities kappa "isentropic expansion coefficient";
  PhaseBoundaryProperties liq
    "thermodynamic base properties on the boiling curve";
  PhaseBoundaryProperties vap "thermodynamic base properties on the dew curve";
  Real dpT(unit="Pa/K") "derivative of saturation pressure w.r.t. temperature";
  SI.MassFraction x "vapour mass fraction";
end SaturationProperties;
