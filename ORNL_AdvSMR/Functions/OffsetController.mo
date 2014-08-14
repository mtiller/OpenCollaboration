within ORNL_AdvSMR.Functions;
block OffsetController "Offset computation for steady-state conditions"
  extends Modelica.Blocks.Interfaces.BlockIcon;
  parameter Real steadyStateGain=0.0
    "0.0: Adds offset to input - 1.0: Closed loop action to find steady state";
  parameter Real SP0 "Initial setpoint for the controlled variable";
  parameter Real deltaSP=0
    "Variation of the setpoint for the controlled variable";
  parameter Modelica.SIunits.Time Tstart=0
    "Start time of the setpoint ramp change";
  parameter Modelica.SIunits.Time Tend=0 "End time of the setpoint ramp change";
  parameter Real Kp "Proportional gain";
  parameter Real Ti "Integral time constant";
  parameter Real biasCO
    "Bias value of the control variable when computing the steady state";
protected
  Real SP;
  Real error;
  Real integralError;
public
  Modelica.Blocks.Interfaces.RealInput deltaCO annotation (Placement(
        transformation(extent={{-140,62},{-100,100}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput PV annotation (Placement(transformation(
          extent={{-140,-100},{-100,-60}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput CO annotation (Placement(transformation(
          extent={{100,-20},{140,20}}, rotation=0)));
equation
  SP = if time <= Tstart then SP0 else if time >= Tend then SP0 + deltaSP else
    SP0 + (time - Tstart)/(Tend - Tstart)*deltaSP;
  error = (SP - PV)*steadyStateGain;
  der(integralError) = error;
  CO = Kp*(error + integralError/Ti) + biasCO + (1.0 - steadyStateGain)*deltaCO;
  annotation (
    Documentation(info="<HTML>
<p>This model is useful to compute the steady state value of a control variable corresponding to some specified setpoint of an output variable, and to reuse it later to perform simulations starting from this steady state condition.
<p>The block has two different behaviours, depending on the value of the <tt>steadyState</tt> parameter.
<p>When <tt>steadyState = 1</tt>, the <tt>deltaCO</tt> input is ignored, and the block acts as a standard PI controller with transfer function Kp*(1+1/sTi) to bring the process variable connected to the <tt>PV</tt> input at the setpoint value, by acting on the control variable connected to the <tt>CO</tt> output. The setpoint value is <tt>SP0</tt> at time zero, and may change by <tt>deltaSP</tt> from <tt>Tstart</tt> to <tt>Tend</tt>; this can be useful to bring the process far away from the tentative start values of the transient without any inconvenience. The control variable can be biased by <tt>biasCO</tt> to start near the expected steady state value of <tt>CO</tt>.
<p>When <tt>steadyState = 0</tt>, the <tt>PV</tt> input is ignored, and the <tt>CO</tt> output is simply the sum of the <tt>deltaCO</tt> input and of the freezed steady-state output of the controller.
<p>To perform a steady state computation:
<ol>
<li>Set <tt>steadyState = 1</tt> and suitably tune <tt>Kp</tt>, <tt>Ti</tt> and <tt>biasCO</tt>
<li>Simulate a transient until the desired steady state is achieved.
<li>Set <tt>steadyState = 0</tt> and continue the simulation for 0 s
<li>Save the final state of the simulation, which contains the initial steady-state values of all the variables for subsequent transient simulations
</ol>
<p>To perform experiments starting from a steady state:
<ol>
<li>Load a previously saved steady state, to be used as initial state
<li>Perform the simulation of the desired transient. The <tt>offsetCO</tt> input value will be automatically added to the previously computed steady state value.
</ol>
<p><b>Revision history:</b></p>
<ul>
<li><i>15 Feb 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</HTML>"),
    Diagram(graphics),
    Icon(graphics={Text(extent={{-90,90},{94,-92}}, textString="SS Offset")}));
end OffsetController;
