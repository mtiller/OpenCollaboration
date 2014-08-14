within ORNL_AdvSMR.Components;
model Plenum "Plenum model with constant gas pressure"
  replaceable package Medium = ORNL_AdvSMR.Media.Fluids.Na constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium model";

  Medium.ThermodynamicState liquidState(p(start=pext),h(start=hstart))
    "Thermodynamic state of the liquid";
  parameter Modelica.SIunits.Area A "Cross-sectional area";
  parameter Modelica.SIunits.Volume V0=0 "Volume at zero level";
  parameter Modelica.SIunits.Pressure pext=1.01325e5 "Surface pressure";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ORNL_AdvSMR.System system "System wide properties";
  parameter Modelica.SIunits.Length ystart "Start level"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.SpecificEnthalpy hstart=1e5
    annotation (Dialog(tab="Initialisation"));
  parameter Choices.Init.Options initOpt=Choices.Init.Options.noInit
    "Initialisation option" annotation (Dialog(tab="Initialisation"));
  Modelica.SIunits.Length y(start=ystart, stateSelect=StateSelect.prefer)
    "Level";
  Modelica.SIunits.Volume V "Liquid volume";
  Modelica.SIunits.Mass M "Liquid mass";
  Modelica.SIunits.Enthalpy H "Liquid (total) enthalpy";
  Medium.SpecificEnthalpy h(start=hstart, stateSelect=StateSelect.prefer)
    "Liquid specific enthalpy";
  Medium.SpecificEnthalpy hin "Inlet specific enthalpy";
  Medium.SpecificEnthalpy hout "Outlet specific enthalpy";
  Medium.AbsolutePressure p(start=pext) "Bottom pressure";
  constant Real g=Modelica.Constants.g_n;

  ORNL_AdvSMR.Interfaces.FlangeA inlet(redeclare package Medium = Medium,
      m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-95,-70},{-55,-30}}, rotation
          =0), iconTransformation(extent={{-95,-70},{-55,-30}})));
  ORNL_AdvSMR.Interfaces.FlangeB outlet(redeclare package Medium = Medium,
      m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{55,-70},{95,-30}}, rotation=0),
        iconTransformation(extent={{55,-70},{95,-30}})));

equation
  // Set liquid properties
  liquidState = Medium.setState_ph(pext, h);

  V = V0 + A*y "Liquid volume";
  M = V*Medium.density(liquidState) "Liquid mass";
  H = M*Medium.specificInternalEnergy(liquidState) "Liquid enthalpy";
  der(M) = inlet.m_flow + outlet.m_flow "Mass balance";
  der(H) = inlet.m_flow*hin + outlet.m_flow*hout "Energy balance";
  p - pext = Medium.density(liquidState)*g*y "Stevino's law";

  // Boundary conditions
  hin = homotopy(if not allowFlowReversal then inStream(inlet.h_outflow) else
    actualStream(inlet.h_outflow), inStream(inlet.h_outflow));
  hout = homotopy(if not allowFlowReversal then h else actualStream(outlet.h_outflow),
    h);
  inlet.h_outflow = h;
  outlet.h_outflow = h;
  inlet.p = p;
  outlet.p = p;
initial equation
  if initOpt == Choices.Init.Options.noInit then
    // do nothing
  elseif initOpt == Choices.Init.Options.steadyState then
    der(h) = 0;
    der(y) = 0;
  else
    assert(false, "Unsupported initialisation option");
  end if;

  annotation (Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-70},{100,55}},
        grid={0.5,0.5}), graphics={
        Text(extent={{-100,-50},{100,-65}}, textString="%name"),
        Rectangle(
          extent={{-100,55},{100,-50}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-90,45},{90,-40}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-90,45},{90,20}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Text(
          extent={{-100,0},{100,-20}},
          lineColor={64,64,64},
          textStyle={TextStyle.Bold},
          textString="Plenum")}), Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-70},{100,55}},
        grid={0.5,0.5}), graphics));
end Plenum;
