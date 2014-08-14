within ORNL_AdvSMR.Media.Interfaces.Types;
record CriticalConstants "Critical point data"
  extends Modelica.Icons.Record;
  Units.Density d "Critical density";
  Units.Temperature T "Critical temperature";
  Units.AbsolutePressure p "Critical pressure";
  Units.SpecificEnthalpy h "Critical specific enthalpy";
  Units.SpecificEntropy s "Critical specific entropy";
  annotation (defaultComponentName="crit");
end CriticalConstants;
