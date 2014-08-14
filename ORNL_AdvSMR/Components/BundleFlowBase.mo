within ORNL_AdvSMR.Components;
partial model BundleFlowBase
  "Abstract model for 1-dimensional flow models through rod bundles"
  replaceable package Medium = ORNL_AdvSMR.Media.Fluids.Na constrainedby
    ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "Medium model"
    annotation (Evaluate=true, choicesAllMatching=true);
  extends ORNL_AdvSMR.Icons.Water.Tube;
  import ORNL_AdvSMR.Choices.Flow1D.FFtypes;
  import ORNL_AdvSMR.Choices.Flow1D.HCtypes;

  parameter Boolean use_HeatTransfer=false
    "true to model the heat transfer process"
    annotation (Dialog(tab="Model Selection", group="Heat Transfer"));
  replaceable model HeatTransfer =
      ORNL_AdvSMR.BaseClasses.HeatTransfer.KazimiCarelli constrainedby
    ORNL_AdvSMR.BaseClasses.HeatTransfer.PartialBundleHeatTransfer
    "Wall heat transfer" annotation (Dialog(
      tab="Model Selection",
      group="Heat Transfer",
      enable=use_HeatTransfer), choicesAllMatching=true);

  parameter Integer nNodes(min=2) = 2 "Number of nodes for thermal variables";
  parameter Integer Nt=1 "Number of tubes in parallel";
  parameter Modelica.SIunits.Distance L "Tube length" annotation (Evaluate=true);
  parameter Modelica.SIunits.Position H=0 "Elevation of outlet over inlet";
  parameter Modelica.SIunits.Area A "Cross-sectional area (single tube)";
  parameter Modelica.SIunits.Length omega
    "Perimeter of heat transfer surface (single tube)";
  parameter Modelica.SIunits.Length Dhyd "Hydraulic Diameter (single tube)";
  parameter Modelica.SIunits.MassFlowRate wnom "Nominal mass flowrate (total)";
  parameter FFtypes FFtype=FFtypes.NoFriction "Friction Factor Type"
    annotation (Evaluate=true);
  parameter Real Kfnom(
    unit="Pa.kg/(m3.kg2/s2)",
    min=0) = 0 "Nominal hydraulic resistance coefficient";
  parameter Modelica.SIunits.Pressure dpnom=0
    "Nominal pressure drop (friction term only!)";
  parameter Modelica.SIunits.Density rhonom=0 "Nominal inlet density";
  parameter Real Cfnom=0 "Nominal Fanning friction factor";
  parameter Real e=0 "Relative roughness (ratio roughness/diameter)";
  parameter Boolean DynamicMomentum=false "Inertial phenomena accounted for"
    annotation (Evaluate=true);
  parameter HCtypes HydraulicCapacitance=HCtypes.Downstream
    "Location of the hydraulic capacitance";
  parameter Boolean avoidInletEnthalpyDerivative=true
    "Avoid inlet enthalpy derivative";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ORNL_AdvSMR.System system "System wide properties";
  parameter ORNL_AdvSMR.Choices.FluidPhase.FluidPhases FluidPhaseStart=
      ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid
    "Fluid phase (only for initialization!)"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.Pressure pstart=1e5 "Pressure start value"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.SpecificEnthalpy hstartin=if FluidPhaseStart ==
      ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if
      FluidPhaseStart == ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Steam then
      3e6 else 1e6 "Inlet enthalpy start value"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.SpecificEnthalpy hstartout=if FluidPhaseStart ==
      ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if
      FluidPhaseStart == ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Steam then
      3e6 else 1e6 "Outlet enthalpy start value"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.SpecificEnthalpy hstart[nNodes]=linspace(
      hstartin,
      hstartout,
      nNodes) "Start value of enthalpy vector (initialized by default)"
    annotation (Dialog(tab="Initialisation"));
  parameter Real wnf=0.02
    "Fraction of nominal flow rate at which linear friction equals turbulent friction";
  parameter Real Kfc=1 "Friction factor correction coefficient";
  parameter ORNL_AdvSMR.Choices.Init.Options initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit
    "Initialisation option" annotation (Dialog(tab="Initialisation"));
  constant Real g=Modelica.Constants.g_n;
  function squareReg = ORNL_AdvSMR.Functions.squareReg;

  ORNL_AdvSMR.Interfaces.FlangeA infl(
    h_outflow(start=hstartin),
    redeclare package Medium = Medium,
    m_flow(start=wnom, min=if allowFlowReversal then -Modelica.Constants.inf
           else 0)) annotation (Placement(transformation(extent={{-120,-20},{-80,
            20}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB outfl(
    h_outflow(start=hstartout),
    redeclare package Medium = Medium,
    m_flow(start=-wnom, max=if allowFlowReversal then +Modelica.Constants.inf
           else 0)) annotation (Placement(transformation(extent={{80,-20},{120,
            20}}, rotation=0)));
  replaceable ORNL_AdvSMR.Thermal.DHT wall(N=nNodes) annotation (Dialog(enable=
          false),Placement(transformation(extent={{-40.5,40},{39.5,60}},
          rotation=0), iconTransformation(extent={{-40.5,40},{39.5,60}})));

  Modelica.SIunits.Power Q
    "Total heat flow through the lateral boundary (all Nt tubes)";
  Modelica.SIunits.Time Tr "Residence time";
  final parameter Real dzdx=H/L "Slope" annotation (Evaluate=true);
  final parameter Modelica.SIunits.Length l=L/(nNodes - 1)
    "Length of a single volume" annotation (Evaluate=true);
  annotation (
    Documentation(info="<HTML>
Basic interface of the <tt>Flow1D</tt> models, containing the common parameters and connectors.
</HTML>
", revisions="<html>
<ul>
<li><i>23 Jul 2007</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Added hstart for more detailed initialization of enthalpy vector.</li>
<li><i>30 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Initialisation support added.</li>
<li><i>24 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       <tt>FFtypes</tt> package and <tt>NoFriction</tt> option added.</li>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>8 Oct 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Created.</li>
</ul>
</html>"),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=1), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=1), graphics));

end BundleFlowBase;
