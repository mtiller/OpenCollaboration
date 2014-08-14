within ORNL_AdvSMR.PRISM.PowerConversionSystem.GasTurbineGroup.Examples;
model GasTurbineSimplified
  extends Interfaces.GasTurbineSimplified;
  parameter Modelica.SIunits.Power maxPower=235e6;
  parameter Modelica.SIunits.MassFlowRate flueGasNomFlowRate=614
    "Nominal flue gas flow rate";
  parameter Modelica.SIunits.MassFlowRate flueGasMinFlowRate=454
    "Minimum flue gas flow rate";
  parameter Modelica.SIunits.MassFlowRate flueGasOffFlowRate=flueGasMinFlowRate
      /100 "Flue gas flow rate with GT switched off";
  parameter Modelica.SIunits.MassFlowRate fuelNomFlowRate=12.1
    "Nominal fuel flow rate";
  parameter Modelica.SIunits.MassFlowRate fuelIntFlowRate=7.08
    "Intermediate fuel flow rate";
  parameter Modelica.SIunits.MassFlowRate fuelMinFlowRate=4.58
    "Minimum fuel flow rate";
  parameter Modelica.SIunits.MassFlowRate fuelOffFlowRate=0.1
    "Flue gas flow rate with GT switched off";
  parameter Real constTempLoad=0.60
    "Fraction of load from which the temperature is kept constant";
  parameter Real intLoad=0.42
    "Intermediate load for fuel consumption computations";
  parameter Modelica.SIunits.Temperature flueGasNomTemp=843
    "Maximum flue gas temperature";
  parameter Modelica.SIunits.Temperature flueGasMinTemp=548
    "Minimum flue gas temperature (zero electrical load)";
  parameter Modelica.SIunits.Temperature flueGasOffTemp=363.15
    "Flue gas temperature with GT switched off";
  parameter Modelica.SIunits.SpecificEnthalpy fuel_LHV=49e6
    "Fuel Lower Heating Value";
  parameter Modelica.SIunits.SpecificEnthalpy fuel_HHV=55e6
    "Fuel Higher Heating Value";
  FlueGasMedium.BaseProperties gas;
  Modelica.SIunits.MassFlowRate w;
  Modelica.SIunits.Power P_el=noEvent(if GTLoad > 0 then GTLoad*maxPower else 0)
    "Electrical power output";
  Modelica.SIunits.MassFlowRate fuelFlowRate "Fuel flow rate";
equation
  gas.p = flueGasOut.p;
  gas.Xi = FlueGasMedium.reference_X[1:FlueGasMedium.nXi];
  gas.T = noEvent(if GTLoad > constTempLoad then flueGasNomTemp else if GTLoad
     > 0 then flueGasMinTemp + GTLoad/constTempLoad*(flueGasNomTemp -
    flueGasMinTemp) else flueGasMinTemp*(1 + GTLoad) - flueGasOffTemp*GTLoad);
  w = noEvent(if GTLoad > constTempLoad then flueGasMinFlowRate + (GTLoad -
    constTempLoad)/(1 - constTempLoad)*(flueGasNomFlowRate - flueGasMinFlowRate)
     else if GTLoad > 0 then flueGasMinFlowRate else flueGasMinFlowRate*(1 +
    GTLoad) - flueGasOffFlowRate*GTLoad);
  fuelFlowRate = noEvent(if GTLoad > intLoad then fuelIntFlowRate + (GTLoad -
    intLoad)/(1 - intLoad)*(fuelNomFlowRate - fuelIntFlowRate) else if GTLoad
     > 0 then fuelMinFlowRate + GTLoad/intLoad*(fuelIntFlowRate -
    fuelMinFlowRate) else fuelMinFlowRate*(1 + GTLoad) - fuelOffFlowRate*GTLoad);

  flueGasOut.m_flow = -w;
  flueGasOut.h_outflow = gas.h;
  flueGasOut.Xi_outflow = gas.Xi;
  annotation (Diagram(graphics));
end GasTurbineSimplified;
