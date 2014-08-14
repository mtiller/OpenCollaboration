within ORNL_AdvSMR.Components;
model Drum "Drum for circulation boilers"
  import aSMR = ORNL_AdvSMR;
  extends ORNL_AdvSMR.Icons.Water.Drum;
  replaceable package Medium = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Medium model";
  Medium.ThermodynamicState liquidState "Thermodynamic state of the liquid";
  Medium.ThermodynamicState vapourState "Thermodynamic state of the vapour";
  Medium.SaturationProperties sat;
  parameter Modelica.SIunits.Length rint=0 "Internal radius";
  parameter Modelica.SIunits.Length rext=0 "External radius";
  parameter Modelica.SIunits.Length L=0 "Length";
  parameter Modelica.SIunits.HeatCapacity Cm=0
    "Total Heat Capacity of the metal wall" annotation (Evaluate=true);
  parameter Modelica.SIunits.Temperature Text=293
    "External atmospheric temperature";
  parameter Modelica.SIunits.Time tauev=15 "Time constant of bulk evaporation";
  parameter Modelica.SIunits.Time tauc=15 "Time constant of bulk condensation";
  parameter Real Kcs=0 "Surface condensation coefficient [kg/(s.m2.K)]";
  parameter Real Ks=0 "Surface heat transfer coefficient [W/(m2.K)]";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer gext=0
    "Heat transfer coefficient between metal wall and external atmosphere";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer gl=200
    "Heat transfer coefficient between metal wall and liquid phase"
    annotation (Evaluate=true);
  parameter Modelica.SIunits.CoefficientOfHeatTransfer gv=200
    "Heat transfer coefficient between metal wall and vapour phase"
    annotation (Evaluate=true);
  parameter Modelica.SIunits.ThermalConductivity lm=20
    "Metal wall thermal conductivity";
  parameter Real afd=0.05 "Ratio of feedwater in downcomer flowrate";
  parameter Real avr=1.2 "Phase separation efficiency coefficient";
  parameter Integer DrumOrientation=0 "0: Horizontal; 1: Vertical";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ORNL_AdvSMR.System system "System wide properties";
  parameter Modelica.SIunits.Pressure pstart=1e5 "Pressure start value"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.SpecificEnthalpy hlstart=Medium.bubbleEnthalpy(
      Medium.setSat_p(pstart)) "Liquid enthalpy start value"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.SpecificEnthalpy hvstart=Medium.dewEnthalpy(
      Medium.setSat_p(pstart)) "Vapour enthalpy start value"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.Length ystart=0 "Start level value"
    annotation (Dialog(tab="Initialisation"));
  parameter ORNL_AdvSMR.Choices.Init.Options initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit
    "Initialisation option" annotation (Dialog(tab="Initialisation"));
  constant Real g=Modelica.Constants.g_n;
  constant Real pi=Modelica.Constants.pi;

  Modelica.SIunits.Volume Vv(start=pi*rint^2*L/2)
    "Volume occupied by the vapour";
  Modelica.SIunits.Volume Vl(start=pi*rint^2*L/2)
    "Volume occupied by the liquid";
  Modelica.SIunits.Pressure p(start=pstart, stateSelect=StateSelect.prefer)
    "Surface pressure";
  Modelica.SIunits.SpecificEnthalpy hl(start=hlstart, stateSelect=StateSelect.prefer)
    "Liquid specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy hv(start=hvstart, stateSelect=StateSelect.prefer)
    "Vapour specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy hrv
    "Specific enthalpy of vapour from the risers after separation";
  Modelica.SIunits.SpecificEnthalpy hrl
    "Specific enthalpy of liquid from the risers after separation";
  Modelica.SIunits.SpecificEnthalpy hls "Specific enthalpy of saturated liquid";
  Modelica.SIunits.SpecificEnthalpy hvs "Specific enthalpy of saturated vapour";
  Modelica.SIunits.SpecificEnthalpy hf "Specific enthalpy of feedwater";
  Modelica.SIunits.SpecificEnthalpy hd
    "Specific enthalpy of liquid to the downcomers";
  Modelica.SIunits.SpecificEnthalpy hvout
    "Specific enthalpy of steam at the outlet";
  Modelica.SIunits.SpecificEnthalpy hr
    "Specific enthalpy of fluid from the risers";
  Modelica.SIunits.MassFlowRate wf "Mass flowrate of feedwater";
  Modelica.SIunits.MassFlowRate wd "Mass flowrate to the downcomers";
  Modelica.SIunits.MassFlowRate wb "Mass flowrate of blowdown";
  Modelica.SIunits.MassFlowRate wr "Mass flowrate from the risers";
  Modelica.SIunits.MassFlowRate wrl "Mass flowrate of liquid from the risers";
  Modelica.SIunits.MassFlowRate wrv "Mass flowrate of vapour from the risers";
  Modelica.SIunits.MassFlowRate wv "Mass flowrate of steam at the outlet";
  Modelica.SIunits.MassFlowRate wc "Mass flowrate of bulk condensation";
  Modelica.SIunits.MassFlowRate wcs "Mass flowrate of surface condensation";
  Modelica.SIunits.MassFlowRate wev "Mass flowrate of bulk evaporation";
  Modelica.Definitions.AbsoluteTemperature Tl "Liquid temperature";
  Modelica.Definitions.AbsoluteTemperature Tv "Vapour temperature";
  Modelica.Definitions.AbsoluteTemperature Tm(start=
        Medium.saturationTemperature(pstart), stateSelect=if Cm > 0 then
        StateSelect.prefer else StateSelect.default) "Wall temperature";
  Modelica.Definitions.AbsoluteTemperature Ts "Saturated water temperature";
  Modelica.SIunits.Power Qmv "Heat flow from the wall to the vapour";
  Modelica.SIunits.Power Qvl "Heat flow from the vapour to the liquid";
  Modelica.SIunits.Power Qml "Heat flow from the wall to the liquid";
  Modelica.SIunits.Power Qme "Heat flow from the wall to the atmosphere";
  Modelica.SIunits.Mass Ml "Liquid mass";
  Modelica.SIunits.Mass Mv "Vapour mass";
  Modelica.SIunits.Energy El "Liquid internal energy";
  Modelica.SIunits.Energy Ev "Vapour internal energy";
  Modelica.Definitions.LiquidDensity rhol "Liquid density";
  Modelica.Definitions.GasDensity rhov "Vapour density";
  Real xl "Mass fraction of vapour in the liquid volume";
  Real xv "Steam quality in the vapour volume";
  Real xr "Steam quality of the fluid from the risers";
  Real xrv "Steam quality of the separated steam from the risers";
  Real gml "Total heat transfer coefficient (wall-liquid)";
  Real gmv "Total heat transfer coefficient (wall-vapour)";
  Real a;
  Modelica.SIunits.Length y(start=ystart, stateSelect=StateSelect.prefer)
    "Level (referred to the centreline)";
  Modelica.SIunits.Area Aml "Surface of the wall-liquid interface";
  Modelica.SIunits.Area Amv "Surface of the wall-vapour interface";
  Modelica.SIunits.Area Asup "Surface of the liquid-vapour interface";
  Modelica.SIunits.Area Aext "External drum surface";
  ORNL_AdvSMR.Interfaces.FlangeA feedwater(
    p(start=pstart),
    h_outflow(start=hlstart),
    redeclare package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-114,-32},{-80,2}}, rotation=
            0)));
  ORNL_AdvSMR.Interfaces.FlangeA riser(
    p(start=pstart),
    h_outflow(start=hlstart),
    redeclare package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{60,-74},{96,-40}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB downcomer(
    p(start=pstart),
    h_outflow(start=hlstart),
    redeclare package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-88,-88},{-52,-52}}, rotation
          =0)));
  ORNL_AdvSMR.Interfaces.FlangeB blowdown(
    p(start=pstart),
    h_outflow(start=hlstart),
    redeclare package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-18,-116},{18,-80}}, rotation
          =0)));
  ORNL_AdvSMR.Interfaces.FlangeB steam(
    p(start=pstart),
    h_outflow(start=hvstart),
    redeclare package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{40,52},{76,88}}, rotation=0)));
