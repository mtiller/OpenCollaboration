within ORNL_AdvSMR.PRISM.CORE;
model CylindricalFuelPellet_wDHTSim "With conduction only..."

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

  Modelica.Blocks.Sources.Constant const(k=4e5)
    annotation (Placement(transformation(extent={{-90,-7.5},{-75,7.5}})));

  Thermal.ConvHT_htc convec(N=N) annotation (Placement(transformation(
        extent={{-35,-10.25},{35,10.25}},
        rotation=270,
        origin={35.25,0})));

  Thermal.TempSource1D tempSource1D1(redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
      N=N) annotation (Placement(transformation(
        extent={{-20,10},{20,-10}},
        rotation=90,
        origin={55,0})));

  Modelica.Blocks.Sources.Ramp ramp1(
    duration=1,
    startTime=1000,
    height=0,
    offset=400 + 273.15)
    annotation (Placement(transformation(extent={{90,-7.5},{75,7.5}})));

  Modelica.Blocks.Sources.Ramp ramp2(
    duration=1,
    startTime=500,
    height=1e3,
    offset=2e4)
    annotation (Placement(transformation(extent={{80,-80},{65,-65}})));
equation
  connect(const.y, fuelPellet.powerIn) annotation (Line(
      points={{-74.25,0},{-57.5,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(convec.fluidside, tempSource1D1.wall) annotation (Line(
      points={{38.325,-5.55112e-016},{47.9125,-5.55112e-016},{47.9125,0},{52,0}},

      color={255,127,0},
      smooth=Smooth.None));

  connect(ramp1.y, tempSource1D1.temperature) annotation (Line(
      points={{74.25,0},{59,0}},
      color={0,0,127},
      smooth=Smooth.None));
  convec.fluidside.gamma = ramp2.y*ones(N);
  fuelPellet.T_cool = sum(convec.fluidside.T)/N;
  fuelPellet.h = sum(convec.fluidside.gamma)/N;
  // convec.otherside.phi = - cylFuelPellet.wall.phi*ones(N);
  // convec.otherside.T = -cylFuelPellet.wall.T * ones(N);

  connect(fuelPellet.wall, convec.otherside) annotation (Line(
      points={{-12.5,0},{9.5,0},{9.5,5.55112e-016},{32.175,5.55112e-016}},
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
end CylindricalFuelPellet_wDHTSim;
