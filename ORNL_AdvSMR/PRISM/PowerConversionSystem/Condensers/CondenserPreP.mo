within ORNL_AdvSMR.PRISM.PowerConversionSystem.Condensers;
model CondenserPreP "Ideal condenser with prescribed pressure"
  replaceable package Medium = ORNL_AdvSMR.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium model";
  //Parameters
  parameter Modelica.SIunits.Pressure p "Nominal inlet pressure";
  parameter Modelica.SIunits.Volume Vtot=10 "Total volume of the fluid side";
  parameter Modelica.SIunits.Volume Vlstart=0.15*Vtot
    "Start value of the liquid water volume";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ORNL_AdvSMR.System system "System wide properties";

  //Variable
  Modelica.SIunits.Density rhol "Density of saturated liquid";
  Modelica.SIunits.Density rhov "Density of saturated steam";
  Medium.SaturationProperties sat "Saturation properties";
  Medium.SpecificEnthalpy hl "Specific enthalpy of saturated liquid";
  Medium.SpecificEnthalpy hv "Specific enthalpy of saturated vapour";
  Modelica.SIunits.Mass M(stateSelect=StateSelect.never)
    "Total mass, steam+liquid";
  Modelica.SIunits.Mass Ml(stateSelect=StateSelect.never) "Liquid mass";
  Modelica.SIunits.Mass Mv(stateSelect=StateSelect.never) "Steam mass";
  Modelica.SIunits.Volume Vl(start=Vlstart, stateSelect=StateSelect.prefer)
    "Liquid volume";
  Modelica.SIunits.Volume Vv(stateSelect=StateSelect.never) "Steam volume";
  Modelica.SIunits.Energy E(stateSelect=StateSelect.never) "Internal energy";
  Modelica.SIunits.Power Q "Thermal power";

  //Connectors
  ORNL_AdvSMR.Interfaces.FlangeA steamIn(redeclare package Medium = Medium,
      m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-20,80},{20,120}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB waterOut(redeclare package Medium = Medium,
      m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}}, rotation
          =0)));
  Modelica.Blocks.Interfaces.RealOutput Qcond annotation (Placement(
        transformation(
        origin={-100,40},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Blocks.Interfaces.RealOutput ratio_Vv_Vtot annotation (Placement(
        transformation(
        origin={-100,-20},
        extent={{-10,-10},{10,10}},
        rotation=180)));

equation
  steamIn.p = p;
  steamIn.h_outflow = hv;
  sat.psat = p;
  sat.Tsat = Medium.saturationTemperature(p);
  hl = Medium.bubbleEnthalpy(sat);
  hv = Medium.dewEnthalpy(sat);
  waterOut.p = p;
  waterOut.h_outflow = hl;
  rhol = Medium.bubbleDensity(sat);
  rhov = Medium.dewDensity(sat);

  Ml = Vl*rhol;
  Mv = Vv*rhov;
  Vtot = Vv + Vl;
  M = Ml + Mv;
  E = Ml*hl + Mv*hv - p*Vtot;

  //Energy and Mass Balances
  der(M) = steamIn.m_flow + waterOut.m_flow;
  der(E) = steamIn.m_flow*hv + waterOut.m_flow*hl - Q;

  //Output signal
  ratio_Vv_Vtot = Vv/Vtot;
  Qcond = Q;

  annotation (Icon(graphics={Rectangle(
          extent={{-90,100},{90,-60}},
          lineColor={0,0,255},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-80,-60},{80,-100}},
          lineColor={0,0,255},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),Line(
          points={{60,-40},{-60,-40},{30,10},{-60,60},{60,60}},
          color={0,0,255},
          thickness=0.5)}), Diagram(graphics));
end CondenserPreP;
