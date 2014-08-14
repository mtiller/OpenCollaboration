within ORNL_AdvSMR.SmAHTR.CORE;
model ReactorCoreBlock

  final parameter Integer noAxialNodes=9;
  replaceable package Medium = ThermoPower3.Media.FlueGas;

  ReactorKinetics reactorKinetics(
    Q_nom=250e6,
    noAxialNodes=9,
    alpha_c=-0.51e-3,
    alpha_f=-3.80e-4,
    T_f0=1373.15,
    T_c0=608.15)
    annotation (Placement(transformation(extent={{-70,-25},{-20,25.5}})));

  FuelPinModel fuelPinModel
    annotation (Placement(transformation(extent={{4,-49.5},{15.5,50}})));
  Modelica.Fluid.Pipes.DynamicPipe averageChannel(
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    nNodes=noAxialNodes,
    nParallel=1,
    length=10,
    isCircular=true,
    height_ab=10,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    diameter=0.5,
    m_flow_start=100,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_vb,
    redeclare replaceable package Medium = Medium,
    p_a_start=12000000,
    p_b_start=12000000,
    T_start=543.15) annotation (Placement(transformation(
        extent={{-25,-25},{25,25}},
        rotation=90,
        origin={75,0})));

  Interfaces.FlangeA coolantIn(redeclare replaceable package Medium =
        Medium) annotation (Placement(transformation(extent={{65,-95},{85,
            -75}}), iconTransformation(extent={{-10,-110},{10,-90}})));
  Interfaces.FlangeB coolantOut(redeclare replaceable package Medium =
        Medium) annotation (Placement(transformation(extent={{65,70},{85,
            90}}), iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Blocks.Interfaces.RealInput rho_CR annotation (Placement(
        transformation(extent={{-120,-20},{-80,20}}), iconTransformation(
          extent={{-60,-10},{-40,10}})));

equation
  connect(reactorKinetics.axialProfile, fuelPinModel.heatIn) annotation (
      Line(
      points={{-20,0.25},{1.125,0.25}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fuelPinModel.heatOut, averageChannel.heatPorts) annotation (
      Line(
      points={{16.9375,0.25},{64,0.25}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(averageChannel.port_b, coolantOut) annotation (Line(
      points={{75,25},{75,80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(averageChannel.port_a, coolantIn) annotation (Line(
      points={{75,-25},{75,-85}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(rho_CR, reactorKinetics.rho_CR) annotation (Line(
      points={{-100,0},{-85,0},{-85,0.25},{-70,0.25}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fuelPinModel.T_fe[8], reactorKinetics.T_fe) annotation (Line(
      points={{9.75,-46.6197},{9.75,-65},{-30,-65},{-30,-25}},
      color={0,0,0},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  reactorKinetics.T_ce = averageChannel.mediums[8].T;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Rectangle(
                extent={{-40,100},{40,-100}},
                fillColor={215,215,215},
                fillPattern=FillPattern.VerticalCylinder,
                pattern=LinePattern.None,
                lineColor={95,95,95}),Text(
                extent={{-70,20},{-50,10}},
                lineColor={95,95,95},
                fillPattern=FillPattern.VerticalCylinder,
                fillColor={215,215,215},
                textString="rho_CR"),Text(
                extent={{-30,10},{30,-10}},
                lineColor={0,127,255},
                lineThickness=1,
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={215,215,215},
                textString="Reactor Core")}),
    experiment(
      StopTime=1000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Sdirk34hw"),
    __Dymola_experimentSetupOutput);
end ReactorCoreBlock;
