within ORNL_AdvSMR.SmAHTR.DRACS;
model dRACS5

  dRACS_AirTowers dRACS_AirTowers1
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  Modelica.Fluid.Sources.Boundary_pT airIn(
    nPorts=1,
    use_p_in=false,
    redeclare package Medium = ORNL_SMR.Media.Fluids.Air,
    p=100000,
    T=673.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,70})));
  Modelica.Fluid.Sources.Boundary_pT airOut(
    nPorts=1,
    use_p_in=false,
    redeclare package Medium = ORNL_SMR.Media.Fluids.Air,
    p=100000,
    T=673.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-90,70})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(
      T=973.15)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  inner System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation
  connect(airIn.ports[1], dRACS_AirTowers1.airIn) annotation (Line(
      points={{-60,60},{-60,32},{-40,32}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(airOut.ports[1], dRACS_AirTowers1.airOut) annotation (Line(
      points={{-90,60},{-90,22},{-40,22}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(fixedTemperature.port, dRACS_AirTowers1.airToSaltInterface)
    annotation (Line(
      points={{60,0},{40,0}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1})),
    experiment(StopTime=100, __Dymola_NumberOfIntervals=1000),
    __Dymola_experimentSetupOutput);
end dRACS5;
