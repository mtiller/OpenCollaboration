within ORNL_AdvSMR.PRISM.CORE.old;
model CylindricalFuelThermalSim_wFlow

  FuelPellet cylindricalFuelThermalModel(
    rho_c=6.5e3,
    cp_c=330,
    radNodes_f=8,
    radNodes_c=4,
    k_c=13.85,
    R_f=2.7051e-3,
    H_f=1.1938,
    H_g=1.1938,
    R_c=3.6830e-3,
    H_c=1.1938,
    rho_f=6.5e3,
    cp_f=330,
    k_f=13.85,
    R_g=3.1242e-3,
    rho_g=850,
    cp_g=1277,
    k_g=68,
    h=10000) annotation (Placement(transformation(extent={{-55,-25},{-5,25}})));
  Modelica.Blocks.Sources.Constant const(k=5e3)
    annotation (Placement(transformation(extent={{-95,-10},{-75,10}})));

  Components.ChannelFlow2 core(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    rhonom=1950,
    dpnom(displayUnit="kPa") = 1,
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
    hstartout=28.8858e3 + 1.2753e3*(550 + 273),
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    nNodes=3,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={30,0})));
  Components.Pump primaryPump(
    wstart=0.7663,
    n0=1000,
    rho0=950,
    dp0(displayUnit="kPa") = 15000,
    hstart=28.8858e3 + 1.2753e3*(400 + 273),
    Np0=1,
    w0=20,
    redeclare function flowCharacteristic =
        ORNL_AdvSMR.Functions.PumpCharacteristics.linearFlow (q_nom={1e-3,1e-1},
          head_nom={5,5}),
    usePowerCharacteristic=false,
    redeclare function efficiencyCharacteristic =
        ORNL_AdvSMR.Functions.PumpCharacteristics.constantEfficiency (eta_nom=
            0.95),
    V=0.1,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na) annotation (
      Placement(transformation(extent={{60,-95},{40,-75}}, rotation=0)));
  Components.SensT coreTi(redeclare package Medium =
        ORNL_AdvSMR.Media.Fluids.Na) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={26,-40})));
  Components.SourceW sourceW(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    w0=1126.4,
    h=28.8858e3 + 1.2753e3*(319 + 273),
    p0=100000) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={85,-83})));
  Components.SinkP sinkP(redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=28.8858e3 + 1.2753e3*(468 + 273)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,60})));
  inner System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(const.y, cylindricalFuelThermalModel.powerIn) annotation (Line(
      points={{-74,0},{-52.5,0}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(coreTi.outlet, core.infl) annotation (Line(
      points={{30,-34},{30,-15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTi.inlet, primaryPump.outfl) annotation (Line(
      points={{30,-46},{30,-78},{44,-78}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(cylindricalFuelThermalModel.heatOut, core.wall[2]) annotation (Line(
      points={{-7.5,0},{24,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sourceW.flange, primaryPump.infl) annotation (Line(
      points={{75,-83},{58,-83}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sinkP.flange, core.outfl) annotation (Line(
      points={{30,50},{30,15}},
      color={0,127,255},
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
end CylindricalFuelThermalSim_wFlow;
