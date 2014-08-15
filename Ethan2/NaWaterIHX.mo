within Ethan2;
model NaWaterIHX "Sodium Water Heat Exchanger"
  parameter Modelica.SIunits.MassFlowRate wNa = 2309.5;
  parameter Modelica.SIunits.MassFlowRate wh2o = 279.15;
  parameter Integer Nnodes = 30;
  parameter Modelica.SIunits.Length dtube = 0.024;
  parameter Modelica.SIunits.Length ttube = 0.00775;
  parameter Integer Ntw = 1838 "Number of tubes in bundle";
  parameter Modelica.SIunits.Length dshroud = 2.75;
  parameter Modelica.SIunits.Length HTLength = 16.76;
  parameter Modelica.SIunits.Volume plenumvol = 1.5 "tube plenum volume";
  constant Real pi = 3.14159265;
  Modelica.SIunits.Power waterpowerin;
  Modelica.SIunits.Power waterpowerout;
  Modelica.SIunits.Power napower;
  ThermoPower3.Water.Flow1D2phChen_wTube waterflow(
    L=HTLength,
    H=HTLength,
    A=pi*dtube^2/4,
    omega=pi*dtube,
    Dhyd=dtube,
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.Cfnom,
    Kfnom=0,
    rhonom=1000,
    Cfnom=0.005,
    tubethick=ttube,
    passallowFlowReversal=system.allowFlowReversal,
    N=Nnodes,
    Nt=Ntw,
    DynamicMomentum=true,
    rhomcm=4000000,
    WallRes=true,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.TwoPhases,
    hstartout=1225000,
    hstartin=950000.0,
    HydraulicCapacitance=ThermoPower3.Choices.Flow1D.HCtypes.Downstream,
    lambda=20.4,
    wnom=wh2o,
    dpnom=100000,
    pstart=6800000,
    Tstartbar=538.15,
    Tstart1=490.15,
    TstartN=698.15)
    annotation (Placement(transformation(extent={{-19,-20},{19,20}},
        rotation=90,
        origin={-5,-14})));
  AnnularFlow1DDB             naflow(redeclare package Medium =
        ORNL_AdvSMR.Media.Fluids.Na,
    N=Nnodes,
    L=HTLength,
    H=-HTLength,
    wnom=wNa,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    A=pi*(dshroud^2/4 - (Ntw*(dtube + 2*ttube)^2)/4),
    hstartout=700000,
    DynamicMomentum=true,
    hstartin=800000.0,
    Dhydext=pi*dshroud,
    omega=Ntw*pi*(ttube + dtube) + pi*dshroud,
    Dhyd=pi*(ttube + dtube),
    pstart=500000)
    annotation (Placement(transformation(extent={{-20,-19},{20,19}},
        rotation=270,
        origin={-90,-13})));
  ThermoPower3.Thermal.CounterCurrent counterCurrent(N=Nnodes)
    annotation (Placement(transformation(extent={{-13.5,-12.5},{13.5,12.5}},
        rotation=90,
        origin={-44.5,-14.5})));
  ThermoPower3.Thermal.ConvHT_htc convHT_htc(N=Nnodes)
    annotation (Placement(transformation(extent={{-13.5,-11.5},{13.5,11.5}},
        rotation=90,
        origin={-63.5,-14.5})));
  ThermoPower3.Water.SourceW sourceW(redeclare package Medium =
        ORNL_AdvSMR.Media.Fluids.Na,
    w0=wNa,
    p0=10000000,
    h=920600)
    annotation (Placement(transformation(extent={{-13,13},{13,-13}},
        rotation=180,
        origin={-73,65})));
  ThermoPower3.Water.SinkP sinkP(redeclare package Medium =
        ORNL_AdvSMR.Media.Fluids.Na,
    h=700000,
    p0=10000000)
    annotation (Placement(transformation(extent={{-11,11},{11,-11}},
        rotation=180,
        origin={-121,-81})));
  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{118,78},{138,98}})));
  UserInteraction.Outputs.NumericValue numericValue(input_Value=waterflow.flowchannel.x[
        Nnodes])
             annotation (Placement(transformation(extent={{62,-8},{82,12}})));
  UserInteraction.Outputs.SpatialPlot2 spatialPlot2_1(
    x1=linspace(
        0,
        HTLength,
        Nnodes),
    y1=waterflow.flowchannel.T,
    minX1=0,
    maxX1=HTLength,
    y2=Modelica.Math.Vectors.reverse(naflow.T),
    minY1=450,
    x2=linspace(
        0,
        HTLength,
        Nnodes),
    maxY1=770)
    annotation (Placement(transformation(extent={{38,-94},{130,-20}})));
  ThermoPower3.Water.Header outletplenum(
    V=plenumvol,
    S=5.08,
    H=0,
    gamma=0,
    Cm=1000,
    hstart=1225000,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    pstart=6800000,
    Tmstart=498.15)
    annotation (Placement(transformation(extent={{-14,-16},{14,16}},
        rotation=90,
        origin={-4,38})));
  ThermoPower3.Water.Header inletplenum(
    V=plenumvol,
    S=5.08,
    H=0,
    gamma=0,
    Cm=1000,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    pstart=6800000,
    hstart=950000.0,
    Tmstart=498.15)
    annotation (Placement(transformation(extent={{-11,-13},{11,13}},
        rotation=90,
        origin={-5,-57})));
  UserInteraction.Outputs.NumericValue numericValue1(input_Value=napower)
             annotation (Placement(transformation(extent={{102,-6},{122,14}})));
  Modelica.Blocks.Sources.Ramp ramp(
    offset=800000,
    height=120600,
    duration=25,
    startTime=0.1)
    annotation (Placement(transformation(extent={{-132,74},{-112,94}})));
  ThermoPower3.Thermal.MetalWall metalWall(
    N=Nnodes,
    M=17470,
    Sint=144,
    Sext=146,
    cm=500,
    Tstartbar=673.15) annotation (Placement(transformation(
        extent={{-14,-15},{14,15}},
        rotation=-90,
        origin={-141,-14})));
  ThermoPower3.Thermal.ConvHT_htc convHT_htc1(N=Nnodes) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-118,-14})));
  PCS pCS annotation (Placement(transformation(extent={{34,-16},{54,4}})));
  UserInteraction.Outputs.NumericValue numericValue2(input_Value=pCS.turbine.Pm)
             annotation (Placement(transformation(extent={{76,36},{96,56}})));
