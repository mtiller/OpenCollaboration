within ORNL_AdvSMR.Functions;
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
