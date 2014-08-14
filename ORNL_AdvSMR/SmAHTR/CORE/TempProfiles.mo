within ORNL_AdvSMR.SmAHTR.CORE;
model TempProfiles
  "This model shows the temperature profiles of critical thermal elements along a channel."

  import Modelica.Constants.*;

  final parameter Integer noAxialNodes=9;

  FuelPinModel fuelPinModel
    annotation (Placement(transformation(extent={{-5,-50},{5,50}})));
  Modelica.Blocks.Sources.Constant[noAxialNodes] fluxProfile(k={-1.25e5*4
        /pi*(cos(pi*i/noAxialNodes) + cos(pi*(1 - i + noAxialNodes)/
        noAxialNodes)) for i in 1:noAxialNodes})
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));

equation
  connect(fluxProfile.y, fuelPinModel.heatIn) annotation (Line(
      points={{-29,0},{-7.5,0}},
      color={0,0,127},
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
    experiment(__Dymola_NumberOfIntervals=1000, Tolerance=1e-006),
    __Dymola_experimentSetupOutput);
end TempProfiles;
