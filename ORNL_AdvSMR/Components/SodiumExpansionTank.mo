within ORNL_AdvSMR.Components;
model SodiumExpansionTank "Sodium expansion tank with argon cover gas"
  replaceable package Medium = ORNL_AdvSMR.Media.Fluids.Na constrainedby
    ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "Medium model";

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
    annotation (Placement(transformation(extent={{-100,-90},{-60,-50}},
          rotation=0), iconTransformation(extent={{-80,-80},{-60,-60}})));
  ORNL_AdvSMR.Interfaces.FlangeB outlet(redeclare package Medium = Medium,
      m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{55,-90},{95,-50}}, rotation=0),
        iconTransformation(extent={{60,-80},{80,-60}})));

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
    der(h) = 0;
  elseif initOpt == Choices.Init.Options.steadyState then
    der(h) = 0;
    der(y) = 0;
  else
    assert(false, "Unsupported initialisation option");
  end if;

  annotation (Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={
        Text(extent={{-100,-105},{100,-120}}, textString="%name"),
        Ellipse(
          extent={{-100,100},{100,-100}},
          pattern=LinePattern.None,
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-85,85},{85,-85}},
          pattern=LinePattern.None,
          lineColor={135,135,135},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-85,85},{85,-85}},
          pattern=LinePattern.None,
          lineColor={135,135,135},
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=180),
        Text(
          extent={{-100,50.5},{100,30}},
          lineColor={64,64,64},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Cover Gas")}), Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics));
end SodiumExpansionTank;
