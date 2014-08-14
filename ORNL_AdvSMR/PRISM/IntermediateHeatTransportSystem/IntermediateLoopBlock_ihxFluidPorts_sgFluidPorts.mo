within ORNL_AdvSMR.PRISM.IntermediateHeatTransportSystem;
model IntermediateLoopBlock_ihxFluidPorts_sgFluidPorts

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  // number of Nodes
  parameter Integer nNodes=9 "Number of axial nodes";

  Components.Pump intermediatePump(
    redeclare package Medium = Medium,
    rho0=950,
    usePowerCharacteristic=false,
    redeclare function efficiencyCharacteristic =
        ORNL_AdvSMR.Functions.PumpCharacteristics.constantEfficiency (eta_nom=
            0.95),
    n0=1400,
    w0=1152.9,
    hstart=28.8858e3 + 1.2753e3*(282 + 273),
    wstart=1152.9,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    V=11.45,
    dp0(displayUnit="kPa") = 250000,
    Np0=1,
    redeclare function flowCharacteristic =
        ORNL_AdvSMR.Functions.PumpCharacteristics.linearFlow (q_nom={1.2618,
            2.5236}, head_nom={37.45,30})) annotation (Placement(transformation(
          extent={{15,-97},{-5,-77}}, rotation=0)));

  Components.SodiumExpansionTank sodiumExpansionTank(
    redeclare package Medium = Medium,
    hstart=28.8858e3 + 1.2753e3*(427 + 273),
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    A=11.401,
    V0=18.241,
    pext=100000,
    ystart=2.5)
    annotation (Placement(transformation(extent={{-15,70},{15,100}})));

  Components.SensT riserTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-60})));

  Components.SensT riserTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-79,35})));

  Components.SensT dcTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={74,29.5})));

  Components.SensT dcTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={74,-40})));

  Components.PipeFlow sgTube(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer (alpha0=
            5000),
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    nNodes=nNodes,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    L=5.04,
    wnom=1152.9,
    rhonom=950,
    A=Modelica.Constants.pi*13.3919e-3^2/4,
    omega=Modelica.Constants.pi*13.3919e-3,
    Dhyd=13.3919e-3,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    H=-5.04,
    hstartin=28.8858e3 + 1.2753e3*(427 + 273),
    hstartout=28.8858e3 + 1.2753e3*(282 + 273),
    Nt=2139,
    dpnom(displayUnit="kPa") = 27500,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=270,
        origin={70,0})));

  Components.PipeFlow ihx2up(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    dpnom(displayUnit="kPa") = 1,
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer (alpha0=
            5000),
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    hstartout=28.8858e3 + 1.2753e3*(427 + 273),
    wnom=1152.9,
    rhonom=950,
    Dhyd=13.3919e-3,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    Nt=1,
    A=2139*Modelica.Constants.pi*13.3919e-3^2/4,
    omega=2139*Modelica.Constants.pi*13.3919e-3,
    H=0,
    hstartin=28.8858e3 + 1.2753e3*(427 + 273),
    nNodes=3,
    L=1,
    pstart=100000) annotation (Placement(transformation(
        extent={{15,15},{-15,-15}},
        rotation=180,
        origin={-45,74.5})));
  Components.PipeFlow pump2ihx(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    dpnom(displayUnit="kPa") = 1,
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer (alpha0=
            5000),
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    hstartin=28.8858e3 + 1.2753e3*(282 + 273),
    wnom=1152.9,
    rhonom=950,
    Dhyd=13.3919e-3,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    Nt=1,
    A=2139*Modelica.Constants.pi*13.3919e-3^2/4,
    omega=2139*Modelica.Constants.pi*13.3919e-3,
    H=0,
    hstartout=28.8858e3 + 1.2753e3*(282 + 273),
    nNodes=3,
    L=1,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,15},{15,-15}},
        rotation=180,
        origin={-25,-80})));
  Components.PipeFlow up2sg(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    dpnom(displayUnit="kPa") = 1,
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer (alpha0=
            5000),
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    hstartout=28.8858e3 + 1.2753e3*(427 + 273),
    wnom=1152.9,
    rhonom=950,
    Dhyd=13.3919e-3,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    Nt=1,
    A=2139*Modelica.Constants.pi*13.3919e-3^2/4,
    omega=2139*Modelica.Constants.pi*13.3919e-3,
    H=0,
    hstartin=28.8858e3 + 1.2753e3*(427 + 273),
    nNodes=3,
    L=1,
    pstart=100000) annotation (Placement(transformation(
        extent={{15,15},{-15,-15}},
        rotation=180,
        origin={40,74.5})));
  Components.PipeFlow sg2pump(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    dpnom(displayUnit="kPa") = 1,
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer (alpha0=
            5000),
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    hstartin=28.8858e3 + 1.2753e3*(282 + 273),
    wnom=1152.9,
    rhonom=950,
    Dhyd=13.3919e-3,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    Nt=1,
    A=2139*Modelica.Constants.pi*13.3919e-3^2/4,
    omega=2139*Modelica.Constants.pi*13.3919e-3,
    H=0,
    hstartout=28.8858e3 + 1.2753e3*(282 + 273),
    nNodes=3,
    L=1,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,15},{15,-15}},
        rotation=180,
        origin={40,-85})));
  Modelica.Fluid.Fittings.Bends.CurvedBend sgOutTurn(redeclare package Medium
      = Medium, geometry(d_hyd=2139*13.3919e-3, R_0=0.5)) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={70,-75})));
  Modelica.Fluid.Fittings.Bends.CurvedBend ihxInTurn(redeclare package Medium
      = Medium, geometry(d_hyd=2139*13.3919e-3, R_0=0.15)) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-60,-80})));
  Modelica.Fluid.Fittings.Bends.CurvedBend ihxOutTurn(redeclare package Medium
      = Medium, geometry(d_hyd=2139*13.3919e-3, R_0=0.15)) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-75,60})));
  Modelica.Fluid.Fittings.Bends.CurvedBend upOutTurn(redeclare package Medium
      = Medium, geometry(d_hyd=2139*13.3919e-3, R_0=0.15)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,59.5})));
  Interfaces.FlangeA ihxIn(redeclare package Medium =
        ORNL_AdvSMR.Media.Fluids.Na) annotation (Placement(transformation(
          extent={{-110,-55},{-90,-35}}), iconTransformation(extent={{-107.5,75},
            {-92.5,90}})));
  Interfaces.FlangeB ihxOut(redeclare package Medium =
        ORNL_AdvSMR.Media.Fluids.Na) annotation (Placement(transformation(
          extent={{-110,5.5},{-90,25.5}}), iconTransformation(extent={{-107.5,
            50},{-92.5,65}})));
  Interfaces.FlangeA sgIn(redeclare package Medium =
        ORNL_AdvSMR.Media.Fluids.Na) annotation (Placement(transformation(
          extent={{89,-94},{109,-74}}), iconTransformation(extent={{90,-90},{
            105,-75}})));
  Interfaces.FlangeB sgOut(redeclare package Medium =
        ORNL_AdvSMR.Media.Fluids.Na) annotation (Placement(transformation(
          extent={{90,-69},{110,-49}}), iconTransformation(extent={{90,-65},{
            105,-50}})));
