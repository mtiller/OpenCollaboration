within ORNL_AdvSMR;
model System "System wide properties"

  import SI = Modelica.SIunits;

  // Assumptions
  parameter Boolean allowFlowReversal=true
    "= false to restrict to design flow direction (flangeA -> flangeB)"
    annotation (Evaluate=true);
  parameter SI.AbsolutePressure p_ambient=101325 "Default ambient pressure"
    annotation (Dialog(group="Environment"));
  parameter SI.Temperature T_ambient=293.15 "Default ambient temperature"
    annotation (Dialog(group="Environment"));
  parameter Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Constant gravity acceleration" annotation (Dialog(group="Environment"));
  parameter Choices.System.Dynamics Dynamics=Choices.System.Dynamics.DynamicFreeInitial;

  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Default formulation of energy balances"
    annotation (Evaluate=true,Dialog(tab="Assumptions", group="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics
    "Default formulation of mass balances"
    annotation (Evaluate=true,Dialog(tab="Assumptions", group="Dynamics"));
  final parameter Modelica.Fluid.Types.Dynamics substanceDynamics=massDynamics
    "Default formulation of substance balances"
    annotation (Evaluate=true,Dialog(tab="Assumptions", group="Dynamics"));
  final parameter Modelica.Fluid.Types.Dynamics traceDynamics=massDynamics
    "Default formulation of trace substance balances"
    annotation (Evaluate=true,Dialog(tab="Assumptions", group="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyState
    "Default formulation of momentum balances, if options available"
    annotation (Evaluate=true,Dialog(tab="Assumptions", group="Dynamics"));

  // Initialization
  parameter Modelica.SIunits.MassFlowRate m_flow_start=0
    "Default start value for mass flow rates"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.AbsolutePressure p_start=p_ambient
    "Default start value for pressures"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.Temperature T_start=T_ambient
    "Default start value for temperatures"
    annotation (Dialog(tab="Initialization"));

  // Advanced
  //parameter Modelica.SIunits.MassFlowRate m_flow_small(min=0) = 0.01
  // "Default small laminar mass flow rate for regularization of zero flow"
  //  annotation (Dialog(tab="Advanced"));
  //parameter Modelica.SIunits.AbsolutePressure dp_small(min=0) = 1
  // "Default small pressure drop for regularization of laminar and zero flow"
  //  annotation (Dialog(tab="Advanced"));
  parameter Boolean use_eps_Re=false
    "= true to determine turbulent region automatically using Reynolds number"
    annotation (Evaluate=true,Dialog(tab="Advanced"));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=if use_eps_Re then 1
       else 1e2*m_flow_small "Default nominal mass flow rate"
    annotation (Dialog(tab="Advanced",enable=use_eps_Re));
  parameter Real eps_m_flow(min=0) = 1e-4
    "Regularization of zero flow for |m_flow| < eps_m_flow*m_flow_nominal"
    annotation (Dialog(tab="Advanced", enable=use_eps_Re));
  parameter Modelica.SIunits.AbsolutePressure dp_small(min=0) = 1
    "Default small pressure drop for regularization of laminar and zero flow"
    annotation (Dialog(
      tab="Advanced",
      group="Classic",
      enable=not use_eps_Re));
  parameter Modelica.SIunits.MassFlowRate m_flow_small(min=0) = 1e-2
    "Default small mass flow rate for regularization of laminar and zero flow"
    annotation (Dialog(
      tab="Advanced",
      group="Classic",
      enable=not use_eps_Re));
initial equation
  //assert(use_eps_Re, "*** Using classic system.m_flow_small and system.dp_small."
  //       + " They do not distinguish between laminar flow and regularization of zero flow."
  //       + " Absolute small values are error prone for models with local nominal values."
  //       + " Moreover dp_small can generally be obtained automatically."
  //       + " Please update the model to new system.use_eps_Re = true  (see system, Advanced tab). ***",
  //       level=AssertionLevel.warning);

  annotation (
    defaultComponentName="system",
    defaultComponentPrefixes="inner",
    Icon(graphics={Polygon(
          points={{-100,60},{-60,100},{60,100},{100,60},{100,-60},{60,-100},{-60,
              -100},{-100,-60},{-100,60}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-80,40},{80,-20}},
          lineColor={0,0,255},
          textString="system")}));
end System;
