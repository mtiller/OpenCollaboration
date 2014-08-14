within ORNL_AdvSMR.Functions.PumpCharacteristics;
partial function basePower
  "Base class for pump power consumption characteristics"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.VolumeFlowRate q_flow "Volumetric flow rate";
  output Modelica.SIunits.Power consumption
    "Power consumption at nominal density";
end basePower;
