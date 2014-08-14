within ORNL_AdvSMR;
package PlantSystems
  model PRISM
    extends Architecture.EndToEnd(
      redeclare replaceable Implementations.DRACS.NoDRACS dracs(redeclare
          package DRACSFluid = ORNL_AdvSMR.Media.Fluids.Na, redeclare package
          Air = Modelica.Media.Air.SimpleAir),
      redeclare replaceable
        Implementations.PrimaryHeatTransportSystem.PRISM_PHTS1 primary_loop(
          FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook, head_nom=0.673*{
            9.8553,7.8948}),
      redeclare replaceable
        Implementations.IntermediateHeatExchanger.PRISM_IHX1_fromBase
        intermediate_heat_exchanger(
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeDiameter=1,
        tubeHeatTrArea=1,
        tubeWallThickness=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        Twall_start=673.15,
        dT=373.15),
      redeclare replaceable
        Implementations.IntermediateHeatTransportSystem.PRISM_IHTS_simple_noPD
        intermediate_loop,
      redeclare replaceable
        Implementations.SteamGenerator.PRISM_SteamGenerator1 steam_generator(
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeFlowArea=1,
        tubePerimeter=1,
        tubeHeatTrArea=1,
        tubeWallThickness=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        redeclare package shellMedium = ORNL_AdvSMR.Media.Fluids.Na,
        redeclare package tubeMedium =
            ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
        Twall_start=673.15),
      redeclare replaceable
        Implementations.PowerConversionSystem.PRISM_PCS1_noCond
        power_conversion_system,
      redeclare replaceable Implementations.ElectricalGenerator.PRISM_G1
        generator,
      redeclare Implementations.EventDriver.PRISM_ED1 event_driver,
      redeclare Implementations.ControlSystem.PRISM_CS2 control_system);
    inner System system
      annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
              -100},{200,100}}), graphics));
  end PRISM;

  model PRISM2
    extends PRISM(
      redeclare Implementations.IntermediateHeatTransportSystem.PRISM_IHTS2
        intermediate_loop,
      redeclare Implementations.PrimaryHeatTransportSystem.PRISM_PHTS2
        primary_loop,
      redeclare Implementations.IntermediateHeatExchanger.PRISM_IHX2
        intermediate_heat_exchanger);
  end PRISM2;

  model PRISM_e2e
    // import ORNL_AdvSMR;

    import Modelica.Math.Vectors.*;

    extends Architecture.EndToEnd(
      redeclare
        ORNL_AdvSMR.Implementations.PrimaryHeatTransportSystem.PRISM_PHTS1_noPD
        primary_loop(
        FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
        head_nom=0.673*{9.8553,7.8948},
        alpha_f=-0.000989,
        alpha_c=-0.013324,
        T_f0=773.15,
        T_c0=670.15),
      redeclare
        ORNL_AdvSMR.Implementations.IntermediateHeatExchanger.PRISM_IHX1_fromBase
        intermediate_heat_exchanger(
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeDiameter=1,
        tubeHeatTrArea=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        tubeWallThickness=1,
        noAxialNodes=20,
        Twall_start=773.15),
      redeclare
        ORNL_AdvSMR.Implementations.IntermediateHeatTransportSystem.PRISM_IHTS_simple_noPD
        intermediate_loop(nNodes=20),
      redeclare Implementations.EventDriver.PRISM_ED1 eventDriver,
      redeclare Implementations.ControlSystem.PRISM_CS2 controlSystem,
      redeclare Implementations.SteamGenerator.PRISM_SteamGenerator1
        steam_generator(
        redeclare package tubeMedium =
            ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
        redeclare package shellMedium = ORNL_AdvSMR.Media.Fluids.Na,
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeFlowArea=1,
        tubePerimeter=1,
        tubeHeatTrArea=1,
        tubeWallThickness=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        Twall_start=573.15),
      redeclare
        ORNL_AdvSMR.Implementations.PowerConversionSystem.PRISM_PCS1_noCond
        power_conversion_system,
      redeclare ORNL_AdvSMR.Implementations.ElectricalGenerator.PRISM_G1
        singleShaftGenerator,
      redeclare Implementations.DRACS.NoDRACS dracs(redeclare package
          DRACSFluid = ORNL_AdvSMR.Media.Fluids.Na, redeclare package Air =
            Modelica.Media.Air.SimpleAir));

    inner System system
      annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));

    .UserInteraction.Outputs.SpatialPlot spatialPlot(
      x=linspace(
            0,
            1,
            8),
      minX=0,
      maxX=1,
      y=primary_loop.core.T .- 273.15,
      minY=300,
      maxY=500)
      annotation (Placement(transformation(extent={{-210,24},{-70,106}})));
    .UserInteraction.Outputs.SpatialPlot2 spatialPlot2_1(
      maxY1=600,
      maxY2=600,
      minY1=200,
      minY2=200,
      y1=intermediate_heat_exchanger.ihx1.shell.T .- 273.15,
      y2=reverse(intermediate_heat_exchanger.ihx1.tube.T) .- 273.15,
      x1=linspace(
            1,
            20,
            20),
      x2=linspace(
            1,
            20,
            20),
      minX1=1,
      maxX1=20)
      annotation (Placement(transformation(extent={{-208,-104},{-84,-16}})));
    .UserInteraction.Outputs.NumericValue numericValue(input_Value=primary_loop.core.T[
          8] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-98,8},{-84,22}})));
    .UserInteraction.Outputs.NumericValue numericValue1(input_Value=
          primary_loop.core.T[1] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-98,-12},{-84,2}})));
    .UserInteraction.Outputs.NumericValue numericValue2(precision=1,
        input_Value=time)
      annotation (Placement(transformation(extent={{-20,44},{0,64}})));

    .UserInteraction.Outputs.NumericValue numericValue3(precision=1,
        input_Value=primary_loop.primaryPump.w)
      annotation (Placement(transformation(extent={{-114,10},{-100,24}})));
    .UserInteraction.Outputs.NumericValue numericValue4(precision=1,
        input_Value=intermediate_loop.intermediatePump.w)
      annotation (Placement(transformation(extent={{6,10},{20,24}})));
    .UserInteraction.Outputs.DynamicDiagram dynamicDiagram(Value=eventDriver.w_fw.y)
      annotation (Placement(transformation(extent={{120,60},{200,100}})));
    .UserInteraction.Outputs.IndicatorLamp indicatorLamp(hideConnector=true,
        input_Value=eventDriver.breakerSwitch.y)
      annotation (Placement(transformation(extent={{160,40},{164,36}})));
    .UserInteraction.Outputs.NumericValue numericValue6(precision=1,
        input_Value=singleShaftGenerator.singleShaft_static.frequencySensor.f)
      annotation (Placement(transformation(extent={{160,28},{168,36}})));
    .UserInteraction.Outputs.NumericValue numericValue5(precision=1,
        input_Value=1.22*singleShaftGenerator.singleShaft_static.powerSensor.W/
          1e6)
      annotation (Placement(transformation(extent={{160,22},{168,30}})));
    .UserInteraction.Outputs.NumericValue numericValue7(precision=1,
        input_Value=power_conversion_system.fwPump.w)
      annotation (Placement(transformation(extent={{126,10},{140,24}})));
    .UserInteraction.Outputs.SpatialPlot spatialPlot1(
      x=linspace(
            0,
            1,
            8),
      minX=0,
      maxX=1,
      y=primary_loop.fuelPin.fp[4].T_f .- 273.15,
      minY=390,
      maxY=410)
      annotation (Placement(transformation(extent={{-6,46},{108,104}})));
    .UserInteraction.Outputs.NumericValue numericValue9(precision=0,
        input_Value=primary_loop.reactorKinetics.Q_total/1e6)
      annotation (Placement(transformation(extent={{-140,8},{-122,26}})));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
              200,100}}), graphics={Text(
              extent={{-112,18},{-122,18}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="w = "),Text(
              extent={{8,18},{-2,18}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="w = "),Text(
              extent={{-22,54},{-36,54}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=24,
              textString="T  = "),Text(
              extent={{158,38},{148,38}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=10,
              textString="Breaker"),Text(
              extent={{158,26},{136,26}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=10,
              textString="Electrical Output",
              horizontalAlignment=TextAlignment.Right),Text(
              extent={{158,32},{138,32}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=10,
              textString="Grid Frequency",
              horizontalAlignment=TextAlignment.Right),Text(
              extent={{176,26},{170,26}},
              lineColor={0,0,0},
              fontSize=10,
              horizontalAlignment=TextAlignment.Left,
              textString="MW"),Text(
              extent={{176,32},{170,32}},
              lineColor={0,0,0},
              fontSize=10,
              horizontalAlignment=TextAlignment.Left,
              textString="Hz"),Text(
              extent={{128,18},{118,18}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="w = "),Text(
              extent={{-138,18},{-148,18}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="Q = ")}),
      experiment(
        StopTime=5000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=1e-006,
        __Dymola_Algorithm="Dassl"),
      __Dymola_experimentSetupOutput);
  end PRISM_e2e;

  model PL2SG
    extends Architecture.Primary2SteamGenerator(
      redeclare Implementations.PrimaryHeatTransportSystem.PRISM_PHTS1
        primary_loop(FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook),
      redeclare Implementations.IntermediateHeatExchanger.PRISM_IHX1
        intermediate_heat_exchanger,
      redeclare Implementations.IntermediateHeatTransportSystem.PRISM_IHTS1
        intermediate_loop,
      redeclare Implementations.SteamGenerator.PRISM_SteamGenerator1
        steam_generator,
      redeclare Implementations.EventDriver.PRISM_ED1 event_driver,
      redeclare Implementations.ControlSystem.PRISM_CS1 control_system);
    inner System system
      annotation (Placement(transformation(extent={{-200,80},{-180,100}})));
  end PL2SG;

  model IHX_Test
    extends Architecture.IHX_test(
      redeclare Implementations.IntermediateHeatExchanger.PRISM_IHX1
        intermediate_heat_exchanger(
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        redeclare model shellHeatTransfer =
            Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer,

        shellHeatTrArea=1,
        redeclare model ShellFlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalTurbulentPipeFlow,

        shellWallThickness=1,
        tubeDiameter=1,
        tubeHeatTrArea=1,
        tubeWallThickness=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1),
      redeclare Implementations.PrimaryHeatTransportSystem.PRISM_PHTS_BC
        primary_loop(FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook),
      redeclare
        Implementations.IntermediateHeatTransportSystem.PRISM_IHTS_simple_noPD
        intermediate_loop(ihx2sg=15));

    inner System system
      annotation (Placement(transformation(extent={{-200,80},{-180,100}})));
    Components.SourceW shellIn(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      w0=1126.4,
      h=28.8858e3 + 1.2753e3*(468 + 273),
      p0=100000)
      annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
    Components.SinkP shellOut(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=28.8858e3 + 1.2753e3*(319 + 273),
      p0=100000)
      annotation (Placement(transformation(extent={{-120,-20},{-140,0}})));
    Components.SourceW shellIn1(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=28.8858e3 + 1.2753e3*(282 + 273),
      w0=1152.9,
      p0=100000)
      annotation (Placement(transformation(extent={{140,0},{120,-20}})));
    Components.SinkP shellOut1(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      p0=100000,
      h=28.8858e3 + 1.2753e3*(426.7 + 273))
      annotation (Placement(transformation(extent={{120,0},{140,20}})));
    Modelica.Blocks.Sources.Ramp ramp(
      duration=1,
      offset=28.8858e3 + 1.2753e3*(282 + 273),
      height=-1.2753e3*20,
      startTime=5000)
      annotation (Placement(transformation(extent={{160,-60},{140,-40}})));
  equation
    connect(shellIn.flange, primary_loop.fromDRACS) annotation (Line(
        points={{-120,10},{-100,10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(shellOut.flange, primary_loop.toDRACS) annotation (Line(
        points={{-120,-10},{-100,-10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(intermediate_loop.toSG, shellOut1.flange) annotation (Line(
        points={{99.5,10.5},{109.75,10.5},{109.75,10},{120,10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(shellIn1.flange, intermediate_loop.fromSG) annotation (Line(
        points={{120,-10},{112,-10},{112,-5.5},{100.5,-5.5}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(ramp.y, shellIn1.in_h) annotation (Line(
        points={{139,-50},{126,-50},{126,-16}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
              200,100}}), graphics),
      experiment(
        StopTime=10000,
        __Dymola_NumberOfIntervals=10000,
        Tolerance=1e-006,
        __Dymola_Algorithm="Dassl"),
      __Dymola_experimentSetupOutput);
  end IHX_Test;

  model IHXtest
    Implementations.IntermediateHeatExchanger.PRISM_IHX1 pRISM_IHX1_1(
      flowPathLength=1,
      shellDiameter=1,
      shellFlowArea=1,
      shellPerimeter=1,
      redeclare model shellHeatTransfer =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer,

      shellHeatTrArea=1,
      redeclare model ShellFlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      shellWallThickness=1,
      tubeDiameter=1,
      tubeHeatTrArea=1,
      tubeWallThickness=1,
      tubeWallRho=1,
      tubeWallCp=1,
      tubeWallK=1)
      annotation (Placement(transformation(extent={{-40,-40},{40,40}})));

    Components.SourceW shellIn(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      w0=1126.4,
      h=28.8858e3 + 1.2753e3*(468 + 273),
      p0=100000)
      annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
    Modelica.Blocks.Sources.Ramp ramp2(
      duration=1,
      startTime=5000,
      offset=28.8858e3 + 1.2753e3*(468 + 273),
      height=1.2753e3*10) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-70,50})));
    Components.SourceW tubeIn(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      w0=1152.9,
      h=28.8858e3 + 1.2753e3*(282 + 273),
      p0=100000) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={0,70})));
    Components.SinkP tubeOut(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=28.8858e3 + 1.2753e3*(426.7 + 273),
      p0=100000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,-70})));
    Components.SinkP shellOut(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=28.8858e3 + 1.2753e3*(319 + 273),
      p0=100000)
      annotation (Placement(transformation(extent={{60,-24},{80,-4}})));
    inner System system
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  equation
    connect(tubeIn.flange, pRISM_IHX1_1.tubeInlet) annotation (Line(
        points={{0,60},{0,44}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(ramp2.y, shellIn.in_h) annotation (Line(
        points={{-70,39},{-70,32},{-66,32},{-66,26}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(shellIn.flange, pRISM_IHX1_1.shellInlet) annotation (Line(
        points={{-60,20},{-40,20}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(shellOut.flange, pRISM_IHX1_1.shellOutlet) annotation (Line(
        points={{60,-14},{38,-14}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(tubeOut.flange, pRISM_IHX1_1.tubeOutlet) annotation (Line(
        points={{0,-60},{0,-44}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end IHXtest;

  model PRISM3
    extends PRISM(
      redeclare Implementations.IntermediateHeatTransportSystem.PRISM_IHTS1
        intermediate_loop,
      redeclare Implementations.PrimaryHeatTransportSystem.PRISM_PHTS2
        primary_loop,
      redeclare Implementations.IntermediateHeatExchanger.PRISM_IHX2
        intermediate_heat_exchanger);
  end PRISM3;

  model Rx2IHX

    import Modelica.Math.Vectors.*;

    extends Architecture.Rx2IHX(redeclare
        Implementations.PrimaryHeatTransportSystem.PRISM_PHTS1_noRx
        primary_loop(
        H_fuelPin=4.0132,
        H_coreChannel=4.0132,
        FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
        Q_nom=425e6/2), redeclare
        Implementations.IntermediateHeatExchanger.PRISM_IHX1
        intermediate_heat_exchanger(
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeDiameter=1,
        tubeHeatTrArea=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        tubeWallThickness=1,
        Twall_start=773.15));

    inner System system
      annotation (Placement(transformation(extent={{-200,80},{-180,100}})));
    Components.SourceW sodiumIn(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      w0=655.19,
      p0=6653000) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-110,10})));
    Components.SinkP sodiumOut(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      p0=6653000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-110,-10})));

    Components.SourceW sodiumIn1(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=28.8858e3 + 1.2753e3*(282 + 273.15),
      p0=100000) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={40,70})));
    Components.SinkP sodiumOut1(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      p0=100000,
      h=28.8858e3 + 1.2753e3*(426.7 + 273)) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={40,-70})));
    Modelica.Blocks.Sources.Ramp w_sec(
      offset=1152.9,
      duration=0,
      height=-1152.9/4,
      startTime=200) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-10,90})));
    Modelica.Blocks.Sources.Ramp w_sec1(
      duration=0,
      offset=28.8858e3 + 1.2753e3*(282 + 273.15),
      height=-1.2753e3*32,
      startTime=700) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-10,50})));
    .UserInteraction.Outputs.SpatialPlot spatialPlot(
      x=linspace(
            0,
            1,
            8),
      minX=0,
      maxX=1,
      y=primary_loop.core.T .- 273.15,
      minY=250,
      maxY=500)
      annotation (Placement(transformation(extent={{-184,14},{-54,108}})));
    .UserInteraction.Outputs.SpatialPlot2 spatialPlot2_1(
      maxY1=500,
      maxY2=500,
      x1=linspace(
            0,
            1,
            10),
      x2=linspace(
            0,
            1,
            10),
      y2=reverse(intermediate_heat_exchanger.tube.T) .- 273.15,
      y1=intermediate_heat_exchanger.shell.T .- 273.15,
      minY1=250,
      minY2=250)
      annotation (Placement(transformation(extent={{-198,-106},{12,-14}})));
    .UserInteraction.Outputs.NumericValue numericValue(input_Value=primary_loop.core.T[
          8] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-18,8},{-4,22}})));
    .UserInteraction.Outputs.NumericValue numericValue1(input_Value=
          primary_loop.core.T[1] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-18,-22},{-4,-8}})));
  equation
    connect(primary_loop.toDRACS, sodiumOut.flange) annotation (Line(
        points={{-60,-10},{-100,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(primary_loop.fromDRACS, sodiumIn.flange) annotation (Line(
        points={{-60,10},{-100,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));

    connect(intermediate_heat_exchanger.tubeInlet, sodiumIn1.flange)
      annotation (Line(
        points={{40,22},{40,60}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediate_heat_exchanger.tubeOutlet, sodiumOut1.flange)
      annotation (Line(
        points={{40,-22},{40,-60}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(sodiumIn1.in_w0, w_sec.y) annotation (Line(
        points={{34,74},{20,74},{20,90},{1,90}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(w_sec1.y, sodiumIn1.in_h) annotation (Line(
        points={{1,50},{20,50},{20,66},{34,66}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
              200,100}}), graphics),
      experiment(
        StopTime=1000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=1e-006),
      __Dymola_experimentSetupOutput);
  end Rx2IHX;

  model Rx2IHTS

    import Modelica.Math.Vectors.*;

    extends Architecture.Rx2IHTS(
      redeclare Implementations.PrimaryHeatTransportSystem.PRISM_PHTS1_noRx
        primary_loop(
        H_fuelPin=4.0132,
        H_coreChannel=4.0132,
        FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
        Q_nom=425e6/2),
      redeclare Implementations.IntermediateHeatExchanger.PRISM_IHX1
        intermediate_heat_exchanger(
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeDiameter=1,
        tubeHeatTrArea=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        tubeWallThickness=1,
        Twall_start=773.15),
      redeclare
        Implementations.IntermediateHeatTransportSystem.PRISM_IHTS_simple_noPD
        intermediate_loop,
      redeclare Implementations.EventDriver.PRISM_ED1 eventDriver,
      redeclare Implementations.ControlSystem.PRISM_CS1 controlSystem);

    inner System system
      annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
    Components.SourceW sodiumIn(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      w0=655.19,
      p0=6653000) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-110,10})));
    Components.SinkP sodiumOut(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      p0=6653000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-110,-10})));

    Components.SourceW sodiumIn1(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=28.8858e3 + 1.2753e3*(282 + 273.15),
      p0=100000) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={130,-32})));
    Components.SinkP sodiumOut1(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      p0=100000,
      h=28.8858e3 + 1.2753e3*(426.7 + 273)) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={110,20})));
    Modelica.Blocks.Sources.Ramp w_sec(
      offset=1152.9,
      duration=0,
      height=-1152.9/4,
      startTime=200) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={190,-20})));
    Modelica.Blocks.Sources.Ramp h_sec(
      duration=0,
      offset=28.8858e3 + 1.2753e3*(282 + 273.15),
      height=-1.2753e3*32,
      startTime=700) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={150,0})));
    .UserInteraction.Outputs.SpatialPlot spatialPlot(
      x=linspace(
            0,
            1,
            8),
      minX=0,
      maxX=1,
      y=primary_loop.core.T .- 273.15,
      minY=300,
      maxY=550)
      annotation (Placement(transformation(extent={{-210,24},{-70,106}})));
    .UserInteraction.Outputs.SpatialPlot2 spatialPlot2_1(
      maxY1=500,
      maxY2=500,
      x1=linspace(
            0,
            1,
            10),
      x2=linspace(
            0,
            1,
            10),
      y2=reverse(intermediate_heat_exchanger.tube.T) .- 273.15,
      y1=intermediate_heat_exchanger.shell.T .- 273.15,
      minY1=250,
      minY2=250)
      annotation (Placement(transformation(extent={{-208,-104},{-84,-16}})));
    .UserInteraction.Outputs.NumericValue numericValue(input_Value=primary_loop.core.T[
          8] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-38,8},{-24,22}})));
    .UserInteraction.Outputs.NumericValue numericValue1(input_Value=
          primary_loop.core.T[1] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-38,-12},{-24,2}})));
    .UserInteraction.Outputs.DynamicDiagram dynamicDiagram(label=
          "Secondary flow rate")
      annotation (Placement(transformation(extent={{100,-100},{200,-40}})));
    .UserInteraction.Outputs.NumericValue numericValue2(precision=1,
        input_Value=time)
      annotation (Placement(transformation(extent={{0,60},{20,80}})));
    .UserInteraction.Outputs.DynamicDiagram dynamicDiagram1(label=
          "Secondary input enthalpy")
      annotation (Placement(transformation(extent={{100,40},{200,100}})));
  equation
    connect(primary_loop.toDRACS, sodiumOut.flange) annotation (Line(
        points={{-80,-10},{-100,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(primary_loop.fromDRACS, sodiumIn.flange) annotation (Line(
        points={{-80,10},{-100,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));

    connect(sodiumIn1.in_w0, w_sec.y) annotation (Line(
        points={{134,-26},{134,-20},{179,-20}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(h_sec.y, sodiumIn1.in_h) annotation (Line(
        points={{139,0},{126,0},{126,-26}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(intermediate_loop.fromSG, sodiumIn1.flange) annotation (Line(
        points={{80.5,-5.5},{100,-5.5},{100,-32},{120,-32}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(intermediate_loop.toSG, sodiumOut1.flange) annotation (Line(
        points={{79.5,10.5},{90,10.5},{90,20},{100,20}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(dynamicDiagram.Value, w_sec.y) annotation (Line(
        points={{100,-70},{92,-70},{92,-20},{179,-20}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(h_sec.y, dynamicDiagram1.Value) annotation (Line(
        points={{139,0},{86,0},{86,70},{100,70}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
              200,100}}), graphics),
      experiment(
        StopTime=1000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=1e-006),
      __Dymola_experimentSetupOutput);
  end Rx2IHTS;

  model Rx2Sg

    import Modelica.Math.Vectors.*;

    extends Architecture.Rx2Sg(
      redeclare Implementations.PrimaryHeatTransportSystem.PRISM_PHTS1_noRx
        primary_loop(
        H_fuelPin=4.0132,
        H_coreChannel=4.0132,
        FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
        Q_nom=425e6/2),
      redeclare Implementations.IntermediateHeatExchanger.PRISM_IHX1
        intermediate_heat_exchanger(
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeDiameter=1,
        tubeHeatTrArea=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        tubeWallThickness=1,
        Twall_start=773.15),
      redeclare
        Implementations.IntermediateHeatTransportSystem.PRISM_IHTS_simple_noPD
        intermediate_loop(nNodes=20),
      redeclare Implementations.EventDriver.PRISM_ED1 eventDriver,
      redeclare Implementations.ControlSystem.PRISM_CS1 controlSystem,
      redeclare Implementations.SteamGenerator.PRISM_SteamGenerator1
        steam_generator(
        redeclare package tubeMedium =
            ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
        redeclare package shellMedium = ORNL_AdvSMR.Media.Fluids.Na,
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeFlowArea=1,
        tubePerimeter=1,
        tubeHeatTrArea=1,
        tubeWallThickness=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        Twall_start=573.15));

    inner System system
      annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
    Components.SourceW airIn(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      w0=655.19,
      p0=6653000) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-170,10})));
    Components.SinkP airOut(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      p0=6653000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-170,-10})));

    .UserInteraction.Outputs.SpatialPlot spatialPlot(
      x=linspace(
            0,
            1,
            8),
      minX=0,
      maxX=1,
      y=primary_loop.core.T .- 273.15,
      minY=300,
      maxY=500)
      annotation (Placement(transformation(extent={{-210,24},{-70,106}})));
    .UserInteraction.Outputs.SpatialPlot2 spatialPlot2_1(
      x1=linspace(
            0,
            1,
            10),
      x2=linspace(
            0,
            1,
            10),
      y2=reverse(intermediate_heat_exchanger.tube.T) .- 273.15,
      y1=intermediate_heat_exchanger.shell.T .- 273.15,
      maxY1=600,
      maxY2=600,
      minY1=200,
      minY2=200)
      annotation (Placement(transformation(extent={{-208,-104},{-84,-16}})));
    .UserInteraction.Outputs.NumericValue numericValue(input_Value=primary_loop.core.T[
          8] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-98,8},{-84,22}})));
    .UserInteraction.Outputs.NumericValue numericValue1(input_Value=
          primary_loop.core.T[1] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-98,-12},{-84,2}})));
    .UserInteraction.Outputs.DynamicDiagram dynamicDiagram(label=
          "Secondary flow rate")
      annotation (Placement(transformation(extent={{100,-100},{200,-40}})));
    .UserInteraction.Outputs.NumericValue numericValue2(precision=1,
        input_Value=time)
      annotation (Placement(transformation(extent={{0,60},{20,80}})));
    .UserInteraction.Outputs.DynamicDiagram dynamicDiagram1(label=
          "Secondary input enthalpy")
      annotation (Placement(transformation(extent={{100,40},{200,100}})));
    Components.SinkP shellOut1(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
      h=5*975.6623e3,
      p0=7143000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={20,-60})));

    Components.SourceW shellIn1(redeclare package Medium =
          ORNL_AdvSMR.Media.Fluids.Water.StandardWater, p0=7143000) annotation
      (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={50,70})));

    Modelica.Blocks.Sources.Pulse h_sg(
      offset=975.6623e3,
      width=100,
      nperiod=1,
      period=500,
      amplitude=-975.6623e3/5,
      startTime=1000)
      annotation (Placement(transformation(extent={{90,40},{70,60}})));
    .UserInteraction.Outputs.NumericValue numericValue3(precision=1,
        input_Value=primary_loop.primaryPump.w)
      annotation (Placement(transformation(extent={{-112,12},{-98,26}})));
    Modelica.Blocks.Sources.Pulse w_sg(
      width=100,
      nperiod=1,
      period=500,
      amplitude=-272,
      offset=2*272,
      startTime=3000)
      annotation (Placement(transformation(extent={{90,80},{70,100}})));
    .UserInteraction.Outputs.NumericValue numericValue4(precision=1,
        input_Value=intermediate_loop.intermediatePump.w)
      annotation (Placement(transformation(extent={{8,12},{22,26}})));
  equation
    connect(primary_loop.toDRACS, airOut.flange) annotation (Line(
        points={{-140,-10},{-160,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(primary_loop.fromDRACS, airIn.flange) annotation (Line(
        points={{-140,10},{-160,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));

    connect(shellIn1.flange, steam_generator.tubeInlet) annotation (Line(
        points={{50,60},{50,40},{60,40},{60,22}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(shellIn1.in_h, h_sg.y) annotation (Line(
        points={{56,66},{62,66},{62,50},{69,50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(shellOut1.flange, steam_generator.tubeOutlet) annotation (Line(
        points={{20,-50},{20,-34},{60,-34},{60,-22}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(dynamicDiagram.Value, h_sg.y) annotation (Line(
        points={{100,-70},{92,-70},{92,66},{62,66},{62,50},{69,50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(shellIn1.in_w0, w_sg.y) annotation (Line(
        points={{56,74},{62,74},{62,90},{69,90}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(dynamicDiagram1.Value, w_sg.y) annotation (Line(
        points={{100,70},{82,70},{82,74},{62,74},{62,90},{69,90}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
              200,100}}), graphics={Text(
              extent={{-110,20},{-120,20}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="w = "),Text(
              extent={{10,20},{0,20}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="w = ")}),
      experiment(
        StopTime=5000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=1e-006),
      __Dymola_experimentSetupOutput);
  end Rx2Sg;

  model Rx2Sg1

    extends Architecture.Rx2Sg(
      redeclare Implementations.PrimaryHeatTransportSystem.PRISM_PHTS1_noRx
        primary_loop(
        FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
        D_fuelPin=7.366e-3,
        Q_nom=425e6),
      redeclare Implementations.IntermediateHeatExchanger.PRISM_IHX1
        intermediate_heat_exchanger(
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeDiameter=1,
        tubeHeatTrArea=1,
        tubeWallThickness=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        Twall_start=773.15),
      redeclare
        Implementations.IntermediateHeatTransportSystem.PRISM_IHTS_simple_noPD
        intermediate_loop,
      redeclare Implementations.SteamGenerator.PRISM_SteamGenerator1
        steam_generator(
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeFlowArea=1,
        tubePerimeter=1,
        tubeHeatTrArea=1,
        tubeWallThickness=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        redeclare package shellMedium = ORNL_AdvSMR.Media.Fluids.Na,
        redeclare package tubeMedium =
            ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
        Twall_start=773.15),
      redeclare Implementations.EventDriver.PRISM_ED1 eventDriver,
      redeclare Implementations.ControlSystem.PRISM_CS1 controlSystem);

    Components.SourceW shellIn(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      w0=1126.4,
      h=28.8858e3 + 1.2753e3*(468 + 273),
      p0=100000)
      annotation (Placement(transformation(extent={{-180,0},{-160,20}})));
    Components.SinkP shellOut(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=28.8858e3 + 1.2753e3*(319 + 273),
      p0=100000)
      annotation (Placement(transformation(extent={{-160,-20},{-180,0}})));
    Components.SourceW shellIn1(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
      w0=272,
      p0=7143000) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={60,70})));

    Components.SinkP shellOut1(
      h=28.8858e3 + 1.2753e3*(426.7 + 273),
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
      p0=100000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={130,-30})));

    Modelica.Blocks.Sources.Ramp ramp(
      duration=1,
      startTime=5000,
      height=0,
      offset=975.6623e3)
      annotation (Placement(transformation(extent={{120,56},{100,76}})));
    inner System system
      annotation (Placement(transformation(extent={{-200,80},{-180,100}})));

  equation
    connect(ramp.y, shellIn1.in_h) annotation (Line(
        points={{99,66},{66,66}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(shellIn.flange, primary_loop.fromDRACS) annotation (Line(
        points={{-160,10},{-140,10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(shellOut.flange, primary_loop.toDRACS) annotation (Line(
        points={{-160,-10},{-140,-10}},
        color={0,127,255},
        smooth=Smooth.None));

    connect(steam_generator.tubeInlet, shellIn1.flange) annotation (Line(
        points={{60,22},{60,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(steam_generator.tubeOutlet, shellOut1.flange) annotation (Line(
        points={{60,-22},{60,-30},{120,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
              200,100}}), graphics),
      experiment(StopTime=1000, __Dymola_NumberOfIntervals=1000),
      __Dymola_experimentSetupOutput);
  end Rx2Sg1;

  model Rx2Sg2
    import ORNL_AdvSMR;

    import Modelica.Math.Vectors.*;

    replaceable package PowerFluid = Modelica.Media.Water.StandardWater;

    extends Architecture.Rx2Sg(
      redeclare Implementations.PrimaryHeatTransportSystem.PRISM_PHTS1_noRx
        primary_loop(
        H_fuelPin=4.0132,
        H_coreChannel=4.0132,
        FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
        Q_nom=425e6/2),
      redeclare Implementations.IntermediateHeatExchanger.PRISM_IHX1
        intermediate_heat_exchanger(
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeDiameter=1,
        tubeHeatTrArea=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        tubeWallThickness=1,
        Twall_start=773.15),
      redeclare
        Implementations.IntermediateHeatTransportSystem.PRISM_IHTS_simple_noPD
        intermediate_loop(nNodes=10),
      redeclare Implementations.EventDriver.PRISM_ED1 eventDriver,
      redeclare Implementations.ControlSystem.PRISM_CS1 controlSystem,
      redeclare Implementations.SteamGenerator.PRISM_SteamGenerator1
        steam_generator(
        redeclare package tubeMedium =
            ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
        redeclare package shellMedium = ORNL_AdvSMR.Media.Fluids.Na,
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeFlowArea=1,
        tubePerimeter=1,
        tubeHeatTrArea=1,
        tubeWallThickness=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        Twall_start=573.15));

    inner System system
      annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
    Components.SourceW sodiumIn(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      w0=655.19,
      p0=6653000) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-170,10})));
    Components.SinkP sodiumOut(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      p0=6653000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-170,-10})));

    .UserInteraction.Outputs.SpatialPlot spatialPlot(
      x=linspace(
            0,
            1,
            8),
      minX=0,
      maxX=1,
      y=primary_loop.core.T .- 273.15,
      minY=300,
      maxY=500)
      annotation (Placement(transformation(extent={{-210,24},{-70,106}})));
    .UserInteraction.Outputs.SpatialPlot2 spatialPlot2_1(
      x1=linspace(
            0,
            1,
            10),
      x2=linspace(
            0,
            1,
            10),
      y2=reverse(intermediate_heat_exchanger.tube.T) .- 273.15,
      y1=intermediate_heat_exchanger.shell.T .- 273.15,
      maxY1=600,
      maxY2=600,
      minY1=200,
      minY2=200)
      annotation (Placement(transformation(extent={{-208,-104},{-84,-16}})));
    .UserInteraction.Outputs.NumericValue numericValue(input_Value=primary_loop.core.T[
          8] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-98,8},{-84,22}})));
    .UserInteraction.Outputs.NumericValue numericValue1(input_Value=
          primary_loop.core.T[1] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-98,-12},{-84,2}})));
    .UserInteraction.Outputs.NumericValue numericValue2(precision=1,
        input_Value=time)
      annotation (Placement(transformation(extent={{0,60},{20,80}})));

    Components.SinkP shellOut1(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
      p0=865,
      h=975.6623e3/10) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={170,-90})));

    Components.SourceW shellIn1(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
      w0=272,
      p0=7143000) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=0,
          origin={130,80})));

    Modelica.Blocks.Sources.Ramp ramp(
      duration=1,
      offset=975.6623e3,
      height=-975.6623e3/10,
      startTime=1000)
      annotation (Placement(transformation(extent={{160,40},{140,60}})));
    Components.SteamTurbineStodola hpTurbine(
      explicitIsentropicEnthalpy=true,
      allowFlowReversal=false,
      redeclare package Medium = PowerFluid,
      wnom=655.20,
      wstart=655.20,
      PRstart=5.5,
      eta_iso_nom=0.83387,
      pnom=6653000,
      Kt=0.00944)
      annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
    Components.SteamTurbineStodola lpTurbine(
      explicitIsentropicEnthalpy=true,
      allowFlowReversal=false,
      redeclare package Medium = PowerFluid,
      PRstart=142.54,
      wstart=655.2,
      wnom=655.2,
      eta_iso_nom=0.83387,
      pnom=1206600,
      Kt=0.11)
      annotation (Placement(transformation(extent={{140,-50},{160,-30}})));
    Components.Pump intermediatePump1(
      usePowerCharacteristic=false,
      redeclare function efficiencyCharacteristic =
          ORNL_AdvSMR.Functions.PumpCharacteristics.constantEfficiency (eta_nom
            =0.95),
      hstart=28.8858e3 + 1.2753e3*(282 + 273),
      wstart=1152.9,
      initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
      V=11.45,
      Np0=1,
      redeclare package Medium = PowerFluid,
      w0=272,
      dp0(displayUnit="kPa") = 100000,
      rho0=1950,
      n0=1400,
      redeclare function flowCharacteristic =
          ORNL_AdvSMR.Functions.PumpCharacteristics.linearFlow (head_nom={1,0.5},
            q_nom={0.01,1})) annotation (Placement(transformation(extent={{100,
              68},{80,88}}, rotation=0)));
    ORNL_AdvSMR.PRISM.PowerConversionSystem.ElectricGeneratorGroup.Examples.SingleShaft_static
      singleShaft_static1(
      eta=0.9,
      omega_nom=3.1416*60*2/2,
      Pn=8.88e12,
      fn=50,
      J_shaft=10000,
      SSInit=true)
      annotation (Placement(transformation(extent={{180,-50},{200,-30}})));
  equation
    connect(primary_loop.toDRACS, sodiumOut.flange) annotation (Line(
        points={{-140,-10},{-160,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(primary_loop.fromDRACS, sodiumIn.flange) annotation (Line(
        points={{-140,10},{-160,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));

    connect(ramp.y, shellIn1.in_h) annotation (Line(
        points={{139,50},{126,50},{126,74}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(steam_generator.tubeOutlet, hpTurbine.inlet) annotation (Line(
        points={{60,-22},{60,-30},{100,-30}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(hpTurbine.outlet, lpTurbine.inlet) annotation (Line(
        points={{120,-50},{130,-50},{130,-30},{140,-30}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(lpTurbine.outlet, shellOut1.flange) annotation (Line(
        points={{160,-50},{170,-50},{170,-80}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(hpTurbine.shaft_b, lpTurbine.shaft_a) annotation (Line(
        points={{120,-40},{140,-40}},
        color={0,0,0},
        smooth=Smooth.None,
        thickness=1));
    connect(shellIn1.flange, intermediatePump1.infl) annotation (Line(
        points={{120,80},{98,80}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediatePump1.outfl, steam_generator.tubeInlet) annotation (
        Line(
        points={{84,85},{74,85},{74,86},{60,86},{60,22}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(lpTurbine.shaft_b, singleShaft_static1.shaft) annotation (Line(
        points={{160,-40},{180,-40}},
        color={0,0,0},
        smooth=Smooth.None,
        thickness=1));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
              200,100}}), graphics),
      experiment(
        StopTime=5000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=1e-006),
      __Dymola_experimentSetupOutput);
  end Rx2Sg2;

  model Rx2Sg3

    import ORNL_AdvSMR;
    import Modelica.Math.Vectors.*;

    replaceable package PowerFluid = Modelica.Media.Water.StandardWater;

    parameter Modelica.SIunits.Area Kt_hp=0.00944
      "Stodola coefficient for high-pressure turbine (m2)";
    parameter Modelica.SIunits.Area Kt_lp=0.11
      "Stodola coefficient for high-pressure turbine (m2)";

    extends Architecture.Rx2Sg(
      redeclare Implementations.PrimaryHeatTransportSystem.PRISM_PHTS1_noRx
        primary_loop(
        FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
        Q_nom=425e6/2,
        H_fuelPin=3.5,
        H_coreChannel=3.5),
      redeclare Implementations.IntermediateHeatExchanger.PRISM_IHX1
        intermediate_heat_exchanger(
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeDiameter=1,
        tubeHeatTrArea=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        tubeWallThickness=1,
        Twall_start=773.15),
      redeclare
        Implementations.IntermediateHeatTransportSystem.PRISM_IHTS_simple_noPD
        intermediate_loop(nNodes=10),
      redeclare Implementations.EventDriver.PRISM_ED1 eventDriver,
      redeclare ORNL_AdvSMR.Implementations.ControlSystem.PRISM_CS1
        controlSystem,
      redeclare Implementations.SteamGenerator.PRISM_SteamGenerator1
        steam_generator(
        redeclare package tubeMedium =
            ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
        redeclare package shellMedium = ORNL_AdvSMR.Media.Fluids.Na,
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeFlowArea=1,
        tubePerimeter=1,
        tubeHeatTrArea=1,
        tubeWallThickness=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        Twall_start=573.15));

    inner System system
      annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
    Components.SourceW sodiumIn(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      w0=655.19,
      p0=6653000) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-170,10})));
    Components.SinkP sodiumOut(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      p0=6653000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-170,-10})));

    .UserInteraction.Outputs.SpatialPlot spatialPlot(
      x=linspace(
            0,
            1,
            8),
      minX=0,
      maxX=1,
      y=primary_loop.core.T .- 273.15,
      minY=300,
      maxY=500)
      annotation (Placement(transformation(extent={{-210,24},{-70,106}})));
    .UserInteraction.Outputs.SpatialPlot2 spatialPlot2_1(
      x1=linspace(
            0,
            1,
            10),
      x2=linspace(
            0,
            1,
            10),
      y2=reverse(intermediate_heat_exchanger.tube.T) .- 273.15,
      y1=intermediate_heat_exchanger.shell.T .- 273.15,
      maxY1=600,
      maxY2=600,
      minY1=200,
      minY2=200)
      annotation (Placement(transformation(extent={{-208,-104},{-84,-16}})));
    .UserInteraction.Outputs.NumericValue numericValue(input_Value=primary_loop.core.T[
          8] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-98,8},{-84,22}})));
    .UserInteraction.Outputs.NumericValue numericValue1(input_Value=
          primary_loop.core.T[1] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-98,-12},{-84,2}})));
    .UserInteraction.Outputs.NumericValue numericValue2(precision=1,
        input_Value=time)
      annotation (Placement(transformation(extent={{-10,60},{10,80}})));

    Components.SourceW shellIn1(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
      w0=272,
      p0=7143000,
      h=975.6623e3) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=0,
          origin={130,72})));

    Modelica.Blocks.Sources.Ramp ramp(
      duration=1,
      startTime=1000,
      offset=272,
      height=272)
      annotation (Placement(transformation(extent={{160,40},{140,60}})));
    Components.Pump intermediatePump1(
      usePowerCharacteristic=false,
      redeclare function efficiencyCharacteristic =
          ORNL_AdvSMR.Functions.PumpCharacteristics.constantEfficiency (eta_nom
            =0.95),
      hstart=28.8858e3 + 1.2753e3*(282 + 273),
      wstart=1152.9,
      initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
      V=11.45,
      Np0=1,
      redeclare package Medium = PowerFluid,
      w0=272,
      dp0(displayUnit="kPa") = 100000,
      rho0=1950,
      n0=1400,
      redeclare function flowCharacteristic =
          ORNL_AdvSMR.Functions.PumpCharacteristics.linearFlow (head_nom={1,0.5},
            q_nom={0.01,1})) annotation (Placement(transformation(extent={{100,
              60},{80,80}}, rotation=0)));
    ORNL_AdvSMR.PRISM.PowerConversionSystem.ElectricGeneratorGroup.Examples.SingleShaft_static
      singleShaft_static1(
      eta=0.9,
      omega_nom=3.1416*60*2/2,
      Pn=8.88e12,
      fn=50,
      J_shaft=10000,
      SSInit=true)
      annotation (Placement(transformation(extent={{180,-50},{200,-30}})));
    ORNL_AdvSMR.Components.SteamTurbineStodola hpTurbine(
      explicitIsentropicEnthalpy=true,
      allowFlowReversal=false,
      redeclare package Medium = PowerFluid,
      PRstart=5.5,
      Kt=Kt_hp,
      eta_iso_nom=0.83387,
      wstart=272,
      wnom=272,
      pnom=6653000)
      annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
    ORNL_AdvSMR.Components.SteamTurbineStodola lpTurbine(
      explicitIsentropicEnthalpy=true,
      allowFlowReversal=false,
      redeclare package Medium = PowerFluid,
      PRstart=142.54,
      Kt=Kt_lp,
      eta_iso_nom=0.83387,
      wstart=272,
      wnom=272,
      pnom=1206600)
      annotation (Placement(transformation(extent={{140,-50},{160,-30}})));
    ORNL_AdvSMR.Components.SinkP shellOut1(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
      h=975.6623e3/10,
      p0=865) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={190,-70})));

    .UserInteraction.Outputs.NumericValue numericValue3(precision=1,
        input_Value=primary_loop.primaryPump.w)
      annotation (Placement(transformation(extent={{-114,10},{-100,24}})));
    .UserInteraction.Outputs.NumericValue numericValue4(precision=1,
        input_Value=intermediate_loop.intermediatePump.w)
      annotation (Placement(transformation(extent={{6,10},{20,24}})));
  equation
    connect(primary_loop.toDRACS, sodiumOut.flange) annotation (Line(
        points={{-140,-10},{-160,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(primary_loop.fromDRACS, sodiumIn.flange) annotation (Line(
        points={{-140,10},{-160,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));

    connect(shellIn1.flange, intermediatePump1.infl) annotation (Line(
        points={{120,72},{98,72}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(intermediatePump1.outfl, steam_generator.tubeInlet) annotation (
        Line(
        points={{84,77},{60,77},{60,22}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(hpTurbine.shaft_b, lpTurbine.shaft_a) annotation (Line(
        points={{120,-40},{140,-40}},
        color={0,0,0},
        smooth=Smooth.None,
        thickness=1));
    connect(lpTurbine.shaft_b, singleShaft_static1.shaft) annotation (Line(
        points={{160,-40},{180,-40}},
        color={0,0,0},
        smooth=Smooth.None,
        thickness=1));
    connect(steam_generator.tubeOutlet, hpTurbine.inlet) annotation (Line(
        points={{60,-22},{60,-30},{100,-30}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(hpTurbine.outlet, lpTurbine.inlet) annotation (Line(
        points={{120,-50},{128,-50},{128,-30},{140,-30}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(lpTurbine.outlet, shellOut1.flange) annotation (Line(
        points={{160,-50},{168,-50},{168,-70},{180,-70}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(ramp.y, shellIn1.in_w0) annotation (Line(
        points={{139,50},{134,50},{134,66}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
              200,100}}), graphics={Text(
              extent={{-112,18},{-122,18}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="w = "),Text(
              extent={{8,18},{-2,18}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="w = ")}),
      experiment(
        StopTime=5000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=1e-006),
      __Dymola_experimentSetupOutput);
  end Rx2Sg3;

  model Rx2PCS
    import ORNL_AdvSMR;

    import Modelica.Math.Vectors.*;

    extends Architecture.Rx2PCS(
      redeclare
        ORNL_AdvSMR.Implementations.PrimaryHeatTransportSystem.PRISM_PHTS1
        primary_loop(
        H_fuelPin=4.0132,
        H_coreChannel=4.0132,
        FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
        Q_nom=425e6/2),
      redeclare Implementations.IntermediateHeatExchanger.PRISM_IHX1
        intermediate_heat_exchanger(
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeDiameter=1,
        tubeHeatTrArea=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        tubeWallThickness=1,
        Twall_start=773.15),
      redeclare
        Implementations.IntermediateHeatTransportSystem.PRISM_IHTS_simple_noPD
        intermediate_loop(nNodes=10),
      redeclare Implementations.EventDriver.PRISM_ED1 eventDriver,
      redeclare Implementations.ControlSystem.PRISM_CS1 controlSystem,
      redeclare Implementations.SteamGenerator.PRISM_SteamGenerator1
        steam_generator(
        redeclare package shellMedium = ORNL_AdvSMR.Media.Fluids.Na,
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeFlowArea=1,
        tubePerimeter=1,
        tubeHeatTrArea=1,
        tubeWallThickness=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        redeclare package tubeMedium =
            ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
        Twall_start=573.15),
      redeclare
        ORNL_AdvSMR.Implementations.PowerConversionSystem.PRISM_PCS1_noCond
        power_conversion_system(redeclare package powerFluid =
            ThermoPower3.Water.StandardWater));

    inner System system
      annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
    Components.SourceW sodiumIn(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      w0=655.19,
      p0=6653000) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-170,10})));
    Components.SinkP sodiumOut(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      p0=6653000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-170,-10})));

    .UserInteraction.Outputs.SpatialPlot spatialPlot(
      x=linspace(
            0,
            1,
            8),
      minX=0,
      maxX=1,
      y=primary_loop.core.T .- 273.15,
      minY=300,
      maxY=500)
      annotation (Placement(transformation(extent={{-210,24},{-70,106}})));
    .UserInteraction.Outputs.SpatialPlot2 spatialPlot2_1(
      x1=linspace(
            0,
            1,
            10),
      x2=linspace(
            0,
            1,
            10),
      y2=reverse(intermediate_heat_exchanger.tube.T) .- 273.15,
      y1=intermediate_heat_exchanger.shell.T .- 273.15,
      maxY1=600,
      maxY2=600,
      minY1=200,
      minY2=200)
      annotation (Placement(transformation(extent={{-208,-104},{-84,-16}})));
    .UserInteraction.Outputs.NumericValue numericValue(input_Value=primary_loop.core.T[
          8] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-98,8},{-84,22}})));
    .UserInteraction.Outputs.NumericValue numericValue1(input_Value=
          primary_loop.core.T[1] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-98,-12},{-84,2}})));
    .UserInteraction.Outputs.NumericValue numericValue2(precision=1,
        input_Value=time)
      annotation (Placement(transformation(extent={{-10,60},{10,80}})));

    ORNL_AdvSMR.PRISM.PowerConversionSystem.ElectricGeneratorGroup.Examples.SingleShaft_static
      singleShaft_static1(
      eta=0.9,
      omega_nom=3.1416*60*2/2,
      Pn=8.88e12,
      fn=50,
      J_shaft=10000,
      SSInit=true)
      annotation (Placement(transformation(extent={{160,-20},{200,20}})));
  equation
    connect(primary_loop.toDRACS, sodiumOut.flange) annotation (Line(
        points={{-140,-10},{-160,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(primary_loop.fromDRACS, sodiumIn.flange) annotation (Line(
        points={{-140,10},{-160,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));

    connect(power_conversion_system.rotorShaft, singleShaft_static1.shaft)
      annotation (Line(
        points={{140,0},{160,0}},
        color={0,0,0},
        smooth=Smooth.None,
        thickness=1));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
              200,100}}), graphics),
      experiment(
        StopTime=5000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=1e-006),
      __Dymola_experimentSetupOutput);
  end Rx2PCS;

  model Rx2PCS1

    extends Architecture.Rx2PCS(
      redeclare Implementations.PrimaryHeatTransportSystem.PRISM_PHTS1_noPD
        primary_loop,
      redeclare Implementations.IntermediateHeatExchanger.PRISM_IHX1
        intermediate_heat_exchanger(
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeDiameter=1,
        tubeHeatTrArea=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        tubeWallThickness=1,
        Twall_start=773.15),
      redeclare
        Implementations.IntermediateHeatTransportSystem.PRISM_IHTS_simple_noPD
        intermediate_loop,
      redeclare Implementations.SteamGenerator.PRISM_SteamGenerator1
        steam_generator(
        redeclare package shellMedium = Modelica.Media.Examples.TwoPhaseWater,
        redeclare package tubeMedium = ORNL_AdvSMR.Media.Fluids.Na,
        flowPathLength=1,
        tubeFlowArea=1,
        tubePerimeter=1,
        tubeHeatTrArea=1,
        tubeWallThickness=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        Twall_start=773.15),
      redeclare Implementations.PowerConversionSystem.PRISM_PCS1
        power_conversion_system,
      redeclare Implementations.EventDriver.PRISM_ED1 eventDriver,
      redeclare Implementations.ControlSystem.PRISM_CS1 controlSystem);

    inner System system
      annotation (Placement(transformation(extent={{-200,80},{-180,100}})));
    Components.SourceW dRACSin(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      w0=655.19,
      p0=6653000) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-170,10})));
    Components.SinkP dRACSout(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      p0=6653000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-170,-10})));

  equation
    connect(primary_loop.toDRACS, dRACSout.flange) annotation (Line(
        points={{-140,-10},{-160,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(primary_loop.fromDRACS, dRACSin.flange) annotation (Line(
        points={{-140,10},{-160,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
              -100},{200,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-200,-100},{200,100}}),
          graphics));
  end Rx2PCS1;

  model Rx2PCS2
    import ORNL_AdvSMR;

    import Modelica.Math.Vectors.*;

    extends Architecture.Rx2PCS(
      redeclare Implementations.PrimaryHeatTransportSystem.PRISM_PHTS1_noRx
        primary_loop(
        H_fuelPin=4.0132,
        H_coreChannel=4.0132,
        FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
        Q_nom=425e6/2),
      redeclare Implementations.IntermediateHeatExchanger.PRISM_IHX1
        intermediate_heat_exchanger(
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeDiameter=1,
        tubeHeatTrArea=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        tubeWallThickness=1,
        Twall_start=773.15),
      redeclare
        Implementations.IntermediateHeatTransportSystem.PRISM_IHTS_simple_noPD
        intermediate_loop(nNodes=20),
      redeclare Implementations.EventDriver.PRISM_ED1 eventDriver,
      redeclare Implementations.ControlSystem.PRISM_CS1 controlSystem,
      redeclare Implementations.SteamGenerator.PRISM_SteamGenerator1
        steam_generator(
        redeclare package tubeMedium =
            ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
        redeclare package shellMedium = ORNL_AdvSMR.Media.Fluids.Na,
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeFlowArea=1,
        tubePerimeter=1,
        tubeHeatTrArea=1,
        tubeWallThickness=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        Twall_start=573.15),
      redeclare
        ORNL_AdvSMR.Implementations.PowerConversionSystem.PRISM_PCS1_noCond
        power_conversion_system);

    inner System system
      annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
    Components.SourceW airIn(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      w0=655.19,
      p0=6653000) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-170,10})));
    Components.SinkP airOut(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      p0=6653000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-170,-10})));

    .UserInteraction.Outputs.SpatialPlot spatialPlot(
      x=linspace(
            0,
            1,
            8),
      minX=0,
      maxX=1,
      y=primary_loop.core.T .- 273.15,
      minY=300,
      maxY=500)
      annotation (Placement(transformation(extent={{-210,24},{-70,106}})));
    .UserInteraction.Outputs.SpatialPlot2 spatialPlot2_1(
      x1=linspace(
            0,
            1,
            10),
      x2=linspace(
            0,
            1,
            10),
      y2=reverse(intermediate_heat_exchanger.tube.T) .- 273.15,
      y1=intermediate_heat_exchanger.shell.T .- 273.15,
      maxY1=600,
      maxY2=600,
      minY1=200,
      minY2=200)
      annotation (Placement(transformation(extent={{-208,-104},{-84,-16}})));
    .UserInteraction.Outputs.NumericValue numericValue(input_Value=primary_loop.core.T[
          8] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-98,8},{-84,22}})));
    .UserInteraction.Outputs.NumericValue numericValue1(input_Value=
          primary_loop.core.T[1] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-98,-12},{-84,2}})));
    .UserInteraction.Outputs.NumericValue numericValue2(precision=1,
        input_Value=time)
      annotation (Placement(transformation(extent={{0,60},{20,80}})));

    .UserInteraction.Outputs.NumericValue numericValue3(precision=1,
        input_Value=primary_loop.primaryPump.w)
      annotation (Placement(transformation(extent={{-112,12},{-98,26}})));
    .UserInteraction.Outputs.NumericValue numericValue4(precision=1,
        input_Value=intermediate_loop.intermediatePump.w)
      annotation (Placement(transformation(extent={{8,12},{22,26}})));
    ORNL_AdvSMR.PRISM.PowerConversionSystem.ElectricGeneratorGroup.Examples.SingleShaft_static
      singleShaft_static1(
      eta=0.9,
      omega_nom=3.1416*60*2/2,
      Pn=8.88e12,
      fn=50,
      J_shaft=10000,
      SSInit=true)
      annotation (Placement(transformation(extent={{160,-20},{200,20}})));
  equation
    connect(primary_loop.toDRACS, airOut.flange) annotation (Line(
        points={{-140,-10},{-160,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(primary_loop.fromDRACS, airIn.flange) annotation (Line(
        points={{-140,10},{-160,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));

    connect(power_conversion_system.rotorShaft, singleShaft_static1.shaft)
      annotation (Line(
        points={{140,0},{160,0}},
        color={0,0,0},
        smooth=Smooth.None,
        thickness=1));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
              200,100}}), graphics={Text(
              extent={{-110,20},{-120,20}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="w = "),Text(
              extent={{10,20},{0,20}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="w = ")}),
      experiment(
        StopTime=5000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=1e-006),
      __Dymola_experimentSetupOutput);
  end Rx2PCS2;

  model Rx2Grid

    extends Architecture.Rx2Grid(
      redeclare
        Implementations.PrimaryHeatTransportSystem.PRISM_PHTS1_3AxialZones
        primary_loop(FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.NoFriction),
      redeclare Implementations.IntermediateHeatExchanger.PRISM_IHX1
        intermediate_heat_exchanger(
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeDiameter=1,
        tubeHeatTrArea=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        tubeWallThickness=1,
        Twall_start=773.15),
      redeclare
        Implementations.IntermediateHeatTransportSystem.PRISM_IHTS_simple_noPD
        intermediate_loop,
      redeclare Implementations.SteamGenerator.PRISM_SteamGenerator1
        steam_generator(
        redeclare package shellMedium = Modelica.Media.Examples.TwoPhaseWater,
        redeclare package tubeMedium = ORNL_AdvSMR.Media.Fluids.Na,
        flowPathLength=1,
        tubeFlowArea=1,
        tubePerimeter=1,
        tubeHeatTrArea=1,
        tubeWallThickness=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        Twall_start=773.15),
      redeclare Implementations.PowerConversionSystem.PRISM_PCS1
        power_conversion_system,
      redeclare Implementations.EventDriver.PRISM_ED1 eventDriver,
      redeclare Implementations.ControlSystem.PRISM_CS1 controlSystem,
      redeclare Implementations.ElectricalGenerator.PRISM_G1
        singleShaftGenerator);

    inner System system
      annotation (Placement(transformation(extent={{-200,80},{-180,100}})));
    Components.SourceW dRACSin(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      w0=655.19,
      p0=6653000) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-182,10})));
    Components.SinkP dRACSout(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      p0=6653000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-182,-10})));

  equation
    connect(primary_loop.toDRACS, dRACSout.flange) annotation (Line(
        points={{-160,-10},{-172,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(primary_loop.fromDRACS, dRACSin.flange) annotation (Line(
        points={{-160,10},{-172,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));

    connect(controlSystem.controlBus, power_conversion_system.controlBus)
      annotation (Line(
        points={{60,-62},{60,-40},{100,-40},{100,-18.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
              -100},{200,100}}), graphics));
  end Rx2Grid;

  model Rx2Grid2
    import ORNL_AdvSMR;

    import Modelica.Math.Vectors.*;

    extends Architecture.Rx2Grid(
      redeclare
        ORNL_AdvSMR.Implementations.PrimaryHeatTransportSystem.PRISM_PHTS1_noPD
        primary_loop(
        FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
        Q_nom=425e6,
        head_nom=0.675*{9.8553,7.8947},
        alpha_c=-0.013324,
        alpha_f=-0.000989,
        noAxialNodes=20,
        T_f0=773.15,
        T_c0=668.15),
      redeclare
        ORNL_AdvSMR.Implementations.IntermediateHeatExchanger.PRISM_IHX1_fromBase
        intermediate_heat_exchanger(
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellWallThickness=1,
        tubeDiameter=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        tubeWallThickness=1,
        noAxialNodes=20,
        shellHeatTrArea=1,
        tubeHeatTrArea=1,
        Twall_start=773.15),
      redeclare
        ORNL_AdvSMR.Implementations.IntermediateHeatTransportSystem.PRISM_IHTS_simple_noPD
        intermediate_loop,
      redeclare Implementations.EventDriver.PRISM_ED1 eventDriver,
      redeclare ORNL_AdvSMR.Implementations.ControlSystem.PRISM_CS2
        controlSystem,
      redeclare ORNL_AdvSMR.Implementations.SmAHTR.SteamGenerator.SmAHTR_SG1
        steam_generator(
        redeclare package tubeMedium =
            ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
        redeclare package shellMedium = ORNL_AdvSMR.Media.Fluids.Na,
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeFlowArea=1,
        tubePerimeter=1,
        tubeHeatTrArea=1,
        tubeWallThickness=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        Twall_start=573.15),
      redeclare ORNL_AdvSMR.Implementations.PowerConversionSystem.PRISM_PCS1
        power_conversion_system,
      redeclare ORNL_AdvSMR.Implementations.ElectricalGenerator.PRISM_G1
        singleShaftGenerator);

    inner System system
      annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
    Components.SourceW airIn(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      w0=655.19,
      p0=6653000) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-190,10})));
    Components.SinkP airOut(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      p0=6653000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-190,-10})));

    .UserInteraction.Outputs.SpatialPlot spatialPlot(
      y=primary_loop.core.T .- 273.15,
      minX=1,
      x=linspace(
            1,
            20,
            20),
      maxX=20,
      minY=275,
      maxY=525)
      annotation (Placement(transformation(extent={{-216,24},{-44,108}})));
    .UserInteraction.Outputs.SpatialPlot2 spatialPlot2_1(
      y1=intermediate_heat_exchanger.ihx1.shell.T .- 273.15,
      y2=reverse(intermediate_heat_exchanger.ihx1.tube.T) .- 273.15,
      minX1=1,
      minX2=1,
      x1=linspace(
            1,
            20,
            20),
      x2=linspace(
            1,
            20,
            20),
      maxX1=20,
      maxX2=20,
      minY1=190,
      maxY1=550,
      minY2=190,
      maxY2=550)
      annotation (Placement(transformation(extent={{-212,-104},{-78,-16}})));
    .UserInteraction.Outputs.NumericValue numericValue(input_Value=primary_loop.core.T[
          8] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-118,8},{-104,22}})));
    .UserInteraction.Outputs.NumericValue numericValue1(input_Value=
          primary_loop.core.T[1] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-118,-22},{-104,-8}})));
    .UserInteraction.Outputs.NumericValue numericValue2(input_Value=time,
        precision=0)
      annotation (Placement(transformation(extent={{2,44},{22,64}})));

    .UserInteraction.Outputs.NumericValue numericValue3(precision=1,
        input_Value=primary_loop.primaryPump.w)
      annotation (Placement(transformation(extent={{-128,0},{-118,10}})));
    .UserInteraction.Outputs.NumericValue numericValue4(precision=1,
        input_Value=intermediate_loop.intermediatePump.w)
      annotation (Placement(transformation(extent={{-22,-14},{-10,-2}})));
    .UserInteraction.Outputs.IndicatorLamp indicatorLamp(hideConnector=true,
        input_Value=eventDriver.breakerSwitch.y)
      annotation (Placement(transformation(extent={{160,40},{164,36}})));
    .UserInteraction.Outputs.NumericValue numericValue6(precision=1,
        input_Value=singleShaftGenerator.singleShaft_static.frequencySensor.f)
      annotation (Placement(transformation(extent={{160,28},{170,38}})));
    .UserInteraction.Outputs.NumericValue numericValue5(precision=1,
        input_Value=1.22*singleShaftGenerator.singleShaft_static.powerSensor.W/
          1e6)
      annotation (Placement(transformation(extent={{160,22},{170,32}})));
    .UserInteraction.Outputs.NumericValue numericValue7(precision=1,
        input_Value=power_conversion_system.fwPump.w)
      annotation (Placement(transformation(extent={{112,10},{122,20}})));
    .UserInteraction.Outputs.NumericValue numericValue9(precision=0,
        input_Value=primary_loop.reactorKinetics.Q_total/1e6)
      annotation (Placement(transformation(extent={{-150,10},{-132,28}})));
    .UserInteraction.Outputs.NumericValue numericValue8(precision=1,
        input_Value=1000*primary_loop.reactorKinetics.rho_t)
      annotation (Placement(transformation(extent={{-128,-6},{-118,4}})));
    .UserInteraction.Outputs.NumericValue numericValue10(precision=1,
        input_Value=intermediate_heat_exchanger.ihx1.LMTD)
      annotation (Placement(transformation(extent={{-172,-94},{-160,-82}})));
    .UserInteraction.Outputs.SpatialPlot2 spatialPlot2_2(
      minX1=1,
      y1=steam_generator.shell.T .- 273.15,
      y2=reverse(steam_generator.tube.T) .- 273.15,
      minY1=150,
      minX2=1,
      minY2=150,
      maxY1=450,
      maxY2=450,
      x1=linspace(
            1,
            20,
            20),
      x2=linspace(
            1,
            20,
            20),
      maxX1=20,
      maxX2=20)
      annotation (Placement(transformation(extent={{80,-104},{210,-16}})));
    .UserInteraction.Outputs.NumericValue numericValue11(precision=1,
        input_Value=steam_generator.LMTD)
      annotation (Placement(transformation(extent={{120,-94},{132,-82}})));
    .UserInteraction.Outputs.NumericValue numericValue12(precision=1,
        input_Value=power_conversion_system.fwPump.Tin - 273.15)
      annotation (Placement(transformation(extent={{64,-24},{78,-10}})));
    .UserInteraction.Outputs.NumericValue numericValue13(precision=1,
        input_Value=power_conversion_system.hpTurbine.steamState_in.T - 273.15)
      annotation (Placement(transformation(extent={{64,10},{78,24}})));
    .UserInteraction.Outputs.NumericValue numericValue14(precision=1,
        input_Value=power_conversion_system.lpTurbine.steamState_in.T - 273.15)
      annotation (Placement(transformation(extent={{84,-10},{98,4}})));
    .UserInteraction.Outputs.NumericValue numericValue15(precision=1,
        input_Value=intermediate_loop.ihx2SG.T[10] - 273.15)
      annotation (Placement(transformation(extent={{2,8},{16,22}})));
    .UserInteraction.Outputs.NumericValue numericValue16(precision=1,
        input_Value=intermediate_loop.pump2ihx.T[1] - 273.15)
      annotation (Placement(transformation(extent={{2,-16},{16,-2}})));
    .UserInteraction.Outputs.NumericValue numericValue17(precision=1,
        input_Value=intermediate_loop.ihx2SG.T[1] - 273.15)
      annotation (Placement(transformation(extent={{-56,4},{-42,18}})));
    .UserInteraction.Outputs.NumericValue numericValue18(precision=1,
        input_Value=intermediate_loop.pump2ihx.T[10] - 273.15)
      annotation (Placement(transformation(extent={{-56,-16},{-42,-2}})));
  equation
    connect(primary_loop.toDRACS, airOut.flange) annotation (Line(
        points={{-160,-10},{-180,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(primary_loop.fromDRACS, airIn.flange) annotation (Line(
        points={{-160,10},{-180,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(controlSystem.controlBus, singleShaftGenerator.controlBus)
      annotation (Line(
        points={{60,-62},{60,-40},{160,-40},{160,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, power_conversion_system.controlBus)
      annotation (Line(
        points={{-60,-62},{-60,-40},{100,-40},{100,-18.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
              200,100}}), graphics={Text(
              extent={{-126,4},{-134,4}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=8,
              textString="w = "),Text(
              extent={{-20,-8},{-28,-8}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=8,
              textString="w = "),Text(
              extent={{4,54},{-16,54}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=24,
              textString="T  = "),Text(
              extent={{158,38},{142,38}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=10,
              textString="Breaker"),Text(
              extent={{158,26},{128,26}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=10,
              textString="Electrical Output",
              horizontalAlignment=TextAlignment.Right),Text(
              extent={{158,32},{130,32}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=10,
              textString="Grid Frequency",
              horizontalAlignment=TextAlignment.Right),Text(
              extent={{180,26},{172,26}},
              lineColor={0,0,0},
              fontSize=10,
              horizontalAlignment=TextAlignment.Left,
              textString="MW"),Text(
              extent={{178,32},{172,32}},
              lineColor={0,0,0},
              fontSize=10,
              horizontalAlignment=TextAlignment.Left,
              textString="Hz"),Text(
              extent={{114,14},{106,14}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=8,
              textString="w = "),Text(
              extent={{-146,20},{-164,18}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=18,
              textString="Q = "),Text(
              extent={{-126,-2},{-136,-2}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=8,
              textString="rho = "),Text(
              extent={{-172,-88},{-194,-88}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="LMTD = "),Text(
              extent={{120,-88},{98,-88}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="LMTD = "),Text(
              extent={{-196,98},{-98,92}},
              lineColor={0,0,0},
              textString="Core Average Channel Temperature Profile",
              textStyle={TextStyle.Bold}),Text(
              extent={{-194,-26},{-96,-32}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              textString="Intermediate Heat Exchanger Temperature Profile"),
            Text(
              extent={{90,-26},{188,-32}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              textString="Steam Generator Temperature Profile"),Text(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              textString="oC",
              origin={-202,65},
              rotation=90),Text(
              extent={{-7.5,3.5},{7.5,-3.5}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              textString="oC",
              origin={-203.5,-61.5},
              rotation=90),Text(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              textString="oC",
              origin={90,-63},
              rotation=90),Text(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              origin={-128,17},
              rotation=180,
              textString="MW"),Text(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              origin={-101,16},
              rotation=180,
              textString="oC"),Text(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              origin={-101,-14},
              rotation=180,
              textString="oC"),Text(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              origin={-39,12},
              rotation=180,
              textString="oC"),Text(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              origin={-39,-10},
              rotation=180,
              textString="oC"),Text(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              origin={19,16},
              rotation=180,
              textString="oC"),Text(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              origin={19,-8},
              rotation=180,
              textString="oC"),Text(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              origin={81,18},
              rotation=180,
              textString="oC"),Text(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              origin={81,-16},
              rotation=180,
              textString="oC"),Text(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              origin={101,-4},
              rotation=180,
              textString="oC"),Text(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              origin={28,53},
              rotation=180,
              textString="sec."),Text(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              origin={-113,4},
              rotation=180,
              textString="kg/s"),Text(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              origin={127,14},
              rotation=180,
              textString="kg/s"),Text(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              origin={-157,-88},
              rotation=180,
              textString="oC"),Text(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              origin={135,-88},
              rotation=180,
              textString="oC"),Text(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              origin={-5,-8},
              rotation=180,
              textString="kg/s")}),
      experiment(
        StopTime=5000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=0.001,
        __Dymola_Algorithm="Cvode"),
      __Dymola_experimentSetupOutput);
  end Rx2Grid2;

  model Rx2Grid2_wCS
    import ORNL_AdvSMR;

    import Modelica.Math.Vectors.*;

    extends Architecture.Rx2Grid(
      redeclare
        ORNL_AdvSMR.Implementations.PrimaryHeatTransportSystem.PRISM_PHTS1_noRx_sensors
        primary_loop(
        H_fuelPin=4.0132,
        H_coreChannel=4.0132,
        FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
        Q_nom=425e6/2),
      redeclare
        ORNL_AdvSMR.Implementations.IntermediateHeatExchanger.PRISM_IHX1_fromBase
        intermediate_heat_exchanger(
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeDiameter=1,
        tubeHeatTrArea=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        tubeWallThickness=1,
        Twall_start=773.15),
      redeclare
        ORNL_AdvSMR.Implementations.IntermediateHeatTransportSystem.PRISM_IHTS_simple_noPD
        intermediate_loop(nNodes=20),
      redeclare Implementations.EventDriver.PRISM_ED1 eventDriver,
      redeclare ORNL_AdvSMR.Implementations.ControlSystem.PRISM_CS1
        controlSystem,
      redeclare Implementations.SteamGenerator.PRISM_SteamGenerator1
        steam_generator(
        redeclare package tubeMedium =
            ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
        redeclare package shellMedium = ORNL_AdvSMR.Media.Fluids.Na,
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeFlowArea=1,
        tubePerimeter=1,
        tubeHeatTrArea=1,
        tubeWallThickness=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        Twall_start=573.15),
      redeclare
        ORNL_AdvSMR.Implementations.PowerConversionSystem.PRISM_PCS1_noCond
        power_conversion_system,
      redeclare ORNL_AdvSMR.Implementations.ElectricalGenerator.PRISM_G1
        singleShaftGenerator);

    inner System system
      annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
    Components.SourceW airIn(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      w0=655.19,
      p0=6653000) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-190,10})));
    Components.SinkP airOut(
      redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=1248.31e3,
      p0=6653000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-190,-10})));

    .UserInteraction.Outputs.SpatialPlot spatialPlot(
      x=linspace(
            0,
            1,
            8),
      minX=0,
      maxX=1,
      y=primary_loop.core.T .- 273.15,
      minY=300,
      maxY=500)
      annotation (Placement(transformation(extent={{-210,24},{-70,106}})));
    .UserInteraction.Outputs.SpatialPlot2 spatialPlot2_1(
      maxY1=600,
      maxY2=600,
      minY1=200,
      minY2=200,
      y1=intermediate_heat_exchanger.ihx1.shell.T .- 273.15,
      y2=reverse(intermediate_heat_exchanger.ihx1.tube.T) .- 273.15,
      x1=linspace(
            0,
            1,
            20),
      x2=linspace(
            0,
            1,
            20))
      annotation (Placement(transformation(extent={{-208,-104},{-84,-16}})));
    .UserInteraction.Outputs.NumericValue numericValue(input_Value=primary_loop.core.T[
          8] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-118,8},{-104,22}})));
    .UserInteraction.Outputs.NumericValue numericValue1(input_Value=
          primary_loop.core.T[1] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-118,-12},{-104,2}})));
    .UserInteraction.Outputs.NumericValue numericValue2(precision=1,
        input_Value=time)
      annotation (Placement(transformation(extent={{-20,44},{0,64}})));

    .UserInteraction.Outputs.NumericValue numericValue3(precision=1,
        input_Value=primary_loop.primaryPump.w)
      annotation (Placement(transformation(extent={{-134,10},{-120,24}})));
    .UserInteraction.Outputs.NumericValue numericValue4(precision=1,
        input_Value=intermediate_loop.intermediatePump.w)
      annotation (Placement(transformation(extent={{-14,10},{0,24}})));
    .UserInteraction.Outputs.DynamicDiagram dynamicDiagram(Value=eventDriver.w_fw.y)
      annotation (Placement(transformation(extent={{120,60},{200,100}})));
    .UserInteraction.Outputs.IndicatorLamp indicatorLamp(hideConnector=true,
        input_Value=eventDriver.breakerSwitch.y)
      annotation (Placement(transformation(extent={{160,40},{164,36}})));
    .UserInteraction.Outputs.NumericValue numericValue6(precision=1,
        input_Value=singleShaftGenerator.singleShaft_static.frequencySensor.f)
      annotation (Placement(transformation(extent={{160,28},{168,36}})));
    .UserInteraction.Outputs.NumericValue numericValue5(precision=1,
        input_Value=singleShaftGenerator.singleShaft_static.powerSensor.W/1e6)
      annotation (Placement(transformation(extent={{160,22},{168,30}})));
  equation
    connect(primary_loop.toDRACS, airOut.flange) annotation (Line(
        points={{-160,-10},{-180,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(primary_loop.fromDRACS, airIn.flange) annotation (Line(
        points={{-160,10},{-180,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(controlSystem.controlBus, singleShaftGenerator.controlBus)
      annotation (Line(
        points={{60,-62},{60,-40},{160,-40},{160,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, power_conversion_system.controlBus)
      annotation (Line(
        points={{-60,-62},{-60,-40},{100,-40},{100,-18.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
              200,100}}), graphics={Text(
              extent={{-132,18},{-142,18}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="w = "),Text(
              extent={{-12,18},{-22,18}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="w = "),Text(
              extent={{-22,54},{-36,54}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=24,
              textString="T  = "),Text(
              extent={{158,38},{148,38}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=10,
              textString="Breaker"),Text(
              extent={{158,26},{136,26}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=10,
              textString="Electrical Output",
              horizontalAlignment=TextAlignment.Right),Text(
              extent={{158,32},{138,32}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=10,
              textString="Grid Frequency",
              horizontalAlignment=TextAlignment.Right),Text(
              extent={{176,26},{170,26}},
              lineColor={0,0,0},
              fontSize=10,
              horizontalAlignment=TextAlignment.Left,
              textString="MW"),Text(
              extent={{176,32},{170,32}},
              lineColor={0,0,0},
              fontSize=10,
              horizontalAlignment=TextAlignment.Left,
              textString="Hz")}),
      experiment(
        StopTime=1000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=1e-006,
        __Dymola_Algorithm="Dassl"),
      __Dymola_experimentSetupOutput);
  end Rx2Grid2_wCS;

  model PRISM_EndToEnd
    import ORNL_AdvSMR;

    import Modelica.Math.Vectors.*;

    extends Architecture.EndToEnd(
      redeclare
        ORNL_AdvSMR.Implementations.PrimaryHeatTransportSystem.PRISM_PHTS1_noPD
        primary_loop(
        FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
        head_nom=0.81*{9.8553,7.8947},
        noAxialNodes=20,
        Q_nom=425e6/2,
        alpha_c=-0*0.013324,
        alpha_f=-0*0.000989,
        T_f0=773.15,
        T_c0=670.15),
      redeclare
        ORNL_AdvSMR.Implementations.IntermediateHeatExchanger.PRISM_IHX1_fromBase
        intermediate_heat_exchanger(
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellWallThickness=1,
        tubeDiameter=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        tubeWallThickness=1,
        noAxialNodes=20,
        shellHeatTrArea=1,
        tubeHeatTrArea=1,
        Twall_start=773.15),
      redeclare
        ORNL_AdvSMR.Implementations.IntermediateHeatTransportSystem.PRISM_IHTS_simple_noPD
        intermediate_loop(nNodes=20),
      redeclare Implementations.EventDriver.PRISM_ED1 eventDriver,
      redeclare ORNL_AdvSMR.Implementations.ControlSystem.PRISM_CS2
        controlSystem,
      redeclare Implementations.SteamGenerator.PRISM_SteamGenerator1
        steam_generator(
        redeclare package tubeMedium =
            ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
        redeclare package shellMedium = ORNL_AdvSMR.Media.Fluids.Na,
        flowPathLength=1,
        shellDiameter=1,
        shellFlowArea=1,
        shellPerimeter=1,
        shellHeatTrArea=1,
        shellWallThickness=1,
        tubeFlowArea=1,
        tubePerimeter=1,
        tubeHeatTrArea=1,
        tubeWallThickness=1,
        tubeWallRho=1,
        tubeWallCp=1,
        tubeWallK=1,
        Twall_start=573.15),
      redeclare
        ORNL_AdvSMR.Implementations.PowerConversionSystem.PRISM_PCS1_noCond
        power_conversion_system,
      redeclare ORNL_AdvSMR.Implementations.ElectricalGenerator.PRISM_G1
        singleShaftGenerator,
      redeclare ORNL_AdvSMR.Implementations.DRACS.NoDRACS dracs(redeclare
          package DRACSFluid = ORNL_AdvSMR.Media.Fluids.Na, redeclare package
          Air = Modelica.Media.Air.SimpleAir));

    inner System system
      annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));

    .UserInteraction.Outputs.SpatialPlot spatialPlot(
      y=primary_loop.core.T .- 273.15,
      minY=250,
      maxY=550,
      x=linspace(
            1,
            20,
            20),
      minX=1,
      maxX=20)
      annotation (Placement(transformation(extent={{-210,24},{-70,106}})));
    .UserInteraction.Outputs.SpatialPlot2 spatialPlot2_1(
      maxY1=600,
      maxY2=600,
      minY1=200,
      minY2=200,
      y1=intermediate_heat_exchanger.ihx1.shell.T .- 273.15,
      y2=reverse(intermediate_heat_exchanger.ihx1.tube.T) .- 273.15,
      minX1=1,
      minX2=1,
      x1=linspace(
            1,
            20,
            20),
      x2=linspace(
            1,
            20,
            20),
      maxX1=20,
      maxX2=20)
      annotation (Placement(transformation(extent={{-208,-104},{-84,-16}})));
    .UserInteraction.Outputs.NumericValue numericValue(input_Value=primary_loop.core.T[
          8] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-98,8},{-84,22}})));
    .UserInteraction.Outputs.NumericValue numericValue1(input_Value=
          primary_loop.core.T[1] - 273.15, precision=1)
      annotation (Placement(transformation(extent={{-98,-12},{-84,2}})));
    .UserInteraction.Outputs.NumericValue numericValue2(precision=1,
        input_Value=time)
      annotation (Placement(transformation(extent={{0,44},{20,64}})));

    .UserInteraction.Outputs.NumericValue numericValue3(precision=1,
        input_Value=primary_loop.primaryPump.w)
      annotation (Placement(transformation(extent={{-114,10},{-100,24}})));
    .UserInteraction.Outputs.NumericValue numericValue4(precision=1,
        input_Value=intermediate_loop.intermediatePump.w)
      annotation (Placement(transformation(extent={{6,10},{20,24}})));
    .UserInteraction.Outputs.IndicatorLamp indicatorLamp(hideConnector=true,
        input_Value=eventDriver.breakerSwitch.y)
      annotation (Placement(transformation(extent={{180,40},{184,36}})));
    .UserInteraction.Outputs.NumericValue numericValue6(precision=1,
        input_Value=singleShaftGenerator.singleShaft_static.frequencySensor.f)
      annotation (Placement(transformation(extent={{180,28},{188,36}})));
    .UserInteraction.Outputs.NumericValue numericValue5(precision=1,
        input_Value=1.22*singleShaftGenerator.singleShaft_static.powerSensor.W/
          1e6)
      annotation (Placement(transformation(extent={{180,22},{188,30}})));
    .UserInteraction.Outputs.NumericValue numericValue7(precision=1,
        input_Value=power_conversion_system.fwPump.w)
      annotation (Placement(transformation(extent={{126,10},{140,24}})));
    .UserInteraction.Outputs.SpatialPlot spatialPlot1(
      x=linspace(
            0,
            1,
            8),
      minX=0,
      maxX=1,
      y=primary_loop.fuelPin.fp[4].T_f .- 273.15,
      maxY=410,
      minY=370)
      annotation (Placement(transformation(extent={{66,34},{210,104}})));
    .UserInteraction.Outputs.NumericValue numericValue9(precision=0,
        input_Value=primary_loop.reactorKinetics.Q_total/1e6)
      annotation (Placement(transformation(extent={{-140,8},{-122,26}})));
    .UserInteraction.Outputs.NumericValue numericValue8(precision=1,
        input_Value=1000*primary_loop.reactorKinetics.rho_t)
      annotation (Placement(transformation(extent={{-140,-4},{-128,8}})));
    .UserInteraction.Outputs.NumericValue numericValue10(precision=1,
        input_Value=intermediate_heat_exchanger.ihx1.LMTD)
      annotation (Placement(transformation(extent={{-176,-94},{-164,-82}})));
    .UserInteraction.Outputs.SpatialPlot2 spatialPlot2_2(
      minX1=1,
      y1=steam_generator.shell.T .- 273.15,
      y2=reverse(steam_generator.tube.T) .- 273.15,
      minY1=150,
      minX2=1,
      minY2=150,
      maxY1=450,
      maxY2=450,
      x1=linspace(
            1,
            20,
            20),
      x2=linspace(
            1,
            20,
            20),
      maxX1=20,
      maxX2=20)
      annotation (Placement(transformation(extent={{84,-104},{208,-16}})));
    .UserInteraction.Outputs.NumericValue numericValue11(precision=1,
        input_Value=steam_generator.LMTD)
      annotation (Placement(transformation(extent={{116,-94},{128,-82}})));
  equation
    connect(controlSystem.controlBus, singleShaftGenerator.controlBus)
      annotation (Line(
        points={{78,-62},{78,-40},{180,-40},{180,-18}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(eventDriver.controlBus, power_conversion_system.controlBus)
      annotation (Line(
        points={{-44,-62},{-44,-40},{120,-40},{120,-18.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
              200,100}}), graphics={Text(
              extent={{-112,18},{-122,18}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="w = "),Text(
              extent={{8,18},{-2,18}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="w = "),Text(
              extent={{-2,54},{-16,54}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=24,
              textString="T  = "),Text(
              extent={{178,38},{168,38}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=10,
              textString="Breaker"),Text(
              extent={{178,26},{156,26}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=10,
              textString="Electrical Output",
              horizontalAlignment=TextAlignment.Right),Text(
              extent={{178,32},{158,32}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=10,
              textString="Grid Frequency",
              horizontalAlignment=TextAlignment.Right),Text(
              extent={{196,26},{190,26}},
              lineColor={0,0,0},
              fontSize=10,
              horizontalAlignment=TextAlignment.Left,
              textString="MW"),Text(
              extent={{196,32},{190,32}},
              lineColor={0,0,0},
              fontSize=10,
              horizontalAlignment=TextAlignment.Left,
              textString="Hz"),Text(
              extent={{128,18},{118,18}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="w = "),Text(
              extent={{-140,18},{-152,18}},
              lineColor={255,0,0},
              textStyle={TextStyle.Bold},
              fontSize=24,
              textString="Q = "),Text(
              extent={{-142,2},{-152,2}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="rho = "),Text(
              extent={{-178,-88},{-192,-88}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="LMTD = "),Text(
              extent={{114,-88},{100,-88}},
              lineColor={0,0,0},
              textStyle={TextStyle.Bold},
              fontSize=14,
              textString="LMTD = ")}),
      experiment(
        StopTime=5000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=1e-006,
        __Dymola_Algorithm="Dassl"),
      __Dymola_experimentSetupOutput);
  end PRISM_EndToEnd;

  package ALMR_PRISM
  end ALMR_PRISM;

  package SmAHTR
    model End2End
      import ORNL_AdvSMR;

      import Modelica.Math.Vectors.*;

      extends Architecture.SmAHTR.EndToEnd(
        redeclare
          ORNL_AdvSMR.Implementations.SmAHTR.PrimaryHeatTransportSystem.smAHTR_PHTS_0
          primary_loop,
        redeclare
          ORNL_AdvSMR.Implementations.SmAHTR.IntermediateHeatExchanger.SmAHTR_IHX
          intermediate_heat_exchanger(
          shellDiameter=1,
          shellFlowArea=1,
          shellPerimeter=1,
          shellWallThickness=1,
          tubeDiameter=1,
          tubeWallRho=1,
          tubeWallCp=1,
          tubeWallK=1,
          tubeWallThickness=1,
          noAxialNodes=20,
          shellHeatTrArea=1,
          tubeHeatTrArea=1,
          Twall_start=773.15),
        redeclare
          ORNL_AdvSMR.Implementations.SmAHTR.IntermediateHeatTransportSystem.SmAHTR_IHTS1_noPD
          intermediate_loop,
        redeclare Implementations.EventDriver.PRISM_ED1 eventDriver,
        redeclare ORNL_AdvSMR.Implementations.ControlSystem.PRISM_CS2
          controlSystem,
        redeclare ORNL_AdvSMR.Implementations.SmAHTR.SteamGenerator.SmAHTR_SG1
          steam_generator(
          redeclare package tubeMedium =
              ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
          redeclare package shellMedium = ORNL_AdvSMR.Media.Fluids.Na,
          flowPathLength=1,
          shellDiameter=1,
          shellFlowArea=1,
          shellPerimeter=1,
          shellHeatTrArea=1,
          shellWallThickness=1,
          tubeFlowArea=1,
          tubePerimeter=1,
          tubeHeatTrArea=1,
          tubeWallThickness=1,
          tubeWallRho=1,
          tubeWallCp=1,
          tubeWallK=1,
          Twall_start=573.15),
        redeclare ORNL_AdvSMR.Implementations.PowerConversionSystem.PRISM_PCS1
          power_conversion_system,
        redeclare ORNL_AdvSMR.Implementations.ElectricalGenerator.PRISM_G1
          singleShaftGenerator,
        redeclare ORNL_AdvSMR.Implementations.SmAHTR.DRACS.DRACS_1 dracs);

      inner System system
        annotation (Placement(transformation(extent={{180,80},{200,100}})));

    equation
      connect(controlSystem.controlBus, singleShaftGenerator.controlBus)
        annotation (Line(
          points={{80,-42},{80,-20},{180,-20},{180,2}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(eventDriver.controlBus, power_conversion_system.controlBus)
        annotation (Line(
          points={{-40,-42},{-40,-20},{120,-20},{120,1.2}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
                {200,100}}), graphics={Text(
                  extent={{-5,2},{5,-2}},
                  lineColor={0,0,0},
                  origin={-101,-14},
                  rotation=180,
                  textString="oC")}),
        experiment(
          StopTime=5000,
          __Dymola_NumberOfIntervals=1000,
          Tolerance=0.001,
          __Dymola_Algorithm="Cvode"),
        __Dymola_experimentSetupOutput);
    end End2End;

    model SmAHTRHydrogen "SmAHTR architecture for hydrogen production"
      import ORNL_AdvSMR;

      import Modelica.Math.Vectors.*;

      extends Architecture.SmAHTR.SmAHTRHydrogen(
        redeclare
          ORNL_AdvSMR.Implementations.SmAHTR.PrimaryHeatTransportSystem.smAHTR_PHTS_0
          primary_loop,
        redeclare
          ORNL_AdvSMR.Implementations.SmAHTR.IntermediateHeatExchanger.SmAHTR_IHX
          intermediate_heat_exchanger(
          shellDiameter=1,
          shellFlowArea=1,
          shellPerimeter=1,
          shellWallThickness=1,
          tubeDiameter=1,
          tubeWallRho=1,
          tubeWallCp=1,
          tubeWallK=1,
          tubeWallThickness=1,
          noAxialNodes=20,
          shellHeatTrArea=1,
          tubeHeatTrArea=1,
          Twall_start=773.15),
        redeclare
          ORNL_AdvSMR.Implementations.SmAHTR.IntermediateHeatTransportSystem.SmAHTR_IHTS1
          intermediate_loop,
        redeclare ORNL_AdvSMR.Implementations.SmAHTR.SteamGenerator.SmAHTR_SG1
          steam_generator(
          redeclare package tubeMedium =
              ORNL_AdvSMR.Media.Fluids.Water.StandardWater,
          redeclare package shellMedium = ORNL_AdvSMR.Media.Fluids.Na,
          flowPathLength=1,
          shellDiameter=1,
          shellFlowArea=1,
          shellPerimeter=1,
          shellHeatTrArea=1,
          shellWallThickness=1,
          tubeFlowArea=1,
          tubePerimeter=1,
          tubeHeatTrArea=1,
          tubeWallThickness=1,
          tubeWallRho=1,
          tubeWallCp=1,
          tubeWallK=1,
          Twall_start=573.15),
        redeclare ORNL_AdvSMR.Implementations.SmAHTR.DRACS.DRACS_1 dracs);

      inner System system
        annotation (Placement(transformation(extent={{180,80},{200,100}})));

      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
                {200,100}}), graphics),
        experiment(
          StopTime=5000,
          __Dymola_NumberOfIntervals=1000,
          Tolerance=0.001,
          __Dymola_Algorithm="Cvode"),
        __Dymola_experimentSetupOutput);
    end SmAHTRHydrogen;
  end SmAHTR;

  package AHTR
  end AHTR;
end PlantSystems;
