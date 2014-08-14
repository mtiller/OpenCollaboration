within ORNL_AdvSMR.Media.Tests.MediaTestModels.LiFBeF2;
model LiFBeF2_ph "Test ORNL_AdvSMR.Media.Fluids.LiFBeF2"
  extends Modelica.Icons.Example;
  extends ORNL_AdvSMR.Media.Tests.Components.PartialTestModel(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.LiFBeF2.flibe_ph,
    ambient(use_T_ambient=false, h_ambient=112570),
    fixedMassFlowRate(use_T_ambient=false, h_ambient=363755));

  annotation (Documentation(info="<html>
</html>"), experiment(StopTime=1.01));
end LiFBeF2_ph;
