within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function d1n "density in region 1 as function of p and T"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature (K)";
  output SI.Density d "density";
protected
  Real pi "dimensionless pressure";
  Real pi1 "dimensionless pressure";
  Real tau "dimensionless temperature";
  Real tau1 "dimensionless temperature";
  Real gpi "dimensionless Gibbs-derivative w.r.t. pi";
  Real[11] o "auxiliary variables";
algorithm
  pi := p/data.PSTAR1;
  tau := data.TSTAR1/T;
  pi1 := 7.1 - pi;
  tau1 := tau - 1.222;
  o[1] := tau1*tau1;
  o[2] := o[1]*o[1];
  o[3] := o[2]*o[2];
  o[4] := o[1]*o[2];
  o[5] := o[1]*tau1;
  o[6] := o[2]*tau1;
  o[7] := pi1*pi1;
  o[8] := o[7]*o[7];
  o[9] := o[8]*o[8];
  o[10] := o[3]*o[3];
  o[11] := o[10]*o[10];
  gpi := pi1*(pi1*((0.000095038934535162 + o[2]*(
    8.4812393955936e-6 + 2.55615384360309e-9*o[4]))/o[2] + pi1*
    ((8.9701127632e-6 + (2.60684891582404e-6 +
    5.7366919751696e-13*o[2]*o[3])*o[5])/o[6] + pi1*(
    2.02584984300585e-6/o[3] + o[7]*pi1*(o[8]*o[9]*pi1*(o[7]*(o[
    7]*o[8]*(-7.63737668221055e-22/(o[1]*o[11]*o[2]) + pi1*(pi1
    *(-5.65070932023524e-23/(o[11]*o[3]) + (
    2.99318679335866e-24*pi1)/(o[11]*o[3]*tau1)) +
    3.5842867920213e-22/(o[1]*o[11]*o[2]*tau1))) -
    3.33001080055983e-19/(o[1]*o[10]*o[2]*o[3]*tau1)) +
    1.44400475720615e-17/(o[10]*o[2]*o[3]*tau1)) + (
    1.01874413933128e-8 + 1.39398969845072e-9*o[6])/(o[1]*o[3]*
    tau1))))) + (0.00094368642146534 + o[5]*(
    0.00060003561586052 + (-0.000095322787813974 + o[1]*(
    8.8283690661692e-6 + 1.45389992595188e-15*o[1]*o[2]*o[3]))*
    tau1))/o[5]) + (-0.00028319080123804 + o[1]*(
    0.00060706301565874 + o[4]*(0.018990068218419 + tau1*(
    0.032529748770505 + (0.021841717175414 +
    0.00005283835796993*o[1])*tau1))))/(o[3]*tau1);
  d := p/(data.RH2O*T*pi*gpi);
end d1n;
