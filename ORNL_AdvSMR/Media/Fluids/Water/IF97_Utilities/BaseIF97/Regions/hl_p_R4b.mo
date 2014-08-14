within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function hl_p_R4b
  "explicit approximation of liquid specific enthalpy on the boundary between regions 4 and 3"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEnthalpy h "specific enthalpy";
protected
  Real x "auxiliary variable";
algorithm
  // documentation of accuray in notebook ~hubertus/props/IAPWS/R3Approx.nb
  // boundary between region IVa and III
  x := Modelica.Math.acos(p/data.PCRIT);
  h := (1 + x*(-0.4945586958175176 + x*(1.346800016564904 + x*(-3.889388153209752
     + x*(6.679385472887931 + x*(-6.75820241066552 + x*(3.558919744656498 + (-0.7179818554978939
     - 0.0001152032945617821*x)*x)))))))*data.HCRIT;
end hl_p_R4b;
