within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.Condensers;
model CondenserShell
  replaceable package Medium =
      Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model";
  parameter Modelica.SIunits.Volume V "Total volume of condensation cavity";
  parameter Modelica.SIunits.Mass Mm "Total mass of shell and tubes";
  parameter Modelica.SIunits.Area Ac "Area of condensation surfaces";
  parameter Modelica.SIunits.Area Af "Area of contact with the cooling fluid";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hc
    "Coefficient of heat transfer on condensation surfaces";
  parameter Modelica.SIunits.SpecificHeatCapacity cm
    "Specific heat capacity of the metal";
  parameter Integer Nc=2 "Number of nodes for coolingFluid connector";
  parameter Modelica.SIunits.Pressure pstart "Pressure start value"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.Volume Vlstart
    "Start value of the liquid water volume"
    annotation (Dialog(tab="Initialisation"));
  parameter ThermoPower3.Choices.Init.Options initOpt=ThermoPower3.Choices.Init.Options.noInit
    "Initialisation option" annotation (Dialog(tab="Initialisation"));
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ThermoPower3.System system "System wide properties";

  Modelica.SIunits.Mass Ml "Liquid water mass";
  Modelica.SIunits.Mass Mv "Steam mass";
  Modelica.SIunits.Mass M "Total liquid+steam mass";
  Modelica.SIunits.Energy E "Total liquid+steam energy";
  Modelica.SIunits.Energy Em "Total energy of metal masses";
  Modelica.SIunits.Volume Vl(start=Vlstart, stateSelect=StateSelect.prefer)
    "Liquid water total volume";
  Modelica.SIunits.Volume Vv "Steam volume";
  Medium.SaturationProperties sat "Saturation properties";
  Medium.AbsolutePressure p(start=pstart,stateSelect=StateSelect.prefer)
    "Drum pressure";
  Medium.MassFlowRate ws "Steam mass flowrate";
  Medium.MassFlowRate wc "Condensate mass flowrate";
  Modelica.SIunits.HeatFlowRate Qcool
    "Heat flow from the metal to the cooling fluid";
  Modelica.SIunits.HeatFlowRate Qcond
    "Heat flow from the condensing fluid to the metal";
  Medium.SpecificEnthalpy hs "Specific enthalpy of entering steam";
  Medium.SpecificEnthalpy hl "Specific enthalpy of saturated liquid";
  Medium.SpecificEnthalpy hv "Specific enthalpy of saturated steam";
  Medium.Temperature Ts "Saturation temperature";
  Medium.Temperature Tm(start=Medium.saturationTemperature(pstart),
      stateSelect=StateSelect.prefer) "Average temperature of metal walls";
  Medium.Density rhol "Density of saturated liquid";
  Medium.Density rhov "Density of saturated steam";

  ThermoPower3.Water.FlangeA steam(redeclare package Medium = Medium,
      m_flow(min=if allowFlowReversal then -Modelica.Constants.inf
           else 0)) annotation (Placement(transformation(extent={{-20,
            80},{20,120}}, rotation=0)));
  ThermoPower3.Water.FlangeB condensate(redeclare package Medium =
        Medium, m_flow(max=if allowFlowReversal then +Modelica.Constants.inf
           else 0)) annotation (Placement(transformation(extent={{-20,-120},
            {20,-80}}, rotation=0)));
  ThermoPower3.Thermal.DHT coolingFluid(N=Nc) annotation (Placement(
        transformation(extent={{-6,-40},{6,40}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput ratio_VvVtot annotation (
      Placement(transformation(
        origin={-70,0},
        extent={{-20,-20},{20,20}},
        rotation=180)));
equation
  Ml = Vl*rhol "Mass of liquid";
  Mv = Vv*rhov "Mass of vapour";
  M = Ml + Mv "Total mass";
  V = Vl + Vv "Total volume";
  E = Ml*hl + Mv*hv - p*V "Total liquid+steam energy";
  Em = Mm*cm*Tm "Metal tubes energy";
  der(M) = ws - wc "Mass balance";
  der(E) = ws*hs - wc*hl - Qcond "Energy balance (liquid+steam)";
  der(Em) = Qcond - Qcool "Energy balance (metal tubes)";
  Qcond = hc*Ac*(Ts - Tm);

  // Boundary conditions
  p = steam.p;
  p = condensate.p;
  ws = steam.m_flow;
  hs = inStream(steam.h_outflow) "Flow reversal not supported";
  steam.h_outflow = hv;
  wc = -condensate.m_flow;
  condensate.h_outflow = hl;
  Qcool = -Af/(Nc - 1)*sum(coolingFluid.phi[1:Nc - 1] + coolingFluid.phi[
    2:Nc])/2;
  coolingFluid.T = ones(Nc)*Tm;

  // Fluid properties
  // sat = Medium.setSat_p(p);

  sat.psat = p;
  sat.Tsat = Medium.saturationTemperature(p);

  Ts = sat.Tsat;
  rhol = Medium.bubbleDensity(sat);
  rhov = Medium.dewDensity(sat);
  hl = Medium.bubbleEnthalpy(sat);
  hv = Medium.dewEnthalpy(sat);
  ratio_VvVtot = Vv/V;
initial equation
  if initOpt == ThermoPower3.Choices.Init.Options.noInit then
    // do nothing
  elseif initOpt == ThermoPower3.Choices.Init.Options.steadyState then
    der(M) = 0;
    der(E) = 0;
  else
    assert(false, "Unsupported initialisation option");
  end if;
  annotation (Diagram(graphics), Icon(graphics={Rectangle(
                  extent={{-54,88},{-14,-86}},
                  lineColor={0,0,255},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{-14,88},{-6,-86}},
                  lineColor={135,135,135},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{6,88},{14,-86}},
                  lineColor={135,135,135},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{14,88},{54,-86}},
                  lineColor={0,0,255},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{-54,88},{54,-86}},
                  lineColor={135,135,135},
                  lineThickness=1),Text(
                  extent={{-102,-130},{108,-148}},
                  lineColor={0,0,255},
                  textString="%name")}));
end CondenserShell;
