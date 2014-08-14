within ORNL_AdvSMR.PRISM.CORE;
model FuelPellet_wDHT
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
  parameter Integer radNodes_f=8 "Number of Radial Nodes"
    annotation (Dialog(tab="Geometry", group="Fuel"));
  /* Gap */
  parameter Length R_g "Radius of Gap"
    annotation (Dialog(tab="Geometry", group="Gap"));
  parameter Length H_g "Height of Gap"
    annotation (Dialog(tab="Geometry", group="Gap"));
  //  parameter Real alpha_g=1e6 "Gap thermal diffusivity";
  /* Cladding */
  parameter Length R_c "Radius of Cladding"
    annotation (Dialog(tab="Geometry", group="Cladding"));
  parameter Length H_c "Height of Cladding"
    annotation (Dialog(tab="Geometry", group="Cladding"));
  parameter Integer radNodes_c=4 "Number of Radial Nodes"
    annotation (Dialog(tab="Geometry", group="Cladding"));
  //   parameter Temperature T_cool=500 + 273.15
  //     annotation (Dialog(tab="Geometry", group="Heat Transfer Fluid"));
  //   parameter CoefficientOfHeatTransfer h=20e3 "Fluid heat transfer coefficient"
  //     annotation (Dialog(tab="Geometry", group="Heat Transfer Fluid"));

  /* Material thermophysical paramaters */
  /* Fuel */
  replaceable model fuelMaterial = ORNL_AdvSMR.Media.Solids.U_Pu_Zr
    constrainedby ORNL_AdvSMR.Media.Solids.Common.MaterialTable "Fuel material"
    annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Material Properties", group="Fuel"));
  parameter Real W_Pu(min=0.0, max=1.0) "Plutonium weight percent" annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Material Properties", group="Fuel"));
  parameter Real W_Zr(min=0.0, max=1.0) "Zirconium weight percent" annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Material Properties", group="Fuel"));
  parameter Real P=0.0 "Fuel porosity fraction" annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Material Properties", group="Fuel"));
  parameter Real P_Na=0.0 "Fraction of sodium infiltration into the fuel metal"
    annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Material Properties", group="Fuel"));
  parameter Boolean varConductivity=true
    "Thermal conductivity varies as a function of temperature" annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Material Properties", group="Fuel"));
  Real W_U=1 - (W_Pu + W_Zr) "Uranium weight percent";
  Real a=17.5*(1.0 - 2.23*W_Zr)/(1.0 + 1.61*W_Zr) - 2.62*W_Pu;
  Real b=1.54e-2*(1.0 + 0.061*W_Zr)/(1.0 + 1.61*W_Zr) + 0.9*W_Pu;
  Real c=9.38e-6*(1.0 - 2.7*W_Pu);
  Density[radNodes_f] rho_f "Density";
  SpecificHeatCapacity[radNodes_f] cp_f "Specific heat capacity";
  ThermalConductivity[radNodes_f] k_f0
    "Fuel thermal conductivity with no sodium infiltration";
  ThermalConductivity[radNodes_f] k_f
    "Fuel thermal conductivity with sodium infiltration";
  Real[radNodes_f] alpha_f
    "Thermal diffusivity for fuel region (alpha = k/rho cp)";
  Length delta_f=R_f/radNodes_f "Radial thickness of fuel nodes";
  Area A_f=pi*R_f^2 "Cross sectional area of the fuel (m2)";
  Volume V_f=A_f*H_f "Fuel volume (m3)";

  /* Gap */
  replaceable package gapMaterial = ORNL_AdvSMR.Media.Fluids.Na constrainedby
    ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "Gap material"
    annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Material Properties", group="Gap"));
  Density rho_g "Density";
  SpecificHeatCapacity cp_g "Specific heat capacity";
  ThermalConductivity k_g "Thermal conductivity";
  Real alpha_g "Thermal diffusivity for gap region (alpha = k/rho cp)";
  Length delta_g=R_g - R_f "Radial thickness of gap nodes";
  Area A_g=pi*(R_g^2 - R_f^2) "Cross sectional area of the gap (m2)";
  Volume V_g=A_g*H_g "Gap volume (m3)";

  /* Cladding */
  replaceable model cladMaterial = ORNL_AdvSMR.Media.Solids.HT9 constrainedby
    ORNL_AdvSMR.Media.Solids.Common.MaterialTable "Cladding material"
    annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Material Properties", group="Cladding"));
  Density[radNodes_c] rho_c "Density";
  SpecificHeatCapacity[radNodes_c] cp_c "Specific heat capacity";
  ThermalConductivity[radNodes_c] k_c "Thermal conductivity";
  Real[radNodes_c] alpha_c
    "Thermal diffusivity for cladding region (alpha = k/rho cp)";
  Length delta_c=(R_c - R_g)/radNodes_c "Radial thickness of cladding nodes";
  Area A_c=pi*(R_c^2 - R_g^2) "Cross sectional area of the cladding (m2)";
  Area A_h=2*pi*R_c*H_c "Heat transfer surface area";
  Volume V_c=A_c*H_c "Cladding volume (m3)";

  // State variables
  Temperature[radNodes_f] T_f "Fuel temperature profile";
  Temperature T_g "Average gap temperature";
  Temperature[radNodes_c] T_c "Cladding temperature profile";
  Temperature T_cool "Coolant temperature";
  ORNL_AdvSMR.SIunits.VolumetricHeatGenerationRate q_ppp
    "Volumetric heat generation rate in a radial node";
  CoefficientOfHeatTransfer h "Fluid heat transfer coefficient";