equation
  der(Mv) = wrv + wev - wv - wc - wcs "Vapour volume mass balance";
  der(Ml) = wf + wrl + wc + wcs - wd - wb - wev "Liquid volume mass balance";
  der(Ev) = wrv*hrv + (wev - wcs)*hvs - wc*hls - wv*hvout + Qmv - Qvl - p*der(
    Vv) "Vapour volume energy balance";
  der(El) = wf*hf + wrl*hrl + wc*hls + (wcs - wev)*hvs - wd*hd - wb*hl + Qml +
    Qvl - p*der(Vl) "Liquid volume energy balance";
  //Metal wall energy balance with singular cases
  if Cm > 0 and (gl > 0 or gv > 0) then
    Cm*der(Tm) = -Qml - Qmv - Qme "Metal wall dynamic energy balance";
  elseif (gl > 0 or gv > 0) then
    0 = -Qml - Qmv - Qme "Metal wall static energy balance";
  else
    Tm = 300 "Wall temperature doesn't matter";
  end if;
  Mv = Vv*rhov "Vapour volume mass";
  Ml = Vl*rhol "Liquid volume mass";
  Ev = Mv*Medium.specificInternalEnergy(vapourState) "Vapour volume energy";
  El = Ml*Medium.specificInternalEnergy(liquidState) "Liquid volume energy";
  wev = xl*rhol*Vl/tauev "Bulk evaporation flow rate in the liquid volume";
  wc = (1 - xv)*rhov*Vv/tauc "Bulk condensation flow rate in the vapour volume";
  wcs = Kcs*Asup*(Ts - Tl) "Surface condensation flow rate";
  Qme = gext*Aext*(Tm - Text)
    "Heat flow from metal wall to external environment";
  Qml = gml*Aml*(Tm - Tl) "Heat flow from metal wall to liquid volume";
  Qmv = gmv*Amv*(Tm - Tv) "Heat flow from metal wall to vapour volume";
  Qvl = Ks*Asup*(Tv - Ts) "Heat flow from vapour to liquid volume";
  xv = homotopy(if hv >= hvs then 1 else (hv - hls)/(hvs - hls), (hv - hls)/(
    hvs - hls)) "Steam quality in the vapour volume";
  xl = homotopy(if hl <= hls then 0 else (hl - hls)/(hvs - hls), 0)
    "Steam quality in the liquid volume";
  gml = if gl == 0 then 0 else 1/(1/gl + a*rint/lm)
    "Total Heat conductance metal-liquid";
  gmv = if gv == 0 then 0 else 1/(1/gv + a*rint/lm)
    "Total Heat conductance metal-vapour";
  a = rext^2/(rext^2 - rint^2)*Modelica.Math.log(rext/rint) - 0.5;
  if DrumOrientation == 0 then
    Vl = L*(rint^2*Modelica.Math.acos(-y/rint) + y*sqrt(rint^2 - y^2))
      "Liquid volume";
    Aml = 2*Vl/L + 2*rint*Modelica.Math.acos(-y/rint)*L
      "Metal-liquid interface area";
    Asup = 2*sqrt(rint^2 - y^2)*L "Liquid-vapour interface area";
  else
    Vl = pi*rint^2*(y + L/2) "Liquid volume";
    Aml = pi*rint^2 + 2*pi*rint*(y + L/2) "Metal-liquid interface area";
    Asup = pi*rint^2 "Liquid-vapour interface area";
  end if;
  Vv = pi*rint^2*L - Vl "Vapour volume";
  Amv = 2*pi*rint*L + 2*pi*rint^2 - Aml "Metal-vapour interface area";
  Aext = 2*pi*rext^2 + 2*pi*rext*L "External metal surface area";

  // Fluid properties
  liquidState = Medium.setState_ph(p, hl);
  Tl = Medium.temperature(liquidState);
  rhol = Medium.density(liquidState);
  vapourState = Medium.setState_ph(p, hv);
  Tv = Medium.temperature(vapourState);
  rhov = Medium.density(vapourState);
  sat.psat = p;
  sat.Tsat = Medium.saturationTemperature(p);
  hls = Medium.bubbleEnthalpy(sat);
  hvs = Medium.dewEnthalpy(sat);
  Ts = sat.Tsat;

  // Boundary conditions
  feedwater.p = p;
  feedwater.m_flow = wf;
  feedwater.h_outflow = hl;
  hf = homotopy(if not allowFlowReversal then inStream(feedwater.h_outflow)
     else noEvent(actualStream(feedwater.h_outflow)), inStream(feedwater.h_outflow));
  downcomer.p = p + rhol*g*y;
  downcomer.m_flow = -wd;
  downcomer.h_outflow = hd;
  hd = homotopy(if not allowFlowReversal then afd*hf + (1 - afd)*hl else
    noEvent(if wd >= 0 then afd*hf + (1 - afd)*hl else inStream(downcomer.h_outflow)),
    afd*hf + (1 - afd)*hl);
  blowdown.p = p;
  blowdown.m_flow = -wb;
  blowdown.h_outflow = hl;
  riser.p = p;
  riser.m_flow = wr;
  riser.h_outflow = hl;
  hrv = hls + xrv*(hvs - hls);
  xrv = homotopy(1 - (rhov/rhol)^avr, 1 - (Medium.dewDensity(Medium.setSat_p(
    pstart))/Medium.bubbleDensity(Medium.setSat_p(pstart)))^avr);
  hr = homotopy(if not allowFlowReversal then inStream(riser.h_outflow) else
    noEvent(actualStream(riser.h_outflow)), inStream(riser.h_outflow));
  xr = homotopy(if not allowFlowReversal then (if hr > hls then (hr - hls)/(hvs
     - hls) else 0) else noEvent(if wr >= 0 then (if hr > hls then (hr - hls)/(
    hvs - hls) else 0) else xl), (hr - hls)/(hvs - hls));
  hrl = homotopy(if not allowFlowReversal then (if hr > hls then hls else hr)
     else noEvent(if wr >= 0 then (if hr > hls then hls else hr) else hl), hls);
  wrv = homotopy(if not allowFlowReversal then xr*wr/xrv else noEvent(if wr >=
    0 then xr*wr/xrv else 0), xr*wr/xrv);
  wrl = wr - wrv;
  steam.p = p;
  steam.m_flow = -wv;
  steam.h_outflow = hv;
  hvout = homotopy(if not allowFlowReversal then hv else noEvent(actualStream(
    steam.h_outflow)), hv);
