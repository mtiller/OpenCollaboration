within ORNL_AdvSMR.Components;
partial model Flow1DBase
  "Basic interface for 1-dimensional water/steam fluid flow models"
  replaceable package Medium = ORNL_AdvSMR.Media.Fluids.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialMedium "Medium model"
    annotation (Evaluate=true, choicesAllMatching=true);
  extends ThermoPower3.Icons.Water.Tube;
  import ThermoPower3.Choices.Flow1D.FFtypes;
  import ThermoPower3.Choices.Flow1D.HCtypes;
  parameter Integer N(min=2) = 2 "Number of nodes for thermal variables";
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
  parameter ThermoPower3.Density rhonom=0 "Nominal inlet density";
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
  outer ThermoPower3.System system "System wide properties";
  parameter ThermoPower3.Choices.FluidPhase.FluidPhases FluidPhaseStart=
      ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid
    "Fluid phase (only for initialization!)"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.Pressure pstart=1e5 "Pressure start value"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.SpecificEnthalpy hstartin=if FluidPhaseStart ==
      ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if
      FluidPhaseStart == ThermoPower3.Choices.FluidPhase.FluidPhases.Steam
       then 3e6 else 1e6 "Inlet enthalpy start value"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.SpecificEnthalpy hstartout=if FluidPhaseStart ==
      ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if
      FluidPhaseStart == ThermoPower3.Choices.FluidPhase.FluidPhases.Steam
       then 3e6 else 1e6 "Outlet enthalpy start value"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.SpecificEnthalpy hstart[N]=linspace(
      hstartin,
      hstartout,
      N) "Start value of enthalpy vector (initialized by default)"
    annotation (Dialog(tab="Initialisation"));
  parameter Real wnf=0.02
    "Fraction of nominal flow rate at which linear friction equals turbulent friction";
  parameter Real Kfc=1 "Friction factor correction coefficient";
  parameter ThermoPower3.Choices.Init.Options initOpt=ThermoPower3.Choices.Init.Options.noInit
    "Initialisation option" annotation (Dialog(tab="Initialisation"));
  constant Real g=Modelica.Constants.g_n;
  function squareReg = ThermoPower3.Functions.squareReg;

  ThermoPower3.Water.FlangeA infl(
    h_outflow(start=hstartin),
    redeclare package Medium = Medium,
    m_flow(start=wnom, min=if allowFlowReversal then -Modelica.Constants.inf
           else 0)) annotation (Placement(transformation(extent={{-120,-20},{-80,
            20}}, rotation=0)));
  ThermoPower3.Water.FlangeB outfl(
    h_outflow(start=hstartout),
    redeclare package Medium = Medium,
    m_flow(start=-wnom, max=if allowFlowReversal then +Modelica.Constants.inf
           else 0)) annotation (Placement(transformation(extent={{80,-20},{120,
            20}}, rotation=0)));
  replaceable ThermoPower3.Thermal.DHT wall(N=N) annotation (Dialog(enable=
          false), Placement(transformation(extent={{-40,40},{40,60}}, rotation=
            0)));
  Modelica.SIunits.Power Q
    "Total heat flow through the lateral boundary (all Nt tubes)";
  Modelica.SIunits.Time Tr "Residence time";
  final parameter Real dzdx=H/L "Slope" annotation (Evaluate=true);
  final parameter Modelica.SIunits.Length l=L/(N - 1)
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
    Diagram(graphics),
    Icon(graphics));

end Flow1DBase;
