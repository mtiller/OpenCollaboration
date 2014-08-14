within ORNL_AdvSMR.SmAHTR.DRACS;
model dRACS
  import aSMR = ORNL_AdvSMR;

  ORNL_AdvSMR.Components.Flow1D flow1D(
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
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.NoFriction,
    Kfnom=1000,
    dpnom=100000,
    pstart=6000000,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState) annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,0})));
  ORNL_AdvSMR.Components.Flow1D flow1D1(
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
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.NoFriction,
    Kfnom=1000,
    dpnom=100000,
    pstart=6000000,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState) annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={0,50})));
  ThermoPower3.Thermal.TempSource1D tempSource1D annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-75})));
  Modelica.Blocks.Sources.Constant saltTemp(k=600)
    annotation (Placement(transformation(extent={{-20,-90},{-10,-80}})));
  ThermoPower3.Thermal.TempSource1D tempSource1D1
    annotation (Placement(transformation(extent={{-10,65},{10,85}})));
  Modelica.Blocks.Sources.Constant airTemp(k=20)
    annotation (Placement(transformation(extent={{-20,80},{-10,90}})));
  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  ORNL_AdvSMR.Components.Flow1D flow1D2(
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
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.NoFriction,
    Kfnom=1000,
    dpnom=100000,
    pstart=6000000,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState) annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={40,0})));
  ORNL_AdvSMR.Components.Flow1D flow1D3(
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
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.NoFriction,
    Kfnom=1000,
    dpnom=100000,
    pstart=6000000,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState) annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={0,-50})));
  ThermoPower3.Thermal.HeatSource1D insulation(omega=Modelica.Constants.pi
        *50e-3,L=4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,0})));
  ThermoPower3.Thermal.HeatSource1D heatSource1D1(L=4, omega=Modelica.Constants.pi
        *50e-3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,0})));
  Modelica.Blocks.Sources.Constant insulation1(k=0)
    annotation (Placement(transformation(extent={{-95,-5},{-85,5}})));
  Modelica.Blocks.Sources.Constant insulation2(k=0)
    annotation (Placement(transformation(extent={{95,-5},{85,5}})));
equation
  connect(flow1D.outfl, flow1D1.infl) annotation (Line(
      points={{-40,20},{-40,50},{-20,50}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=1));
  connect(saltTemp.y, tempSource1D.temperature) annotation (Line(
      points={{-9.5,-85},{-4.89859e-016,-85},{-4.89859e-016,-79}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tempSource1D1.wall, flow1D1.wall) annotation (Line(
      points={{0,72},{0,60}},
      color={255,127,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(airTemp.y, tempSource1D1.temperature) annotation (Line(
      points={{-9.5,85},{0,85},{0,79}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(flow1D1.outfl, flow1D2.infl) annotation (Line(
      points={{20,50},{40,50},{40,20}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=1));
  connect(tempSource1D.wall, flow1D3.wall) annotation (Line(
      points={{3.67394e-016,-72},{3.67394e-016,-60},{-1.22465e-015,-60}},
      color={255,127,0},
      smooth=Smooth.None,
      thickness=0.5));

  connect(flow1D2.outfl, flow1D3.infl) annotation (Line(
      points={{40,-20},{40,-50},{20,-50}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=1));
  connect(flow1D3.outfl, flow1D.infl) annotation (Line(
      points={{-20,-50},{-40,-50},{-40,-20}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=1));
  connect(insulation.wall, flow1D.wall) annotation (Line(
      points={{-67,-1.83697e-016},{-58.5,-1.83697e-016},{-58.5,
          6.12323e-016},{-50,6.12323e-016}},
      color={255,127,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(heatSource1D1.wall, flow1D2.wall) annotation (Line(
      points={{67,5.51091e-016},{58.5,5.51091e-016},{58.5,-1.83697e-015},
          {50,-1.83697e-015}},
      color={255,127,0},
      thickness=0.5,
      smooth=Smooth.None));

  connect(insulation2.y, heatSource1D1.power) annotation (Line(
      points={{84.5,0},{79.25,0},{79.25,-7.34788e-016},{74,-7.34788e-016}},
      color={0,0,127},
      thickness=0.5,
      smooth=Smooth.None));

  connect(insulation1.y, insulation.power) annotation (Line(
      points={{-84.5,0},{-79.25,0},{-79.25,2.44929e-016},{-74,
          2.44929e-016}},
      color={0,0,127},
      thickness=0.5,
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
