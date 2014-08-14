within ORNL_AdvSMR.Media.Fluids.LiFBeF2;
package flibe_incompressible "Simple incompressible flibe model"


extends Modelica.Media.Interfaces.PartialMedium(
  mediumName="LiFBeF2",
  singleState=true,
  reducedX=true,
  SpecificEnthalpy(start=1.0e5, nominal=5.0e5),
  Density(start=1900, nominal=1950),
  AbsolutePressure(start=1e5, nominal=1.01325e5),
  Temperature(start=490, nominal=675));

constant Modelica.SIunits.Pressure p0=1.01325e5 "Reference pressure";
constant Modelica.SIunits.Temperature T0=731.15
  "Reference temperature and critical temperature";
constant Modelica.SIunits.SpecificHeatCapacity cp0=2386
  "Specific heat capacity is assumed constant within the temperature range";
constant Modelica.SIunits.Density rho0=2056 "Density at reference temperature";
constant Modelica.SIunits.RelativePressureCoefficient beta_r=2.3755e-4
  "Relative pressure coefficient";
constant Modelica.SIunits.SpecificEnthalpy h0=1.7445e6
  "Fluid enthalpy at reference pressure and temperature";
constant Modelica.SIunits.DynamicViscosity eta0=0.03023
  "Dynamic viscosity at reference pressure and temperature";
constant Modelica.SIunits.ThermalConductivity lambda0=0.966827
  "Thermal conductivty at reference pressure and temperature";


redeclare record extends ThermodynamicState
  Modelica.SIunits.Temperature T;
  end ThermodynamicState;


redeclare model extends BaseProperties "Base properties of medium"
  equation
  // h = cp0*(T-T0)+h0;
  T = T0 + (h - h0)/cp0 "Temperature as a function of enthalpy";
  d = rho0*(1 - beta_r*(T - T0)) "Density as a function of temperature";
  u = h "Fluid internal energy taken equal to enthalpy, i.e. pv = 0";
  R = 1;
  MM = 72.947 "Liquid flibe molar mass";
  state.T = T "Temperature state";
  end BaseProperties;


redeclare function extends specificHeatCapacityCp
  "Return specific heat capacity at constant pressure"
  algorithm
  cp := cp0;
  end specificHeatCapacityCp;


redeclare function extends specificHeatCapacityCv
  "Return specific heat capacity at constant volume"
  algorithm
  cv := cp0;
  end specificHeatCapacityCv;


redeclare function extends density_derh_p
  "density derivative by specific enthalpy at const pressure"
  algorithm
  ddhp := -rho0*beta_r/cp0;
  end density_derh_p;


redeclare function extends density_derp_h
  "density derivative by pressure at const specific enthalpy"
  algorithm
  ddph := 0;
  end density_derp_h;


redeclare function extends dynamicViscosity "Return dynamic viscosity"
  algorithm
  eta := eta0;
  end dynamicViscosity;


redeclare function extends thermalConductivity "Return thermal conductivity"
  algorithm
  lambda := lambda0;
  end thermalConductivity;
end flibe_incompressible;