initial equation
  if initOpt == ORNL_AdvSMR.Choices.Init.Options.noInit then
    // do nothing
  elseif initOpt == ORNL_AdvSMR.Choices.Init.Options.steadyState then
    der(p) = 0;
    der(hl) = 0;
    der(hv) = 0;
    der(y) = 0;
    if Cm > 0 and (gl > 0 or gv > 0) then
      der(Tm) = 0;
    end if;
  elseif initOpt == ORNL_AdvSMR.Choices.Init.Options.steadyStateNoP then
    der(hl) = 0;
    der(hv) = 0;
    der(y) = 0;
    if Cm > 0 and (gl > 0 or gv > 0) then
      der(Tm) = 0;
    end if;
  else
    assert(false, "Unsupported initialisation option");
  end if;
  annotation (
    Icon(graphics={
        Text(extent={{-150,26},{-78,0}}, textString="Feed"),
        Text(extent={{-180,-34},{-66,-58}}, textString="Downcomer"),
        Text(extent={{-38,-102},{46,-142}}, textString="Blowdown"),
        Text(extent={{52,-22},{146,-40}}, textString="Risers"),
        Text(extent={{-22,100},{50,80}}, textString="Steam")}),
    Documentation(info="<HTML>
<p>This model describes the cylindrical drum of a drum boiler, without assuming thermodynamic equilibrium between the liquid and vapour holdups. Connectors are provided for feedwater inlet, steam outlet, downcomer outlet, riser inlet, and blowdown outlet.
<p>The model is based on dynamic mass and energy balance equations of the liquid volume and vapour volume inside the drum. Mass and energy tranfer between the two phases is provided by bulk condensation and surface condensation of the vapour phase, and by bulk boiling of the liquid phase. Additional energy transfer can take place at the surface if the steam is superheated.
<p>The riser flowrate is separated before entering the drum, at the vapour pressure. The (saturated) liquid fraction goes into the liquid volume; the (wet) vapour fraction goes into the vapour volume, vith a steam quality depending on the liquid/vapour density ratio and on the <tt>avr</tt> parameter.
<p>The enthalpy of the liquid going to the downcomer is computed by assuming that a fraction of the total mass flowrate (<tt>afd</tt>) comes directly from the feedwater inlet. The pressure at the downcomer connector is equal to the vapour pressure plus the liquid head.
<p>The metal wall dynamics is taken into account, assuming uniform temperature. Heat transfer takes place between the metal wall and the liquid phase, vapour phase, and external atmosphere, the corresponding heat transfer coefficients being <tt>gl</tt>, <tt>gv</tt>, and <tt>gext</tt>.
<p>The drum level is referenced to the centreline.
<p>The start values of drum pressure, liquid specific enthalpy, vapour specific enthalpy, and metal wall temperature can be specified by setting the parameters <tt>pstart</tt>, <tt>hlstart</tt>, <tt>hvstart</tt>, <tt>Tmstart</tt>
<p><b>Modelling options</b></p>
<p>The following options are available to specify the orientation of the cylindrical drum:
<ul><li><tt>DrumOrientation = 0</tt>: horizontal axis.
<li><tt>DrumOrientation = 1</tt>: vertical axis.
</ul>
</HTML>", revisions="<html>
<ul>
<li><i>30 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Initialisation support added.</li>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>5 Jul 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<li><i>1 Feb 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Improved equations for drum geometry.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
"),
    Diagram(graphics));
end Drum;
