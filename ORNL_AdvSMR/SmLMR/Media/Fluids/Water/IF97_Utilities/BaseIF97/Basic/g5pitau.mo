within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function g5pitau "derivative of g w.r.t. pi and tau"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature (K)";
  output Real pi "dimensionless pressure";
  output Real tau "dimensionless temperature";
  output Real gpi "dimensionless dervative of Gibbs function w.r.t. pi";
  output Real gtau "dimensionless dervative of Gibbs function w.r.t. tau";
protected
  Real[3] o "vector of auxiliary variables";
algorithm
  assert(p > triple.ptriple,
    "IF97 medium function g5pitau called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");
  assert(p <= data.PLIMIT5,
    "IF97 medium function g5pitau: input pressure (= " + String(
    p) + " Pa) is higher than 10 Mpa in region 5");
  assert(T <= 2273.15,
    "IF97 medium function g5pitau: input temperature (= " +
    String(T) +
    " K) is higher than limit of 2273.15 K in region 5");
  pi := p/data.PSTAR5;
  tau := data.TSTAR5/T;
  o[1] := tau*tau;
  o[2] := o[1]*o[1];
  o[3] := o[2]*o[2];
  gtau := pi*(0.0021774678714571 - 0.013782846269973*o[1] + pi*
    (-0.0000357523455236121*o[3] + 3.8757684869352e-7*o[1]*pi))
     + (0.074415446800398 + tau*(-0.73803069960666 + (
    3.1161318213925 + o[1]*(6.8540841634434 - 0.65923253077834*
    tau))*tau))/o[2];
  gpi := (1.0 + pi*(-0.00012563183589592 + (0.0021774678714571
     - 0.004594282089991*o[1])*tau + pi*(-7.9449656719138e-6*o[
    3]*tau + 3.8757684869352e-7*o[1]*pi*tau)))/pi;
end g5pitau;
