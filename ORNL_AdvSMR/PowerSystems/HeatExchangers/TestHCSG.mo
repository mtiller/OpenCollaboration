within ORNL_AdvSMR.PowerSystems.HeatExchangers;
model TestHCSG "Test simulation for the Helical Coil Steam Generator model"
  import aSMR = ORNL_AdvSMR;
  ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator.HelicalCoilSteamGenerator
    helicalCoilSteamGenerator
    annotation (Placement(transformation(extent={{-80,-80},{80,80}})));
  ORNL_AdvSMR.Components.SourceP sourceP
    annotation (Placement(transformation(extent={{-100,22},{-80,42}})));
  ORNL_AdvSMR.Components.SourceP sourceP1
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  ORNL_AdvSMR.Components.SinkP sinkP
    annotation (Placement(transformation(extent={{80,-38},{100,-18}})));
  ORNL_AdvSMR.Components.SinkP sinkP1
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  inner ORNL_AdvSMR.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(sourceP.flange, helicalCoilSteamGenerator.shellIn) annotation (Line(
      points={{-80,32},{-60,32}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sourceP1.flange, helicalCoilSteamGenerator.tubeIn) annotation (Line(
      points={{-20,-90},{0,-90},{0,-80}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(helicalCoilSteamGenerator.shellOut, sinkP.flange) annotation (Line(
      points={{60,-28},{80,-28}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sinkP1.flange, helicalCoilSteamGenerator.tubeOut) annotation (Line(
      points={{20,90},{0,90},{0,80}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics), Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5})));
end TestHCSG;
