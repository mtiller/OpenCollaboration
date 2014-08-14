within ORNL_AdvSMR.Components;
model Accumulator "Water-Gas Accumulator"
  import aSMR = ORNL_AdvSMR;
  extends ORNL_AdvSMR.Icons.Water.Accumulator;
  replaceable package Medium = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialMedium "Liquid medium model";
  Medium.ThermodynamicState liquidState "Thermodynamic state of the liquid";

  parameter Modelica.SIunits.Volume V "Total volume";
  parameter Modelica.SIunits.Volume Vl0
    "Water nominal volume (at reference level)";
  parameter Modelica.SIunits.Area A "Cross Sectional Area";

  parameter Modelica.SIunits.Height zl0
    "Height of water reference level over inlet/outlet connectors";
  parameter Modelica.SIunits.Height zl_start
    "Water start level (relative to reference)";
  parameter Modelica.SIunits.SpecificEnthalpy hl_start
    "Water start specific enthalpy";
  parameter Modelica.SIunits.Pressure pg_start "Gas start pressure";
  parameter ORNL_AdvSMR.SIunits.AbsoluteTemperature Tg_start=300
    "Gas start temperature";

  parameter Modelica.SIunits.CoefficientOfHeatTransfer gamma_ex=50
    "Water-Gas heat transfer coefficient";
  parameter Modelica.SIunits.Temperature Tgin=300 "Inlet gas temperature";
  parameter Modelica.SIunits.MolarMass MM=29e-3 "Gas molar mass";
  parameter Modelica.SIunits.MassFlowRate wg_out0 "Nominal gas outlet flowrate";
  parameter ORNL_AdvSMR.SIunits.AbsoluteTemperature Tg0=300
    "Nominal gas temperature";
  parameter Modelica.SIunits.Pressure pg0 "Nominal gas pressure";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ORNL_AdvSMR.System system "System wide properties";
  parameter ORNL_AdvSMR.Choices.Init.Options initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit
    "Initialisation option";
protected
  constant Modelica.SIunits.Acceleration g=Modelica.Constants.g_n;
  constant Real R=Modelica.Constants.R "Universal gas constant";
  parameter Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cpg=(7/2)*
      Rstar "Cp of gas";
  parameter Modelica.SIunits.SpecificHeatCapacityAtConstantVolume cvg=(5/2)*
      Rstar "Cv of gas";
  parameter Real Rstar=R/MM "Gas constant";
  parameter Real K=wg_out0/(pg0*sqrt(Tg0)) "Gas outlet flow coefficient";
