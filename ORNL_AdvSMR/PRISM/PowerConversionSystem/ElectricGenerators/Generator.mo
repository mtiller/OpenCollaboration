within ORNL_AdvSMR.PRISM.PowerConversionSystem.ElectricGenerators;
model Generator "Active power generator"
  import Modelica.SIunits.Conversions.NonSIunits.*;
  parameter Real eta=1 "Conversion efficiency";
  parameter Modelica.SIunits.MomentOfInertia J=0 "Moment of inertia";
  parameter Integer Np=2 "Number of electrical poles";
  parameter Modelica.SIunits.Frequency fstart=50
    "Start value of the electrical frequency"
    annotation (Dialog(tab="Initialization"));
  parameter ORNL_AdvSMR.Choices.Init.Options initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit
    "Initialization option" annotation (Dialog(tab="Initialization"));
  Modelica.SIunits.Power Pm "Mechanical power";
  Modelica.SIunits.Power Pe "Electrical Power";
  Modelica.SIunits.Power Ploss "Inertial power Loss";
  Modelica.SIunits.Torque tau "Torque at shaft";
  Modelica.SIunits.AngularVelocity omega_m(start=2*Modelica.Constants.pi*fstart
        /Np) "Angular velocity of the shaft";
  Modelica.SIunits.AngularVelocity omega_e
    "Angular velocity of the e.m.f. rotating frame";
  AngularVelocity_rpm n "Rotational speed";
  Modelica.SIunits.Frequency f "Electrical frequency";
  PowerConnection powerConnection annotation (Placement(transformation(extent={
            {72,-14},{100,14}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft annotation (Placement(
        transformation(extent={{-100,-14},{-72,14}}, rotation=0)));
equation
  omega_m = der(shaft.phi) "Mechanical boundary condition";
  omega_e = omega_m*Np;
  f = omega_e/(2*Modelica.Constants.pi) "Electrical frequency";
  n = Modelica.SIunits.Conversions.to_rpm(omega_m) "Rotational speed in rpm";
  Pm = omega_m*tau;
  if J > 0 then
    Ploss = J*der(omega_m)*omega_m;
  else
    Ploss = 0;
  end if annotation (Diagram);
  Pm = Pe/eta + Ploss "Energy balance";
  // Boundary conditions
  f = powerConnection.f;
  Pe = -powerConnection.W;
  tau = shaft.tau;
initial equation
  if initOpt == ORNL_AdvSMR.Choices.Init.Options.noInit then
    // do nothing
  elseif initOpt == ORNL_AdvSMR.Choices.Init.Options.steadyState then
    der(omega_m) = 0;
  else
    assert(false, "Unsupported initialisation option");
  end if;
  annotation (
    Icon(graphics={Rectangle(
          extent={{-72,6},{-48,-8}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={160,160,164}),Ellipse(
          extent={{50,-50},{-50,50}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Line(
          points={{50,0},{72,0}},
          color={255,0,0},
          thickness=1),Text(
          extent={{-26,24},{28,-28}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="G")}),
    Diagram(graphics),
    Documentation(info="<html>
<p>This model describes the conversion between mechanical power and electrical power in an ideal synchronous generator. 
The frequency in the electrical connector is the e.m.f. of generator.
<p>It is possible to consider the generator inertia in the model, by setting the parameter <tt>J > 0</tt>. 
</html>"));
end Generator;
