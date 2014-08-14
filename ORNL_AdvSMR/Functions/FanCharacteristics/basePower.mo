within ORNL_AdvSMR.Functions.FanCharacteristics;
partial function basePower
  "Base class for fan power consumption characteristics"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.VolumeFlowRate q_flow "Volumetric flow rate";
  input Real bladePos=1 "Blade position";
  output Modelica.SIunits.Power consumption "Power consumption";
end basePower;
