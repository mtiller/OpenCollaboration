within ORNL_AdvSMR.Interfaces;
partial model PartialLumpedVolume "Lumped volume with mass and energy balance"
  import Modelica.Fluid.Types;
  import Modelica.Fluid.Types.Dynamics;
  import Modelica.Media.Interfaces.Choices.IndependentVariables;

  outer Modelica.Fluid.System system "System properties";
  replaceable package Medium = ORNL_AdvSMR.Media.Interfaces.PartialMedium
    "Medium in the component" annotation (choicesAllMatching=true);

  // Inputs provided to the volume model
  input Modelica.SIunits.Volume fluidVolume "Volume";

  // Assumptions
  parameter Types.Dynamics energyDynamics=system.energyDynamics
    "Formulation of energy balance"
    annotation (Evaluate=true,Dialog(tab="Assumptions", group="Dynamics"));
  parameter Types.Dynamics massDynamics=system.massDynamics
    "Formulation of mass balance"
    annotation (Evaluate=true,Dialog(tab="Assumptions", group="Dynamics"));
  final parameter Types.Dynamics substanceDynamics=massDynamics
    "Formulation of substance balance"
    annotation (Evaluate=true,Dialog(tab="Assumptions", group="Dynamics"));
  final parameter Types.Dynamics traceDynamics=massDynamics
    "Formulation of trace substance balance"
    annotation (Evaluate=true,Dialog(tab="Assumptions", group="Dynamics"));

  // Initialization
  parameter Medium.AbsolutePressure p_start=system.p_start
    "Start value of pressure" annotation (Dialog(tab="Initialization"));
  parameter Boolean use_T_start=true "= true, use T_start, otherwise h_start"
    annotation (Dialog(tab="Initialization"), Evaluate=true);
  parameter Medium.Temperature T_start=if use_T_start then system.T_start else
      Medium.temperature_phX(
      p_start,
      h_start,
      X_start) "Start value of temperature"
    annotation (Dialog(tab="Initialization", enable=use_T_start));
  parameter Medium.SpecificEnthalpy h_start=if use_T_start then
      Medium.specificEnthalpy_pTX(
      p_start,
      T_start,
      X_start) else Medium.h_default "Start value of specific enthalpy"
    annotation (Dialog(tab="Initialization", enable=not use_T_start));
  parameter Medium.MassFraction X_start[Medium.nX]=Medium.X_default
    "Start value of mass fractions m_i/m"
    annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0));
  parameter Medium.ExtraProperty C_start[Medium.nC](quantity=Medium.extraPropertiesNames)
     = fill(0, Medium.nC) "Start value of trace substances"
    annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));

  Medium.BaseProperties medium(
    preferredMediumStates=true,
    p(start=p_start),
    h(start=h_start),
    T(start=T_start),
    Xi(start=X_start[1:Medium.nXi]));
  Modelica.SIunits.Energy U "Internal energy of fluid";
  Modelica.SIunits.Mass m "Mass of fluid";
  Modelica.SIunits.Mass[Medium.nXi] mXi
    "Masses of independent components in the fluid";
  Modelica.SIunits.Mass[Medium.nC] mC "Masses of trace substances in the fluid";
  // C need to be added here because unlike for Xi, which has medium.Xi,
  // there is no variable medium.C
  Medium.ExtraProperty C[Medium.nC] "Trace substance mixture content";

  // variables that need to be defined by an extending class
  Modelica.SIunits.MassFlowRate mb_flow "Mass flows across boundaries";
  Modelica.SIunits.MassFlowRate[Medium.nXi] mbXi_flow
    "Substance mass flows across boundaries";
  Medium.ExtraPropertyFlowRate[Medium.nC] mbC_flow
    "Trace substance mass flows across boundaries";
  Modelica.SIunits.EnthalpyFlowRate Hb_flow
    "Enthalpy flow across boundaries or energy source/sink";
  Modelica.SIunits.HeatFlowRate Qb_flow
    "Heat flow across boundaries or energy source/sink";
  Modelica.SIunits.Power Wb_flow "Work flow across boundaries or source term";
