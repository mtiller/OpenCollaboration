within ORNL_AdvSMR.PRISM.CORE;
model FuelPinSim2

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  // number of Nodes
  parameter Integer nNodes=1 "Number of axial nodes";

  FuelPin fuelPin(noAxialNodes=nNodes)
    annotation (Placement(transformation(extent={{-40,-75},{-24.5,75}})));

  Modelica.Blocks.Sources.Step[nNodes] step(
    each height=100e3,
    each offset=100e3,
    each startTime=5000)
    annotation (Placement(transformation(extent={{-75,-7.5},{-60,7.5}})));

  Thermal.TempSource1D tempSource1D(N=nNodes, redeclare
      ORNL_AdvSMR.Thermal.DHThtc wall) annotation (Placement(transformation(
        extent={{-10,-5},{10,5}},
        rotation=270,
        origin={25,0})));

  Modelica.Blocks.Sources.Step step1(
    each height=50,
    each startTime=500,
    each offset=300 + 273.15)
    annotation (Placement(transformation(extent={{55,-7.5},{40,7.5}})));

  Thermal.ConvHT_htc convec(N=nNodes) annotation (Placement(transformation(
        extent={{-75,-10},{75,10}},
        rotation=270,
        origin={1.24345e-014,0})));

equation
  connect(step.y, fuelPin.powerIn) annotation (Line(
      points={{-59.25,0},{-43.875,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step1.y, tempSource1D.temperature) annotation (Line(
      points={{39.25,0},{27,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(convec.fluidside, tempSource1D.wall) annotation (Line(
      points={{3,-5.55112e-016},{14.5,-5.55112e-016},{14.5,2.77556e-016},{23.5,
          2.77556e-016}},
      color={255,127,0},
      smooth=Smooth.None));
  convec.fluidside.gamma = 1e4*ones(nNodes);
  // Coupling of heat transfer to interface nodes
  for i in 1:nNodes loop
    fuelPin.fp[i].T_cool = convec.fluidside.T[i];
    fuelPin.fp[i].h = 1e4;
  end for;
  connect(fuelPin.wall, convec.otherside) annotation (Line(
      points={{-22.5625,0},{-3,0}},
      color={255,127,0},
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
end FuelPinSim2;
