within ORNL_AdvSMR.SmAHTR.CORE;
model ReactorKineticsSim

  ReactorKinetics reactorKinetics(
    Q_nom=250e6,
    noAxialNodes=9,
    alpha_f=-3.80e-3,
    T_f0=1473.15,
    T_c0=948.15)
    annotation (Placement(transformation(extent={{-50,-50},{50,50}})));
  Modelica.Blocks.Sources.Trapezoid rho_CR(
    startTime=50,
    falling=50,
    nperiod=1,
    period=1000,
    rising=1,
    offset=0,
    amplitude=-3,
    width=1000)
    annotation (Placement(transformation(extent={{-80,-7.5},{-65,7.5}})));
  Modelica.Blocks.Sources.Constant T_c(k=675 + 273.15)
    annotation (Placement(transformation(extent={{-55,-90},{-40,-75}})));
  Modelica.Blocks.Sources.Constant T_f0(k=1200 + 273.15)
    annotation (Placement(transformation(extent={{10,-90},{25,-75}})));
equation
  connect(rho_CR.y, reactorKinetics.rho_CR) annotation (Line(
      points={{-64.25,0},{-50,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_c.y, reactorKinetics.T_ce) annotation (Line(
      points={{-39.25,-82.5},{-30,-82.5},{-30,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_f0.y, reactorKinetics.T_fe) annotation (Line(
      points={{25.75,-82.5},{30,-82.5},{30,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5})),
    experiment(
      StopTime=1000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput);
end ReactorKineticsSim;
