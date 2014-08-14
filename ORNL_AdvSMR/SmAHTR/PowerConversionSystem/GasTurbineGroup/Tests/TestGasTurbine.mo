within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.GasTurbineGroup.Tests;
model TestGasTurbine

  Examples.GasTurbineSimplified gasTurbine annotation (Placement(
        transformation(extent={{-40,-40},{0,0}}, rotation=0)));
  ThermoPower3.Gas.SinkP sinkP(redeclare package Medium =
        ThermoPower.Media.FlueGas) annotation (Placement(
        transformation(extent={{62,-14},{82,6}}, rotation=0)));
  Modelica.Blocks.Sources.Constant const annotation (Placement(
        transformation(extent={{-90,-30},{-70,-10}}, rotation=0)));
  ThermoPower3.PowerPlants.HRSG.Components.StateReader_gas
    stateReader_gas(redeclare package Medium =
        ThermoPower.Media.FlueGas) annotation (Placement(
        transformation(extent={{20,-14},{40,6}}, rotation=0)));
  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{70,70},{90,90}})));
equation
  connect(const.y, gasTurbine.GTLoad)
    annotation (Line(points={{-69,-20},{-40,-20}}, color={0,0,127}));
  connect(stateReader_gas.inlet, gasTurbine.flueGasOut) annotation (
      Line(
      points={{24,-4},{0,-4}},
      color={159,159,223},
      thickness=0.5));
  connect(stateReader_gas.outlet, sinkP.flange) annotation (Line(
      points={{36,-4},{62,-4}},
      color={159,159,223},
      thickness=0.5));
  annotation (Diagram(graphics));
end TestGasTurbine;
