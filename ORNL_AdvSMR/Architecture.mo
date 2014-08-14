within ORNL_AdvSMR;
package Architecture "Plant end-to-end architecture"
  partial model EndToEnd "Generic end-to-end plant architecture"

    replaceable Interfaces.RxPrimaryHeatTransportSystem primary_loop
      annotation (Placement(transformation(extent={{-140,-20},{-101,20}})));
    replaceable Interfaces.IntermediateHeatExchanger
      intermediate_heat_exchanger
      annotation (Placement(transformation(extent={{-80,-20},{-40,20}})));
    replaceable Interfaces.IntermediateHeatTransportSystem intermediate_loop
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    replaceable Interfaces.SteamGenerator steam_generator
      annotation (Placement(transformation(extent={{40,-20},{80,20}})));
    replaceable Interfaces.PowerConversionSystem power_conversion_system
      annotation (Placement(transformation(extent={{100,-20},{140,20}})));
    replaceable Interfaces.SingleShaftGenerator singleShaftGenerator
      annotation (Placement(transformation(extent={{160,-20},{200,20}})));
    replaceable Interfaces.ControlSystem controlSystem
      annotation (Placement(transformation(extent={{58,-100},{98,-60}})));
    replaceable Interfaces.EventDriver eventDriver
      annotation (Placement(transformation(extent={{-64,-100},{-24,-60}})));
    replaceable Interfaces.DRACS dracs
      annotation (Placement(transformation(extent={{-200,-20},{-160,20}})));

  equation
    connect(power_conversion_system.rotorShaft, singleShaftGenerator.shaft)
      annotation (Line(
        points={{140,0},{160,0}},
        color={0,0,0},
        smooth=Smooth.None,
        thickness=1));
    connect(intermediate_heat_exchanger.tubeOutlet, intermediate_loop.fromIHX)
      annotation (Line(
        points={{-60,-22},{-60,-30},{-30,-30},{-30,6.5},{-19.5,6.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.tubeInlet, intermediate_loop.toIHX)
      annotation (Line(
        points={{-60,22},{-60,40},{-26,40},{-26,-5.5},{-19.5,-5.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(controlSystem.controlBus, primary_loop.controlBus) annotation (Line(
        points={{78,-62},{78,-46},{-120.5,-46},{-120.5,-18.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, intermediate_heat_exchanger.controlBus)
      annotation (Line(
        points={{78,-62},{78,-46},{-44,-46},{-44,-18},{-43,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, intermediate_loop.controlBus) annotation
      (Line(
        points={{78,-62},{78,-46},{0,-46},{0,-19.5}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, steam_generator.controlBus) annotation (
        Line(
        points={{78,-62},{78,-18},{77,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, power_conversion_system.controlBus)
      annotation (Line(
        points={{78,-62},{78,-46},{120,-46},{120,-18.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, singleShaftGenerator.controlBus)
      annotation (Line(
        points={{78,-62},{78,-46},{180,-46},{180,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(dracs.toPHTS, primary_loop.fromDRACS) annotation (Line(
        points={{-159,10},{-140,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(dracs.fromPHTS, primary_loop.toDRACS) annotation (Line(
        points={{-159,-10},{-140,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(dracs.controlBus, controlSystem.controlBus) annotation (Line(
        points={{-180,-19},{-180,-46},{78,-46},{78,-62}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, intermediate_loop.controlBus) annotation (
        Line(
        points={{-44,-62},{-44,-46},{0,-46},{0,-19.5}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, intermediate_heat_exchanger.controlBus)
      annotation (Line(
        points={{-44,-62},{-44,-18},{-43,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, primary_loop.controlBus) annotation (Line(
        points={{-44,-62},{-44,-46},{-120.5,-46},{-120.5,-18.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, steam_generator.controlBus) annotation (
        Line(
        points={{-44,-62},{-44,-46},{78,-46},{78,-18},{77,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, power_conversion_system.controlBus)
      annotation (Line(
        points={{-44,-62},{-44,-46},{120,-46},{120,-18.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, singleShaftGenerator.controlBus)
      annotation (Line(
        points={{-44,-62},{-44,-46},{180,-46},{180,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(primary_loop.toIHX, intermediate_heat_exchanger.shellInlet)
      annotation (Line(
        points={{-101,10},{-80,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.shellOutlet, primary_loop.fromIHX)
      annotation (Line(
        points={{-41,-7},{-36,-7},{-36,-34},{-88,-34},{-88,-10},{-101,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_loop.fromSG, steam_generator.shellInlet) annotation (
        Line(
        points={{20.5,-5.5},{32,-5.5},{32,9},{42,9}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(steam_generator.shellOutlet, intermediate_loop.toSG) annotation (
        Line(
        points={{78,-8},{88,-8},{88,-30},{28,-30},{28,10.5},{19.5,10.5}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(steam_generator.tubeOutlet, power_conversion_system.steamInlet)
      annotation (Line(
        points={{60,-22},{60,-36},{90,-36},{90,12},{100,12}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(steam_generator.tubeInlet, power_conversion_system.condensateReturn)
      annotation (Line(
        points={{60,22},{60,40},{92,40},{92,-12},{100,-12}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(extent={{-200,-100},{200,100}},
            preserveAspectRatio=false), graphics={Text(
              extent={{-200,32},{-160,26}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="DRACS"),Text(
              extent={{-140,40},{-100,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Primary Heat
Transport System"),Text(
              extent={{-20,40},{20,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate Heat
Transport System"),Text(
              extent={{100,40},{140,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Power Conversion
System"),Text(extent={{160,32},{200,26}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Electrical
Grid"),Text(  extent={{-78,38},{-42,24}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate
Heat Exchanger"),Text(
              extent={{40,38},{80,20}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Steam Generator")}), Icon(coordinateSystem(extent={{-200,
              -100},{200,100}})));
  end EndToEnd;

  partial model Primary2SteamGenerator
    "Primary loop-to-steam generator architecture"

    replaceable Interfaces.RxPrimaryHeatTransportSystem primary_loop
      annotation (Placement(transformation(extent={{-136,-20},{-97,20}})));
    replaceable Interfaces.IntermediateHeatExchanger
      intermediate_heat_exchanger
      annotation (Placement(transformation(extent={{-76,-20},{-36,20}})));
    replaceable Interfaces.IntermediateHeatTransportSystem intermediate_loop
      annotation (Placement(transformation(extent={{20,-20},{60,20}})));
    replaceable Interfaces.SteamGenerator steam_generator
      annotation (Placement(transformation(extent={{80,-20},{120,20}})));
    replaceable Interfaces.ControlSystem control_system
      annotation (Placement(transformation(extent={{20,-100},{60,-60}})));
    replaceable Interfaces.EventDriver event_driver
      annotation (Placement(transformation(extent={{-60,-100},{-20,-60}})));
  equation

    connect(intermediate_heat_exchanger.tubeOutlet, intermediate_loop.fromIHX)
      annotation (Line(
        points={{-56,-22},{-56,-30},{-20,-30},{-20,6.5},{20.5,6.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.tubeInlet, intermediate_loop.toIHX)
      annotation (Line(
        points={{-56,22},{-56,40},{0,40},{0,-5.5},{20.5,-5.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(control_system.controlBus, primary_loop.controlBus) annotation (
        Line(
        points={{40,-62},{40,-46},{-116.5,-46},{-116.5,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(control_system.controlBus, intermediate_heat_exchanger.controlBus)
      annotation (Line(
        points={{40,-62},{40,-46},{-40,-46},{-40,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(control_system.controlBus, intermediate_loop.controlBus)
      annotation (Line(
        points={{40,-62},{40,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(control_system.controlBus, steam_generator.controlBus) annotation (
        Line(
        points={{40,-62},{40,-17.9},{116,-17.9}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(event_driver.controlBus, intermediate_loop.controlBus) annotation (
        Line(
        points={{-40,-62},{-40,-46},{40,-46},{40,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(event_driver.controlBus, intermediate_heat_exchanger.controlBus)
      annotation (Line(
        points={{-40,-62},{-40,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(event_driver.controlBus, primary_loop.controlBus) annotation (Line(
        points={{-40,-62},{-40,-46},{-116.5,-46},{-116.5,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(event_driver.controlBus, steam_generator.controlBus) annotation (
        Line(
        points={{-40,-62},{-40,-46},{116,-46},{116,-17.9}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(primary_loop.toIHX, intermediate_heat_exchanger.shellInlet)
      annotation (Line(
        points={{-97,10},{-76,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.shellOutlet, primary_loop.fromIHX)
      annotation (Line(
        points={{-37,-7},{-28,-7},{-28,-40},{-88,-40},{-88,-10},{-97,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_loop.toSG, steam_generator.tubeInlet) annotation (Line(
        points={{59.5,10.5},{68,10.5},{68,40},{100,40},{100,22}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(steam_generator.tubeOutlet, intermediate_loop.fromSG) annotation (
        Line(
        points={{100,-22},{100,-40},{70,-40},{70,-5.5},{60.5,-5.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    annotation (Diagram(coordinateSystem(extent={{-200,-100},{200,100}},
            preserveAspectRatio=false), graphics={Text(
              extent={{-136,40},{-96,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Primary Heat
Transport System"),Text(
              extent={{20,40},{60,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate Heat
Transport System"),Text(
              extent={{-74,38},{-38,24}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate
Heat Exchanger"),Text(
              extent={{80,38},{120,20}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Steam Generator")}), Icon(coordinateSystem(extent={{-200,
              -100},{200,100}})));
  end Primary2SteamGenerator;

  partial model IHX_test "Primary loop-to-steam generator architecture"

    replaceable Interfaces.RxPrimaryHeatTransportSystem primary_loop
      annotation (Placement(transformation(extent={{-100,-20},{-61,20}})));
    replaceable Interfaces.IntermediateHeatExchanger
      intermediate_heat_exchanger
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    replaceable Interfaces.IntermediateHeatTransportSystem intermediate_loop
      annotation (Placement(transformation(extent={{60,-20},{100,20}})));
  equation

    connect(intermediate_heat_exchanger.tubeOutlet, intermediate_loop.fromIHX)
      annotation (Line(
        points={{0,-22},{0,-30},{34,-30},{34,6.5},{60.5,6.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.tubeInlet, intermediate_loop.toIHX)
      annotation (Line(
        points={{0,22},{0,40},{40,40},{40,-5.5},{60.5,-5.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(primary_loop.toIHX, intermediate_heat_exchanger.shellInlet)
      annotation (Line(
        points={{-61,10},{-20,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.shellOutlet, primary_loop.fromIHX)
      annotation (Line(
        points={{19,-7},{28,-7},{28,-40},{-32,-40},{-32,-10},{-61,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    annotation (Diagram(coordinateSystem(extent={{-200,-100},{200,100}},
            preserveAspectRatio=false), graphics={Text(
              extent={{-80,40},{-40,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Primary Heat
Transport System"),Text(
              extent={{60,40},{100,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate Heat
Transport System"),Text(
              extent={{-18,38},{18,24}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate
Heat Exchanger")}), Icon(coordinateSystem(extent={{-200,-100},{200,100}})));
  end IHX_test;

  partial model HybridEnergySystem "Generic end-to-end plant architecture"
    replaceable Interfaces.RxPrimaryHeatTransportSystem primary_loop
      annotation (Placement(transformation(extent={{-140,-20},{-101,20}})));
    replaceable Interfaces.IntermediateHeatExchanger
      intermediate_heat_exchanger
      annotation (Placement(transformation(extent={{-80,-20},{-40,20}})));
    replaceable Interfaces.IntermediateHeatTransportSystem intermediate_loop
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    replaceable Interfaces.SteamGenerator steam_generator
      annotation (Placement(transformation(extent={{40,-20},{80,20}})));
    replaceable Interfaces.PowerConversionSystem power_conversion_system
      annotation (Placement(transformation(extent={{100,-20},{140,20}})));
    replaceable Interfaces.SingleShaftGenerator generator
      annotation (Placement(transformation(extent={{160,-20},{200,20}})));
    replaceable Interfaces.ControlSystem control_system
      annotation (Placement(transformation(extent={{56,-100},{96,-60}})));
    replaceable Interfaces.EventDriver event_driver
      annotation (Placement(transformation(extent={{-64,-100},{-24,-60}})));
    replaceable Interfaces.DRACS dracs
      annotation (Placement(transformation(extent={{-200,-20},{-160,20}})));
  equation
    connect(power_conversion_system.rotorShaft, generator.shaft) annotation (
        Line(
        points={{140,0},{160,0}},
        color={0,0,0},
        smooth=Smooth.None,
        thickness=1));

    connect(intermediate_heat_exchanger.tubeOutlet, intermediate_loop.fromIHX)
      annotation (Line(
        points={{-60,-22},{-60,-30},{-30,-30},{-30,6.5},{-19.5,6.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.tubeInlet, intermediate_loop.toIHX)
      annotation (Line(
        points={{-60,22},{-60,40},{-26,40},{-26,-5.5},{-19.5,-5.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(control_system.controlBus, primary_loop.controlBus) annotation (
        Line(
        points={{76,-62},{76,-46},{-120.5,-46},{-120.5,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(control_system.controlBus, intermediate_heat_exchanger.controlBus)
      annotation (Line(
        points={{76,-62},{76,-46},{-44,-46},{-44,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(control_system.controlBus, intermediate_loop.controlBus)
      annotation (Line(
        points={{76,-62},{76,-46},{0,-46},{0,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(control_system.controlBus, steam_generator.controlBus) annotation (
        Line(
        points={{76,-62},{76,-17.9}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(control_system.controlBus, power_conversion_system.controlBus)
      annotation (Line(
        points={{76,-62},{76,-46},{119.975,-46},{119.975,-18.125}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(control_system.controlBus, generator.controlBus) annotation (Line(
        points={{76,-62},{76,-46},{180,-46},{180,-19}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(dracs.toPHTS, primary_loop.fromDRACS) annotation (Line(
        points={{-159,10},{-140,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(dracs.fromPHTS, primary_loop.toDRACS) annotation (Line(
        points={{-159,-10},{-140,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(dracs.controlBus, control_system.controlBus) annotation (Line(
        points={{-180,-19},{-180,-46},{76,-46},{76,-62}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(event_driver.controlBus, intermediate_loop.controlBus) annotation (
        Line(
        points={{-44,-62},{-44,-46},{0,-46},{0,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(event_driver.controlBus, intermediate_heat_exchanger.controlBus)
      annotation (Line(
        points={{-44,-62},{-44,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(event_driver.controlBus, primary_loop.controlBus) annotation (Line(
        points={{-44,-62},{-44,-46},{-120.5,-46},{-120.5,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(event_driver.controlBus, steam_generator.controlBus) annotation (
        Line(
        points={{-44,-62},{-44,-46},{76,-46},{76,-17.9}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(event_driver.controlBus, power_conversion_system.controlBus)
      annotation (Line(
        points={{-44,-62},{-44,-46},{119.975,-46},{119.975,-18.125}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(event_driver.controlBus, generator.controlBus) annotation (Line(
        points={{-44,-62},{-44,-46},{180,-46},{180,-19}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(steam_generator.shellOutlet, power_conversion_system.steamInlet[2])
      annotation (Line(
        points={{78,-8},{88,-8},{88,12},{100,12}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(primary_loop.toIHX, intermediate_heat_exchanger.shellInlet)
      annotation (Line(
        points={{-101,10},{-80,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.shellOutlet, primary_loop.fromIHX)
      annotation (Line(
        points={{-41,-7},{-36,-7},{-36,-34},{-88,-34},{-88,-10},{-101,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(steam_generator.shellInlet, power_conversion_system.condensateReturn)
      annotation (Line(
        points={{42,9},{32,9},{32,-34},{92,-34},{92,-12},{100,-12}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_loop.toSG, steam_generator.tubeInlet) annotation (Line(
        points={{19.5,10.5},{28,10.5},{28,40},{60,40},{60,22}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(steam_generator.tubeOutlet, intermediate_loop.fromSG) annotation (
        Line(
        points={{60,-22},{60,-30},{28,-30},{28,-5.5},{20.5,-5.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    annotation (Diagram(coordinateSystem(extent={{-200,-100},{200,100}},
            preserveAspectRatio=false), graphics={Text(
              extent={{-200,32},{-160,26}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="DRACS"),Text(
              extent={{-140,40},{-100,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Primary Heat
Transport System"),Text(
              extent={{-20,40},{20,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate Heat
Transport System"),Text(
              extent={{100,40},{140,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Power Conversion
System"),Text(extent={{160,32},{200,26}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Electrical
Grid"),Text(  extent={{-78,38},{-42,24}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate
Heat Exchanger"),Text(
              extent={{40,38},{80,20}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Steam Generator")}), Icon(coordinateSystem(extent={{-200,
              -100},{200,100}})));
  end HybridEnergySystem;

  partial model ProcessHeatSystem
    "End-to-end plant architecture with process heat plant"
    replaceable Interfaces.RxPrimaryHeatTransportSystem primary_loop
      annotation (Placement(transformation(extent={{-140,-20},{-101,20}})));
    replaceable Interfaces.IntermediateHeatExchanger
      intermediate_heat_exchanger
      annotation (Placement(transformation(extent={{-80,-20},{-40,20}})));
    replaceable Interfaces.IntermediateHeatTransportSystem intermediate_loop
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    replaceable Interfaces.SteamGenerator steam_generator
      annotation (Placement(transformation(extent={{40,-20},{80,20}})));
    replaceable Interfaces.PowerConversionSystem power_conversion_system
      annotation (Placement(transformation(extent={{100,-20},{140,20}})));
    replaceable Interfaces.SingleShaftGenerator generator
      annotation (Placement(transformation(extent={{160,-20},{200,20}})));
    replaceable Interfaces.ControlSystem control_system
      annotation (Placement(transformation(extent={{56,-100},{96,-60}})));
    replaceable Interfaces.EventDriver event_driver
      annotation (Placement(transformation(extent={{-64,-100},{-24,-60}})));
    replaceable Interfaces.DRACS dracs
      annotation (Placement(transformation(extent={{-200,-20},{-160,20}})));
    replaceable Interfaces.ProcessPlant processPlant
      annotation (Placement(transformation(extent={{-80,60},{-40,100}})));
  equation
    connect(power_conversion_system.rotorShaft, generator.shaft) annotation (
        Line(
        points={{140,0},{160,0}},
        color={0,0,0},
        smooth=Smooth.None,
        thickness=1));

    connect(intermediate_heat_exchanger.tubeOutlet, intermediate_loop.fromIHX)
      annotation (Line(
        points={{-60,-22},{-60,-30},{-30,-30},{-30,6.5},{-19.5,6.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.tubeInlet, intermediate_loop.toIHX)
      annotation (Line(
        points={{-60,22},{-60,40},{-26,40},{-26,-5.5},{-19.5,-5.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(control_system.controlBus, primary_loop.controlBus) annotation (
        Line(
        points={{76,-62},{76,-46},{-120.5,-46},{-120.5,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(control_system.controlBus, intermediate_heat_exchanger.controlBus)
      annotation (Line(
        points={{76,-62},{76,-46},{-44,-46},{-44,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(control_system.controlBus, intermediate_loop.controlBus)
      annotation (Line(
        points={{76,-62},{76,-46},{0,-46},{0,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(control_system.controlBus, steam_generator.controlBus) annotation (
        Line(
        points={{76,-62},{76,-17.9}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(control_system.controlBus, power_conversion_system.controlBus)
      annotation (Line(
        points={{76,-62},{76,-46},{119.975,-46},{119.975,-18.125}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(control_system.controlBus, generator.controlBus) annotation (Line(
        points={{76,-62},{76,-46},{180,-46},{180,-19}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(dracs.toPHTS, primary_loop.fromDRACS) annotation (Line(
        points={{-159,10},{-140,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(dracs.fromPHTS, primary_loop.toDRACS) annotation (Line(
        points={{-159,-10},{-140,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(dracs.controlBus, control_system.controlBus) annotation (Line(
        points={{-180,-19},{-180,-46},{76,-46},{76,-62}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(event_driver.controlBus, intermediate_loop.controlBus) annotation (
        Line(
        points={{-44,-62},{-44,-46},{0,-46},{0,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(event_driver.controlBus, intermediate_heat_exchanger.controlBus)
      annotation (Line(
        points={{-44,-62},{-44,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(event_driver.controlBus, primary_loop.controlBus) annotation (Line(
        points={{-44,-62},{-44,-46},{-120.5,-46},{-120.5,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(event_driver.controlBus, steam_generator.controlBus) annotation (
        Line(
        points={{-44,-62},{-44,-46},{76,-46},{76,-17.9}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(event_driver.controlBus, power_conversion_system.controlBus)
      annotation (Line(
        points={{-44,-62},{-44,-46},{119.975,-46},{119.975,-18.125}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(event_driver.controlBus, generator.controlBus) annotation (Line(
        points={{-44,-62},{-44,-46},{180,-46},{180,-19}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(steam_generator.shellOutlet, power_conversion_system.steamInlet[2])
      annotation (Line(
        points={{78,-8},{88,-8},{88,12},{100,12}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.shellOutlet, primary_loop.fromIHX)
      annotation (Line(
        points={{-41,-7},{-36,-7},{-36,-34},{-88,-34},{-88,-10},{-101,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(steam_generator.shellInlet, power_conversion_system.condensateReturn)
      annotation (Line(
        points={{42,9},{32,9},{32,-34},{92,-34},{92,-12},{100,-12}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_loop.toSG, steam_generator.tubeInlet) annotation (Line(
        points={{19.5,10.5},{28,10.5},{28,40},{60,40},{60,22}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(steam_generator.tubeOutlet, intermediate_loop.fromSG) annotation (
        Line(
        points={{60,-22},{60,-30},{28,-30},{28,-5.5},{20.5,-5.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(primary_loop.toIHX, processPlant.toPHP) annotation (Line(
        points={{-101,10},{-96,10},{-96,90},{-80,90}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(processPlant.fromPHP, intermediate_heat_exchanger.shellInlet)
      annotation (Line(
        points={{-80,70},{-90,70},{-90,10},{-80,10}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(extent={{-200,-100},{200,100}},
            preserveAspectRatio=false), graphics={Text(
              extent={{-200,32},{-160,26}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="DRACS"),Text(
              extent={{-140,40},{-100,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Primary Heat
Transport System"),Text(
              extent={{-20,40},{20,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate Heat
Transport System"),Text(
              extent={{100,40},{140,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Power Conversion
System"),Text(extent={{160,32},{200,26}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Electrical
Grid"),Text(  extent={{-78,38},{-42,24}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate
Heat Exchanger"),Text(
              extent={{40,38},{80,20}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Steam Generator")}), Icon(coordinateSystem(extent={{-200,
              -100},{200,100}})));
  end ProcessHeatSystem;

  partial model Rx2IHX "Reactor-to-IHX architecture"

    replaceable Interfaces.RxPrimaryHeatTransportSystem primary_loop
      annotation (Placement(transformation(extent={{-60,-20},{-21,20}})));
    replaceable Interfaces.IntermediateHeatExchanger
      intermediate_heat_exchanger
      annotation (Placement(transformation(extent={{20,-20},{60,20}})));
  equation

    connect(primary_loop.toIHX, intermediate_heat_exchanger.shellInlet)
      annotation (Line(
        points={{-21,10},{20,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.shellOutlet, primary_loop.fromIHX)
      annotation (Line(
        points={{59,-7},{64,-7},{64,-34},{12,-34},{12,-10},{-21,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    annotation (Diagram(coordinateSystem(extent={{-200,-100},{200,100}},
            preserveAspectRatio=false), graphics={Text(
              extent={{-60,40},{-20,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Primary Heat
Transport System"),Text(
              extent={{22,38},{58,24}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate
Heat Exchanger")}), Icon(coordinateSystem(extent={{-200,-100},{200,100}})));
  end Rx2IHX;

  partial model Rx2IHTS "Architecture from PHTS to IHTS."
    replaceable Interfaces.RxPrimaryHeatTransportSystem primary_loop
      annotation (Placement(transformation(extent={{-80,-20},{-40,20}})));
    replaceable Interfaces.IntermediateHeatExchanger
      intermediate_heat_exchanger
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    replaceable Interfaces.IntermediateHeatTransportSystem intermediate_loop
      annotation (Placement(transformation(extent={{40,-20},{80,20}})));
    replaceable Interfaces.EventDriver eventDriver
      annotation (Placement(transformation(extent={{-80,-100},{-40,-60}})));
    replaceable Interfaces.ControlSystem controlSystem
      annotation (Placement(transformation(extent={{40,-100},{80,-60}})));
  equation

    connect(intermediate_heat_exchanger.tubeOutlet, intermediate_loop.fromIHX)
      annotation (Line(
        points={{0,-22},{0,-30},{30,-30},{30,6.5},{40.5,6.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.tubeInlet, intermediate_loop.toIHX)
      annotation (Line(
        points={{0,22},{0,40},{34,40},{34,-5.5},{40.5,-5.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(primary_loop.toIHX, intermediate_heat_exchanger.shellInlet)
      annotation (Line(
        points={{-40,10},{-20,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.shellOutlet, primary_loop.fromIHX)
      annotation (Line(
        points={{19,-7},{24,-7},{24,-36},{-28,-36},{-28,-10},{-40,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(eventDriver.controlBus, primary_loop.controlBus) annotation (Line(
        points={{-60,-62},{-60,-18.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, primary_loop.controlBus) annotation (Line(
        points={{60,-62},{60,-40},{-60,-40},{-60,-18.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, intermediate_heat_exchanger.controlBus)
      annotation (Line(
        points={{-60,-62},{-60,-40},{17,-40},{17,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, intermediate_loop.controlBus) annotation (
        Line(
        points={{-60,-62},{-60,-40},{60,-40},{60,-19}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, intermediate_heat_exchanger.controlBus)
      annotation (Line(
        points={{60,-62},{60,-40},{17,-40},{17,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, intermediate_loop.controlBus) annotation
      (Line(
        points={{60,-62},{60,-19}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(extent={{-200,-100},{200,100}},
            preserveAspectRatio=false), graphics={Text(
              extent={{-80,40},{-40,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Primary Heat
Transport System"),Text(
              extent={{40,40},{80,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate Heat
Transport System"),Text(
              extent={{-18,38},{18,24}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate
Heat Exchanger")}), Icon(coordinateSystem(extent={{-200,-100},{200,100}})));
  end Rx2IHTS;

  partial model Rx2Sg "Generic end-to-end plant architecture"
    replaceable Interfaces.RxPrimaryHeatTransportSystem primary_loop
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    replaceable Interfaces.IntermediateHeatExchanger
      intermediate_heat_exchanger
      annotation (Placement(transformation(extent={{-80,-20},{-40,20}})));
    replaceable Interfaces.IntermediateHeatTransportSystem intermediate_loop
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    replaceable Interfaces.SteamGenerator steam_generator
      annotation (Placement(transformation(extent={{40,-20},{80,20}})));
    replaceable Interfaces.EventDriver eventDriver
      annotation (Placement(transformation(extent={{-80,-100},{-40,-60}})));
    replaceable Interfaces.ControlSystem controlSystem
      annotation (Placement(transformation(extent={{40,-100},{80,-60}})));
  equation

    connect(intermediate_heat_exchanger.tubeOutlet, intermediate_loop.fromIHX)
      annotation (Line(
        points={{-60,-22},{-60,-30},{-30,-30},{-30,6.5},{-19.5,6.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.tubeInlet, intermediate_loop.toIHX)
      annotation (Line(
        points={{-60,22},{-60,40},{-26,40},{-26,-5.5},{-19.5,-5.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(primary_loop.toIHX, intermediate_heat_exchanger.shellInlet)
      annotation (Line(
        points={{-100,10},{-80,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.shellOutlet, primary_loop.fromIHX)
      annotation (Line(
        points={{-41,-7},{-36,-7},{-36,-34},{-88,-34},{-88,-10},{-100,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(eventDriver.controlBus, primary_loop.controlBus) annotation (Line(
        points={{-60,-62},{-60,-40},{-120,-40},{-120,-18.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, primary_loop.controlBus) annotation (Line(
        points={{60,-62},{60,-40},{-120,-40},{-120,-18.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, intermediate_heat_exchanger.controlBus)
      annotation (Line(
        points={{-60,-62},{-60,-40},{-43,-40},{-43,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, intermediate_loop.controlBus) annotation (
        Line(
        points={{-60,-62},{-60,-40},{0,-40},{0,-19}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, intermediate_heat_exchanger.controlBus)
      annotation (Line(
        points={{60,-62},{60,-40},{-43,-40},{-43,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, intermediate_loop.controlBus) annotation
      (Line(
        points={{60,-62},{60,-40},{0,-40},{0,-19}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, steam_generator.controlBus) annotation (
        Line(
        points={{-60,-62},{-60,-40},{77,-40},{77,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, steam_generator.controlBus) annotation (
        Line(
        points={{60,-62},{60,-40},{77,-40},{77,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(intermediate_loop.toSG, steam_generator.shellInlet) annotation (
        Line(
        points={{19.5,10.5},{30.75,10.5},{30.75,9},{42,9}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(steam_generator.shellOutlet, intermediate_loop.fromSG) annotation (
        Line(
        points={{78,-8},{88,-8},{88,-28},{30,-28},{30,-5.5},{20.5,-5.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    annotation (Diagram(coordinateSystem(extent={{-200,-100},{200,100}},
            preserveAspectRatio=false), graphics={Text(
              extent={{-140,40},{-100,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Primary Heat
Transport System"),Text(
              extent={{-20,40},{20,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate Heat
Transport System"),Text(
              extent={{-78,38},{-42,24}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate
Heat Exchanger"),Text(
              extent={{40,38},{80,20}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Steam Generator")}), Icon(coordinateSystem(extent={{-200,
              -100},{200,100}})));
  end Rx2Sg;

  partial model Rx2PCS "Generic end-to-end plant architecture"

    replaceable Interfaces.RxPrimaryHeatTransportSystem primary_loop
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    replaceable Interfaces.IntermediateHeatExchanger
      intermediate_heat_exchanger
      annotation (Placement(transformation(extent={{-80,-20},{-40,20}})));
    replaceable Interfaces.IntermediateHeatTransportSystem intermediate_loop
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    replaceable Interfaces.SteamGenerator steam_generator
      annotation (Placement(transformation(extent={{40,-20},{80,20}})));
    replaceable Interfaces.PowerConversionSystem power_conversion_system
      annotation (Placement(transformation(extent={{100,-20},{140,20}})));

    replaceable Interfaces.EventDriver eventDriver
      annotation (Placement(transformation(extent={{-80,-100},{-40,-60}})));
    replaceable Interfaces.ControlSystem controlSystem
      annotation (Placement(transformation(extent={{40,-100},{80,-60}})));
  equation
    connect(intermediate_heat_exchanger.tubeOutlet, intermediate_loop.fromIHX)
      annotation (Line(
        points={{-60,-22},{-60,-30},{-30,-30},{-30,6.5},{-19.5,6.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.tubeInlet, intermediate_loop.toIHX)
      annotation (Line(
        points={{-60,22},{-60,40},{-26,40},{-26,-5.5},{-19.5,-5.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(primary_loop.toIHX, intermediate_heat_exchanger.shellInlet)
      annotation (Line(
        points={{-100,10},{-80,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.shellOutlet, primary_loop.fromIHX)
      annotation (Line(
        points={{-41,-7},{-36,-7},{-36,-34},{-88,-34},{-88,-10},{-100,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));

    connect(primary_loop.controlBus, eventDriver.controlBus) annotation (Line(
        points={{-120,-18.8},{-120,-40},{-60,-40},{-60,-62}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, intermediate_heat_exchanger.controlBus)
      annotation (Line(
        points={{-60,-62},{-60,-40},{-43,-40},{-43,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, intermediate_loop.controlBus) annotation (
        Line(
        points={{-60,-62},{-60,-40},{0,-40},{0,-19}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, steam_generator.controlBus) annotation (
        Line(
        points={{-60,-62},{-60,-40},{77,-40},{77,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, power_conversion_system.controlBus)
      annotation (Line(
        points={{-60,-62},{-60,-40},{120,-40},{120,-18.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, steam_generator.controlBus) annotation (
        Line(
        points={{60,-62},{60,-40},{77,-40},{77,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, power_conversion_system.controlBus)
      annotation (Line(
        points={{60,-62},{60,-40},{120,-40},{120,-18.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, intermediate_loop.controlBus) annotation
      (Line(
        points={{60,-62},{60,-40},{0,-40},{0,-19}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, intermediate_heat_exchanger.controlBus)
      annotation (Line(
        points={{60,-62},{60,-40},{-43,-40},{-43,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, eventDriver.controlBus) annotation (Line(
        points={{60,-62},{60,-40},{-60,-40},{-60,-62}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, primary_loop.controlBus) annotation (Line(
        points={{60,-62},{60,-40},{-120,-40},{-120,-18.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(intermediate_loop.toSG, steam_generator.shellInlet) annotation (
        Line(
        points={{19.5,10.5},{30.75,10.5},{30.75,9},{42,9}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(steam_generator.shellOutlet, intermediate_loop.fromSG) annotation (
        Line(
        points={{78,-8},{88,-8},{88,-32},{30,-32},{30,-5.5},{20.5,-5.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(steam_generator.tubeOutlet, power_conversion_system.steamInlet)
      annotation (Line(
        points={{60,-22},{60,-36},{94,-36},{94,12},{100,12}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(power_conversion_system.condensateReturn, steam_generator.tubeInlet)
      annotation (Line(
        points={{100,-12},{90,-12},{90,40},{60,40},{60,22}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    annotation (Diagram(coordinateSystem(extent={{-200,-100},{200,100}},
            preserveAspectRatio=false), graphics={Text(
              extent={{-140,40},{-100,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Primary Heat
Transport System"),Text(
              extent={{-20,40},{20,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate Heat
Transport System"),Text(
              extent={{100,40},{140,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Power Conversion
System"),Text(extent={{-78,38},{-42,24}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate
Heat Exchanger"),Text(
              extent={{40,38},{80,20}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Steam Generator")}), Icon(coordinateSystem(extent={{-200,
              -100},{200,100}})));
  end Rx2PCS;

  partial model Rx2Grid "PHTS-to-grid system architecture"

    replaceable Interfaces.RxPrimaryHeatTransportSystem primary_loop
      annotation (Placement(transformation(extent={{-160,-20},{-120,20}})));
    replaceable Interfaces.IntermediateHeatExchanger
      intermediate_heat_exchanger
      annotation (Placement(transformation(extent={{-100,-20},{-60,20}})));
    replaceable Interfaces.IntermediateHeatTransportSystem intermediate_loop
      annotation (Placement(transformation(extent={{-40,-20},{0,20}})));
    replaceable Interfaces.SteamGenerator steam_generator
      annotation (Placement(transformation(extent={{20,-20},{60,20}})));
    replaceable Interfaces.EventDriver eventDriver
      annotation (Placement(transformation(extent={{-80,-100},{-40,-60}})));
    replaceable Interfaces.ControlSystem controlSystem
      annotation (Placement(transformation(extent={{40,-100},{80,-60}})));
    replaceable Interfaces.SingleShaftGenerator singleShaftGenerator
      annotation (Placement(transformation(extent={{140,-20},{180,20}})));
    replaceable Interfaces.PowerConversionSystem power_conversion_system
      annotation (Placement(transformation(extent={{80,-20},{120,20}})));

  equation
    connect(intermediate_heat_exchanger.tubeOutlet, intermediate_loop.fromIHX)
      annotation (Line(
        points={{-80,-22},{-80,-30},{-54,-30},{-54,6.5},{-39.5,6.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.tubeInlet, intermediate_loop.toIHX)
      annotation (Line(
        points={{-80,22},{-80,40},{-52,40},{-52,-5.5},{-39.5,-5.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(primary_loop.toIHX, intermediate_heat_exchanger.shellInlet)
      annotation (Line(
        points={{-120,10},{-100,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.shellOutlet, primary_loop.fromIHX)
      annotation (Line(
        points={{-61,-7},{-56,-7},{-56,-34},{-108,-34},{-108,-10},{-120,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(eventDriver.controlBus, primary_loop.controlBus) annotation (Line(
        points={{-60,-62},{-60,-40},{-140,-40},{-140,-18.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, intermediate_heat_exchanger.controlBus)
      annotation (Line(
        points={{-60,-62},{-60,-40},{-63,-40},{-63,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, intermediate_loop.controlBus) annotation (
        Line(
        points={{-60,-62},{-60,-40},{-20,-40},{-20,-19.5}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, steam_generator.controlBus) annotation (
        Line(
        points={{-60,-62},{-60,-40},{57,-40},{57,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, singleShaftGenerator.controlBus)
      annotation (Line(
        points={{-60,-62},{-60,-40},{160,-40},{160,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(intermediate_loop.toSG, steam_generator.shellInlet) annotation (
        Line(
        points={{-0.5,10.5},{10,10.5},{10,9},{22,9}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(steam_generator.shellOutlet, intermediate_loop.fromSG) annotation (
        Line(
        points={{58,-8},{70,-8},{70,-30},{12,-30},{12,-5.5},{0.5,-5.5}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(steam_generator.tubeOutlet, power_conversion_system.steamInlet)
      annotation (Line(
        points={{40,-22},{40,-32},{72,-32},{72,12},{80,12}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(power_conversion_system.condensateReturn, steam_generator.tubeInlet)
      annotation (Line(
        points={{80,-12},{66,-12},{66,40},{40,40},{40,22}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(power_conversion_system.rotorShaft, singleShaftGenerator.shaft)
      annotation (Line(
        points={{120,0},{140,0}},
        color={0,0,0},
        smooth=Smooth.None,
        thickness=1));
    connect(controlSystem.controlBus, singleShaftGenerator.controlBus)
      annotation (Line(
        points={{60,-62},{60,-40},{160,-40},{160,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, power_conversion_system.controlBus)
      annotation (Line(
        points={{60,-62},{60,-40},{100,-40},{100,-18.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, steam_generator.controlBus) annotation (
        Line(
        points={{60,-62},{60,-40},{56,-40},{56,-40},{57,-40},{57,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, intermediate_loop.controlBus) annotation
      (Line(
        points={{60,-62},{60,-40},{-20,-40},{-20,-19.5}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, primary_loop.controlBus) annotation (Line(
        points={{60,-62},{60,-40},{-140,-40},{-140,-18.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(controlSystem.controlBus, intermediate_heat_exchanger.controlBus)
      annotation (Line(
        points={{60,-62},{60,-40},{-63,-40},{-63,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(extent={{-200,-100},{200,100}},
            preserveAspectRatio=false), graphics={Text(
              extent={{-160,40},{-120,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Primary Heat
Transport System"),Text(
              extent={{-40,40},{0,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate Heat
Transport System"),Text(
              extent={{80,40},{120,22}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Power Conversion
System"),Text(extent={{-98,38},{-62,24}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Intermediate
Heat Exchanger"),Text(
              extent={{20,38},{60,20}},
              lineColor={0,127,255},
              lineThickness=0.5,
              textString="Steam Generator")}), Icon(coordinateSystem(extent={{-200,
              -100},{200,100}})));
  end Rx2Grid;

  package ALMR_PRISM "Package for ALMR PRISM architecture description"
    partial model EndToEnd
      "Generic end-to-end plant architecture for ALMR_PRISM"

      replaceable Interfaces.RxPrimaryHeatTransportSystem primary_loop
        annotation (Placement(transformation(extent={{-140,-20},{-101,20}})));
      replaceable Interfaces.IntermediateHeatExchanger
        intermediate_heat_exchanger
        annotation (Placement(transformation(extent={{-80,-20},{-40,20}})));
      replaceable Interfaces.IntermediateHeatTransportSystem intermediate_loop
        annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
      replaceable Interfaces.SteamGenerator steam_generator
        annotation (Placement(transformation(extent={{40,-20},{80,20}})));
      replaceable Interfaces.PowerConversionSystem power_conversion_system
        annotation (Placement(transformation(extent={{100,-20},{140,20}})));
      replaceable Interfaces.SingleShaftGenerator singleShaftGenerator
        annotation (Placement(transformation(extent={{160,-20},{200,20}})));
      replaceable Interfaces.ControlSystem controlSystem
        annotation (Placement(transformation(extent={{58,-100},{98,-60}})));
      replaceable Interfaces.EventDriver eventDriver
        annotation (Placement(transformation(extent={{-64,-100},{-24,-60}})));
      replaceable Interfaces.DRACS dracs
        annotation (Placement(transformation(extent={{-200,-20},{-160,20}})));

    equation
      connect(power_conversion_system.rotorShaft, singleShaftGenerator.shaft)
        annotation (Line(
          points={{140,0},{160,0}},
          color={0,0,0},
          smooth=Smooth.None,
          thickness=1));
      connect(intermediate_heat_exchanger.tubeOutlet, intermediate_loop.fromIHX)
        annotation (Line(
          points={{-60,-22},{-60,-30},{-30,-30},{-30,6.5},{-19.5,6.5}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(intermediate_heat_exchanger.tubeInlet, intermediate_loop.toIHX)
        annotation (Line(
          points={{-60,22},{-60,40},{-26,40},{-26,-5.5},{-19.5,-5.5}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(controlSystem.controlBus, primary_loop.controlBus) annotation (
          Line(
          points={{78,-62},{78,-46},{-120.5,-46},{-120.5,-18.8}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, intermediate_heat_exchanger.controlBus)
        annotation (Line(
          points={{78,-62},{78,-46},{-44,-46},{-44,-18},{-43,-18}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, intermediate_loop.controlBus)
        annotation (Line(
          points={{78,-62},{78,-46},{0,-46},{0,-19.5}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, steam_generator.controlBus) annotation
        (Line(
          points={{78,-62},{78,-18},{77,-18}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, power_conversion_system.controlBus)
        annotation (Line(
          points={{78,-62},{78,-46},{120,-46},{120,-18.8}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, singleShaftGenerator.controlBus)
        annotation (Line(
          points={{78,-62},{78,-46},{180,-46},{180,-18}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(dracs.toPHTS, primary_loop.fromDRACS) annotation (Line(
          points={{-159,10},{-140,10}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(dracs.fromPHTS, primary_loop.toDRACS) annotation (Line(
          points={{-159,-10},{-140,-10}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(dracs.controlBus, controlSystem.controlBus) annotation (Line(
          points={{-180,-19},{-180,-46},{78,-46},{78,-62}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, intermediate_loop.controlBus) annotation
        (Line(
          points={{-44,-62},{-44,-46},{0,-46},{0,-19.5}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, intermediate_heat_exchanger.controlBus)
        annotation (Line(
          points={{-44,-62},{-44,-18},{-43,-18}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, primary_loop.controlBus) annotation (Line(
          points={{-44,-62},{-44,-46},{-120.5,-46},{-120.5,-18.8}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, steam_generator.controlBus) annotation (
          Line(
          points={{-44,-62},{-44,-46},{78,-46},{78,-18},{77,-18}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, power_conversion_system.controlBus)
        annotation (Line(
          points={{-44,-62},{-44,-46},{120,-46},{120,-18.8}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, singleShaftGenerator.controlBus)
        annotation (Line(
          points={{-44,-62},{-44,-46},{180,-46},{180,-18}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(primary_loop.toIHX, intermediate_heat_exchanger.shellInlet)
        annotation (Line(
          points={{-101,10},{-80,10}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(intermediate_heat_exchanger.shellOutlet, primary_loop.fromIHX)
        annotation (Line(
          points={{-41,-7},{-36,-7},{-36,-34},{-88,-34},{-88,-10},{-101,-10}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(intermediate_loop.fromSG, steam_generator.shellInlet) annotation
        (Line(
          points={{20.5,-5.5},{32,-5.5},{32,9},{42,9}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(steam_generator.shellOutlet, intermediate_loop.toSG) annotation (
          Line(
          points={{78,-8},{88,-8},{88,-30},{28,-30},{28,10.5},{19.5,10.5}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(steam_generator.tubeOutlet, power_conversion_system.steamInlet)
        annotation (Line(
          points={{60,-22},{60,-36},{90,-36},{90,12},{100,12}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(steam_generator.tubeInlet, power_conversion_system.condensateReturn)
        annotation (Line(
          points={{60,22},{60,40},{92,40},{92,-12},{100,-12}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(extent={{-200,-100},{200,100}},
              preserveAspectRatio=false), graphics={Text(
                  extent={{-200,32},{-160,26}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="DRACS"),Text(
                  extent={{-140,40},{-100,22}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="Primary Heat
Transport System"),Text(
                  extent={{-20,40},{20,22}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="Intermediate Heat
Transport System"),Text(
                  extent={{100,40},{140,22}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="Power Conversion
System"),Text(    extent={{160,32},{200,26}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="Electrical
Grid"),Text(      extent={{-78,38},{-42,24}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="Intermediate
Heat Exchanger"),Text(
                  extent={{40,38},{80,20}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="Steam Generator")}), Icon(coordinateSystem(extent
              ={{-200,-100},{200,100}})));
    end EndToEnd;

    partial model Rx2Grid "PHTS-to-grid system architecture for ALMR PRISM"

      replaceable Interfaces.RxPrimaryHeatTransportSystem primary_loop
        annotation (Placement(transformation(extent={{-160,-20},{-120,20}})));
      replaceable Interfaces.IntermediateHeatExchanger
        intermediate_heat_exchanger
        annotation (Placement(transformation(extent={{-100,-20},{-60,20}})));
      replaceable Interfaces.IntermediateHeatTransportSystem intermediate_loop
        annotation (Placement(transformation(extent={{-40,-20},{0,20}})));
      replaceable Interfaces.SteamGenerator steam_generator
        annotation (Placement(transformation(extent={{20,-20},{60,20}})));
      replaceable Interfaces.EventDriver eventDriver
        annotation (Placement(transformation(extent={{-80,-100},{-40,-60}})));
      replaceable Interfaces.ControlSystem controlSystem
        annotation (Placement(transformation(extent={{40,-100},{80,-60}})));
      replaceable Interfaces.SingleShaftGenerator singleShaftGenerator
        annotation (Placement(transformation(extent={{140,-20},{180,20}})));
      replaceable Interfaces.PowerConversionSystem power_conversion_system
        annotation (Placement(transformation(extent={{80,-20},{120,20}})));

    equation
      connect(intermediate_heat_exchanger.tubeOutlet, intermediate_loop.fromIHX)
        annotation (Line(
          points={{-80,-22},{-80,-30},{-54,-30},{-54,6.5},{-39.5,6.5}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(intermediate_heat_exchanger.tubeInlet, intermediate_loop.toIHX)
        annotation (Line(
          points={{-80,22},{-80,40},{-52,40},{-52,-5.5},{-39.5,-5.5}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(primary_loop.toIHX, intermediate_heat_exchanger.shellInlet)
        annotation (Line(
          points={{-120,10},{-100,10}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(intermediate_heat_exchanger.shellOutlet, primary_loop.fromIHX)
        annotation (Line(
          points={{-61,-7},{-56,-7},{-56,-34},{-108,-34},{-108,-10},{-120,-10}},

          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));

      connect(eventDriver.controlBus, primary_loop.controlBus) annotation (Line(
          points={{-60,-62},{-60,-40},{-140,-40},{-140,-18.8}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, intermediate_heat_exchanger.controlBus)
        annotation (Line(
          points={{-60,-62},{-60,-40},{-63,-40},{-63,-18}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, intermediate_loop.controlBus) annotation
        (Line(
          points={{-60,-62},{-60,-40},{-20,-40},{-20,-19.5}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, steam_generator.controlBus) annotation (
          Line(
          points={{-60,-62},{-60,-40},{57,-40},{57,-18}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, singleShaftGenerator.controlBus)
        annotation (Line(
          points={{-60,-62},{-60,-40},{160,-40},{160,-18}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(intermediate_loop.toSG, steam_generator.shellInlet) annotation (
          Line(
          points={{-0.5,10.5},{10,10.5},{10,9},{22,9}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(steam_generator.shellOutlet, intermediate_loop.fromSG)
        annotation (Line(
          points={{58,-8},{70,-8},{70,-30},{12,-30},{12,-5.5},{0.5,-5.5}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(steam_generator.tubeOutlet, power_conversion_system.steamInlet)
        annotation (Line(
          points={{40,-22},{40,-32},{72,-32},{72,12},{80,12}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(power_conversion_system.condensateReturn, steam_generator.tubeInlet)
        annotation (Line(
          points={{80,-12},{66,-12},{66,40},{40,40},{40,22}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(power_conversion_system.rotorShaft, singleShaftGenerator.shaft)
        annotation (Line(
          points={{120,0},{140,0}},
          color={0,0,0},
          smooth=Smooth.None,
          thickness=1));
      connect(controlSystem.controlBus, singleShaftGenerator.controlBus)
        annotation (Line(
          points={{60,-62},{60,-40},{160,-40},{160,-18}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, power_conversion_system.controlBus)
        annotation (Line(
          points={{60,-62},{60,-40},{100,-40},{100,-18.8}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, steam_generator.controlBus) annotation
        (Line(
          points={{60,-62},{60,-40},{56,-40},{56,-40},{57,-40},{57,-18}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, intermediate_loop.controlBus)
        annotation (Line(
          points={{60,-62},{60,-40},{-20,-40},{-20,-19.5}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, primary_loop.controlBus) annotation (
          Line(
          points={{60,-62},{60,-40},{-140,-40},{-140,-18.8}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, intermediate_heat_exchanger.controlBus)
        annotation (Line(
          points={{60,-62},{60,-40},{-63,-40},{-63,-18}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(extent={{-200,-100},{200,100}},
              preserveAspectRatio=false), graphics={Text(
                  extent={{-160,40},{-120,22}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="Primary Heat
Transport System"),Text(
                  extent={{-40,40},{0,22}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="Intermediate Heat
Transport System"),Text(
                  extent={{80,40},{120,22}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="Power Conversion
System"),Text(    extent={{-98,38},{-62,24}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="Intermediate
Heat Exchanger"),Text(
                  extent={{20,38},{60,20}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="Steam Generator")}), Icon(coordinateSystem(extent
              ={{-200,-100},{200,100}})));
    end Rx2Grid;
  end ALMR_PRISM;

  package AHTR
    "Package for Advanced High-Temperature Reactor (AHTR) plant architecture description"

    partial model EndToEnd "Generic end-to-end plant architecture for AHTR"

      replaceable Interfaces.RxPrimaryHeatTransportSystem primary_loop
        annotation (Placement(transformation(extent={{-140,-20},{-101,20}})));
      replaceable Interfaces.IntermediateHeatExchanger
        intermediate_heat_exchanger
        annotation (Placement(transformation(extent={{-80,-20},{-40,20}})));
      replaceable Interfaces.IntermediateHeatTransportSystem intermediate_loop
        annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
      replaceable Interfaces.SteamGenerator steam_generator
        annotation (Placement(transformation(extent={{40,-20},{80,20}})));
      replaceable Interfaces.PowerConversionSystem power_conversion_system
        annotation (Placement(transformation(extent={{100,-20},{140,20}})));
      replaceable Interfaces.SingleShaftGenerator singleShaftGenerator
        annotation (Placement(transformation(extent={{160,-20},{200,20}})));
      replaceable Interfaces.ControlSystem controlSystem
        annotation (Placement(transformation(extent={{58,-100},{98,-60}})));
      replaceable Interfaces.EventDriver eventDriver
        annotation (Placement(transformation(extent={{-64,-100},{-24,-60}})));
      replaceable Interfaces.DRACS dracs
        annotation (Placement(transformation(extent={{-200,-20},{-160,20}})));

    equation
      connect(power_conversion_system.rotorShaft, singleShaftGenerator.shaft)
        annotation (Line(
          points={{140,0},{160,0}},
          color={0,0,0},
          smooth=Smooth.None,
          thickness=1));
      connect(intermediate_heat_exchanger.tubeOutlet, intermediate_loop.fromIHX)
        annotation (Line(
          points={{-60,-22},{-60,-30},{-30,-30},{-30,6.5},{-19.5,6.5}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(intermediate_heat_exchanger.tubeInlet, intermediate_loop.toIHX)
        annotation (Line(
          points={{-60,22},{-60,40},{-26,40},{-26,-5.5},{-19.5,-5.5}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(controlSystem.controlBus, primary_loop.controlBus) annotation (
          Line(
          points={{78,-62},{78,-46},{-120.5,-46},{-120.5,-18.8}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, intermediate_heat_exchanger.controlBus)
        annotation (Line(
          points={{78,-62},{78,-46},{-44,-46},{-44,-18},{-43,-18}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, intermediate_loop.controlBus)
        annotation (Line(
          points={{78,-62},{78,-46},{0,-46},{0,-19.5}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, steam_generator.controlBus) annotation
        (Line(
          points={{78,-62},{78,-18},{77,-18}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, power_conversion_system.controlBus)
        annotation (Line(
          points={{78,-62},{78,-46},{120,-46},{120,-18.8}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, singleShaftGenerator.controlBus)
        annotation (Line(
          points={{78,-62},{78,-46},{180,-46},{180,-18}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(dracs.toPHTS, primary_loop.fromDRACS) annotation (Line(
          points={{-159,10},{-140,10}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(dracs.fromPHTS, primary_loop.toDRACS) annotation (Line(
          points={{-159,-10},{-140,-10}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(dracs.controlBus, controlSystem.controlBus) annotation (Line(
          points={{-180,-19},{-180,-46},{78,-46},{78,-62}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, intermediate_loop.controlBus) annotation
        (Line(
          points={{-44,-62},{-44,-46},{0,-46},{0,-19.5}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, intermediate_heat_exchanger.controlBus)
        annotation (Line(
          points={{-44,-62},{-44,-18},{-43,-18}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, primary_loop.controlBus) annotation (Line(
          points={{-44,-62},{-44,-46},{-120.5,-46},{-120.5,-18.8}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, steam_generator.controlBus) annotation (
          Line(
          points={{-44,-62},{-44,-46},{78,-46},{78,-18},{77,-18}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, power_conversion_system.controlBus)
        annotation (Line(
          points={{-44,-62},{-44,-46},{120,-46},{120,-18.8}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, singleShaftGenerator.controlBus)
        annotation (Line(
          points={{-44,-62},{-44,-46},{180,-46},{180,-18}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(primary_loop.toIHX, intermediate_heat_exchanger.shellInlet)
        annotation (Line(
          points={{-101,10},{-80,10}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(intermediate_heat_exchanger.shellOutlet, primary_loop.fromIHX)
        annotation (Line(
          points={{-41,-7},{-36,-7},{-36,-34},{-88,-34},{-88,-10},{-101,-10}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(intermediate_loop.fromSG, steam_generator.shellInlet) annotation
        (Line(
          points={{20.5,-5.5},{32,-5.5},{32,9},{42,9}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(steam_generator.shellOutlet, intermediate_loop.toSG) annotation (
          Line(
          points={{78,-8},{88,-8},{88,-30},{28,-30},{28,10.5},{19.5,10.5}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(steam_generator.tubeOutlet, power_conversion_system.steamInlet)
        annotation (Line(
          points={{60,-22},{60,-36},{90,-36},{90,12},{100,12}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(steam_generator.tubeInlet, power_conversion_system.condensateReturn)
        annotation (Line(
          points={{60,22},{60,40},{92,40},{92,-12},{100,-12}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(extent={{-200,-100},{200,100}},
              preserveAspectRatio=false), graphics={Text(
                  extent={{-200,32},{-160,26}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="DRACS"),Text(
                  extent={{-140,40},{-100,22}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="Primary Heat
Transport System"),Text(
                  extent={{-20,40},{20,22}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="Intermediate Heat
Transport System"),Text(
                  extent={{100,40},{140,22}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="Power Conversion
System"),Text(    extent={{160,32},{200,26}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="Electrical
Grid"),Text(      extent={{-78,38},{-42,24}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="Intermediate
Heat Exchanger"),Text(
                  extent={{40,38},{80,20}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  textString="Steam Generator")}), Icon(coordinateSystem(extent
              ={{-200,-100},{200,100}})));
    end EndToEnd;
  end AHTR;

  package SmAHTR
    "Package for Small Modular Advanced High-Temperature Reactor (SmAHTR) architecture description"

    partial model EndToEnd "Generic end-to-end plant architecture for AmAHTR"

      replaceable
        Implementations.SmAHTR.PrimaryHeatTransportSystem.smAHTR_PHTS_0
        primary_loop constrainedby
        SystemInterfaces.RxPrimaryHeatTransportSystem
        annotation (Placement(transformation(extent={{-140,0},{-101,40}})));
      replaceable Implementations.SmAHTR.IntermediateHeatExchanger.SmAHTR_IHX
        intermediate_heat_exchanger constrainedby
        SystemInterfaces.IntermediateHeatExchanger
        annotation (Placement(transformation(extent={{-80,0},{-40,40}})));
      replaceable
        Implementations.SmAHTR.IntermediateHeatTransportSystem.SmAHTR_IHTS_BC
        intermediate_loop constrainedby
        SystemInterfaces.IntermediateHeatTransportSystem
        annotation (Placement(transformation(extent={{-20,0},{20,40}})));
      replaceable Implementations.SmAHTR.SteamGenerator.SmAHTR_SG1
        steam_generator constrainedby SystemInterfaces.SteamGenerator
        annotation (Placement(transformation(extent={{40,0},{80,40}})));
      replaceable SystemInterfaces.PowerConversionSystem
        power_conversion_system
        annotation (Placement(transformation(extent={{100,0},{140,40}})));
      replaceable SystemInterfaces.SingleShaftGenerator singleShaftGenerator
        annotation (Placement(transformation(extent={{160,0},{200,40}})));
      replaceable SystemInterfaces.ControlSystem controlSystem
        annotation (Placement(transformation(extent={{60,-80},{100,-40}})));
      replaceable SystemInterfaces.EventDriver eventDriver
        annotation (Placement(transformation(extent={{-60,-80},{-20,-40}})));
      replaceable Implementations.SmAHTR.DRACS.DRACS_1 dracs constrainedby
        SystemInterfaces.PassiveHeatRejectionSystems
        annotation (Placement(transformation(extent={{-200,0},{-160,40}})));

      replaceable SystemInterfaces.ReactorProtectionSystem
        reactorProtectionSystem
        annotation (Placement(transformation(extent={{-180,-80},{-140,-40}})));
      replaceable SystemInterfaces.SupervisoryControlSystem
        supervisoryControlSystem
        annotation (Placement(transformation(extent={{0,-80},{40,-40}})));
    equation
      connect(power_conversion_system.rotorShaft, singleShaftGenerator.shaft)
        annotation (Line(
          points={{140,20},{160,20}},
          color={0,0,0},
          smooth=Smooth.None,
          thickness=1));
      connect(intermediate_heat_exchanger.tubeOutlet, intermediate_loop.fromIHX)
        annotation (Line(
          points={{-60,0},{-60,-10},{-30,-10},{-30,26.5},{-19.5,26.5}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(intermediate_heat_exchanger.tubeInlet, intermediate_loop.toIHX)
        annotation (Line(
          points={{-60,40},{-60,60},{-26,60},{-26,14.5},{-19.5,14.5}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(controlSystem.controlBus, primary_loop.controlBus) annotation (
          Line(
          points={{80,-42},{80,-20},{-120.5,-20},{-120.5,2}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, intermediate_heat_exchanger.controlBus)
        annotation (Line(
          points={{80,-42},{80,-20},{-40,-20},{-40,2},{-43,2}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, intermediate_loop.controlBus)
        annotation (Line(
          points={{80,-42},{80,-20},{0,-20},{0,0.5}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, steam_generator.controlBus) annotation
        (Line(
          points={{80,-42},{80,2},{77,2}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, power_conversion_system.controlBus)
        annotation (Line(
          points={{80,-42},{80,-20},{120,-20},{120,1.2}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, singleShaftGenerator.controlBus)
        annotation (Line(
          points={{80,-42},{80,-20},{180,-20},{180,2}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(dracs.toPHTS, primary_loop.fromDRACS) annotation (Line(
          points={{-159,32},{-140,32}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(dracs.fromPHTS, primary_loop.toDRACS) annotation (Line(
          points={{-159,8},{-140,8}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(dracs.controlBus, controlSystem.controlBus) annotation (Line(
          points={{-180,1},{-180,-20},{80,-20},{80,-42}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, intermediate_loop.controlBus) annotation
        (Line(
          points={{-40,-42},{-40,-20},{0,-20},{0,0.5}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, intermediate_heat_exchanger.controlBus)
        annotation (Line(
          points={{-40,-42},{-40,2},{-43,2}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, primary_loop.controlBus) annotation (Line(
          points={{-40,-42},{-40,-20},{-120.5,-20},{-120.5,2}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, steam_generator.controlBus) annotation (
          Line(
          points={{-40,-42},{-40,-20},{80,-20},{80,2},{77,2}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, power_conversion_system.controlBus)
        annotation (Line(
          points={{-40,-42},{-40,-20},{120,-20},{120,1.2}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, singleShaftGenerator.controlBus)
        annotation (Line(
          points={{-40,-42},{-40,-20},{180,-20},{180,2}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(primary_loop.toIHX, intermediate_heat_exchanger.shellInlet)
        annotation (Line(
          points={{-101,32},{-80,32}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(intermediate_heat_exchanger.shellOutlet, primary_loop.fromIHX)
        annotation (Line(
          points={{-40,12},{-36,12},{-36,-14},{-88,-14},{-88,8},{-101,8}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(intermediate_loop.fromSG, steam_generator.shellInlet) annotation
        (Line(
          points={{20.5,14.5},{32,14.5},{32,29},{42,29}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(steam_generator.shellOutlet, intermediate_loop.toSG) annotation (
          Line(
          points={{78,12},{88,12},{88,-10},{28,-10},{28,30.5},{19.5,30.5}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(steam_generator.tubeOutlet, power_conversion_system.steamInlet)
        annotation (Line(
          points={{60,-2},{60,-16},{90,-16},{90,32},{100,32}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(steam_generator.tubeInlet, power_conversion_system.condensateReturn)
        annotation (Line(
          points={{60,42},{60,60},{92,60},{92,8},{100,8}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(reactorProtectionSystem.controlBus, controlSystem.controlBus)
        annotation (Line(
          points={{-160,-42},{-160,-20},{80,-20},{80,-42}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(supervisoryControlSystem.controlBus, primary_loop.controlBus)
        annotation (Line(
          points={{20,-42},{20,-20},{-120.5,-20},{-120.5,2}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(extent={{-200,-100},{200,100}},
              preserveAspectRatio=false), graphics={Text(
                  extent={{-200,50},{-160,46}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  textStyle={TextStyle.Bold},
                  textString="Passive Heat 
Rejection Systems"),Text(
                  extent={{-140,50},{-100,46}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  textString="Primary Heat
Transport System",textStyle={TextStyle.Bold}),Text(
                  extent={{-20,50},{20,46}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  textString="Intermediate Heat
Transport System",textStyle={TextStyle.Bold}),Text(
                  extent={{100,50},{140,46}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  textString="Power Conversion
System",          textStyle={TextStyle.Bold}),Text(
                  extent={{160,50},{200,46}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  textString="Electrical
Grid",            textStyle={TextStyle.Bold}),Text(
                  extent={{-80,50},{-40,46}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  textString="Intermediate
Heat Exchanger",  textStyle={TextStyle.Bold}),Text(
                  extent={{40,48},{80,44}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  textString="Steam Generator",
                  textStyle={TextStyle.Bold})}), Icon(coordinateSystem(extent={
                {-200,-100},{200,100}})));
    end EndToEnd;

    partial model SmAHTRHydrogen "SmAHTR architecture for hydrogen production"

      replaceable
        Implementations.SmAHTR.PrimaryHeatTransportSystem.smAHTR_PHTS_0
        primary_loop constrainedby
        SystemInterfaces.RxPrimaryHeatTransportSystem
        annotation (Placement(transformation(extent={{-100,0},{-61,40}})));
      replaceable Implementations.SmAHTR.IntermediateHeatExchanger.SmAHTR_IHX
        intermediate_heat_exchanger constrainedby
        SystemInterfaces.IntermediateHeatExchanger
        annotation (Placement(transformation(extent={{-40,0},{0,40}})));
      replaceable
        Implementations.SmAHTR.IntermediateHeatTransportSystem.SmAHTR_IHTS_BC
        intermediate_loop constrainedby
        SystemInterfaces.IntermediateHeatTransportSystem
        annotation (Placement(transformation(extent={{20,0},{60,40}})));
      replaceable Implementations.SmAHTR.SteamGenerator.SmAHTR_SG1
        steam_generator constrainedby SystemInterfaces.SteamGenerator
        annotation (Placement(transformation(extent={{80,0},{120,40}})));
      replaceable SystemInterfaces.ControlSystem controlSystem
        annotation (Placement(transformation(extent={{110,-80},{150,-40}})));
      replaceable SystemInterfaces.EventDriver eventDriver
        annotation (Placement(transformation(extent={{-70,-80},{-30,-40}})));
      replaceable Implementations.SmAHTR.DRACS.DRACS_1 dracs constrainedby
        SystemInterfaces.PassiveHeatRejectionSystems
        annotation (Placement(transformation(extent={{-160,0},{-120,40}})));

      replaceable SystemInterfaces.ReactorProtectionSystem
        reactorProtectionSystem
        annotation (Placement(transformation(extent={{-160,-80},{-120,-40}})));
      replaceable SystemInterfaces.SupervisoryControlSystem
        supervisoryControlSystem
        annotation (Placement(transformation(extent={{20,-80},{60,-40}})));
      replaceable SystemInterfaces.HydrogenPlant hydrogenPlant
        annotation (Placement(transformation(extent={{140,0},{180,40}})));
    equation
      connect(intermediate_heat_exchanger.tubeOutlet, intermediate_loop.fromIHX)
        annotation (Line(
          points={{-20,0},{-20,-10},{10,-10},{10,26.5},{20.5,26.5}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(intermediate_heat_exchanger.tubeInlet, intermediate_loop.toIHX)
        annotation (Line(
          points={{-20,40},{-20,60},{14,60},{14,14.5},{20.5,14.5}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(controlSystem.controlBus, primary_loop.controlBus) annotation (
          Line(
          points={{130,-42},{130,-20},{-80.5,-20},{-80.5,2.8}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, intermediate_heat_exchanger.controlBus)
        annotation (Line(
          points={{130,-42},{130,-20},{-32,-20},{-32,2.8}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, intermediate_loop.controlBus)
        annotation (Line(
          points={{130,-42},{130,-20},{40,-20},{40,2.8}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(controlSystem.controlBus, steam_generator.controlBus) annotation
        (Line(
          points={{130,-42},{130,-20},{88,-20},{88,-20},{88,-20},{88,2.4}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(dracs.toPHTS, primary_loop.fromDRACS) annotation (Line(
          points={{-119,32},{-100,32}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(dracs.fromPHTS, primary_loop.toDRACS) annotation (Line(
          points={{-119,8},{-100,8}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(dracs.controlBus, controlSystem.controlBus) annotation (Line(
          points={{-140,2.8},{-140,-20},{130,-20},{130,-42}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, intermediate_loop.controlBus) annotation
        (Line(
          points={{-50,-42},{-50,-20},{40,-20},{40,2.8}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, intermediate_heat_exchanger.controlBus)
        annotation (Line(
          points={{-50,-42},{-50,-20},{-32,-20},{-32,2.8}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, primary_loop.controlBus) annotation (Line(
          points={{-50,-42},{-50,-20},{-80.5,-20},{-80.5,2.8}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, steam_generator.controlBus) annotation (
          Line(
          points={{-50,-42},{-50,-20},{88,-20},{88,2.4}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(primary_loop.toIHX, intermediate_heat_exchanger.shellInlet)
        annotation (Line(
          points={{-61,32},{-40,32}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(intermediate_heat_exchanger.shellOutlet, primary_loop.fromIHX)
        annotation (Line(
          points={{0,12},{4,12},{4,-14},{-48,-14},{-48,8},{-61,8}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(intermediate_loop.fromSG, steam_generator.shellInlet) annotation
        (Line(
          points={{60.5,14.5},{72,14.5},{72,29},{82,29}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(steam_generator.shellOutlet, intermediate_loop.toSG) annotation (
          Line(
          points={{118,12},{128,12},{128,-10},{68,-10},{68,30.5},{59.5,30.5}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(reactorProtectionSystem.controlBus, controlSystem.controlBus)
        annotation (Line(
          points={{-140,-42},{-140,-20},{130,-20},{130,-42}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(supervisoryControlSystem.controlBus, primary_loop.controlBus)
        annotation (Line(
          points={{40,-42},{40,-20},{-80.5,-20},{-80.5,2.8}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(steam_generator.tubeInlet, hydrogenPlant.condensateReturn)
        annotation (Line(
          points={{100,42},{100,60},{132,60},{132,8},{140,8}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(hydrogenPlant.steamInlet, steam_generator.tubeOutlet) annotation
        (Line(
          points={{140,32},{130,32},{130,-8},{100,-8},{100,-2}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=0.5));
      connect(controlSystem.controlBus, hydrogenPlant.controlBus) annotation (
          Line(
          points={{130,-42},{130,-20},{160,-20},{160,2.4}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(extent={{-200,-100},{200,100}},
              preserveAspectRatio=false), graphics={Text(
                  extent={{-160,50},{-120,46}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  textStyle={TextStyle.Bold},
                  textString="Passive Heat 
Rejection Systems"),Text(
                  extent={{-100,50},{-60,46}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  textString="Primary Heat
Transport System",textStyle={TextStyle.Bold}),Text(
                  extent={{20,50},{60,46}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  textString="Intermediate Heat
Transport System",textStyle={TextStyle.Bold}),Text(
                  extent={{140,50},{180,46}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  textStyle={TextStyle.Bold},
                  textString="Hydrogen Production
Plant"),Text(     extent={{-40,50},{0,46}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  textString="Intermediate
Heat Exchanger",  textStyle={TextStyle.Bold}),Text(
                  extent={{80,48},{120,44}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  textString="Steam Generator",
                  textStyle={TextStyle.Bold})}), Icon(coordinateSystem(extent={
                {-200,-100},{200,100}})));
    end SmAHTRHydrogen;
  end SmAHTR;
end Architecture;
