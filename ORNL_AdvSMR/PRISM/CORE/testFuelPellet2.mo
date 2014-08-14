within ORNL_AdvSMR.PRISM.CORE;
model testFuelPellet2

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  // number of Nodes
  parameter Power Q_total=1.25e6 "Total thermal power into the channel";
  parameter Integer noAxialNodes=1;
  parameter Integer noRadialNodes_f=8 "Number of radial nodes for fuel";
  parameter Integer noRadialNodes_c=4 "Number of radial nodes for cladding";

  FuelPellet2 fp(
    each radNodes_f=noRadialNodes_f,
    each radNodes_c=noRadialNodes_c,
    each R_f=2.7051e-3,
    each H_f=5.04/noAxialNodes,
    each R_g=2.7051e-3 + 0.5588e-3,
    each H_g=5.04/noAxialNodes,
    each R_c=3.7e-3,
    each H_c=5.04/noAxialNodes,
    each W_Pu=0.26,
    each W_Zr=0.10)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Modelica.Blocks.Sources.Step step(
    each startTime=100,
    each height=0,
    each offset=Q_total)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

  .UserInteraction.Outputs.SpatialPlot spatialPlot(
    minX=0,
    maxX=1,
    y=fp.T_f .- 273.15,
    x=linspace(
        0,
        1,
        noRadialNodes_f),
    minY=500,
    maxY=650)
    annotation (Placement(transformation(extent={{-114,26},{26,108}})));
equation
  connect(fp.powerIn, step.y) annotation (Line(
      points={{-18,0},{-39,0}},
      color={0,0,0},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  fp.T_cool = 395 + 273.15;
  fp.h = 86e3;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end testFuelPellet2;