equation

  connect(dcTi.outlet, sgTube.infl) annotation (Line(
      points={{70,23.5},{70,15}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sgTube.outfl, dcTo.inlet) annotation (Line(
      points={{70,-15},{70,-34}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));

  connect(pump2ihx.infl, intermediatePump.outfl) annotation (Line(
      points={{-10,-80},{-1,-80}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sg2pump.outfl, intermediatePump.infl) annotation (Line(
      points={{25,-85},{13,-85}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(dcTo.outlet, sgOutTurn.port_a) annotation (Line(
      points={{70,-46},{70,-65}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sgOutTurn.port_b, sg2pump.infl) annotation (Line(
      points={{70,-85},{55,-85}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ihxInTurn.port_a, pump2ihx.outfl) annotation (Line(
      points={{-50,-80},{-40,-80}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(riserTi.inlet, ihxInTurn.port_b) annotation (Line(
      points={{-76,-66},{-76,-80},{-70,-80}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ihx2up.outfl, sodiumExpansionTank.inlet) annotation (Line(
      points={{-30,74.5},{-10.5,74.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ihxOutTurn.port_b, ihx2up.infl) annotation (Line(
      points={{-75,70},{-75,74.5},{-60,74.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(up2sg.infl, sodiumExpansionTank.outlet) annotation (Line(
      points={{25,74.5},{10.5,74.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(up2sg.outfl, upOutTurn.port_a) annotation (Line(
      points={{55,74.5},{70,74.5},{70,69.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(upOutTurn.port_b, dcTi.inlet) annotation (Line(
      points={{70,49.5},{70,35.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ihxOutTurn.port_a, riserTo.outlet) annotation (Line(
      points={{-75,50},{-75,41}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ihxOut, riserTo.inlet) annotation (Line(
      points={{-100,15.5},{-75,15.5},{-75,29}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(ihxIn, riserTi.outlet) annotation (Line(
      points={{-100,-45},{-76,-45},{-76,-54}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={175,175,175},
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          radius=4),Bitmap(
          extent={{-90,90},{90,-60}},
          imageSource=
            "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Ai1CQApEiypLogoBISAEhIAQaAoCUiCaUhOSQwgIASEgBIRAixCQAtGiypKoQkAICAEhIASagkCmAnHnnXc2RUbJIQSEgBAQAkJACDQMAX2Ns2EVInGEgBAQAkJACLQBgUwLRBuEl4xCQAgIASEgBIRAPQhIgagHd+UqBISAEBACQqDVCMxrtfQSXggIgWAIfP/73x/wetvb3ha95z3vGVzrRAgIASGQREAKRBIRXQuBHiKA8rBkyZLKSr7jjjtGL7zwQrTrrrtGixYtin71q19FmzZtigh/17ve5c4POOCACEXGpyeffDJ64IEHojVr1kSnn366f0vnQkAIVIyAFIiKAVd2QqDpCKxatSrabbfdcol5//33u7hPPPGEO771rW+NCIP22Wcfd/7SSy+5axQFOv8sOvjggwe37By+KA077LCD4/8///M/Lg4Kh0gICIF6EZACUS/+yl0INAoBRv1nn312o2TyhVm7dm10yimn+EE6FwKpCPzyl790FqykFSs1sgInQkAKxESwKZEQ6CYCamy7Wa99LBVTYaJyEdAqjHLxFXch0BkEfvaznznrhD99cMIJJ7gwrBb8mHKAGP3ho/DBD37Q/WxjOtISj3DS2nTHtddeG11wwQUDrNavXz8490/wmRAJASHQDASkQDSjHiSFEGg8AkcffXS0evXqoY7+sssuc6s1UAZQMM477zxXDhQErBk4Z6IwmKIAD4hw0hx33HHuGuVhxYoVLpwAC3c3vb+8vhleEp0KASFQEgLzSuIrtkJACDQIAUb+dPBZRIc+iuz+xo0bXcePUmBkygJ54DhJ3IcfftgpDsThPoRV4rbbbnP3uSbcLBZcn3baaY438URCQAg0HwEpEM2vI0koBKZG4JxzzonOP//8iflgWVi4cKGzKrD8EmfGk08+2fH7zGc+45QBVkvsvvvubmkmN1588cWIVRmk3bBhQ3T99dfPyh+Lgk1vYJ145ZVXopUrV86KpwAhIASah4AUiObViSQSAsERoCOH2GeBqYOksyRWA6wDaVYKLAK33377YOoCSwE+CqZAmL/CtttuG2GhuPjii6Pjjz8+uuSSS5wfBAoBFguUBcLXrVvnZMBiwfLMgw46aFBe0mKZEAkBIdB8BKRANL+OJKEQCIYAu0v6zorGGCVhzz33zNx9kjQoHhAdvCkNbOhkhAXBPN+Jz882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"
             +
            "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",
          fileName="modelica://ORNL_AdvSMR/Icons/IHTS.png"),Rectangle(extent={{
          -90,90},{90,-60}}, lineColor={175,175,175}),Text(
          extent={{-100,-75},{100,-90}},
          lineColor={64,64,64},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="INTERMEDIATE
HEAT  TRANSPORT  SYSTEM")}),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end IntermediateLoopBlock_ihxFluidPorts_sgFluidPorts;
