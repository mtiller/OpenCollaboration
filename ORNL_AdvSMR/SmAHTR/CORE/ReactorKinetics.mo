within ORNL_AdvSMR.SmAHTR.CORE;
model ReactorKinetics
  "0-D model of reactor dynamics with 6-group precursor concentrations"

  import Modelica.Math.*;
  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  /* PARAMETERS */
  /* General parameters */
  parameter Power Q_nom=250e6 "Reactor nominal heat rating (W)"
    annotation (Dialog(tab="General"));
  parameter Integer noRadialNodes=4 "Number of radial zones"
    annotation (Dialog(tab="General"));
  parameter Integer noAxialNodes=8 "Number of axial zones"
    annotation (Dialog(tab="General"));
  parameter Integer noFuelAssemblies=10 "Number of fuel assemblies"
    annotation (Dialog(tab="General", group="Core Loading Parameters"));
  parameter Integer noFuelPins=12*12 "Number of fuel pins in an assembly"
    annotation (Dialog(tab="General", group="Core Loading Parameters"));
  parameter Length H_fuelPin=3 "Active height of a fuel pin"
    annotation (Dialog(tab="General", group="Core Loading Parameters"));
  parameter Boolean usePowerProfile=true "Use power profile output"
    annotation (Dialog(tab="General", group="Core Loading Parameters"));

  /* Neutron kinetic parameters */
  parameter Real[6] beta={0.000215,0.001424,0.001274,0.002568,0.000748,
      0.000273} "Delayed neutron precursor fractions" annotation (Dialog(
        tab="Kinetics", group="Neutron Kinetics Parameters"));
  parameter Real[6] lambda(unit="1/s") = {0.0124,0.0305,0.111,0.301,1.14,
    3.01} "Decay constants for each precursor group" annotation (Dialog(
        tab="Kinetics", group="Neutron Kinetics Parameters"));
  parameter Real Lambda(unit="s") = 0.03 "Mean neutron generation time"
    annotation (Dialog(tab="Kinetics", group=
          "Neutron Kinetics Parameters"));
  /* Reactivity feedback parameters */
  parameter Real alpha_f=-3.80 "Fuel Doppler feedback coefficient"
    annotation (Dialog(tab="Kinetics", group=
          "Reactivity Feedback Parameters"));
  parameter Temperature T_f0=1300 + 273.15 "Fuel reference temperature"
    annotation (Dialog(tab="Kinetics", group=
          "Reactivity Feedback Parameters"));
  parameter Real alpha_c=-0.51 "Coolant density feedback coefficient"
    annotation (Dialog(tab="Kinetics", group=
          "Reactivity Feedback Parameters"));
  parameter Temperature T_c0=675 + 273.15 "Coolant reference temperature"
    annotation (Dialog(tab="Kinetics", group=
          "Reactivity Feedback Parameters"));
  /* Fuel Cycle Parameters */
  parameter Time T_op=360*24*3600 "Time since reactor startup"
    annotation (Dialog(tab="Kinetics", group="Fuel Cycle Parameters"));

  /* Simulation variables */
  Real n(start=1.0) "Normalized reactor power"
    annotation (Dialog(tab="Initialization"));
  Real[6] c(start=ones(6)) "Normalized precursor concentrations vector"
    annotation (Dialog(tab="Initialization"));

protected
  Integer noNodes=noRadialNodes*noAxialNodes "Total number of zones";
  Real Beta=sum(beta) "Sum of delayed neutron precursor fractions";
  Real rho_f "Fuel reactivity feedback";
  Real rho_c "Coolant reactivity feedback";
  Real rho_t "Total reactivity feedback";
public
  Real Qn_decay "Normalized decay heat fraction";
  Power Q_decay "Decay heat during operation and after shutdown (W)";
  Power Q_prompt "Prompt heat generated during operation (W)";
  Power Q_total "Total thermal power of the reactor (W)";
  Power q_channel "Total thermal power of the channel (W)";