equation
  waterpowerin = waterflow.flowchannel.u[1]*waterflow.flowchannel.rho[1]*waterflow.flowchannel.h[1]*waterflow.flowchannel.A*waterflow.flowchannel.Nt;
  waterpowerout = waterflow.flowchannel.u[Nnodes]*waterflow.flowchannel.rho[Nnodes]*waterflow.flowchannel.h[Nnodes]*waterflow.flowchannel.A*waterflow.flowchannel.Nt;
  napower = (naflow.u[1]*naflow.rho[1]*naflow.h[1]*naflow.A-naflow.u[Nnodes]*naflow.rho[Nnodes]*naflow.h[Nnodes]*naflow.A);
  connect(counterCurrent.side2, waterflow.wall) annotation (Line(
      points={{-40.625,-14.5},{-16.6,-14.5},{-16.6,-14}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(convHT_htc.otherside, counterCurrent.side1) annotation (Line(
      points={{-60.05,-14.5},{-48.25,-14.5}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(convHT_htc.fluidside, naflow.wall) annotation (Line(
      points={{-66.95,-14.5},{-66.95,-14},{-80.5,-14},{-80.5,-13}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(sourceW.flange, naflow.infl) annotation (Line(
      points={{-86,65},{-90,65},{-90,7}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(naflow.outfl, sinkP.flange) annotation (Line(
      points={{-90,-33},{-90,-81},{-110,-81}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(waterflow.flangeB, outletplenum.inlet) annotation (Line(
      points={{-5,5},{-4,5},{-4,23.86}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(waterflow.flangeA, inletplenum.outlet) annotation (Line(
      points={{-5,-33},{-5,-46}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ramp.y, sourceW.in_h) annotation (Line(
      points={{-111,84},{-78,84},{-78,72.8},{-78.2,72.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(naflow.extwall, convHT_htc1.fluidside) annotation (Line(
      points={{-99.88,-13},{-106.94,-13},{-106.94,-14},{-115,-14}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(convHT_htc1.otherside, metalWall.int) annotation (Line(
      points={{-121,-14},{-136.5,-14}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(outletplenum.outlet, pCS.flangeA) annotation (Line(
      points={{-4,52},{36,52},{36,4},{34,4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pCS.flangeB, inletplenum.inlet) annotation (Line(
      points={{34,-16},{30,-16},{30,-68.11},{-5,-68.11}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -100},{140,100}}), graphics={Text(
          extent={{62,-2},{82,-14}},
          lineColor={0,0,255},
          textString="Exit Quality"),    Text(
          extent={{100,-4},{126,-14}},
          lineColor={0,0,255},
          textString="Power Input
MW (Sodium)"),                           Text(
          extent={{62,40},{110,30}},
          lineColor={0,0,255},
          fontSize=14,
          textString="Turbine Power (MW)")}),
               Icon(coordinateSystem(extent={{-140,-100},{140,100}})));
end NaWaterIHX;
