within ORNL_AdvSMR.Media.Tests.MediaTestModels.KFZrF4;
model KFZrF4_ph "Test ORNL_AdvSMR.Media.Fluids.KFZrF4.KFZrF4_ph"
  extends Modelica.Icons.Example;
  extends ORNL_AdvSMR.Media.Tests.Components.PartialTestModel(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.KFZrF4.zrkf,
    ambient(use_T_ambient=false, h_ambient=112570),
    fixedMassFlowRate(use_T_ambient=false, h_ambient=363755));
  annotation (Documentation(info="<html>
</html>"), experiment(StopTime=1.01));
end KFZrF4_ph;
