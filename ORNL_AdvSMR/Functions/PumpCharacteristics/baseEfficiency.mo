within ORNL_AdvSMR.Functions.PumpCharacteristics;
partial function baseEfficiency "Base class for efficiency characteristics"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.VolumeFlowRate q_flow "Volumetric flow rate";
  output Real eta "Efficiency";
end baseEfficiency;
