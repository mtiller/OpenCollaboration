within ORNL_AdvSMR.PRISM.CORE.old;
model CylindricalFuelThermalSim2

  inner System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  FuelPellet cylindricalFuelThermalModel(
    radNodes_f=8,
    radNodes_c=4,
    R_f=2.7051e-3,
    H_f=1.1938,
    H_g=1.1938,
    R_c=3.6830e-3,
    H_c=1.1938,
    R_g=3.1242e-3,
    W_Pu=0.26,
    W_Zr=0.10)
    annotation (Placement(transformation(extent={{-55,-25},{-5,25}})));

  Modelica.Blocks.Sources.Constant const(k=10e3)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));

  Components.PipeFlow core(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    rhonom=1950,
    L=0.80,
    H=0.80,
    A=0.623/(19*19),
    omega=Modelica.Constants.pi*6.5e-2,
    Dhyd=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2),
    wnom=1325/(19*19),
    use_HeatTransfer=true,
    hstartin=28.8858e3 + 1.2753e3*(400 + 273),
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer (alpha0=
            5000),
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    hstartout=28.8858e3 + 1.2753e3*(550 + 273),
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    dpnom(displayUnit="kPa") = 1000,
    nNodes=10,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={85,0})));

  Components.SensT coreTi(redeclare package Medium =
        ORNL_AdvSMR.Media.Fluids.Na) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={81,-40})));

  Components.SensT coreTo(redeclare package Medium =
        ORNL_AdvSMR.Media.Fluids.Na) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={81,30})));

  Components.SourceW sourceW(
    h=28.8858e3 + 1.2753e3*(282 + 273),
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    w0=1152.9/(169*271),
    p0=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={85,-75})));

  Components.SinkP sinkP(h=28.8858e3 + 1.2753e3*(426.7 + 273), redeclare
      package Medium = ORNL_AdvSMR.Media.Fluids.Na) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={85,75})));

  Thermal.ConvHT_htc conv(N=10) annotation (Placement(transformation(
        extent={{-50,-12.5},{50,12.5}},
        rotation=270,
        origin={50,0})));

  Thermal.HT_DHT hT_DHT(N=10, exchangeSurface=0.027626)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
equation
  connect(const.y, cylindricalFuelThermalModel.powerIn) annotation (Line(
      points={{-69,0},{-52.5,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(coreTi.outlet, core.infl) annotation (Line(
      points={{85,-34},{85,-15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTo.inlet, core.outfl) annotation (Line(
      points={{85,24},{85,15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sourceW.flange, coreTi.inlet) annotation (Line(
      points={{85,-65},{85,-46}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sinkP.flange, coreTo.outlet) annotation (Line(
      points={{85,65},{85,36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(cylindricalFuelThermalModel.heatOut, hT_DHT.HT_port) annotation (Line(
      points={{-7.5,0},{8,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(hT_DHT.DHT_port, conv.otherside) annotation (Line(
      points={{31,0},{39.75,0},{39.75,6.66134e-016},{46.25,6.66134e-016}},
      color={255,127,0},
      smooth=Smooth.None));

  connect(conv.fluidside, core.wall) annotation (Line(
      points={{53.75,0},{66.5,0},{66.5,-0.075},{77.5,-0.075}},
      color={255,127,0},
      smooth=Smooth.None));
  conv.fluidside.gamma = 50e3*ones(10);
  cylindricalFuelThermalModel.h = sum(conv.fluidside.gamma)/10;

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
end CylindricalFuelThermalSim2;
