within ORNL_AdvSMR.Thermal;
model CounterCurrent
  "Counter-current heat transfer adaptor for 1D heat transfer"

  extends ORNL_AdvSMR.Icons.HeatFlow;
  parameter Integer N=2 "Number of Nodes";
  parameter Boolean counterCurrent=true
    "Swap temperature and flux vector order";
  DHT side1(N=N) annotation (Placement(transformation(extent={{-40,20},{40,40}},
          rotation=0)));
  DHT side2(N=N) annotation (Placement(transformation(extent={{-40,-42},{40,-20}},
          rotation=0)));
equation
  // Swap temperature and flux vector order
  if counterCurrent then
    side1.phi = -side2.phi[N:-1:1];
    side1.T = side2.T[N:-1:1];
  else
    side1.phi = -side2.phi;
    side1.T = side2.T;
  end if;
  annotation (Icon(graphics={Polygon(
          points={{-74,2},{-48,8},{-74,16},{-56,8},{-74,2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),Polygon(
          points={{74,-16},{60,-10},{74,-2},{52,-10},{74,-16}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),Text(
          extent={{-100,-46},{100,-70}},
          lineColor={191,95,0},
          textString="%name")}), Documentation(info="<HTML>
<p>This component can be used to model counter-current heat transfer. The temperature and flux vectors on one side are swapped with respect to the other side. This means that the temperature of node <tt>j</tt> on side 1 is equal to the temperature of note <tt>N-j+1</tt> on side 2; heat fluxes behave correspondingly.
<p>
The swapping is performed if the counterCurrent parameter is true (default value).
</HTML>", revisions="<html>
<ul>
<li><i>25 Aug 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       <tt>counterCurrent</tt> parameter added.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>

</html>
"));
end CounterCurrent;