public
  SIInterfaces.SIPowerInput powerIn annotation (Placement(transformation(extent
          ={{-100,-10},{-80,10}}), iconTransformation(extent={{-100,-10},{-80,
            10}})));
  replaceable ORNL_AdvSMR.Interfaces.HT wall constrainedby
    ORNL_AdvSMR.Interfaces.HT "Heat transfer port to the coolant" annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,0}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,0})));

equation
  /* VOLUMETRIC HEAT GENERATION RATE */
  q_ppp = powerIn/V_f "Volumetric heat generation rate in fuel";
  assert(W_Pu + W_Zr < 1.0,
    "Sum of plutonium and zirconium weight percents cannot be greater 1.0!");

  /* FUEL */
  // Recalculate fuel thermal properties
  rho_f = 15.7e3*ones(radNodes_f) "(kg/m3)";
  cp_f = 17e3*ones(radNodes_f) "(J/kgK)";
  k_f0 = a .+ b .* T_f .+ c .* T_f .^ 2 "W/m2K";
  k_f = k_f0 "W/m2K - Sodium infiltration neglected...";
  alpha_f = k_f ./ (rho_f .* cp_f);
  // Finite difference in center node
  1/alpha_f[1]*der(T_f[1]) = 4/delta_f^2*(T_f[2] - T_f[1]) + 1/k_f[1]*q_ppp;
  // Finite difference in interior nodes
  for i in 2:radNodes_f - 1 loop
    1/alpha_f[i]*der(T_f[i]) = 1/delta_f^2*(T_f[i - 1] - 2*T_f[i] + T_f[i + 1])
       + 1/(i*delta_f)*1/(2*delta_f)*(T_f[i + 1] - T_f[i - 1]) + 1/k_f[i]*q_ppp;
  end for;
  // Finite difference in gap boundary node
  1/alpha_f[radNodes_f]*der(T_f[radNodes_f]) = 1/delta_f^2*(T_f[radNodes_f - 1]
     - 2*T_f[radNodes_f] + T_g) + 1/(2*R_f*delta_f)*(T_g - T_f[radNodes_f - 1])
     + 1/k_f[radNodes_f]*q_ppp;

  /* GAP */
  rho_g = 1017.0 - 0.239*T_g
    "Linearized version of density equation by Stone et al.";
  cp_g = 1275.3 "Constant sodium specific heat capacity";
  k_g = 93.0 - 0.0581*T_g + 1.173e-5*T_g^2 "Liquid sodium thermal conductivity";
  alpha_g = k_g/(rho_g*cp_g) "Thermal diffusivity";
  // Finite difference for gap
  1/alpha_g*der(T_g) = 1/delta_g^2*(T_f[radNodes_f] - 2*T_g + T_c[1]) + 1/(2*
    R_g*delta_g)*(T_c[1] - T_f[radNodes_f]);

  /* CLADDING */
  rho_c = 7800*ones(radNodes_c);
  cp_c = 1000*(0.475 .+ 2*0.0007 .* T_c .- 2876.1 ./ T_c .^ 2);
  k_c = 17.622 .+ 2.42e-2 .* T_c .- 1.696e-5 .* T_c .^ 2;
  alpha_c = k_c ./ (rho_c .* cp_c);
  // Finite difference for gap boundary node
  1/alpha_c[1]*der(T_c[1]) = 1/delta_c^2*(T_g - 2*T_c[1] + T_c[2]) + 1/(2*(R_g
     + delta_c)*delta_c)*(T_c[2] - T_g);
  // Finite difference for clad interior nodes
  for i in 2:radNodes_c - 1 loop
    1/alpha_c[i]*der(T_c[i]) = 1/delta_c^2*(T_c[i - 1] - 2*T_c[i] + T_c[i + 1])
       + 1/(2*(R_g + i*delta_c)*delta_c)*(T_c[i + 1] - T_c[i - 1]);
  end for;
  // Finite difference for clad-fluid boundary node
  1/alpha_c[radNodes_c]*der(T_c[radNodes_c]) = 2/delta_c^2*(T_c[radNodes_c - 1]
     - T_c[radNodes_c] - delta_c*h/k_c[radNodes_c]*(T_c[radNodes_c] - T_cool))
     + 1/R_c*h/k_c[radNodes_c]*(T_c[radNodes_c] - T_cool);

  /* FUEL-TO-COOLANT HEAT TRANSFER */
  wall.T = T_c[radNodes_c]*ones(2);
  // wall.phi = -powerIn/A_h * ones(2);

initial equation
  der(T_f) = zeros(radNodes_f);
  der(T_c) = zeros(radNodes_c);
  der(T_g) = 0;

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
Vector",  origin={-105,20},
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
end FuelPellet_wDHT;
