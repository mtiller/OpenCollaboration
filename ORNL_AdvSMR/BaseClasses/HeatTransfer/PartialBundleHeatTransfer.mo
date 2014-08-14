within ORNL_AdvSMR.BaseClasses.HeatTransfer;
partial model PartialBundleHeatTransfer
  "Abstract class that describes heat transfer correlations for bundle flows"

  extends ORNL_AdvSMR.Interfaces.PartialHeatTransfer;

  parameter Modelica.SIunits.CoefficientOfHeatTransfer h0=1000
    "guess value for heat transfer coefficients";

  // Variables
  //    Flow geometry
  input Modelica.SIunits.Length P "Pitch of the bundle";
  input Modelica.SIunits.Length D "Tube outer diameter";
  input Boolean isTriangular "True if triangular, False if square pitch";
  //    Flow
  input Modelica.SIunits.Velocity v "Fluid velocity";
  Modelica.SIunits.Area A_flow "Channel flow area";
  Modelica.SIunits.Length P_heated "Heated perimeter";
  Modelica.SIunits.Length D_hyd "Hydraulic diameter";
  //    Medium thermophysical properties
  Modelica.SIunits.Density[n] rho "Densities";
  Modelica.SIunits.DynamicViscosity[n] mu "Dynamic viscosities";
  Modelica.SIunits.ThermalConductivity[n] k "Thermal conductivities";
  Modelica.SIunits.SpecificHeatCapacity[n] c_p "Specific heat capacities";
  //    Dimensionless variables
  Real[n] Re "Reynolds numbers";
  Real[n] Pr "Prandtl numbers";
  Real[n] Nu "Nusselt numbers";
  Real[n] Pe "Peclet numbers";
  //    Local heat transfer coefficients
  Modelica.SIunits.CoefficientOfHeatTransfer[n] h(each start=h0)
    "CoefficientOfHeatTransfer";

equation
  if isTriangular then
    // triangular pitch
    A_flow = sqrt(3)/4*P^2 - Modelica.Constants.pi/2*(D/2)^2;
    P_heated = 1/2*Modelica.Constants.pi*D;
  else
    // square pitch
    A_flow = P^2 - Modelica.Constants.pi*(D/2)^2;
    P_heated = Modelica.Constants.pi*D;
  end if;

  // Calculate hydraulic diameter
  D_hyd = 4*A_flow/P_heated;

  // Calculate characteristic numbers
  Re = CharacteristicNumbers.ReynoldsNumber(
    v=v,
    rho=rho,
    mu=mu,
    D=D_hyd);
  Pr = CharacteristicNumbers.PrandtlNumber(
    c_p=c_p,
    mu=mu,
    k=k);
  Nu = CharacteristicNumbers.NusseltNumber(
    h=h,
    D=D_hyd,
    k=k);
  Pe = Re .* Pr;

  // Calculate heat flux
  phi = {h[i]*(heatPort.T[i] - Ts[i]) for i in 1:n};

  annotation (Icon(graphics={Rectangle(
          extent={{-80,60},{80,-60}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.HorizontalCylinder),Text(
          extent={{-40,22},{38,-18}},
          lineColor={0,0,0},
          textString="%name")}));
end PartialBundleHeatTransfer;
