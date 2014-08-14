within ORNL_AdvSMR.SmAHTR.CORE;
model CylindricalFuelThermalModel
  "1-D model of fuel thermal model for plank-type AHTR fuel"

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  /* PARAMETERS */
  /* FUEL PIN GEOMETRY PARAMETERS */
  /* Fuel */
  parameter Length R_f "Radius of Fuel"
    annotation (Dialog(tab="Geometry", group="Fuel"));
  parameter Length H_f "Height of Fuel"
    annotation (Dialog(tab="Geometry", group="Fuel"));
  parameter Integer radNodes_f=8 "Number of Radial Nodes for Fuel"
    annotation (Dialog(tab="Geometry", group="Fuel"));
  /* Gap */
  parameter Length R_g "Radius of Gap"
    annotation (Dialog(tab="Geometry", group="Gap"));
  parameter Length H_g "Height of Gap"
    annotation (Dialog(tab="Geometry", group="Gap"));
  parameter Real alpha_g=1e6 "Gap thermal diffusivity";
  /* Cladding */
  parameter Length R_c "Radius of Cladding"
    annotation (Dialog(tab="Geometry", group="Cladding"));
  parameter Length H_c "Height of Cladding"
    annotation (Dialog(tab="Geometry", group="Cladding"));
  parameter Integer radNodes_c=4 "Number of Radial Nodes for Cladding"
    annotation (Dialog(tab="Geometry", group="Cladding"));

  /* Material thermophysical paramaters */
  /* Fuel */
  parameter Density rho_f "Density"
    annotation (Dialog(tab="Material Properties", group="Fuel"));
  parameter SpecificHeatCapacity cp_f "Specific heat capacity"
    annotation (Dialog(tab="Material Properties", group="Fuel"));
  parameter ThermalConductivity k_f=3.6 "Thermal conductivity"
    annotation (Dialog(tab="Material Properties", group="Fuel"));
  /* Gap */
  parameter CoefficientOfHeatTransfer h_g "Gap Conductance (W/m2.K)"
    annotation (Dialog(tab="Material Properties", group="Gap"));
  /* Cladding */
  parameter Density rho_c "Density"
    annotation (Dialog(tab="Material Properties", group="Cladding"));
  parameter SpecificHeatCapacity cp_c "Specific heat capacity"
    annotation (Dialog(tab="Material Properties", group="Cladding"));
  parameter ThermalConductivity k_c "Thermal conductivity"
    annotation (Dialog(tab="Material Properties", group="Cladding"));

  Temperature[radNodes_f] T_f "Fuel temperature profile";
  Temperature T_g "Mid-point gap temperature";
  Temperature[radNodes_c] T_c "Cladding temperature profile";

protected
  Length delta_f=R_f/radNodes_f;
  Length delta_g=R_g - R_f;
  Length delta_c=(R_c - R_g)/radNodes_c;
  // Node size (delta = R/N (m))
  Real alpha_f=k_f/(rho_f*cp_f)
    "Thermal diffusivity for fuel region (alpha = k/rho cp)";
  Real alpha_c=k_c/(rho_c*cp_c)
    "Thermal diffusivity for cladding region (alpha = k/rho cp)";
  Area A_f=pi*R_f^2 "Area of the fuel (m2)";
  Area A_g=pi*(R_g^2 - R_f^2) "Area of the gap (m2)";
  Area A_c=pi*(R_c^2 - R_g^2) "Area of the cladding (m2)";
  Volume V_f=A_f*H_f "Fuel volume (m3)";
  Volume V_g=A_g*H_g "Gap volume (m3)";
  Volume V_c=A_c*H_c "Cladding volume (m3)";
  CoefficientOfHeatTransfer h=34000
    "Constant heat transfer coefficient (W/m2K)";
  ORNL_AdvSMR.SIunits.VolumetricHeatGenerationRate q_ppp
    "Volumetric heat generation rate in a radial node";
  Temperature T_cool=293.1 + 273.15;

public
  Interfaces.HeatPort_b heatOut "Heat transfer port to the coolant"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={90,0}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,0})));
  Modelica.Blocks.Interfaces.RealInput heatIn annotation (Placement(
        transformation(extent={{-120,-20},{-80,20}}), iconTransformation(
          extent={{-100,-10},{-80,10}})));

