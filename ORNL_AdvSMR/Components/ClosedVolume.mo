within ORNL_AdvSMR.Components;
model ClosedVolume
  "Volume of fixed size, closed to the ambient, with inlet/outlet ports"
  import Modelica.Constants.pi;

  // Mass and energy balance, ports
  extends ORNL_AdvSMR.Components.BaseClasses.PartialLumpedVessel(
    final fluidVolume=V,
    vesselArea=pi*(3/4*V)^(2/3),
    heatTransfer(surfaceAreas={4*pi*(3/4*V/pi)^(2/3)}));

  parameter Modelica.SIunits.Volume V "Volume";

  Modelica.SIunits.Temperature T "Average tank temperature";

equation
  Wb_flow = 0;
  for i in 1:nPorts loop
    vessel_ps_static[i] = medium.p;
  end for;

  T = heatTransfer.states[1].T;

  annotation (
    defaultComponentName="volume",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={170,213,255}),Text(
          extent={{-150,12},{150,-18}},
          lineColor={0,0,0},
          textString="V=%V")}),
    Documentation(info="<html>
<p>
Ideally mixed volume of constant size with two fluid ports and one medium model.
The flow properties are computed from the upstream quantities, pressures are equal in both nodes and the medium model if <code>use_portsData=false</code>.
Heat transfer through a thermal port is possible, it equals zero if the port remains unconnected.
A spherical shape is assumed for the heat transfer area, with V=4/3*pi*r^3, A=4*pi*r^2.
Ideal heat transfer is assumed per default; the thermal port temperature is equal to the medium temperature.
</p>
<p>
If <code>use_portsData=true</code>, the port pressures represent the pressures just after the outlet (or just before the inlet) in the attached pipe.
The hydraulic resistances <code>portsData.zeta_in</code> and <code>portsData.zeta_out</code> determine the dissipative pressure drop between volume and port depending on
the direction of mass flow. See <a href=\"modelica://Modelica.Fluid.Vessels.BaseClasses.VesselPortsData\">VesselPortsData</a> and <i>[Idelchik, Handbook of Hydraulic Resistance, 2004]</i>.
</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=true,extent={{-100,-100},{100,
            100}}), graphics));
end ClosedVolume;
