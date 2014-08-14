within ORNL_AdvSMR.SmAHTR.CORE;
model End2EndwHRSG2

  replaceable package Medium = ThermoPower3.Media.FlueGas annotation (
      __Dymola_choicesAllMatching=true);

  ReactorCoreBlock reactorCoreBlock(redeclare replaceable package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-80,-40},{0,40}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=50,
    offset=0,
    startTime=500,
    height=1)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  inner ORNL_AdvSMR.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  SteamPlant_Sim1_dp steamPlant_Sim1_dp
    annotation (Placement(transformation(extent={{0,-40},{80,40}})));
  ThermoPower3.Gas.ValveLin valveLin
    annotation (Placement(transformation(extent={{0,-76},{-20,-56}})));
  ThermoPower3.Gas.Compressor compressor
    annotation (Placement(transformation(extent={{36,-84},{16,-64}})));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque
    annotation (Placement(transformation(extent={{41,-102},{61,-82}})));
  Modelica.Blocks.Continuous.PID PID
    annotation (Placement(transformation(extent={{-75,-70},{-55,-50}})));
equation
  connect(ramp.y, reactorCoreBlock.rho_CR) annotation (Line(
      points={{-79,0},{-60,0}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(steamPlant_Sim1_dp.flangeA, reactorCoreBlock.flangeB)
    annotation (Line(
      points={{0,0},{-10,0},{-10,60},{-40,60},{-40,40}},
      color={159,159,223},
      thickness=1,
      smooth=Smooth.None));
  connect(constantTorque.flange, compressor.shaft_a) annotation (Line(
      points={{61,-92},{70,-92},{70,-74},{32,-74}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(valveLin.inlet, compressor.outlet) annotation (Line(
      points={{0,-66},{18,-66}},
      color={159,159,223},
      smooth=Smooth.None,
      thickness=1));
  connect(steamPlant_Sim1_dp.flangeB, compressor.inlet) annotation (Line(
      points={{80,0},{90,0},{90,-66},{34,-66}},
      color={159,159,223},
      smooth=Smooth.None,
      thickness=1));
  connect(valveLin.outlet, reactorCoreBlock.flangeA) annotation (Line(
      points={{-20,-66},{-40,-66},{-40,-40}},
      color={159,159,223},
      smooth=Smooth.None,
      thickness=1));
  connect(PID.y, valveLin.cmd) annotation (Line(
      points={{-54,-60},{-32,-60},{-32,-52},{-10,-52},{-10,-59}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1})),
    experiment(
      StopTime=1000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Sdirk34hw"),
    __Dymola_experimentSetupOutput);
end End2EndwHRSG2;
