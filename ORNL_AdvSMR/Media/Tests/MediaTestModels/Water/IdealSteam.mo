within ORNL_AdvSMR.Media.Tests.MediaTestModels.Water;
model IdealSteam "Test Modelica.Media.Water.IdealSteam"
  extends Modelica.Icons.Example;
  extends ORNL_AdvSMR.Media.Tests.Components.PartialTestModel(redeclare package
      Medium = Modelica.Media.Water.IdealSteam);
  annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
end IdealSteam;
