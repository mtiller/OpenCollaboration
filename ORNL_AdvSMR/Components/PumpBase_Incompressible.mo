within ORNL_AdvSMR.Components;
partial model PumpBase_Incompressible "Base model for centrifugal pumps"
  import aSMR = ORNL_AdvSMR;
  extends ORNL_AdvSMR.Icons.Water.Pump;
  import Modelica.SIunits.Conversions.NonSIunits.*;
  replaceable package Medium = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialMedium "Medium model";
  //   Medium.ThermodynamicState inletFluidState
  //     "Thermodynamic state of the fluid at the inlet";
  replaceable function flowCharacteristic =
      ORNL_AdvSMR.Functions.PumpCharacteristics.quadraticFlow constrainedby
    ORNL_AdvSMR.Functions.PumpCharacteristics.baseFlow
    "Head vs. q_flow characteristic at nominal speed and density" annotation (
      Dialog(group="Characteristics"), choicesAllMatching=true);
  parameter Boolean usePowerCharacteristic=false
    "Use powerCharacteristic (vs. efficiencyCharacteristic)"
    annotation (Dialog(group="Characteristics"));
  replaceable function powerCharacteristic =
      ORNL_AdvSMR.Functions.PumpCharacteristics.constantPower constrainedby
    ORNL_AdvSMR.Functions.PumpCharacteristics.basePower
    "Power consumption vs. q_flow at nominal speed and density" annotation (
      Dialog(group="Characteristics",enable=usePowerCharacteristic),
      choicesAllMatching=true);
  replaceable function efficiencyCharacteristic =
      ORNL_AdvSMR.Functions.PumpCharacteristics.constantEfficiency (eta_nom=0.8)
    constrainedby ORNL_AdvSMR.Functions.PumpCharacteristics.baseEfficiency
    "Efficiency vs. q_flow at nominal speed and density" annotation (Dialog(
        group="Characteristics", enable=not usePowerCharacteristic),
      choicesAllMatching=true);
  parameter Integer Np0(min=1) = 1 "Nominal number of pumps in parallel";
  parameter ORNL_AdvSMR.SIunits.Density rho0=2056 "Nominal Liquid Density"
    annotation (Dialog(group="Characteristics"));
  parameter AngularVelocity_rpm n0 "Nominal rotational speed"
    annotation (Dialog(group="Characteristics"));
  parameter Modelica.SIunits.Volume V=0 "Pump Internal Volume"
    annotation (Evaluate=true);
  parameter Boolean CheckValve=false "Reverse flow stopped";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ORNL_AdvSMR.System system "System wide properties";
  parameter Modelica.SIunits.MassFlowRate wstart=w0
    "Mass Flow Rate Start Value" annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.SpecificEnthalpy hstart=1e5
    "Specific Enthalpy Start Value" annotation (Dialog(tab="Initialisation"));
  parameter ORNL_AdvSMR.Choices.Init.Options initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit
    "Initialisation option" annotation (Dialog(tab="Initialisation"));
  constant Modelica.SIunits.Acceleration g=Modelica.Constants.g_n;
  parameter Modelica.SIunits.MassFlowRate w0 "Nominal mass flow rate"
    annotation (Dialog(group="Characteristics"));
  parameter Modelica.SIunits.Pressure dp0 "Nominal pressure increase"
    annotation (Dialog(group="Characteristics"));
  final parameter Modelica.SIunits.VolumeFlowRate q_single0=w0/(Np0*rho0)
    "Nominal volume flow rate (single pump)";
  final parameter Modelica.SIunits.Height head0=dp0/(rho0*g)
    "Nominal pump head";
protected
  function df_dqflow = der(flowCharacteristic, q_flow);
  constant Modelica.SIunits.Pressure p0=1.01325e5 "Reference pressure";
  constant Modelica.SIunits.Temperature T0=731.15
    "Reference temperature and critical temperature";
  constant Modelica.SIunits.SpecificHeatCapacity cp0=2386
    "Specific heat capacity is assumed constant within the temperature range";
  // constant Modelica.SIunits.Density rho0=2056
  //  "Density at reference temperature";
  constant Modelica.SIunits.RelativePressureCoefficient beta_r=2.3755e-4
    "Relative pressure coefficient";
  constant Modelica.SIunits.SpecificEnthalpy h0=1.7445e6
    "Fluid enthalpy at reference pressure and temperature";
  constant Modelica.SIunits.DynamicViscosity eta0=0.03023
    "Dynamic viscosity at reference pressure and temperature";
  constant Modelica.SIunits.ThermalConductivity lambda0=0.966827
    "Thermal conductivty at reference pressure and temperature";

