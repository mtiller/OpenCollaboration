within ORNL_AdvSMR.PRISM.DRACS;
model dRACS
  import aSMR = ORNL_AdvSMR;

  ORNL_AdvSMR.Components.PipeFlow flow1D(
    L=4,
    H=4,
    A=Modelica.Constants.pi*50e-3^2/4,
    omega=Modelica.Constants.pi*50e-3,
    Dhyd=50e-3,
    wnom=10,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    hstartin=5e4,
    hstartout=6e4,
    Kfnom=1000,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    nNodes=3,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    dpnom=100000,
    pstart=6000000) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,0})));
  ORNL_AdvSMR.Components.PipeFlow flow1D1(
    H=0,
    L=1,
    A=Modelica.Constants.pi*25e-3^2/4,
    omega=Modelica.Constants.pi*25e-3,
    wnom=10,
    Dhyd=25e-3,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    hstartin=5e4,
    hstartout=6e4,
    Kfnom=1000,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    nNodes=3,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    dpnom=100000,
    pstart=6000000) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={0,50})));
  ThermoPower3.Thermal.TempSource1D tempSource1D(N=3) annotation (Placement(
        transformation(
        extent={{-10.25,-10},{10.25,10}},
        rotation=180,
        origin={0.25,-75})));
  Modelica.Blocks.Sources.Constant saltTemp(k=600)
    annotation (Placement(transformation(extent={{-20,-90},{-10,-80}})));
  ThermoPower3.Thermal.TempSource1D tempSource1D1(N=3)
    annotation (Placement(transformation(extent={{-10.5,65},{10,85}})));
  Modelica.Blocks.Sources.Constant airTemp(k=20)
    annotation (Placement(transformation(extent={{-20,80},{-10,90}})));
  ORNL_AdvSMR.Components.PipeFlow flow1D2(
    L=4,
    A=Modelica.Constants.pi*50e-3^2/4,
    omega=Modelica.Constants.pi*50e-3,
    Dhyd=50e-3,
    wnom=10,
    H=-4,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    hstartin=5e4,
    hstartout=6e4,
    Kfnom=1000,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    nNodes=3,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    dpnom=100000,
    pstart=6000000) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={40,0})));
  ORNL_AdvSMR.Components.PipeFlow flow1D3(
    H=0,
    L=1,
    A=Modelica.Constants.pi*25e-3^2/4,
    omega=Modelica.Constants.pi*25e-3,
    wnom=10,
    Dhyd=25e-3,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    hstartin=5e4,
    hstartout=6e4,
    Kfnom=1000,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    nNodes=3,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    dpnom=100000,
    pstart=6000000) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={0,-50})));
  ThermoPower3.Thermal.HeatSource1D insulation(
    omega=Modelica.Constants.pi*50e-3,
    L=4,
    N=3) annotation (Placement(transformation(
        extent={{-10.25,-10},{10.25,10}},
        rotation=90,
        origin={-70,-0.25})));
  ThermoPower3.Thermal.HeatSource1D heatSource1D1(
    L=4,
    omega=Modelica.Constants.pi*50e-3,
    N=3) annotation (Placement(transformation(
        extent={{-10.25,-10},{10.25,10}},
        rotation=270,
        origin={70,0.25})));
  Modelica.Blocks.Sources.Constant insulation1(k=0)
    annotation (Placement(transformation(extent={{-95.5,-5.5},{-85,5}})));
  Modelica.Blocks.Sources.Constant insulation2(k=0)
    annotation (Placement(transformation(extent={{95,-5},{84.5,5.5}})));
  inner aSMR.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(saltTemp.y, tempSource1D.temperature) annotation (Line(
      points={{-9.5,-85},{0.25,-85},{0.25,-79}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(airTemp.y, tempSource1D1.temperature) annotation (Line(
      points={{-9.5,85},{-0.25,85},{-0.25,79}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(insulation2.y, heatSource1D1.power) annotation (Line(
      points={{83.975,0.25},{74,0.25}},
      color={0,0,127},
      thickness=0.5,
      smooth=Smooth.None));
  connect(insulation1.y, insulation.power) annotation (Line(
      points={{-84.475,-0.25},{-74,-0.25}},
      color={0,0,127},
      thickness=0.5,
      smooth=Smooth.None));

  connect(insulation.wall, flow1D.wall) annotation (Line(
      points={{-67,-0.25},{-57.75,-0.25},{-57.75,-0.1},{-50,-0.1}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(flow1D2.wall, heatSource1D1.wall) annotation (Line(
      points={{50,0.1},{59,0.1},{59,0.25},{67,0.25}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(tempSource1D1.wall, flow1D1.wall) annotation (Line(
      points={{-0.25,72},{-0.25,66.5},{-0.1,66.5},{-0.1,60}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(flow1D3.wall, tempSource1D.wall) annotation (Line(
      points={{0.1,-60},{0.1,-66},{0.25,-66},{0.25,-72}},
      color={255,127,0},
      smooth=Smooth.None));

  connect(flow1D2.outfl, flow1D3.infl) annotation (Line(
      points={{40,-20},{40.5,-20},{40.5,-50},{20,-50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flow1D.infl, flow1D3.outfl) annotation (Line(
      points={{-40,-20},{-40.5,-20},{-40.5,-50},{-20,-50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flow1D1.infl, flow1D.outfl) annotation (Line(
      points={{-20,50},{-40,50},{-40,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flow1D1.outfl, flow1D2.infl) annotation (Line(
      points={{20,50},{40,50},{40,20}},
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
      StopTime=6000,
      Interval=10,
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput);
end dRACS;
