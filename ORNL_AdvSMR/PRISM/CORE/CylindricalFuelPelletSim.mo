within ORNL_AdvSMR.PRISM.CORE;
model CylindricalFuelPelletSim

  parameter Integer N=1;

  FuelPellet fp(
    R_f=2.7051e-3,
    R_g=3.1242e-3,
    R_c=3.6830e-3,
    W_Pu=0.26,
    W_Zr=0.10,
    redeclare ORNL_AdvSMR.Thermal.HT wall,
    radNodes_c=4,
    radNodes_f=8,
    H_f=5.04,
    H_g=5.04,
    H_c=5.04)
    annotation (Placement(transformation(extent={{-60,-25},{-10,25}})));

  Modelica.Blocks.Sources.Constant const(k=1e6)
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
    offset=450 + 273.15)
    annotation (Placement(transformation(extent={{90,-7.5},{75,7.5}})));

  Thermal.HT_DHT hT_DHT(N=N, exchangeSurface=0.0085*5.04)
    annotation (Placement(transformation(extent={{5,-5},{15,5}})));

  Modelica.Blocks.Sources.Ramp ramp2(
    duration=1,
    offset=1e4,
    startTime=500,
    height=1e4)
    annotation (Placement(transformation(extent={{80,-80},{65,-65}})));
equation
  connect(const.y, fp.powerIn) annotation (Line(
      points={{-74.25,0},{-57.5,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hT_DHT.DHT_port, convec.otherside) annotation (Line(
      points={{15.5,0},{32.175,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(convec.fluidside, tempSource1D1.wall) annotation (Line(
      points={{38.325,-5.55112e-016},{47.9125,-5.55112e-016},{47.9125,0},{52,0}},

      color={255,127,0},
      smooth=Smooth.None));

  connect(ramp1.y, tempSource1D1.temperature) annotation (Line(
      points={{74.25,0},{59,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fp.wall, hT_DHT.HT_port) annotation (Line(
      points={{-12.5,0},{4,0}},
      color={191,0,0},
      smooth=Smooth.None));
  convec.fluidside.gamma = ramp2.y*ones(N);
  fp.T_cool = sum(convec.fluidside.T)/N;
  fp.h = sum(convec.fluidside.gamma)/N;
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
end CylindricalFuelPelletSim;