public
  Modelica.SIunits.MassFlowRate w_single(start=wstart/Np0)
    "Mass flow rate (single pump)";
  Modelica.SIunits.MassFlowRate w=Np*w_single "Mass flow rate (total)";
  Modelica.SIunits.VolumeFlowRate q_single(start=wstart/(Np0*rho0))
    "Volume flow rate (single pump)";
  Modelica.SIunits.VolumeFlowRate q=Np*q_single "Volume flow rate (total)";
  Modelica.SIunits.Pressure dp "Outlet pressure minus inlet pressure";
  Modelica.SIunits.Height head "Pump head";
  Medium.SpecificEnthalpy h(start=hstart) "Fluid specific enthalpy";
  Medium.SpecificEnthalpy hin "Enthalpy of entering fluid";
  Medium.SpecificEnthalpy hout "Enthalpy of outgoing fluid";
  ORNL_AdvSMR.SIunits.LiquidDensity rho "Liquid density";
  Medium.Temperature Tin "Liquid inlet temperature";
  AngularVelocity_rpm n "Shaft r.p.m.";
  Integer Np(min=1) "Number of pumps in parallel";
  Modelica.SIunits.Power W_single "Power Consumption (single pump)";
  Modelica.SIunits.Power W=Np*W_single "Power Consumption (total)";
  constant Modelica.SIunits.Power W_eps=1e-8
    "Small coefficient to avoid numerical singularities";
  constant AngularVelocity_rpm n_eps=1e-6;
  Real eta "Pump efficiency";
  Real s "Auxiliary Variable";

  ORNL_AdvSMR.Interfaces.FlangeA infl(redeclare package Medium = Medium, m_flow(
        min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-100,0},{-60,40}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB outfl(redeclare package Medium = Medium,
      m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{40,50},{80,90}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput in_Np "Number of  parallel pumps"
    annotation (Placement(transformation(
        origin={28,80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  // Number of pumps in parallel
  Np = in_Np;
  if cardinality(in_Np) == 0 then
    in_Np = Np0 "Number of pumps selected by parameter";
  end if;

  // Flow equations
  q_single = w_single/homotopy(rho, rho0);
  head = dp/(homotopy(rho, rho0)*g);
  if noEvent(s > 0 or (not CheckValve)) then
    // Flow characteristics when check valve is open
    q_single = s;
    head = homotopy((n/n0)^2*flowCharacteristic(q_single*n0/(n + n_eps)),
      df_dqflow(q_single0)*(q_single - q_single0) + (2/n0*flowCharacteristic(
      q_single0) - q_single0/n0*df_dqflow(q_single0))*(n - n0) + head0);
  else
    // Flow characteristics when check valve is closed
    head = homotopy((n/n0)^2*flowCharacteristic(0) - s, df_dqflow(q_single0)*(
      q_single - q_single0) + (2/n0*flowCharacteristic(q_single0) - q_single0/
      n0*df_dqflow(q_single0))*(n - n0) + head0);
    q_single = 0;
  end if;

  // Power consumption
  if usePowerCharacteristic then
    W_single = (n/n0)^3*(rho/rho0)*powerCharacteristic(q_single*n0/(n + n_eps))
      "Power consumption (single pump)";
    eta = (dp*q_single)/(W_single + W_eps) "Hydraulic efficiency";
  else
    eta = efficiencyCharacteristic(q_single*n0/(n + n_eps));
    W_single = dp*q_single/eta;
  end if;

  // Fluid properties
  // inletFluidState = Medium.setState_ph(infl.p, hin);
  // rho = Medium.density(inletFluidState);
  rho = rho0*(1 - beta_r*(Tin - T0)) "Density as a function of temperature";
  // Tin = Medium.temperature(inletFluidState);
  Tin = T0 + (h - h0)/cp0 "Temperature as a function of enthalpy";

  // Boundary conditions
  dp = outfl.p - infl.p;
  w = infl.m_flow "Pump total flow rate";
  hin = homotopy(if not allowFlowReversal then inStream(infl.h_outflow) else
    if w >= 0 then inStream(infl.h_outflow) else inStream(outfl.h_outflow),
    inStream(infl.h_outflow));
  infl.h_outflow = hout;
  outfl.h_outflow = hout;
  h = hout;

  // Mass and energy balances
  infl.m_flow + outfl.m_flow = 0 "Mass balance";
  if V > 0 then
    (rho*V*der(h)) = (outfl.m_flow/Np)*hout + (infl.m_flow/Np)*hin + W_single
      "Energy balance";
  else
    0 = (outfl.m_flow/Np)*hout + (infl.m_flow/Np)*hin + W_single
      "Energy balance";
  end if;

initial equation
  if initOpt == ORNL_AdvSMR.Choices.Init.Options.noInit then
    // do nothing
  elseif initOpt == ORNL_AdvSMR.Choices.Init.Options.steadyState then
    if V > 0 then
      der(h) = 0;
    end if;
  else
    assert(false, "Unsupported initialisation option");
  end if;

  annotation (
    Icon(graphics),
    Diagram(graphics),
    Documentation(info="<HTML>
<p>This is the base model for the <tt>Pump</tt> and <tt>
PumpMech</tt> pump models.
<p>The model describes a centrifugal pump, or a group of <tt>Np</tt> identical pumps in parallel. The pump model is based on the theory of kinematic similarity: the pump characteristics are given for nominal operating conditions (rotational speed and fluid density), and then adapted to actual operating condition, according to the similarity equations. 
<p>In order to avoid singularities in the computation of the outlet enthalpy at zero flowrate, the thermal capacity of the fluid inside the pump body can be taken into account.
<p>The model can either support reverse flow conditions or include a built-in check valve to avoid flow reversal.
<p><b>Modelling options</b></p>
<p> The nominal hydraulic characteristic (head vs. volume flow rate) is given by the the replaceable function <tt>flowCharacteristic</tt>. 
<p> The pump energy balance can be specified in two alternative ways:
<ul>
<li><tt>usePowerCharacteristic = false</tt> (default option): the replaceable function <tt>efficiencyCharacteristic</tt> (efficiency vs. volume flow rate in nominal conditions) is used to determine the efficiency, and then the power consumption. The default is a constant efficiency of 0.8.
<li><tt>usePowerCharacteristic = true</tt>: the replaceable function <tt>powerCharacteristic</tt> (power consumption vs. volume flow rate in nominal conditions) is used to determine the power consumption, and then the efficiency.
</ul>
<p>
Several functions are provided in the package <tt>Functions.PumpCharacteristics</tt> to specify the characteristics as a function of some operating points at nominal conditions.
<p>Depending on the value of the <tt>checkValve</tt> parameter, the model either supports reverse flow conditions, or includes a built-in check valve to avoid flow reversal.
 
<p>If the <tt>in_Np</tt> input connector is wired, it provides the number of pumps in parallel; otherwise,  <tt>Np0</tt> parallel pumps are assumed.</p>
<p>It is possible to take into account the heat capacity of the fluid inside the pump by specifying its volume <tt>V</tt> at nominal conditions; this is necessary to avoid singularities in the computation of the outlet enthalpy in case of zero flow rate. If zero flow rate conditions are always avoided, this dynamic effect can be neglected by leaving the default value <tt>V = 0</tt>, thus avoiding a fast state variable in the model.
<p>The <tt>CheckValve</tt> parameter determines whether the pump has a built-in check valve or not.
<p>If <tt>computeNPSHa = true</tt>, the available net positive suction head is also computed; this requires a two-phase medium model to provide the fluid saturation pressure.
</HTML>", revisions="<html>
<ul>
<li><i>31 Oct 2006</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
      Added initialisation parameter <tt>wstart</tt>.</li>
<li><i>5 Nov 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
      Model restructured according to kinematic similarity theory.<br>
      Characteristics now specified by replaceable functions.</li>
<li><i>6 Apr 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       <tt>CharData</tt> substituted by <tt>OpPoints</tt></li>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>2 Aug 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Optional NPSHa computation added. Changed parameter names</li>
<li><i>5 Jul 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Model restructured by using inheritance. Adapted to Modelica.Media.</li>
<li><i>15 Jan 2004</i>
    by <a href=\"mailto:francesco.schiavo@polimi.it\">Francesco Schiavo</a>:<br>
       <tt>ThermalCapacity</tt> and <tt>CheckValve</tt> added.</li>
<li><i>15 Dec 2003</i>
    by <a href=\"mailto:francesco.schiavo@polimi.it\">Francesco Schiavo</a>:<br>
       First release.</li>
</ul>
</html>"));
end PumpBase_Incompressible;
