within ORNL_AdvSMR.Media.Tests.MediaTestModels.Incompressible;
model Glycol47 "Test Modelica.Media.Incompressible.Examples.Glycol47"
  extends Modelica.Icons.Example;
  extends ORNL_AdvSMR.Media.Tests.Components.PartialTestModel(redeclare package
      Medium = Modelica.Media.Incompressible.Examples.Glycol47 (final
          singleState=true, final enthalpyOfT=true));
  annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.01));
end Glycol47;
