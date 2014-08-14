within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model CoreFlowPaths1_wModelicaFluid_woPump

  inner System system annotation (Placement(transformation(extent={{-100,
            80},{-80,100}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe(
    length=0.80,
    diameter=8.40932e-2,
    height_ab=0.80,
    m_flow_start=0.5,
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_a_start=10000000,
    p_b_start=10000000,
    T_start=373.15,
    nNodes=1,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,0})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    m_flow=0.7663,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    T=373.15) annotation (Placement(transformation(extent={{-65,-85},{-45,
            -65}})));
  Modelica.Fluid.Sources.FixedBoundary boundary1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p=10000000,
    T=973.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,80})));
equation
  connect(boundary1.ports[1], pipe.port_b) annotation (Line(
      points={{0,70},{0,20}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(boundary.ports[1], pipe.port_a) annotation (Line(
      points={{-45,-75},{-1.22125e-015,-75},{-1.22125e-015,-20}},
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
end CoreFlowPaths1_wModelicaFluid_woPump;
