within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model CoreFlowPaths1_wModelicaFluid

  inner System system annotation (Placement(transformation(extent={{-100,
            80},{-80,100}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe(
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    length=0.80,
    diameter=8.40932e-2,
    height_ab=0.80,
    m_flow_start=0.5,
    useLumpedPressure=true,
    useInnerPortProperties=true,
    nNodes=1,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    p_a_start=100000,
    p_b_start=100000,
    T_start=973.15) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,0})));
  Modelica.Fluid.Machines.PrescribedPump pump(
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    N_nominal=1000,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.linearFlow (
         V_flow_nominal={0.001,0.0015}, head_nominal={30,0}),
    rho_nominal=2200,
    m_flow_start=0.5,
    p_a_start=100000,
    p_b_start=100000,
    T_start=923.15) annotation (Placement(transformation(extent={{-30,-85},
            {-10,-65}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    nPorts=1,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    m_flow=0.7663,
    T=923.15) annotation (Placement(transformation(extent={{-65,-85},{-45,
            -65}})));
  Modelica.Fluid.Sources.FixedBoundary boundary1(
    nPorts=1,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    p=100000,
    T=973.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,80})));
equation
  connect(pump.port_b, pipe.port_a) annotation (Line(
      points={{-10,-75},{0,-75},{0,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(boundary.ports[1], pump.port_a) annotation (Line(
      points={{-45,-75},{-30,-75}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(boundary1.ports[1], pipe.port_b) annotation (Line(
      points={{0,70},{0,20}},
      color={0,127,255},
      thickness=1,
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
    __Dymola_experimentSetupOutput(textual=true, doublePrecision=true));
end CoreFlowPaths1_wModelicaFluid;
