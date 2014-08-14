within ORNL_AdvSMR.PRISM.PowerConversionSystem.SteamTurbines;
model SteamTurbineVarEta "Steam turbine with variable efficiency"
  extends ThermoPower3.Water.SteamTurbineBase;

  //Parameter
  parameter Modelica.SIunits.Area Kt "Kt coefficient of Stodola's law";
  replaceable function curveEta_iso =
      ThermoPower3.PowerPlants.SteamTurbineGroup.Functions.curveEfficiency
    "Characteristich curve of efficiency";
  parameter Real eta_iso_nom=0.92 "Nominal isentropic efficiency";
  parameter Real x=0.5 "Degree of reaction";
  parameter Modelica.SIunits.Length Rm "Mean ray";
  parameter Integer n "Number of stages";

  //Variable
  Real y "Ratio uf/wiso";
  Real uf "Mean peripheral velocity of the rotor";
  Real viso "Mean velocity of the fluid in isentropic conditions";

equation
  w = Kt*partialArc*sqrt(Medium.pressure(steamState_in)*Medium.density(
    steamState_in))*ThermoPower3.Functions.sqrtReg(1 - (1/PR)^2)
    "Stodola's law";

  uf = omega*Rm;
  viso = sqrt(2*(hin - hiso)/n);
  y = uf/viso;
  eta_iso = curveEta_iso(
    eta_iso_nom,
    y,
    x) "Variable efficiency";
end SteamTurbineVarEta;
