within ORNL_AdvSMR.SmAHTR.CORE;
model CylindricalFuelThermalSim

  CylindricalFuelThermalModel cylindricalFuelThermalModel(
    H_g=3.01,
    rho_f=10.97e3,
    cp_f=247,
    rho_c=6.5e3,
    cp_c=330,
    radNodes_f=8,
    radNodes_c=4,
    R_f=8.192e-3/2,
    R_g=(8.192e-3 + 0.0826e-3)/2,
    R_c=(8.192e-3 + 0.0826e-3 + 0.572e-3)/2,
    H_f=3.658,
    H_c=3.876,
    k_f=2.163,
    h_g=5700,
    k_c=13.85)
    annotation (Placement(transformation(extent={{-25,-25},{25,25}})));

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Constant const(k=5e4)
    annotation (Placement(transformation(extent={{-85,-10},{-65,10}})));
equation

  connect(const.y, cylindricalFuelThermalModel.heatIn) annotation (Line(
      points={{-64,0},{-22.5,0}},
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
    experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end CylindricalFuelThermalSim;