public
  Modelica.Blocks.Interfaces.RealInput rho_CR "Control rod reactivity"
    annotation (Placement(transformation(extent={{-105,-5},{-95,5}}),
        iconTransformation(extent={{-105,-5},{-95,5}})));
  SIInterfaces.SITemperatureInput T_ce "Effective coolant temperature"
    annotation (Placement(transformation(
        extent={{-10,-9.75},{10,9.75}},
        rotation=90,
        origin={-59.75,-97.5}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-100})));
  SIInterfaces.SITemperatureInput T_fe "Fuel effective temperature"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-97.5}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-100})));
  Modelica.Blocks.Interfaces.RealOutput[noAxialNodes] axialProfile
    "Normalized nodal flux profile" annotation (Placement(transformation(
          extent={{95,-10},{115,10}}), iconTransformation(extent={{95,-5},
            {105,5}})));

equation
  /* Normalized 6-group point kinetics equations */
  der(n) = (rho_t - Beta)/Lambda*n + sum(beta .* c)/Lambda;
  der(c) = lambda .* (n .- c);

  /* Reactivity feedback equations */
  rho_f = alpha_f*(T_fe - T_f0) "Fuel Doppler reactivity feedback";
  rho_c = alpha_c*(T_ce - T_c0) "Coolant density reactivity feedback";
  rho_t = rho_CR + rho_f + rho_c "Total reactivity feedback";

  /* Decay heat equations */
  Qn_decay = 0.1*((time + 10)^(-0.2) - (time + T_op)^(-0.2) + 0.87*(time
     + T_op + 2e7)^(-0.2) - 0.87*(time + 2e7)^(-0.2));
  Q_decay = Qn_decay*Q_nom;
  Q_prompt = n*Q_nom;
  Q_total = (Q_prompt + Q_decay)/(1 + Qn_decay);

  q_channel = Q_total/(noFuelAssemblies*noFuelPins);

  /* Thermal power profile */
  axialProfile[1:noAxialNodes] = {-q_channel*H_fuelPin/pi*(cos(pi*i/
    noAxialNodes) + cos(pi*(1 - i + noAxialNodes)/noAxialNodes)) for i in
        1:noAxialNodes};

initial equation
  der(n) = 0;
  der(c) = zeros(6);

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}),graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={175,175,175},
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                lineThickness=0.5,
                radius=8),Bitmap(extent={{-90,95},{90,-80}}, fileName=
          "modelica://aSMR/Icons/Reactor-core-simulation-image2.jpg")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}),graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={175,175,175},
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                lineThickness=0.5,
                radius=8),Bitmap(extent={{-75,85},{75,-55}}, fileName=
          "modelica://aSMR/Icons/Reactor-core-simulation-image2.jpg"),
          Text( extent={{-100,-70},{100,-85}},
                lineColor={135,135,135},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textStyle={TextStyle.Bold},
                textString="Reactor Core"),Text(
                extent={{-80,-82.5},{-45,-87.5}},
                lineColor={95,95,95},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textStyle={TextStyle.Bold},
                textString="Coolant
Temperature"),
        Text(   extent={{40,-82.5},{75,-87.5}},
                lineColor={95,95,95},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textStyle={TextStyle.Bold},
                textString="Fuel
Temperature"),
        Rectangle(extent={{-90,90},{90,-70}}, lineColor={95,95,95}),Text(
                extent={{-17.5,2.5},{17.5,-2.5}},
                lineColor={95,95,95},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textStyle={TextStyle.Bold},
                origin={-107.5,17.5},
                rotation=90,
                textString="Control Rod
Reactivity"),
       Text(    extent={{-17.5,2.5},{17.5,-2.5}},
                lineColor={95,95,95},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textStyle={TextStyle.Bold},
                origin={107.5,17.5},
                rotation=270,
                textString="Neutron Flux
Profile")}),
    experiment(StopTime=1000,NumberOfIntervals=10000),
    __Dymola_experimentSetupOutput,
    Diagram(graphics));
end ReactorKinetics;
