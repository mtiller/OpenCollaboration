within Ethan2;
model Core "Simple Core model"
  parameter Integer N(min=1) = 2 "Number of nodes";
  parameter Modelica.SIunits.Mass M "Mass";
  parameter Modelica.SIunits.Area Sext "External surface";
  parameter Modelica.SIunits.SpecificHeatCapacity cm
    "Specific heat capacity of metal";
  parameter Modelica.SIunits.Temperature Tstartbar=300 "Avarage temperature"
    annotation (Dialog(tab="Initialisation"));
  Modelica.SIunits.Temperature Tbar(start=Tstartbar);
  Modelica.SIunits.Power qcore "Heat leaving the core";
  Modelica.SIunits.Power qcorem "-qcore (for plotting)";
  parameter ThermoPower3.Choices.Init.Options initOpt=ThermoPower3.Choices.Init.Options.noInit
    "Initialisation option" annotation (Dialog(tab="Initialisation"));
  constant Real pi=Modelica.Constants.pi;
  ThermoPower3.Thermal.DHT ext(N=N, T(start=linspace(Tstartbar,Tstartbar,N)))
    "External surface"
    annotation (Placement(transformation(extent={{-40,-42},{40,-20}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealInput p_in annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,90}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,108})));
equation
  qcorem = -qcore;
  qcore = sum(ext.phi)*Sext/N;
  (cm*M)*der(Tbar) = p_in + qcore "Energy balance";
  // No temperature gradients across the thickness
  ext.T = linspace(Tbar,Tbar,N);
initial equation
  if initOpt == ThermoPower3.Choices.Init.Options.noInit then
    // do nothing
  elseif initOpt == ThermoPower3.Choices.Init.Options.steadyState then
    der(Tbar) = 0;
  elseif initOpt == ThermoPower3.Choices.Init.Options.steadyStateNoT then
    // do nothing
  else
    assert(false, "Unsupported initialisation option");
  end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics={           Text(
            extent={{-100,-20},{-40,-60}},
            lineColor={0,0,0},
            fillColor={128,128,128},
            fillPattern=FillPattern.Forward,
            textString="Ext"),Text(
            extent={{-138,-60},{142,-100}},
            lineColor={191,95,0},
            textString="%name"),
        Rectangle(
          extent={{-100,88},{100,-22}},
          lineColor={135,135,135},
          fillColor={199,199,199},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<HTML>
<p>This is the model of a cylindrical tube of solid material.
<p>The heat capacity (which is lumped at the center of the tube thickness) is accounted for, as well as the thermal resistance due to the finite heat conduction coefficient. Longitudinal heat conduction is neglected.
<p><b>Modelling options</b></p>
<p>The following options are available:
<ul>
<li><tt>WallRes = false</tt>: the thermal resistance of the tube wall is neglected.
<li><tt>WallRes = true</tt>: the thermal resistance of the tube wall is accounted for.
</ul>
</HTML>",
        revisions="<html>
<ul>
<li><i>30 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Initialisation support added.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>
"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
            graphics));
end Core;
