within ThermoPower3;
package Functions "Miscellaneous functions"
  extends Modelica.Icons.Library;
  function linear
    extends Modelica.Icons.Function;
    input Real x;
    output Real y;
  algorithm
    y := x;
    annotation (derivative=Functions.linear_der);
  end linear;

  function linear_der
    extends Modelica.Icons.Function;
    input Real x;
    input Real der_x;
    output Real der_y;
  algorithm
    der_y := der_x;
  end linear_der;

  function one
    extends Modelica.Icons.Function;
    input Real x;
    output Real y;
  algorithm
    y := 1;
    annotation (derivative=Functions.one_der);
  end one;

  function one_der
    extends Modelica.Icons.Function;
    input Real x;
    input Real der_x;
    output Real der_y;
  algorithm
    der_y := 0;
  end one_der;

  function sqrtReg
    "Symmetric square root approximation with finite derivative in zero"
    extends Modelica.Icons.Function;
    input Real x;
    input Real delta=0.01 "Range of significant deviation from sqrt(x)";
    output Real y;
  algorithm
    y := x/sqrt(sqrt(x*x + delta*delta));

    annotation (
      derivative(zeroDerivative=delta) = ThermoPower3.Functions.sqrtReg_der,
      Documentation(info="<html>
This function approximates sqrt(x)*sign(x), such that the derivative is finite and smooth in x=0. 
</p>
<p>
<table border=1 cellspacing=0 cellpadding=2> 
<tr><th>Function</th><th>Approximation</th><th>Range</th></tr>
<tr><td>y = sqrtReg(x)</td><td>y ~= sqrt(abs(x))*sign(x)</td><td>abs(x) &gt;&gt delta</td></tr>
<tr><td>y = sqrtReg(x)</td><td>y ~= x/sqrt(delta)</td><td>abs(x) &lt;&lt  delta</td></tr>
</table>
<p>
With the default value of delta=0.01, the difference between sqrt(x) and sqrtReg(x) is 16% around x=0.1, 0.25% around x=0.1 and 0.0025% around x=1.
</p> 
</html>", revisions="<html>
<ul>
<li><i>15 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Created. </li>
</ul>
</html>"),
      Documentation(info="<html>
This function approximates sqrt(x)*sign(x), such that the derivative is finite and smooth in x=0. 
</p>
<p>
<table border=1 cellspacing=0 cellpadding=2> 
<tr><th>Function</th><th>Approximation</th><th>Range</th></tr>
<tr><td>y = sqrtReg(x)</td><td>y ~= sqrt(abs(x))*sign(x)</td><td>abs(x) &gt;&gt delta</td></tr>
<tr><td>y = sqrtReg(x)</td><td>y ~= x/delta</td><td>abs(x) &lt;&lt  delta</td></tr>
</table>
<p>
With the default value of delta=0.01, the difference between sqrt(x) and sqrtReg(x) is 0.5% around x=0.1 and 0.005% around x=1.
</p> 
</html>", revisions="<html>
<ul>
<li><i>15 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Created. </li>
</ul>
</html>"));
  end sqrtReg;

  function sqrtReg_der "Derivative of sqrtReg"
    extends Modelica.Icons.Function;
    input Real x;
    input Real delta=0.01 "Range of significant deviation from sqrt(x)";
    input Real dx "Derivative of x";
    output Real dy;
  algorithm
    dy := dx*0.5*(x*x + 2*delta*delta)/((x*x + delta*delta)^1.25);
    annotation (Documentation(info="<html>
</html>", revisions="<html>
<ul>
<li><i>15 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Created. </li>
</ul>
</html>"));
  end sqrtReg_der;

  function squareReg
    "Anti-symmetric square approximation with non-zero derivative in the origin"
    extends Modelica.Icons.Function;
    input Real x;
    input Real delta=0.01 "Range of significant deviation from x^2*sgn(x)";
    output Real y;
  algorithm
    y := x*sqrt(x*x + delta*delta);

    annotation (Documentation(info="<html>
This function approximates x^2*sgn(x), such that the derivative is non-zero in x=0.
</p>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Function</th><th>Approximation</th><th>Range</th></tr>
<tr><td>y = regSquare(x)</td><td>y ~= x^2*sgn(x)</td><td>abs(x) &gt;&gt delta</td></tr>
<tr><td>y = regSquare(x)</td><td>y ~= x*delta</td><td>abs(x) &lt;&lt  delta</td></tr>
</table>
<p>
With the default value of delta=0.01, the difference between x^2 and regSquare(x) is 41% around x=0.01, 0.4% around x=0.1 and 0.005% around x=1.
</p>
</p>
</html>", revisions="<html>
<ul>
<li><i>15 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Created. </li>
</ul>
</html>"), Documentation(info="<html>
This function approximates sqrt(x)*sign(x), such that the derivative is finite and smooth in x=0.
</p>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Function</th><th>Approximation</th><th>Range</th></tr>
<tr><td>y = sqrtReg(x)</td><td>y ~= sqrt(abs(x))*sign(x)</td><td>abs(x) &gt;&gt delta</td></tr>
<tr><td>y = sqrtReg(x)</td><td>y ~= x/delta</td><td>abs(x) &lt;&lt  delta</td></tr>
</table>
<p>
With the default value of delta=0.01, the difference between sqrt(x) and sqrtReg(x) is 0.5% around x=0.1 and 0.005% around x=1.
</p>
</html>", revisions="<html>
<ul>
<li><i>15 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Created. </li>
</ul>
</html>"));
  end squareReg;

  function stepReg = Modelica.Fluid.Utilities.regStep
    "Regularized step function" annotation (
    smoothOrder=1,
    Documentation(info="<html>

</html>", revisions="<html>
<ul>
<li><i>22 Aug 2011</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Added. </li>
</ul>
</html>"),
    Documentation(info="<html>
This function approximates sqrt(x)*sign(x), such that the derivative is finite and smooth in x=0.
</p>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Function</th><th>Approximation</th><th>Range</th></tr>
<tr><td>y = sqrtReg(x)</td><td>y ~= sqrt(abs(x))*sign(x)</td><td>abs(x) &gt;&gt delta</td></tr>
<tr><td>y = sqrtReg(x)</td><td>y ~= x/delta</td><td>abs(x) &lt;&lt  delta</td></tr>
</table>
<p>
With the default value of delta=0.01, the difference between sqrt(x) and sqrtReg(x) is 0.5% around x=0.1 and 0.005% around x=1.
</p>
</html>", revisions="<html>
<ul>
<li><i>15 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Created. </li>
</ul>
</html>"));
  block OffsetController "Offset computation for steady-state conditions"
    extends Modelica.Blocks.Interfaces.BlockIcon;
    parameter Real steadyStateGain=0.0
      "0.0: Adds offset to input - 1.0: Closed loop action to find steady state";
    parameter Real SP0 "Initial setpoint for the controlled variable";
    parameter Real deltaSP=0
      "Variation of the setpoint for the controlled variable";
    parameter Time Tstart=0 "Start time of the setpoint ramp change";
    parameter Time Tend=0 "End time of the setpoint ramp change";
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
    Modelica.Blocks.Interfaces.RealInput PV annotation (Placement(
          transformation(extent={{-140,-100},{-100,-60}}, rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput CO annotation (Placement(
          transformation(extent={{100,-20},{140,20}}, rotation=0)));
  equation
    SP = if time <= Tstart then SP0 else if time >= Tend then SP0 + deltaSP
       else SP0 + (time - Tstart)/(Tend - Tstart)*deltaSP;
    error = (SP - PV)*steadyStateGain;
    der(integralError) = error;
    CO = Kp*(error + integralError/Ti) + biasCO + (1.0 - steadyStateGain)*
      deltaCO;
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

  package PumpCharacteristics "Functions for pump characteristics"
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;

    partial function baseFlow "Base class for pump flow characteristics"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.VolumeFlowRate q_flow "Volumetric flow rate";
      output Modelica.SIunits.Height head "Pump head";
    end baseFlow;

    partial function basePower
      "Base class for pump power consumption characteristics"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.VolumeFlowRate q_flow "Volumetric flow rate";
      output Modelica.SIunits.Power consumption
        "Power consumption at nominal density";
    end basePower;

    partial function baseEfficiency "Base class for efficiency characteristics"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.VolumeFlowRate q_flow "Volumetric flow rate";
      output Real eta "Efficiency";
    end baseEfficiency;

    function linearFlow "Linear flow characteristic"
      extends baseFlow;
      input Modelica.SIunits.VolumeFlowRate q_nom[2]
        "Volume flow rate for two operating points (single pump)";
      input Modelica.SIunits.Height head_nom[2]
        "Pump head for two operating points";
      /* Linear system to determine the coefficients:
  head_nom[1] = c[1] + q_nom[1]*c[2];
  head_nom[2] = c[1] + q_nom[2]*c[2];
  */
    protected
      parameter Real c[2]=Modelica.Math.Matrices.solve([ones(2), q_nom],
          head_nom) "Coefficients of linear head curve";
    algorithm
      // Flow equation: head = q*c[1] + c[2];
      head := c[1] + q_flow*c[2];
      annotation (smoothOrder=2);
    end linearFlow;

    function quadraticFlow "Quadratic flow characteristic"
      extends baseFlow;
      input Modelica.SIunits.VolumeFlowRate q_nom[3]
        "Volume flow rate for three operating points (single pump)";
      input Modelica.SIunits.Height head_nom[3]
        "Pump head for three operating points";
    protected
      parameter Real q_nom2[3]={q_nom[1]^2,q_nom[2]^2,q_nom[3]^2}
        "Squared nominal flow rates";
      /* Linear system to determine the coefficients:
  head_nom[1] = c[1] + q_nom[1]*c[2] + q_nom[1]^2*c[3];
  head_nom[2] = c[1] + q_nom[2]*c[2] + q_nom[2]^2*c[3];
  head_nom[3] = c[1] + q_nom[3]*c[2] + q_nom[3]^2*c[3];
  */
      parameter Real c[3]=Modelica.Math.Matrices.solve([ones(3), q_nom, q_nom2],
          head_nom) "Coefficients of quadratic head curve";
    algorithm
      // Flow equation: head = c[1] + q_flow*c[2] + q_flow^2*c[3];
      head := c[1] + q_flow*c[2] + q_flow^2*c[3];
    end quadraticFlow;

    function polynomialFlow "Polynomial flow characteristic"
      extends baseFlow;
      input Modelica.SIunits.VolumeFlowRate q_nom[:]
        "Volume flow rate for N operating points (single pump)";
      input Modelica.SIunits.Height head_nom[:]
        "Pump head for N operating points";
      constant VolumeFlowRate q_eps=1e-6
        "Small coefficient to avoid numerical singularities";
    protected
      parameter Integer N=size(q_nom, 1) "Number of nominal operating points";
      parameter Real q_nom_pow[N, N]={{q_nom[i]^(j - 1) for j in 1:N} for i in
          1:N} "Rows: different operating points; columns: increasing powers";
      /* Linear system to determine the coefficients (example N=3):
  head_nom[1] = c[1] + q_nom[1]*c[2] + q_nom[1]^2*c[3];
  head_nom[2] = c[1] + q_nom[2]*c[2] + q_nom[2]^2*c[3];
  head_nom[3] = c[1] + q_nom[3]*c[2] + q_nom[3]^2*c[3];
  */
      parameter Real c[N]=Modelica.Math.Matrices.solve(q_nom_pow, head_nom)
        "Coefficients of polynomial head curve";
    algorithm
      // Flow equation (example N=3): head = c[1] + q_flow*c[2] + q_flow^2*c[3];
      // Note: the implementation is numerically efficient only for low values of N
      head := sum((q_flow + q_eps)^(i - 1)*c[i] for i in 1:N);
    end polynomialFlow;

    function constantPower "Constant power consumption characteristic"
      extends basePower;
      input Modelica.SIunits.Power power=0 "Constant power consumption";
    algorithm
      consumption := power;
    end constantPower;

    function linearPower "Linear power consumption characteristic"
      extends basePower;
      input Modelica.SIunits.VolumeFlowRate q_nom[2]
        "Volume flow rate for two operating points (single pump)";
      input Modelica.SIunits.Power W_nom[2]
        "Power consumption for two operating points";
      /* Linear system to determine the coefficients:
  W_nom[1] = c[1] + q_nom[1]*c[2];
  W_nom[2] = c[1] + q_nom[2]*c[2];
  */
    protected
      Real c[2]=Modelica.Math.Matrices.solve([ones(2), q_nom], W_nom)
        "Coefficients of quadratic power consumption curve";
    algorithm
      consumption := c[1] + q_flow*c[2];
    end linearPower;

    function quadraticPower "Quadratic power consumption characteristic"
      extends basePower;
      input Modelica.SIunits.VolumeFlowRate q_nom[3]
        "Volume flow rate for three operating points (single pump)";
      input Modelica.SIunits.Power W_nom[3]
        "Power consumption for three operating points";
    protected
      Real q_nom2[3]={q_nom[1]^2,q_nom[2]^2,q_nom[3]^2}
        "Squared nominal flow rates";
      /* Linear system to determine the coefficients:
  W_nom[1] = c[1] + q_nom[1]*c[2] + q_nom[1]^2*c[3];
  W_nom[2] = c[1] + q_nom[2]*c[2] + q_nom[2]^2*c[3];
  W_nom[3] = c[1] + q_nom[3]*c[2] + q_nom[3]^2*c[3];
  */
      Real c[3]=Modelica.Math.Matrices.solve([ones(3), q_nom, q_nom2], W_nom)
        "Coefficients of quadratic power consumption curve";
    algorithm
      consumption := c[1] + q_flow*c[2] + q_flow^2*c[3];
    end quadraticPower;

    function constantEfficiency "Constant efficiency characteristic"
      extends baseEfficiency;
      input Real eta_nom "Nominal efficiency";
    algorithm
      eta := eta_nom;
    end constantEfficiency;

  end PumpCharacteristics;

  package ValveCharacteristics "Functions for valve characteristics"
    partial function baseFun "Base class for valve characteristics"
      extends Modelica.Icons.Function;
      input Real pos "Stem position (per unit)";
      output Real rc "Relative coefficient (per unit)";
    end baseFun;

    function linear "Linear characteristic"
      extends baseFun;
    algorithm
      rc := pos;
    end linear;

    function one "Constant characteristic"
      extends baseFun;
    algorithm
      rc := 1;
    end one;

    function quadratic "Quadratic characteristic"
      extends baseFun;
    algorithm
      rc := pos*pos;
    end quadratic;

    function equalPercentage "Equal percentage characteristic"
      extends baseFun;
      input Real rangeability=20 "Rangeability";
      input Real delta=0.01;
    algorithm
      rc := if pos > delta then rangeability^(pos - 1) else pos/delta*
        rangeability^(delta - 1);
      annotation (Documentation(info="<html>
This characteristic is such that the relative change of the flow coefficient is proportional to the change in the stem position:
<p> d(rc)/d(pos) = k d(pos).
<p> The constant k is expressed in terms of the rangeability, i.e. the ratio between the maximum and the minimum useful flow coefficient:
<p> rangeability = exp(k) = rc(1.0)/rc(0.0).
<p> The theoretical characteristic has a non-zero opening when pos = 0; the implemented characteristic is modified so that the valve closes linearly when pos &lt delta.
</html>"));
    end equalPercentage;

    function sinusoidal "Sinusoidal characteristic"
      extends baseFun;
      import Modelica.Math.*;
      import Modelica.Constants.*;
    algorithm
      rc := sin(pos*pi/2);
    end sinusoidal;
  end ValveCharacteristics;

  package FanCharacteristics "Functions for fan characteristics"
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;

    partial function baseFlow "Base class for fan flow characteristics"
      extends Modelica.Icons.Function;
      input VolumeFlowRate q_flow "Volumetric flow rate";
      input Real bladePos=1 "Blade position";
      output SpecificEnergy H "Specific Energy";
    end baseFlow;

    partial function basePower
      "Base class for fan power consumption characteristics"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.VolumeFlowRate q_flow "Volumetric flow rate";
      input Real bladePos=1 "Blade position";
      output Modelica.SIunits.Power consumption "Power consumption";
    end basePower;

    partial function baseEfficiency "Base class for efficiency characteristics"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.VolumeFlowRate q_flow "Volumetric flow rate";
      input Real bladePos=1 "Blade position";
      output Real eta "Efficiency";
    end baseEfficiency;

    function linearFlow "Linear flow characteristic, fixed blades"
      extends baseFlow;
      input Modelica.SIunits.VolumeFlowRate q_nom[2]
        "Volume flow rate for two operating points (single fan)";
      input Modelica.SIunits.Height H_nom[2]
        "Specific energy for two operating points";
      /* Linear system to determine the coefficients:
  H_nom[1] = c[1] + q_nom[1]*c[2];
  H_nom[2] = c[1] + q_nom[2]*c[2];
  */
    protected
      parameter Real c[2]=Modelica.Math.Matrices.solve([ones(2), q_nom], H_nom)
        "Coefficients of linear head curve";
    algorithm
      // Flow equation: head = q*c[1] + c[2];
      H := c[1] + q_flow*c[2];
    end linearFlow;

    function quadraticFlow "Quadratic flow characteristic, fixed blades"
      extends baseFlow;
      input Modelica.SIunits.VolumeFlowRate q_nom[3]
        "Volume flow rate for three operating points (single fan)";
      input Modelica.SIunits.Height H_nom[3]
        "Specific work for three operating points";
    protected
      parameter Real q_nom2[3]={q_nom[1]^2,q_nom[2]^2,q_nom[3]^2}
        "Squared nominal flow rates";
      /* Linear system to determine the coefficients:
  H_nom[1] = c[1] + q_nom[1]*c[2] + q_nom[1]^2*c[3];
  H_nom[2] = c[1] + q_nom[2]*c[2] + q_nom[2]^2*c[3];
  H_nom[3] = c[1] + q_nom[3]*c[2] + q_nom[3]^2*c[3];
  */
      parameter Real c[3]=Modelica.Math.Matrices.solve([ones(3), q_nom, q_nom2],
          H_nom) "Coefficients of quadratic specific work characteristic";
    algorithm
      // Flow equation: H = c[1] + q_flow*c[2] + q_flow^2*c[3];
      H := c[1] + q_flow*c[2] + q_flow^2*c[3];
    end quadraticFlow;

    function quadraticFlowBlades
      "Quadratic flow characteristic, movable blades"
      extends baseFlow;
      input Real bladePos_nom[:];
      input Modelica.SIunits.VolumeFlowRate q_nom[3, :]
        "Volume flow rate for three operating points at N_pos blade positionings";
      input Modelica.SIunits.Height H_nom[3, :]
        "Specific work for three operating points at N_pos blade positionings";
      input Real slope_s(
        unit="(J/kg)/(m3/s)",
        max=0) = 0
        "Slope of flow characteristic at stalling conditions (must be negative)";
    algorithm
      H := Utilities.quadraticFlowBlades(
            q_flow,
            bladePos,
            bladePos_nom,
            Utilities.quadraticFlowBladesCoeff(
              bladePos_nom,
              q_nom,
              H_nom),
            slope_s);
    end quadraticFlowBlades;

    function polynomialFlow "Polynomial flow characteristic, fixed blades"
      extends baseFlow;
      input Modelica.SIunits.VolumeFlowRate q_nom[:]
        "Volume flow rate for N operating points (single fan)";
      input Modelica.SIunits.Height H_nom[:]
        "Specific work for N operating points";
    protected
      parameter Integer N=size(q_nom, 1) "Number of nominal operating points";
      parameter Real q_nom_pow[N, N]={{q_nom[j]^(i - 1) for j in 1:N} for i in
          1:N} "Rows: different operating points; columns: increasing powers";
      /* Linear system to determine the coefficients (example N=3):
  H_nom[1] = c[1] + q_nom[1]*c[2] + q_nom[1]^2*c[3];
  H_nom[2] = c[1] + q_nom[2]*c[2] + q_nom[2]^2*c[3];
  H_nom[3] = c[1] + q_nom[3]*c[2] + q_nom[3]^2*c[3];
  */
      parameter Real c[N]=Modelica.Math.Matrices.solve(q_nom_pow, H_nom)
        "Coefficients of polynomial specific work curve";
    algorithm
      // Flow equation (example N=3): H = c[1] + q_flow*c[2] + q_flow^2*c[3];
      // Note: the implementation is numerically efficient only for low values of Na
      H := sum(q_flow^(i - 1)*c[i] for i in 1:N);
    end polynomialFlow;

    function constantEfficiency "Constant efficiency characteristic"
      extends baseEfficiency;
      input Real eta_nom "Nominal efficiency";
    algorithm
      eta := eta_nom;
    end constantEfficiency;

    function constantPower "Constant power consumption characteristic"
      extends FanCharacteristics.basePower;
      input Modelica.SIunits.Power power=0 "Constant power consumption";
    algorithm
      consumption := power;
    end constantPower;

    function quadraticPower
      "Quadratic power consumption characteristic, fixed blades"
      extends basePower;
      input Modelica.SIunits.VolumeFlowRate q_nom[3]
        "Volume flow rate for three operating points (single fan)";
      input Modelica.SIunits.Power W_nom[3]
        "Power consumption for three operating points";
    protected
      Real q_nom2[3]={q_nom[1]^2,q_nom[2]^2,q_nom[3]^2}
        "Squared nominal flow rates";
      /* Linear system to determine the coefficients:
  W_nom[1]*g = c[1] + q_nom[1]*c[2] + q_nom[1]^2*c[3];
  W_nom[2]*g = c[1] + q_nom[2]*c[2] + q_nom[2]^2*c[3];
  W_nom[3]*g = c[1] + q_nom[3]*c[2] + q_nom[3]^2*c[3];
  */
      Real c[3]=Modelica.Math.Matrices.solve([ones(3), q_nom, q_nom2], W_nom)
        "Coefficients of quadratic power consumption curve";
    algorithm
      consumption := c[1] + q_flow*c[2] + q_flow^2*c[3];
    end quadraticPower;

    package Utilities
      function quadraticFlowBlades
        "Quadratic flow characteristic, movable blades"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.VolumeFlowRate q_flow;
        input Real bladePos;
        input Real bladePos_nom[:];
        input Real c[:, :]
          "Coefficients of quadratic specific work characteristic";
        input Real slope_s(
          unit="(J/kg)/(m3/s)",
          max=0) = 0
          "Slope of flow characteristic at stalling conditions (must be negative)";
        output SpecificEnergy H "Specific Energy";
      protected
        Integer N_pos=size(bladePos_nom, 1);
        Integer i;
        Real alpha;
        Real q_s "Volume flow rate at stalling conditions";
      algorithm
        // Flow equation: H = c[1] + q_flow*c[2] + q_flow^2*c[3];
        i := N_pos - 1;
        while bladePos <= bladePos_nom[i] and i > 1 loop
          i := i - 1;
        end while;
        alpha := (bladePos - bladePos_nom[i])/(bladePos_nom[i + 1] -
          bladePos_nom[i]);
        q_s := (slope_s - ((1 - alpha)*c[2, i] + alpha*c[2, i + 1]))/(2*((1 -
          alpha)*c[3, i] + alpha*c[3, i + 1]));
        H := if q_flow > q_s then ((1 - alpha)*c[1, i] + alpha*c[1, i + 1]) + (
          (1 - alpha)*c[2, i] + alpha*c[2, i + 1])*q_flow + ((1 - alpha)*c[3, i]
           + alpha*c[3, i + 1])*q_flow^2 else ((1 - alpha)*c[1, i] + alpha*c[1,
          i + 1]) + ((1 - alpha)*c[2, i] + alpha*c[2, i + 1])*q_s + ((1 - alpha)
          *c[3, i] + alpha*c[3, i + 1])*q_s^2 + (q_flow - q_s)*slope_s;
      end quadraticFlowBlades;

      function quadraticFlowBladesCoeff
        extends Modelica.Icons.Function;
        input Real bladePos_nom[:];
        input Modelica.SIunits.VolumeFlowRate q_nom[3, :]
          "Volume flow rate for three operating points at N_pos blade positionings";
        input Modelica.SIunits.Height H_nom[3, :]
          "Specific work for three operating points at N_pos blade positionings";
        output Real c[3, size(bladePos_nom, 1)]
          "Coefficients of quadratic specific work characteristic";
      protected
        Integer N_pos=size(bladePos_nom, 1);
        Real q_nom2[3];
      algorithm
        for j in 1:N_pos loop
          q_nom2 := {q_nom[1, j]^2,q_nom[2, j]^2,q_nom[3, j]^2};
          c[:, j] := Modelica.Math.Matrices.solve([ones(3), q_nom[:, j], q_nom2],
            H_nom[:, j]);
        end for;
      end quadraticFlowBladesCoeff;
    end Utilities;
  end FanCharacteristics;
  annotation (Documentation(info="<HTML>
This package contains general-purpose functions and models
</HTML>"));
end Functions;
