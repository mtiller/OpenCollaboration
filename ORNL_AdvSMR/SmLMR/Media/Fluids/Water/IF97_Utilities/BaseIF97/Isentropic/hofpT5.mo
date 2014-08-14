within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Isentropic;
function hofpT5 "specific enthalpy in region 5 h(p,T)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature (K)";
  output SI.SpecificEnthalpy h "specific enthalpy";
protected
  Real[4] o "vector of auxiliary variables";
  Real tau "dimensionless temperature";
  Real pi "dimensionless pressure";
algorithm
  tau := data.TSTAR5/T;
  pi := p/data.PSTAR5;
  assert(p > triple.ptriple,
    "IF97 medium function hofpT5 called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");
  o[1] := tau*tau;
  o[2] := o[1]*o[1];
  o[3] := pi*pi;
  o[4] := o[2]*o[2];
  h := data.RH2O*T*tau*(6.8540841634434 + 3.1161318213925/o[1]
     + 0.074415446800398/o[2] - 0.0000357523455236121*o[3]*o[4]
     + 0.0021774678714571*pi - 0.013782846269973*o[1]*pi +
    3.8757684869352e-7*o[1]*o[3]*pi - 0.73803069960666/(o[1]*
    tau) - 0.65923253077834*tau);
end hofpT5;
