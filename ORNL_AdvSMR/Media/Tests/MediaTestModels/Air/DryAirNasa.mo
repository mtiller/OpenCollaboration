within ORNL_AdvSMR.Media.Tests.MediaTestModels.Air;
model DryAirNasa "Test Modelica.Media.Air.DryAirNasa"
  extends Modelica.Icons.Example;
  extends ORNL_AdvSMR.Media.Tests.Components.PartialTestModel2(redeclare
      package Medium = Modelica.Media.Air.DryAirNasa, fixedMassFlowRate(
        redeclare package Medium = Medium (ThermoStates=Modelica.Media.Interfaces.PartialMedium.Choices.IndependentVariables.dTX)));
  annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
end DryAirNasa;
