within ORNL_AdvSMR.Media.Tests.MediaTestModels.LinearFluid;
model LinearColdWater "Test Modelica.Media.Incompressible.Examples.Glycol47"
  extends Modelica.Icons.Example;
  extends ORNL_AdvSMR.Media.Tests.Components.PartialTestModel(redeclare package
      Medium = Modelica.Media.CompressibleLiquids.LinearColdWater);
  annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
end LinearColdWater;