equation
  /* VOLUMETRIC HEAT GENERATION RATE */
  q_ppp = heatIn/V_f "Volumetric heat generation rate in the fuel node";

  /* FUEL */
  // Center node
  1/alpha_f*der(T_f[1]) = 1/delta_f^2*2*2*(T_f[2] - T_f[1]) + 1/k_f*q_ppp;
  // Interior nodes
  for i in 2:radNodes_f - 1 loop
    1/alpha_f*der(T_f[i]) = 1/delta_f^2*(T_f[i - 1] - 2*T_f[i] + T_f[i +
      1]) + 1/(i*delta_f)*1/(2*delta_f)*(T_f[i + 1] - T_f[i - 1]) + 1/k_f
      *q_ppp;
  end for;
  // Gap boundary node
  1/alpha_f*der(T_f[radNodes_f]) = 1/delta_f^2*(T_f[radNodes_f - 1] - 2*
    T_f[radNodes_f] + T_g) + 1/R_f*1/(2*delta_f)*(T_g - T_f[radNodes_f -
    1]) + 1/k_f*q_ppp;

  /* GAP */
  // T_f[radNodes_f] - T_c[1] = q_ppp*A_f/(2*pi*R_g*h_g);
  T_g = 1/2*(T_f[radNodes_f] + T_c[1]);
  // 1/alpha_g*der(T_g) = 1/delta_g^2*(T_f[radNodes_f] - 2*T_g + T_c[1])
  //                    + 1/(2*R_g*delta_g)*(T_c[1] - T_f[radNodes_f]); // Gap conductance model

  /* CLADDING */
  // Gap boundary node
  1/alpha_c*der(T_c[1]) = 1/delta_c^2*(T_g - 2*T_c[1] + T_c[2]) + 1/(2*(
    R_g + delta_c)*delta_c)*(T_c[2] - T_g);
  // Interior nodes
  for i in 2:radNodes_c - 1 loop
    1/alpha_c*der(T_c[i]) = 1/delta_c^2*(T_c[i - 1] - 2*T_c[i] + T_c[i +
      1]) + 1/(2*(R_g + i*delta_c)*delta_c)*(T_c[i + 1] - T_c[i - 1]);
  end for;
  // Fluid boundary node
  1/alpha_c*der(T_c[radNodes_c]) = 1/delta_c^2*(2*T_c[radNodes_c - 1] - 2
    *T_c[radNodes_c] - 2*delta_c*h/k_c*(T_c[radNodes_c] - T_cool)) + 1/(2
    *(R_g + R_c)*delta_c)*(-2*delta_c*h/k_c*(T_c[radNodes_c] - T_cool));

  /* FUEL-TO-COOLANT HEAT TRANSFER */
  heatOut.T = T_c[radNodes_c];
  // heatOut.Q_flow = q_ppp*V_f;

initial equation
  der(T_f) = zeros(radNodes_f);
  der(T_c) = zeros(radNodes_c);
  // der(T_g) = 0; // If gap conductance model is used...

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Ellipse(
                extent={{-100,100},{100,-100}},
                pattern=LinePattern.None,
                lineThickness=1,
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,0}),Ellipse(
                extent={{-95,95},{95,-95}},
                pattern=LinePattern.None,
                lineThickness=1,
                fillColor={215,215,215},
                fillPattern=FillPattern.Sphere,
                lineColor={179,123,115}),Ellipse(
                extent={{-90,90},{90,-90}},
                pattern=LinePattern.None,
                lineThickness=1,
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,0}),Text(
                extent={{-30,15},{30,-15}},
                lineColor={175,175,175},
                lineThickness=1,
                fillPattern=FillPattern.Sphere,
                fillColor={215,215,215},
                textString="Fuel")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Ellipse(
                extent={{-100,100},{100,-100}},
                pattern=LinePattern.None,
                lineThickness=1,
                fillColor={95,95,95},
                fillPattern=FillPattern.Sphere,
                lineColor={175,175,175}),Ellipse(
                extent={{-95,95},{95,-95}},
                pattern=LinePattern.None,
                lineThickness=1,
                fillColor={215,215,215},
                fillPattern=FillPattern.Sphere,
                lineColor={179,123,115}),Ellipse(
                extent={{-90,90},{90,-90}},
                pattern=LinePattern.None,
                lineThickness=1,
                fillColor={95,95,95},
                fillPattern=FillPattern.Sphere,
                lineColor={175,175,175}),Text(
                extent={{-30,15},{30,-15}},
                lineColor={175,175,175},
                lineThickness=1,
                fillPattern=FillPattern.Sphere,
                fillColor={215,215,215},
                textString="Fuel"),Text(
                extent={{-15,5},{15,-5}},
                lineColor={175,175,175},
                lineThickness=1,
                fillPattern=FillPattern.Sphere,
                fillColor={215,215,215},
                textString="Neutron Flux
Vector",        origin={-105,20},
                rotation=90),Text(
                extent={{-15,5},{15,-5}},
                lineColor={175,175,175},
                lineThickness=1,
                fillPattern=FillPattern.Sphere,
                fillColor={215,215,215},
                origin={105,25},
                rotation=270,
                textString="Heat Output
Vector")}),
    DymolaStoredErrors,
    experiment(StopTime=1000, NumberOfIntervals=10000),
    __Dymola_experimentSetupOutput,
    Diagram(graphics));
end CylindricalFuelThermalModel;
