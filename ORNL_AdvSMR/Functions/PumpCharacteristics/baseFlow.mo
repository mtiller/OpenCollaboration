within ORNL_AdvSMR.Functions.PumpCharacteristics;
partial function baseFlow "Base class for pump flow characteristics"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.VolumeFlowRate q_flow "Volumetric flow rate";
  output Modelica.SIunits.Height head "Pump head";
end baseFlow;