public
  Modelica.SIunits.MassFlowRate wl_in "Water inflow mass flow rate";
  Modelica.SIunits.MassFlowRate wl_out "Water outflow mass flow rate";
  Modelica.SIunits.Height zl(start=zl_start)
    "Water level (relative to reference)";
  Medium.SpecificEnthalpy hl_in "Water inlet specific enthalpy";
  Medium.SpecificEnthalpy hl_out "Water outlet specific enthalpy";
  Medium.SpecificEnthalpy hl(start=hl_start, stateSelect=StateSelect.prefer)
    "Water internal specific enthalpy";
  Modelica.SIunits.Volume Vl "Volume occupied by water";
  Modelica.SIunits.Mass Mg "Mass of gas";
  Medium.AbsolutePressure pf "Water Pressure at the inlet/outlet flanges";
  Modelica.SIunits.EnergyFlowRate Qp "Water-Gas heat flow";
  Modelica.SIunits.MassFlowRate wg_in "Gas inflow mass flow rate";
  Modelica.SIunits.MassFlowRate wg_out "Gas outflow mass flow rate";
  ORNL_AdvSMR.SIunits.GasDensity rhog(start=pg_start*MM/(R*Tg_start))
    "Gas density";
  Medium.Temperature Tg(start=Tg_start) "Gas temperature";
  Modelica.SIunits.Volume Vg "Volume occupied by gas";
  Medium.AbsolutePressure pg(start=pg_start) "Gas pressure";
  ORNL_AdvSMR.SIunits.Density rho "Density of tue water";
  Modelica.Blocks.Interfaces.RealInput GasInfl annotation (Placement(
        transformation(extent={{-84,80},{-64,100}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeA WaterInfl(redeclare package Medium = Medium,
      m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-44,-100},{-24,-80}},
          rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB WaterOutfl(redeclare package Medium = Medium,
      m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{24,-100},{44,-80}}, rotation=
            0)));
  Modelica.Blocks.Interfaces.RealInput OutletValveOpening annotation (Placement(
        transformation(
        origin={44,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation

  //Equations for water and gas volumes and exchanged thermal power
  Vl = Vl0 + A*zl;
  Vg = V - Vl;
  Qp = gamma_ex*A*(Medium.temperature(liquidState) - Tg);

  // Boundary conditions
  // (Thermal effects of the water going out of the accumulator are neglected)
  hl_in = homotopy(if not allowFlowReversal then inStream(WaterInfl.h_outflow)
     else if wl_in >= 0 then inStream(WaterInfl.h_outflow) else hl, inStream(
    WaterInfl.h_outflow));
  hl_out = homotopy(if not allowFlowReversal then hl else if wl_out >= 0 then
    inStream(WaterOutfl.h_outflow) else hl, hl);
  WaterInfl.h_outflow = inStream(WaterOutfl.h_outflow);
  WaterOutfl.h_outflow = inStream(WaterInfl.h_outflow);
  wl_in = WaterInfl.m_flow;
  wl_out = WaterOutfl.m_flow;
  WaterInfl.p = pf;
  WaterOutfl.p = pf;

  rho*A*der(zl) = wl_in + wl_out
    "Water mass balance (density variations neglected)";
  rho*Vl*der(hl) - Vl*der(pg) - pg*der(Vl) = wl_in*(hl_in - hl) + wl_out*(
    hl_out - hl) - Qp "Water energy balance";

  // Set liquid properties
  liquidState = Medium.setState_ph(pg, hl);
  rho = Medium.density(liquidState);

  pf = pg + rho*g*(zl + zl0) "Stevino's law";

  wg_in = GasInfl "Gas inlet mass-flow rate";

  //Gas outlet mass-flow rate
  wg_out = -OutletValveOpening*K*pg*sqrt(Tg);

  pg = rhog*Rstar*Tg "Gas state equation";
  Mg = Vg*rhog "Gas mass";
  der(Mg) = wg_in + wg_out "Gas mass balance";
  rhog*Vg*cpg*der(Tg) = wg_in*cpg*(Tgin - Tg) + Vg*der(pg) + Qp
    "Gas energy balance";
initial equation
  if initOpt == ORNL_AdvSMR.Choices.Init.Options.noInit then
    // do nothing
  elseif initOpt == ORNL_AdvSMR.Choices.Init.Options.steadyState then
    zl = zl_start;
    der(Tg) = 0;
    der(hl) = 0;
    der(Vl) = 0;
  elseif initOpt == ORNL_AdvSMR.Choices.Init.Options.steadyStateNoP then
    zl = zl_start;
    der(Tg) = 0;
    der(hl) = 0;
  else
    assert(false, "Unsupported initialisation option");
  end if;
  annotation (
    Diagram(graphics),
    Icon(graphics),
    DymolaStoredErrors,
    Documentation(info="<HTML>
<p>This model describes a water-gas accumulator (the gas is modeled as ideal bi-atomic). <p>
Water flows in and out through the interfaces at the component bottom (flow reversal supported). <p>
The gas is supposed to flow in at constant temperature (parameter <tt>Tgin</tt>) and with variable flow-rate (<tt>GasInfl</tt> signal port), and to flow out by a valve operating in choked condition; the valve coefficient is determined by the working point at full opening (<tt>wg_out0,Tg0, Pg0</tt>) while the valve opening (in the range <tt>0-1</tt>) is an input signal (<tt>OutletValveOpening</tt> signal port).
<p><b>Dimensional parameters</b></p>
<ul>
<li><tt>V</tt>: accumulator total volume;
<li><tt>Vl0</tt>: volume occupied by water at the nominal level (reference value);
<li><tt>zl0</tt>: height of water nominal level above the water connectors;
<li><tt>A</tt>: cross-sectional area at actual water level;
</ul>
</HTML>", revisions="<html>
<ul>
<li><i>30 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Initialisation support added.</li>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>18 Jun 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<li><i>5 Feb 2004</i>
    by <a href=\"mailto:francesco.schiavo@polimi.it\">Francesco Schiavo</a>:<br>
       First release.</li>
</ul>
</html>"));
end Accumulator;
