within ORNL_AdvSMR.PRISM.PowerConversionSystem.ElectricGeneratorGroup.Tests;
model Test_Generator_SE
  import aSMR = ORNL_AdvSMR;

  ORNL_AdvSMR.PRISM.PowerConversionSystem.SteamTurbines.SteamTurbineStodola
    steamTurbineStodola(
    wstart=67.6,
    wnom=67.6,
    eta_iso_nom=0.833,
    Kt=0.0032078,
    PRstart=5,
    pnom=12800000) annotation (Placement(transformation(extent={{-80,-24},{-48,
            8}}, rotation=0)));
  ORNL_AdvSMR.Components.SinkP sinkP(p0=29.8e5, h=3.1076e6) annotation (
      Placement(transformation(extent={{-44,34},{-32,46}}, rotation=0)));
  ORNL_AdvSMR.Components.ValveVap valveHP(
    CvData=ThermoPower3.Choices.Valve.CvTypes.Cv,
    CheckValve=true,
    wnom=67.6,
    Cv=1165,
    pnom=12960000,
    dpnom=160000) annotation (Placement(transformation(
        origin={-76,24},
        extent={{6,6},{-6,-6}},
        rotation=90)));
  ORNL_AdvSMR.Components.SourceP sourceP(h=3.47e6, p0=1.296e7) annotation (
      Placement(transformation(extent={{-96,34},{-84,46}}, rotation=0)));
public
  Modelica.Blocks.Sources.Ramp com_valveHP_a(
    offset=0.2,
    startTime=5,
    height=+0.7,
    duration=3) annotation (Placement(transformation(extent={{0,76},{-12,88}},
          rotation=0)));
public
  Modelica.Blocks.Sources.Ramp com_valveHP_b(
    offset=0,
    duration=5,
    height=-0.8,
    startTime=15) annotation (Placement(transformation(extent={{0,54},{-12,66}},
          rotation=0)));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
        origin={-49,69},
        extent={{-7,-7},{7,7}},
        rotation=180)));
  ORNL_AdvSMR.PRISM.PowerConversionSystem.ElectricGenerators.OldElementsSwingEquation.Generator_SE
    generator_SE(
    Pmax=30e6,
    eta=0.96,
    r=0.2,
    J=15000,
    delta_start=0.5073,
    omega_nom=157.08) annotation (Placement(transformation(extent={{-30,-48},{
            50,32}}, rotation=0)));
  ORNL_AdvSMR.PRISM.PowerConversionSystem.ElectricGenerators.Grid grid(Pn=50e8,
      droop=0) annotation (Placement(transformation(extent={{66,-18},{86,2}},
          rotation=0)));
  inner ORNL_AdvSMR.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation
  connect(sinkP.flange, steamTurbineStodola.outlet) annotation (Line(
      points={{-44,40},{-51.2,40},{-51.2,4.8}},
      thickness=0.5,
      color={0,0,255}));
  connect(valveHP.outlet, steamTurbineStodola.inlet) annotation (Line(
      points={{-76,18},{-76,11.4},{-76,4.8},{-76.8,4.8}},
      thickness=0.5,
      color={0,0,255}));
  connect(sourceP.flange, valveHP.inlet) annotation (Line(
      points={{-84,40},{-76,40},{-76,30}},
      thickness=0.5,
      color={0,0,255}));
  connect(add.y, valveHP.theta) annotation (Line(points={{-56.7,69},{-62,69},{-62,
          24},{-71.2,24}}, color={0,0,127}));
  connect(com_valveHP_b.y, add.u1) annotation (Line(points={{-12.6,60},{-30,60},
          {-30,64},{-40.6,64},{-40.6,64.8}}, color={0,0,127}));
  connect(com_valveHP_a.y, add.u2) annotation (Line(points={{-12.6,82},{-30,82},
          {-30,74},{-40.6,74},{-40.6,73.2}}, color={0,0,127}));
  connect(generator_SE.shaft, steamTurbineStodola.shaft_b) annotation (Line(
      points={{-26,-8},{-53.76,-8}},
      color={0,0,0},
      thickness=0.5));
  connect(grid.connection, generator_SE.powerConnection) annotation (Line(
      points={{67.4,-8},{53.1,-8},{53.1,-8},{38.8,-8}},
      pattern=LinePattern.None,
      thickness=0.5));
  annotation (Diagram(graphics), experiment(StopTime=32, NumberOfIntervals=
          50000));
end Test_Generator_SE;
