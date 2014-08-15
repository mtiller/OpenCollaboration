within Ethan2;
model RVACS "1D heat transfer into air cooling system"
  parameter Integer N=2 "Number of Nodes";
  Modelica.SIunits.CoefficientOfHeatTransfer gamma
    "Constant heat transfer coefficient";
  parameter Modelica.SIunits.Area A = 3.14 "chimney CSA";
  parameter Modelica.SIunits.Length height = 10 "chimney height";
  parameter Modelica.SIunits.Length Di = 0.01995
    "individual tube outside Diameter/annulus Diameter";
  parameter Modelica.SIunits.Length Do = 1 "shroud diameter";
  parameter Integer Ntr = 56 "number of tubes";
  parameter Modelica.SIunits.Length L=2 "Vessel annulus Length";
  parameter Real C = 0.65 "discharge coefficient";
  //this should be removed at some point (adjusts to better match expectation):
  parameter Real ksi = 4 "gamma adjustment coefficient";
  parameter Real N_tower=4 "Number of Parallel Towers";
  constant Real g = Modelica.Constants.g_n;
  constant Real pi = Modelica.Constants.pi;
  Modelica.SIunits.Area dA "wall differential area";
  Modelica.SIunits.Volume dV "volume element";
  constant Modelica.SIunits.Density rho = 1.2 "air density";
  constant Modelica.SIunits.SpecificHeatCapacity cp = 1006 "Air specific heat";

  Modelica.SIunits.Power rvacspower;
  Modelica.SIunits.VolumeFlowRate Qstack;
  Modelica.SIunits.Velocity u;
  Modelica.SIunits.MassFlowRate w;
  Real Tdif "temperature difference";
  Modelica.SIunits.Area A_rv "RVACS area";
  Modelica.SIunits.Length Dhyd "RVACS hydraulic Diameter";

  parameter Modelica.SIunits.Temperature To = 290 "Outside Air Temp";
  parameter Modelica.SIunits.Temperature Tstart[N]=linspace(290, 300, N);
  Modelica.SIunits.Temperature T[N](start=Tstart) "axial air temperature";
  Modelica.SIunits.Temperature Ti "outlet wall temperature";

  ThermoPower3.Thermal.DHT side1(N=N) annotation (Placement(transformation(
          extent={{-40,-100},{40,-80}},
                                     rotation=0), iconTransformation(extent={{-40,
            -100},{40,-80}})));
equation
  //geometry
  dA = Ntr*pi*Di*L/N;
  dV = A_rv*L/N;
  A_rv = 0.25*pi*(Do^2-Ntr*Di^2);
  Dhyd = A_rv/(pi*(Ntr*Di+Do));

  //equations
  w = Qstack*rho;
  u = Qstack/A_rv;
  //stack flow equation
  Qstack = N_tower*C*A*sqrt(2*g*height)*(Tdif);
  Tdif = if Ti>To then sqrt((Ti-To)/Ti) else 1e-7;
  Ti = T[N];
  der(T[1])=0;
  for j in 2:N loop
    der(T[j]) = (side1.phi[j]*dA + w*cp*(T[j-1]-T[j]))/(rho*dV*cp);
  end for;

  side1.phi = ksi*gamma*(side1.T - T) "Convective heat transfer";
  gamma = ThermoPower3.Water.f_dittus_boelter(
        w,
        Dhyd,
        A_rv,
        17e-6,
        0.0271,
        1006);

  rvacspower = sum(side1.phi)*dA;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={Text(
            extent={{-100,12},{100,-12}},
            lineColor={191,95,0},
            textString="%name",
          origin={90,0},
          rotation=90),
        Polygon(
          points={{-40,-80},{-30,80},{30,80},{40,-80},{-40,-80}},
          lineColor={127,0,0},
          smooth=Smooth.None,
          fillPattern=FillPattern.Solid,
          fillColor={166,108,79}),
        Line(
          points={{-26,82},{-16,104},{-24,120},{-18,134}},
          color={135,135,135},
          smooth=Smooth.None),
        Line(
          points={{-16,86},{-6,108},{-14,124},{-8,138}},
          color={135,135,135},
          smooth=Smooth.None),
        Line(
          points={{-6,82},{4,104},{-4,120},{2,134}},
          color={135,135,135},
          smooth=Smooth.None),
        Line(
          points={{4,82},{14,104},{6,120},{12,134}},
          color={135,135,135},
          smooth=Smooth.None),
        Line(
          points={{14,86},{24,108},{16,124},{22,138}},
          color={135,135,135},
          smooth=Smooth.None),
        Line(
          points={{24,82},{34,104},{26,120},{32,134}},
          color={135,135,135},
          smooth=Smooth.None)}),   Documentation(info="<HTML>
<p>Model of a simple convective heat transfer mechanism between two 1D objects, with a constant heat transfer coefficient.
<p>Node <tt>j</tt> on side 1 interacts with node <tt>j</tt> on side 2.
</HTML>",
        revisions="<html>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
end RVACS;
