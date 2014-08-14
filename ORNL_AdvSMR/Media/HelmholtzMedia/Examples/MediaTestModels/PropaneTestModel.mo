within ORNL_AdvSMR.Media.HelmholtzMedia.Examples.MediaTestModels;
model PropaneTestModel "Test HelmholtzMedia.HelmholtzFluids.Propane"
  extends Modelica.Icons.Example;
  extends Modelica.Media.Examples.Tests.Components.PartialTestModel(redeclare
      package Medium = HelmholtzMedia.HelmholtzFluids.Propane,
      fixedMassFlowRate(use_T_ambient=false));

  annotation (experiment(StopTime=11));

end PropaneTestModel;
