within Ethan2;
model PrescribedPressureCondenser "Ideal condenser with prescribed pressure"
  replaceable package Medium = ThermoPower3.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium model";
  //Parameters
  parameter Modelica.SIunits.Pressure p = 0.08 "Nominal inlet pressure";
  parameter Modelica.SIunits.Volume Vtot=10 "Total volume of the fluid side";
  parameter Modelica.SIunits.Volume Vlstart=0.15*Vtot
    "Start value of the liquid water volume";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ThermoPower3.System system "System wide properties";

  //Variable
  Modelica.SIunits.Density rhol "Density of saturated liquid";
  Modelica.SIunits.Density rhov "Density of saturated steam";
  Medium.SaturationProperties sat "Saturation properties";
  Medium.SpecificEnthalpy hl "Specific enthalpy of saturated liquid";
  Medium.SpecificEnthalpy hv "Specific enthalpy of saturated vapour";
  Medium.SpecificEnthalpy hf "Specific enthalpy of saturated vapour";
  Modelica.SIunits.Mass M(stateSelect=StateSelect.never)
    "Total mass, steam+liquid";
  Modelica.SIunits.Mass Ml(stateSelect=StateSelect.never) "Liquid mass";
  Modelica.SIunits.Mass Mv(stateSelect=StateSelect.never) "Steam mass";
  Modelica.SIunits.Volume Vl(start=Vlstart, stateSelect=StateSelect.prefer)
    "Liquid volume";
  Modelica.SIunits.Volume Vv(stateSelect=StateSelect.never) "Steam volume";
  Modelica.SIunits.Energy E(stateSelect=StateSelect.never) "Internal energy";
  Modelica.SIunits.Power Q "Thermal power";
  constant Real g=Modelica.Constants.g_n;
  parameter Modelica.SIunits.Area A = 1 "representative condenser area";

  //Connectors
  ThermoPower3.Water.FlangeA steamIn(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,80},{20,120}}, rotation=0)));
  ThermoPower3.Water.FlangeB waterOut(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}}, rotation=
           0)));

  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation

  y = der(Ml);
  steamIn.p = p;
  steamIn.h_outflow = hv;
  sat.psat = p;
  sat.Tsat = Medium.saturationTemperature(p);
  hl = Medium.bubbleEnthalpy(sat);
  hv = Medium.dewEnthalpy(sat);
  waterOut.p = p + rhol * g * Vl/A;
  waterOut.h_outflow = min(hf,hl);
  rhol = Medium.bubbleDensity(sat);
  rhov = Medium.dewDensity(sat);

  Ml = Vl*rhol;
  Mv = Vv*rhov;
  Vtot = Vv + Vl;
  M = Ml + Mv;
  E = Ml*hl + Mv*hv - p*Vtot;

  //Energy and Mass Balances
  der(M) = steamIn.m_flow + waterOut.m_flow;
  der(E) = steamIn.m_flow*hf + waterOut.m_flow*hl - Q;

  hf = homotopy(if not allowFlowReversal then inStream(steamIn.h_outflow) else
    actualStream(steamIn.h_outflow), inStream(steamIn.h_outflow));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
         graphics={Ellipse(
              extent={{-90,100},{90,-80}},
              lineColor={0,0,255},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(
              points={{44,-40},{-50,-40},{8,10},{-50,60},{44,60}},
              color={0,0,255},
              thickness=0.5),Rectangle(
              extent={{-48,-66},{48,-100}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),Text(
              extent={{-100,-115},{100,-145}},
              lineColor={85,170,255},
              textString="%name")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
            graphics),
    Documentation(revisions="<html>
<ul>
<li><i>10 Dec 2008</i>
    by <a>Luca Savoldelli</a>:<br>
       First release.</li>
</ul>
</html>"));
end PrescribedPressureCondenser;
