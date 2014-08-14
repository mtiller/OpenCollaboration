within ORNL_AdvSMR.Media.Tests.MediaTestModels.Incompressible;
model Essotherm650 "Test Modelica.Media.Incompressible.Examples.Essotherm65"
  extends Modelica.Icons.Example;
  extends ORNL_AdvSMR.Media.Tests.Components.PartialTestModel(redeclare package
      Medium = Modelica.Media.Incompressible.Examples.Essotherm650);
  annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
end Essotherm650;
