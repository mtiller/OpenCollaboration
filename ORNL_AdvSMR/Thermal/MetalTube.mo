within ORNL_AdvSMR.Thermal;
model MetalTube "Cylindrical metal tube - 1 radial node and N axial nodes"

  extends ORNL_AdvSMR.Icons.MetalWall;
  parameter Integer N(min=1) = 2 "Number of nodes";
  parameter Modelica.SIunits.Length L "Tube length";
  parameter Modelica.SIunits.Length rint "Internal radius (single tube)";
  parameter Modelica.SIunits.Length rext "External radius (single tube)";
  parameter Real rhomcm "Metal heat capacity per unit volume [J/m^3.K]";
  parameter Modelica.SIunits.ThermalConductivity lambda "Thermal conductivity";
  parameter Boolean WallRes=true "Wall conduction resistance accounted for";
  parameter Modelica.SIunits.Temperature Tstartbar=300 "Avarage temperature"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.Temperature Tstart1=Tstartbar
    "Temperature start value - first node"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.Temperature TstartN=Tstartbar
    "Temperature start value - last node"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.Temperature Tstart[N]=linspaceExt(
      Tstart1,
      TstartN,
      N) "Start value of temperature vector (initialized by default)"
    annotation (Dialog(tab="Initialisation"));
  parameter ORNL_AdvSMR.Choices.Init.Options initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit
    "Initialisation option" annotation (Dialog(tab="Initialisation"));
  constant Real pi=Modelica.Constants.pi;
  ORNL_AdvSMR.SIunits.AbsoluteTemperature T[N](start=Tstart)
    "Node temperatures";
  Modelica.SIunits.Area Am "Area of the metal tube cross-section";
  DHT int(N=N, T(start=Tstart)) "Internal surface" annotation (Placement(
        transformation(extent={{-40,20},{40,40}}, rotation=0),
        iconTransformation(extent={{-60,20},{60,40}})));
  DHT ext(N=N, T(start=Tstart)) "External surface" annotation (Placement(
        transformation(extent={{-40,-42},{40,-20}}, rotation=0),
        iconTransformation(extent={{-60,-40},{60,-20}})));
equation
  assert(rext > rint, "External radius must be greater than internal radius");
  Am = (rext^2 - rint^2)*pi "Area of the metal cross section";
  rhomcm*Am*der(T) = rint*2*pi*int.phi + rext*2*pi*ext.phi "Energy balance";
  if WallRes then
    int.phi = lambda/(rint*Modelica.Math.log((rint + rext)/(2*rint)))*(int.T -
      T) "Heat conduction through the internal half-thickness";
    ext.phi = lambda/(rext*Modelica.Math.log((2*rext)/(rint + rext)))*(ext.T -
      T) "Heat conduction through the external half-thickness";
  else
    // No temperature gradients across the thickness
    int.T = T;
    ext.T = T;
  end if;
initial equation
  if initOpt == ORNL_AdvSMR.Choices.Init.Options.noInit then
    // do nothing
  elseif initOpt == ORNL_AdvSMR.Choices.Init.Options.steadyState then
    der(T) = zeros(N);
  elseif initOpt == ORNL_AdvSMR.Choices.Init.Options.steadyStateNoT then
    // do nothing
  else
    assert(false, "Unsupported initialisation option");
  end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={Text(
          extent={{-100,60},{-40,20}},
          lineColor={0,0,0},
          fillColor={128,128,128},
          fillPattern=FillPattern.Forward,
          textString="Int"),Text(
          extent={{-100,-20},{-40,-60}},
          lineColor={0,0,0},
          fillColor={128,128,128},
          fillPattern=FillPattern.Forward,
          textString="Ext"),Text(
          extent={{-140,-48},{140,-88}},
          lineColor={191,95,0},
          textString="%name")}),
    Documentation(info="<HTML>
<p>This is the model of a cylindrical tube of solid material.
<p>The heat capacity (which is lumped at the center of the tube thickness) is accounted for, as well as the thermal resistance due to the finite heat conduction coefficient. Longitudinal heat conduction is neglected.
<p><b>Modelling options</b></p>
<p>The following options are available:
<ul>
<li><tt>WallRes = false</tt>: the thermal resistance of the tube wall is neglected.
<li><tt>WallRes = true</tt>: the thermal resistance of the tube wall is accounted for.
</ul>
</HTML>", revisions="<html>
<ul>
<li><i>30 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Initialisation support added.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>
"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics));
end MetalTube;
