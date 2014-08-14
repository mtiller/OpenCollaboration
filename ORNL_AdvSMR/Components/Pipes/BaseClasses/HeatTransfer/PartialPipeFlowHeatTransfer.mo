within ORNL_AdvSMR.Components.Pipes.BaseClasses.HeatTransfer;
partial model PartialPipeFlowHeatTransfer
  "Base class for pipe heat transfer correlation in terms of Nusselt number heat transfer in a circular pipe for laminar and turbulent one-phase flow"
  extends PartialFlowHeatTransfer;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha0=100
    "guess value for heat transfer coefficients";
  Modelica.SIunits.CoefficientOfHeatTransfer[n] alphas(each start=alpha0)
    "CoefficientOfHeatTransfer";
  Real[n] Res "Reynolds numbers";
  Real[n] Prs "Prandtl numbers";
  Real[n] Nus "Nusselt numbers";
  Medium.Density[n] ds "Densities";
  Medium.DynamicViscosity[n] mus "Dynamic viscosities";
  Medium.ThermalConductivity[n] lambdas "Thermal conductivity";
  Modelica.SIunits.Length[n] diameters=dimensions
    "Hydraulic diameters for pipe flow";
equation
  ds = Medium.density(states);
  mus = Medium.dynamicViscosity(states);
  lambdas = Medium.thermalConductivity(states);
  Prs = Medium.prandtlNumber(states);
  Res = CharacteristicNumbers.ReynoldsNumber(
    vs,
    ds,
    mus,
    diameters);
  Nus = CharacteristicNumbers.NusseltNumber(
    alphas,
    diameters,
    lambdas);
  Q_flows = {alphas[i]*surfaceAreas[i]*(heatPorts[i].T - Ts[i])*nParallel for i
     in 1:n};
  annotation (Documentation(info="<html>
Base class for heat transfer models that are expressed in terms of the Nusselt number and which can be used in distributed pipe models.
</html>"));
end PartialPipeFlowHeatTransfer;
