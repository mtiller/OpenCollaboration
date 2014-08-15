within Ethan2;
model FHR_PCS_Null "Null implementation for FHR PCS"
  extends ORNL_AdvSMR.Interfaces.PowerConversionSystem;
  ORNL_AdvSMR.Components.SinkP sinkP
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  ORNL_AdvSMR.Components.SourceW sourceW
    annotation (Placement(transformation(extent={{-32,-70},{-52,-50}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed shaftSpeed(
      w_fixed=314.16/2, useSupport=false) annotation (Placement(
        transformation(extent={{6,-20},{46,20}},     rotation=0)));
equation
  connect(sinkP.flange, steamInlet) annotation (Line(
      points={{-50,60},{-100,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sourceW.flange, condensateReturn) annotation (Line(
      points={{-52,-60},{-100,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(shaftSpeed.flange, rotorShaft) annotation (Line(
      points={{46,0},{100,0}},
      color={0,0,0},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}), graphics));
end FHR_PCS_Null;
