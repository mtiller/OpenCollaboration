within ORNL_AdvSMR.PRISM.PowerConversionSystem.ElectricGenerators.OldElementsSwingEquation;
model Generator_SE_Breaker
  "Electic generator inclusive of approximate swing equation and breaker for connection grid"
  //Parameters
  parameter Real eta=1 "Conversion efficiency";
  parameter Integer Np=2 "Number of couple of electrical poles";
  parameter Modelica.SIunits.Power Pmax "Maximum power of generator";
  parameter Real J "Moment of inertia of the system-shaft";
  parameter Real r=0.3 "Damping of the system";
  parameter Modelica.SIunits.AngularVelocity omega_nom
    "Nominal angulary velocity of shaft";
  parameter Modelica.SIunits.Angle delta_start "Loaded angle start value";
  parameter Modelica.SIunits.AngularVelocity omega_start
    "Angulaty velocity of shaft start value";

  Modelica.SIunits.AngularVelocity omega(start=omega_start)
    "Shaft angular velocity";
  Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm n
    "Rotational speed";
  Modelica.SIunits.Angle delta(start=delta_start) "Loaded angle";
  Modelica.SIunits.AngularVelocity d_delta "Variation of loaded angle";
  Modelica.SIunits.AngularVelocity omegaGrid "Angulary velocity in the grid";
  Modelica.SIunits.Power Pe "Outlet electric power";
  Modelica.SIunits.Power Pm "Inlet mechanical power";
  Real M "Auxiliary variable";
  Real D "Auxiliary variable";

  ThermoPower3.Electrical.PowerConnection powerConnection annotation (Placement(
        transformation(extent={{58,-14},{86,14}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft annotation (Placement(
        transformation(extent={{-100,-10},{-80,10}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput closed annotation (Placement(
        transformation(
        origin={0,68},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Interfaces.RealOutput delta_out annotation (Placement(
        transformation(
        origin={0,-68},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  M = J/(Np^2)*omega_nom*Np;
  D = 2*r*sqrt(Pmax*J*omega_nom*Np/(Np^2));
  omega = der(shaft.phi);
  Pm = omega*shaft.tau;
  n = Modelica.SIunits.Conversions.to_rpm(omega) "Rotational speed in rpm";
  omegaGrid = 2*Modelica.Constants.pi*powerConnection.f;
  powerConnection.W = -Pe;

  //Definition loaded angle
  d_delta = omega*Np - omegaGrid;
  der(delta) = d_delta;

  //swing equation
  M*der(d_delta) + D*d_delta = Pm - Pe/eta;
  if closed then
    Pe = Pmax*Modelica.Math.sin(delta);
  else
    //Free turbine and not connection a grid
    Pe = 0;
  end if;

  //Output signal
  delta_out = delta - integer(delta/(2*Modelica.Constants.pi))*2*Modelica.Constants.pi;

  annotation (
    Icon(graphics={Rectangle(
          extent={{-60,8},{-90,-8}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175}),Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),Text(
          extent={{-60,60},{60,-20}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid,
          textString="G"),Text(
          extent={{-60,-10},{60,-50}},
          lineColor={0,127,0},
          textString="SE")}),
    Diagram(graphics),
    Diagram);
end Generator_SE_Breaker;