protected
  parameter Boolean initialize_p=not Medium.singleState
    "= true to set up initial equations for pressure";
  Real[Medium.nC] mC_scaled(min=fill(Modelica.Constants.eps, Medium.nC))
    "Scaled masses of trace substances in the fluid";
equation
  assert(not (energyDynamics <> Dynamics.SteadyState and massDynamics ==
    Dynamics.SteadyState) or Medium.singleState,
    "Bad combination of dynamics options and Medium not conserving mass if fluidVolume is fixed.");

  // Total quantities
  m = fluidVolume*medium.d;
  mXi = m*medium.Xi;
  U = m*medium.u;
  mC = m*C;

  // Energy and mass balances
  if energyDynamics == Dynamics.SteadyState then
    0 = Hb_flow + Qb_flow + Wb_flow;
  else
    der(U) = Hb_flow + Qb_flow + Wb_flow;
  end if;

  if massDynamics == Dynamics.SteadyState then
    0 = mb_flow;
  else
    der(m) = mb_flow;
  end if;

  if substanceDynamics == Dynamics.SteadyState then
    zeros(Medium.nXi) = mbXi_flow;
  else
    der(mXi) = mbXi_flow;
  end if;

  if traceDynamics == Dynamics.SteadyState then
    zeros(Medium.nC) = mbC_flow;
  else
    der(mC_scaled) = mbC_flow ./ Medium.C_nominal;
  end if;
  mC = mC_scaled .* Medium.C_nominal;

initial equation
  // initialization of balances
  if energyDynamics == Dynamics.FixedInitial then
    /*
    if use_T_start then
      medium.T = T_start;
    else
      medium.h = h_start;
    end if;
    */
    if Medium.ThermoStates == IndependentVariables.ph or Medium.ThermoStates
         == IndependentVariables.phX then
      medium.h = h_start;
    else
      medium.T = T_start;
    end if;
  elseif energyDynamics == Dynamics.SteadyStateInitial then
    /*
    if use_T_start then
      der(medium.T) = 0;
    else
      der(medium.h) = 0;
    end if;
    */
    if Medium.ThermoStates == IndependentVariables.ph or Medium.ThermoStates
         == IndependentVariables.phX then
      der(medium.h) = 0;
    else
      der(medium.T) = 0;
    end if;
  end if;

  if massDynamics == Dynamics.FixedInitial then
    if initialize_p then
      medium.p = p_start;
    end if;
  elseif massDynamics == Dynamics.SteadyStateInitial then
    if initialize_p then
      der(medium.p) = 0;
    end if;
  end if;

  if substanceDynamics == Dynamics.FixedInitial then
    medium.Xi = X_start[1:Medium.nXi];
  elseif substanceDynamics == Dynamics.SteadyStateInitial then
    der(medium.Xi) = zeros(Medium.nXi);
  end if;

  if traceDynamics == Dynamics.FixedInitial then
    mC_scaled = m*C_start[1:Medium.nC] ./ Medium.C_nominal;
  elseif traceDynamics == Dynamics.SteadyStateInitial then
    der(mC_scaled) = zeros(Medium.nC);
  end if;

  annotation (Documentation(info="<html>
<p>
Interface and base class for an ideally mixed fluid volume with the ability to store mass and energy.
The following boundary flow and source terms are part of the energy balance and must be specified in an extending class:
</p>
<ul>
<li><code><b>Qb_flow</b></code>, e.g., convective or latent heat flow rate across segment boundary, and</li>
<li><code><b>Wb_flow</b></code>, work term, e.g., p*der(fluidVolume) if the volume is not constant.</li>
</ul>
<p>
The component volume <code><b>fluidVolume</b></code> is an input that needs to be set in the extending class to complete the model.
</p>
<p>
Further source terms must be defined by an extending class for fluid flow across the segment boundary:
</p>
<ul>
<li><code><b>Hb_flow</b></code>, enthalpy flow,</li>
<li><code><b>mb_flow</b></code>, mass flow,</li>
<li><code><b>mbXi_flow</b></code>, substance mass flow, and</li>
<li><code><b>mbC_flow</b></code>, trace substance mass flow.</li>
</ul>
</html>"));
end PartialLumpedVolume;
