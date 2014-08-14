within ORNL_AdvSMR.Functions.FanCharacteristics;
partial function baseFlow "Base class for fan flow characteristics"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.VolumeFlowRate q_flow "Volumetric flow rate";
  input Real bladePos=1 "Blade position";
  output Modelica.SIunits.SpecificEnergy H "Specific Energy";
end baseFlow;
