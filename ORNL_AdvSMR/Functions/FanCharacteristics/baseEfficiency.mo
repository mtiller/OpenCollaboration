within ORNL_AdvSMR.Functions.FanCharacteristics;
partial function baseEfficiency "Base class for efficiency characteristics"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.VolumeFlowRate q_flow "Volumetric flow rate";
  input Real bladePos=1 "Blade position";
  output Real eta "Efficiency";
end baseEfficiency;
