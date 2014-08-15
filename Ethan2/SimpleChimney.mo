within Ethan2;
model SimpleChimney "Stack Flow Driven Chimney"
  replaceable package Medium = ThermoPower3.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium model";
 // Medium.ThermodynamicState fluidState;
  parameter Real Nt=1 "Number of Parallel Towers";
  parameter Modelica.SIunits.MassFlowRate w0=1 "Nominal mass flowrate";
  parameter Modelica.SIunits.Pressure p0=1e5 "Nominal pressure";
  parameter Modelica.SIunits.SpecificEnthalpy hout=1e5
    "Nominal specific enthalpy";
  parameter Modelica.SIunits.Temperature To = 263 "Outside Air Temp";
  parameter Modelica.SIunits.Temperature Tin= 293 "stream temp";
  parameter Modelica.SIunits.Area A = 3.14 "chimney CSA";
  parameter Modelica.SIunits.Length height = 10 "chimney height";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ThermoPower3.System system "System wide properties";

  parameter Real C = 0.65 "discharge coefficient";
  constant Real g = Modelica.Constants.g_n;
  Modelica.SIunits.MassFlowRate w "Mass flowrate";
  Modelica.SIunits.VolumeFlowRate Qstack;
 // Modelica.SIunits.SpecificEnthalpy hin "inlet enthalpy";
 // Modelica.SIunits.Density rho;
  //parameter Modelica.SIunits.SpecificHeatCapacity cp=4.184;
  parameter Modelica.SIunits.Density rhonom=1000;
  ThermoPower3.Water.FlangeA flange(redeclare package Medium = Medium, m_flow(
        min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}}, rotation=
           0), iconTransformation(extent={{-20,-120},{20,-80}})));
equation
  //fluid properties
//  fluidState = Medium.setState_ph(p0, hin);
//  rho = Medium.density(fluidState);
  //Tin = Medium.temperature(fluidState);
  w = Qstack*rhonom;
  Qstack = Nt * C * A * sqrt(2 * g * height * (Tin - To)/(Tin));

  flange.m_flow = -w;
  flange.h_outflow = hout;
 // hin = homotopy(if not allowFlowReversal then inStream(flange.h_outflow)
 //    else actualStream(flange.h_outflow), inStream(flange.h_outflow));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics={
        Polygon(
          points={{-40,-100},{-30,60},{30,60},{40,-100},{-40,-100}},
          lineColor={127,0,0},
          smooth=Smooth.None,
          fillPattern=FillPattern.Solid,
          fillColor={166,108,79}),
        Line(
          points={{-26,62},{-16,84},{-24,100},{-18,114}},
          color={135,135,135},
          smooth=Smooth.None),
        Line(
          points={{-16,66},{-6,88},{-14,104},{-8,118}},
          color={135,135,135},
          smooth=Smooth.None),
        Line(
          points={{-6,62},{4,84},{-4,100},{2,114}},
          color={135,135,135},
          smooth=Smooth.None),
        Line(
          points={{4,62},{14,84},{6,100},{12,114}},
          color={135,135,135},
          smooth=Smooth.None),
        Line(
          points={{14,66},{24,88},{16,104},{22,118}},
          color={135,135,135},
          smooth=Smooth.None),
        Line(
          points={{24,62},{34,84},{26,100},{32,114}},
          color={135,135,135},
          smooth=Smooth.None)}),
    Documentation(info="<HTML>
<p><b>Modelling options</b></p>
<p>If <tt>G</tt> is set to zero, the flowrate source is ideal; otherwise, the incoming flowrate increases proportionally to the inlet pressure.</p>
<p>If <tt>w0Fix</tt> is set to true, the incoming flowrate is given by the parameter <tt>w0</tt>; otherwise, the <tt>in_w0</tt> connector must be wired, providing the (possibly varying) source flowrate.</p>
<p>If <tt>hFix</tt> is set to true, the source enthalpy is given by the parameter <tt>h</tt>; otherwise, the <tt>in_h</tt> connector must be wired, providing the (possibly varying) source enthalpy.</p>
</HTML>",
        revisions="<html>
<ul>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Medium model and standard medium definition added.</li>
<li><i>18 Jun 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Removed <tt>p0_fix</tt> and <tt>hfix</tt>; the connection of external signals is now detected automatically.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),
    Diagram(graphics));
end SimpleChimney;
