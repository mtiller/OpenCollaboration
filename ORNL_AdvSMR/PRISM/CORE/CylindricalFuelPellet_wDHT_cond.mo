within ORNL_AdvSMR.PRISM.CORE;
model CylindricalFuelPellet_wDHT_cond

  parameter Integer N=2;

  FuelPellet_wDHT fuelPellet(
    radNodes_f=8,
    radNodes_c=4,
    R_f=2.7051e-3,
    H_f=1.1938,
    R_g=3.1242e-3,
    H_g=1.1938,
    R_c=3.6830e-3,
    H_c=1.1938,
    W_Pu=0.26,
    W_Zr=0.10,
    redeclare ORNL_AdvSMR.Interfaces.DHT wall)
    annotation (Placement(transformation(extent={{-60,-25},{-10,25}})));

  Modelica.Blocks.Sources.Constant const(k=9.2797e+04)
    annotation (Placement(transformation(extent={{-90,-7.5},{-75,7.5}})));

  Thermal.TempSource1D tempSource1D1(N=N) annotation (Placement(transformation(
        extent={{-20,10},{20,-10}},
        rotation=90,
        origin={55,0})));

  Modelica.Blocks.Sources.Ramp ramp1(
    duration=1,
    startTime=1000,
    height=0,
    offset=600 + 273.15)
    annotation (Placement(transformation(extent={{90,-7.5},{75,7.5}})));

  Modelica.Blocks.Sources.Ramp ramp2(
    duration=1,
    startTime=500,
    height=1e3,
    offset=1e4)
    annotation (Placement(transformation(extent={{80,-80},{65,-65}})));
equation
  connect(const.y, fuelPellet.powerIn) annotation (Line(
      points={{-74.25,0},{-57.5,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp1.y, tempSource1D1.temperature) annotation (Line(
      points={{74.25,0},{59,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tempSource1D1.wall, fuelPellet.wall) annotation (Line(
      points={{52,1.66533e-016},{21.5,1.66533e-016},{21.5,0},{-12.5,0}},
      color={255,127,0},
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
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end CylindricalFuelPellet_wDHT_cond;
