within ORNL_AdvSMR.PRISM.PrimaryHeatTransportSystem;
model Reactor_PrimaryLoop_UpperPlenum_Block

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  inner System system(Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState,
      allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));
  Components.ChannelFlow2 core(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    rhonom=1950,
    dpnom(displayUnit="kPa") = 1,
    L=0.80,
    H=0.80,
    A=0.623/(19*19),
    omega=Modelica.Constants.pi*6.5e-2,
    Dhyd=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2),
    wnom=1325/(19*19),
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    hstartin=28.8858e3 + 1.2753e3*(400 + 273),
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer (alpha0=
            5000),
    hstartout=28.8858e3 + 1.2753e3*(550 + 273),
    nNodes=nNodes,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={20,0})));
  Components.Pump primaryPump(
    wstart=0.7663,
    n0=1000,
    redeclare package Medium = Medium,
    rho0=950,
    dp0(displayUnit="kPa") = 15000,
    hstart=28.8858e3 + 1.2753e3*(400 + 273),
    Np0=1,
    w0=20,
    redeclare function flowCharacteristic =
        ORNL_AdvSMR.Functions.PumpCharacteristics.linearFlow (q_nom={1e-3,1e-1},
          head_nom={5,5}),
    usePowerCharacteristic=false,
    redeclare function efficiencyCharacteristic =
        ORNL_AdvSMR.Functions.PumpCharacteristics.constantEfficiency (eta_nom=
            0.95),
    V=0.1,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState) annotation (Placement(
        transformation(extent={{50,-95},{30,-75}}, rotation=0)));
  Components.Plenum upperPlenum(
    redeclare package Medium = Medium,
    A=4,
    V0=1,
    ystart=1,
    initOpt=Choices.Init.Options.noInit,
    hstart=28.8858e3 + 1.2753e3*(550 + 273),
    pext=200000)
    annotation (Placement(transformation(extent={{20,60},{60,100}})));
  Components.SensT coreTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={16,-40})));
  Components.SensT coreTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={16,40})));
  Components.SensT dcTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={64,40})));
  Components.SensT dcTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={64,-41})));
  CORE.FuelPinModel fuelPinModel(noAxialNodes=nNodes)
    annotation (Placement(transformation(extent={{-15,-75},{0.5,75}})));
  CORE.ReactorKinetics reactorKinetics(
    noAxialNodes=9,
    noFuelAssemblies=1,
    noFuelPins=1,
    alpha_f=0,
    alpha_c=0,
    Q_nom=100e3,
    T_f0=1073.15,
    T_c0=623.15)
    annotation (Placement(transformation(extent={{-75,-20},{-35,20}})));

  // number of Nodes
  parameter Integer nNodes=9 "Number of axial nodes";

  Modelica.Blocks.Interfaces.RealInput u annotation (Placement(transformation(
          extent={{-130,-20},{-90,20}}), iconTransformation(extent={{-110,-10},
            {-90,10}})));
  Modelica.Blocks.Interfaces.RealInput u1 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={55,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-100})));
  Interfaces.FlangeA primaryReturn
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Interfaces.FlangeB primaryOutlet
    annotation (Placement(transformation(extent={{90,10},{110,30}})));
equation
  connect(coreTi.outlet, core.infl) annotation (Line(
      points={{20,-34},{20,-15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTi.inlet, primaryPump.outfl) annotation (Line(
      points={{20,-46},{20,-78},{34,-78}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTo.inlet, core.outfl) annotation (Line(
      points={{20,34},{20,15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(dcTo.outlet, primaryPump.infl) annotation (Line(
      points={{60,-47},{60,-83},{48,-83}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(reactorKinetics.axialProfile, fuelPinModel.powerIn) annotation (Line(
      points={{-35,0},{-18.875,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fuelPinModel.T_fe, reactorKinetics.T_fe) annotation (Line(
      points={{-7.25,-75},{-7.25,-90},{-43,-90},{-43,-20}},
      color={0,0,0},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(fuelPinModel.heatOut, core.wall) annotation (Line(
      points={{2.4375,0},{14,0}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(upperPlenum.inlet, coreTo.outlet) annotation (Line(
      points={{25,66.4},{25,55},{20,55},{20,46}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(upperPlenum.outlet, dcTi.inlet) annotation (Line(
      points={{55,66.4},{55,55},{60,55},{60,46}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  reactorKinetics.T_ce = sum(core.T)/nNodes;

  connect(u1, primaryPump.in_n) annotation (Line(
      points={{55,-110},{55,-65},{42.6,-65},{42.6,-77}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(primaryOutlet, dcTi.outlet) annotation (Line(
      points={{100,20},{60,20},{60,34}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(primaryReturn, dcTo.inlet) annotation (Line(
      points={{100,-20},{60,-20},{60,-35}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(u, reactorKinetics.rho_CR) annotation (Line(
      points={{-110,0},{-75,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={175,175,175},
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5,
          radius=8),Rectangle(
          extent={{-90,90},{90,-80}},
          lineColor={175,175,175},
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          radius=2),Text(
          extent={{-100,-59.5},{100,-74.5}},
          lineColor={135,135,135},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          textString="Primary Heat Transport System"),Text(
          extent={{-17.5,2.5},{17.5,-2.5}},
          lineColor={95,95,95},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          origin={-107,-28},
          rotation=90,
          textString="Control Rod
Reactivity"),Text(
          extent={{-12.25,2.5},{12.25,-2.5}},
          lineColor={95,95,95},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          origin={107.5,37.75},
          rotation=270,
          textString="Primary
Out"),Text(
          extent={{-15,2.5},{15,-2.5}},
          lineColor={95,95,95},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          origin={107.5,-40},
          rotation=270,
          textString="Primary
Return"),Text(
          extent={{-17.5,2.5},{17.5,-2.5}},
          lineColor={95,95,95},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          origin={27.5,-107.5},
          rotation=180,
          textString="Primary Pump
Speed")}),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end Reactor_PrimaryLoop_UpperPlenum_Block;
