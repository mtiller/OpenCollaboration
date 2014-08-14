within ORNL_AdvSMR.Thermal;
model MetalWall "Generic metal wall - 1 radial node and N axial nodes"
  import aSMR = ORNL_AdvSMR;
  extends ORNL_AdvSMR.Icons.MetalWall;
  parameter Integer N(min=1) = 2 "Number of nodes";
  parameter Modelica.SIunits.Mass M "Mass";
  parameter Modelica.SIunits.Area Sint "Internal surface";
  parameter Modelica.SIunits.Area Sext "External surface";
  parameter Modelica.SIunits.SpecificHeatCapacity cm
    "Specific heat capacity of metal";
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
  SmAHTR.AbsoluteTemperature T[N](start=Tstart) "Node temperatures";
  ORNL_AdvSMR.Thermal.DHT int(N=N, T(start=Tstart)) "Internal surface"
    annotation (Placement(transformation(extent={{-40,20},{40,40}}, rotation=0)));
  ORNL_AdvSMR.Thermal.DHT ext(N=N, T(start=Tstart)) "External surface"
    annotation (Placement(transformation(extent={{-40,-42},{40,-20}}, rotation=
            0)));
equation
  (cm*M)*der(T) = Sint*int.phi + Sext*ext.phi "Energy balance";
  // No temperature gradients across the thickness
  int.T = T;
  ext.T = T;
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
    Icon(graphics={Text(
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
          extent={{-138,-60},{142,-100}},
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
    Diagram(graphics));
end MetalWall;
