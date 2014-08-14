within ORNL_AdvSMR.PRISM.PowerConversionSystem.Tests;
model SteamTurbine3Stages

  ThermoPower3.PowerPlants.SteamTurbineGroup.Examples.ST3L_bypass sT3L_bypass
    annotation (Placement(transformation(extent={{-60,-60},{60,60}})));
  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end SteamTurbine3Stages;
