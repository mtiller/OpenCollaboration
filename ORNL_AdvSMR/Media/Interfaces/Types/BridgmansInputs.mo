within ORNL_AdvSMR.Media.Interfaces.Types;
record BridgmansInputs "Input variables to Bridgmans table"
  extends Modelica.Icons.Record;
  Modelica.SIunits.SpecificVolume v "specific volume";
  Modelica.SIunits.Pressure p "pressure";
  Modelica.SIunits.Temperature T "temperature";
  Modelica.SIunits.SpecificEntropy s "specific entropy";
  Modelica.SIunits.SpecificHeatCapacity cp "heat capacity at constant pressure";
  Units.VolumetricExpansionCoefficient beta
    "isobaric volume expansion coefficient";
  Units.IsothermalCompressibility kappa "isothermal compressibility";
end BridgmansInputs;
