within ORNL_AdvSMR.SmAHTR.CORE;
model FuelPinModel
  "This class models the behavior of a fuel pin made up of a stack of fuel pellets."

  parameter Integer noAxialNodes=9;

  CylindricalFuelThermalModel[noAxialNodes] cylindricalFuelThermalModel(
    each radNodes_f=9,
    each radNodes_c=4,
    each rho_f=10.97e3,
    each cp_f=247,
    each rho_c=6.5e3,
    each cp_c=330,
    each R_f=8.192e-3/2,
    each H_f=3.657,
    each R_g=(8.192e-3 + 0.0826e-3)/2,
    each H_g=3.868,
    each R_c=(8.192e-3 + 0.0826e-3 + 0.572e-3)/2,
    each H_c=3.876,
    each k_f=2.163,
    each h_g=5700,
    each k_c=13.85)
    annotation (Placement(transformation(extent={{-15,-15},{15,15}})));
  Modelica.Blocks.Interfaces.RealInput[noAxialNodes] heatIn
    "Flux profile from reactor kinetics" annotation (Placement(
        transformation(extent={{-60,-20},{-20,20}}), iconTransformation(
          extent={{-20,-5},{-10,5}})));
  Interfaces.HeatPorts_b[noAxialNodes] heatOut
    "Heat and temperature profile deposited to coolant channel"
    annotation (Placement(transformation(
        extent={{-10,-9.75},{10,9.75}},
        rotation=90,
        origin={30.25,0}), iconTransformation(
        extent={{-95,-2.5},{95,2.5}},
        rotation=90,
        origin={12.5,0})));
  SIInterfaces.SITemperatureOutput[noAxialNodes] T_fe
    "Effective fuel temperature vector for Doppler feedback" annotation (
      Placement(transformation(extent={{-8,-105},{12,-85}}),
        iconTransformation(extent={{-7.5,-102},{7.5,-87}})));

equation
  connect(heatIn, cylindricalFuelThermalModel.heatIn) annotation (Line(
      points={{-40,0},{-13.5,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(cylindricalFuelThermalModel.heatOut, heatOut) annotation (Line(
      points={{13.5,0},{30.25,0}},
      color={191,0,0},
      smooth=Smooth.None));
  T_fe = cylindricalFuelThermalModel[5].T_f;

  annotation (Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-10,-95},{10,95}},
        grid={0.5,0.5}), graphics={Bitmap(extent={{-15,99},{15,-101}},
          fileName="modelica://aSMR/Icons/FuelPin.png"),Text(
                extent={{-10,5},{10,-5}},
                lineColor={95,95,95},
                fillPattern=FillPattern.VerticalCylinder,
                fillColor={215,215,215},
                textString="Flux Profile",
                origin={-22.5,15},
                rotation=90),Text(
                extent={{-12.5,5},{12.5,-5}},
                lineColor={95,95,95},
                fillPattern=FillPattern.VerticalCylinder,
                fillColor={215,215,215},
                textString="Heat Profile",
                origin={20,17.5},
                rotation=270),Text(
                extent={{-15,5},{15,-5}},
                lineColor={95,95,95},
                fillPattern=FillPattern.VerticalCylinder,
                fillColor={215,215,215},
                textString="Effective
Fuel Temperature",
                origin={-15,-95},
                rotation=90)}), Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-10,-95},{10,95}},
        grid={0.5,0.5}), graphics));
end FuelPinModel;
