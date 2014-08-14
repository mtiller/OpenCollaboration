within ORNL_AdvSMR.Components;
model CounterCurrentConvection
  "Models counter-flow heat exchange via convection"

  // Number of axial nodes
  parameter Integer nNodes=10 "Number of axial nodes";

  Thermal.MetalTube metalTube(
    N=nNodes,
    L=5.04,
    lambda=18.80,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    rint=13.3919e-3/2,
    rext=13.3919e-3/2 + 0.9779e-3,
    WallRes=true,
    rhomcm=8030*550) annotation (Placement(transformation(
        extent={{-100.25,-10},{100.25,10}},
        rotation=270,
        origin={1.24345e-014,-0.25})));

  Thermal.ConvHT_htc convHT_htc(N=nNodes) annotation (Placement(transformation(
        extent={{-40.25,-10},{40.25,10}},
        rotation=90,
        origin={-35,-0.25})));

  Thermal.CounterCurrent counterCurrent(N=nNodes, counterCurrent=true)
    annotation (Placement(transformation(
        extent={{-40.25,-10},{40.25,10}},
        rotation=90,
        origin={20,-0.25})));

  Thermal.ConvHT_htc convHT_htc1(N=nNodes) annotation (Placement(transformation(
        extent={{-40.25,10},{40.25,-10}},
        rotation=90,
        origin={40,-0.25})));

  Thermal.DHThtc_in shellSide(N=nNodes) annotation (Placement(transformation(
          extent={{-100,-80.5},{-80,80}}), iconTransformation(extent={{-10,-100},
            {10,100}})));

  Thermal.DHThtc_in tubeSide(N=nNodes) annotation (Placement(transformation(
          extent={{80,-80.5},{100,80}}), iconTransformation(extent={{40,-100},{
            60,100}})));

equation
  connect(metalTube.int, counterCurrent.side1) annotation (Line(
      points={{3,-0.25},{17,-0.25}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(convHT_htc.otherside, metalTube.ext) annotation (Line(
      points={{-32,-0.25},{-3,-0.25}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(counterCurrent.side2, convHT_htc1.otherside) annotation (Line(
      points={{23.1,-0.25},{37,-0.25}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(shellSide, convHT_htc.fluidside) annotation (Line(
      points={{-90,-0.25},{-38,-0.25}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(tubeSide, convHT_htc1.fluidside) annotation (Line(
      points={{90,-0.25},{43,-0.25}},
      color={255,127,0},
      smooth=Smooth.None));
  for i in 1:nNodes loop
    shellSide.gamma[i] = 3.4e4;
    tubeSide.gamma[i] = 6.8e4;
  end for;

  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics), Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          radius=2,
          origin={0,0},
          rotation=90)}));
end CounterCurrentConvection;
