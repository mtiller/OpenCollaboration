within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function g1pitau "derivative of g w.r.t. pi and tau"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature (K)";
  output Real pi "dimensionless pressure";
  output Real tau "dimensionless temperature";
  output Real gpi "dimensionless dervative of Gibbs function w.r.t. pi";
  output Real gtau "dimensionless dervative of Gibbs function w.r.t. tau";
protected
  Real pi1 "dimensionless pressure";
  Real tau1 "dimensionless temperature";
  Real[28] o "vector of auxiliary variables";
algorithm
  assert(p > triple.ptriple,
    "IF97 medium function g1pitau called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");
  assert(p <= 100.0e6,
    "IF97 medium function g1pitau: the input pressure (= " +
    String(p) + " Pa) is higher than 100 Mpa");
  assert(T >= 273.15,
    "IF97 medium function g1pitau: the temperature (= " +
    String(T) + " K) is lower than 273.15 K!");
  pi := p/data.PSTAR1;
  tau := data.TSTAR1/T;
  pi1 := 7.1 - pi;
  tau1 := -1.222 + tau;
  o[1] := tau1*tau1;
  o[2] := o[1]*tau1;
  o[3] := 1/o[2];
  o[4] := o[1]*o[1];
  o[5] := o[4]*o[4];
  o[6] := o[1]*o[5];
  o[7] := o[1]*o[4];
  o[8] := 1/o[4];
  o[9] := o[1]*o[4]*o[5];
  o[10] := o[4]*tau1;
  o[11] := 1/o[10];
  o[12] := o[4]*o[5];
  o[13] := o[5]*tau1;
  o[14] := 1/o[13];
  o[15] := pi1*pi1;
  o[16] := o[15]*pi1;
  o[17] := o[15]*o[15];
  o[18] := o[17]*o[17];
  o[19] := o[17]*o[18]*pi1;
  o[20] := o[15]*o[17];
  o[21] := o[5]*o[5];
  o[22] := o[21]*o[21];
  o[23] := o[22]*o[5]*tau1;
  o[24] := 1/o[23];
  o[25] := o[22]*o[5];
  o[26] := 1/o[25];
  o[27] := o[1]*o[22]*o[4]*tau1;
  o[28] := 1/o[27];
  gtau := pi1*((-0.00254871721114236 + o[1]*(
    0.00424944110961118 + (0.018990068218419 + (-0.021841717175414
     - 0.00015851507390979*o[1])*o[1])*o[7]))/o[6] + pi1*(o[8]*
    (0.00141552963219801 + o[4]*(0.000047661393906987 + o[1]*(-0.0000132425535992538
     - 1.2358149370591e-14*o[9]))) + pi1*(o[11]*(
    0.000126718579380216 - 5.11230768720618e-9*o[6]) + pi1*((
    0.000011212640954 + (1.30342445791202e-6 -
    1.4341729937924e-12*o[12])*o[2])/o[7] + pi1*(
    3.24135974880936e-6*o[14] + o[16]*((1.40077319158051e-8 +
    1.04549227383804e-9*o[10])/o[12] + o[19]*(
    1.9941018075704e-17/(o[1]*o[21]*o[4]*o[5]) + o[15]*(-4.48827542684151e-19
    /o[22] + o[20]*(-1.00075970318621e-21*o[28] + pi1*(
    4.65957282962769e-22*o[26] + pi1*(-7.2912378325616e-23*o[24]
     + (3.83502057899078e-24*pi1)/(o[1]*o[22]*o[5]))))))))))))
     + o[3]*(-0.29265942426334 + tau1*(0.84548187169114 + o[1]*
    (3.3855169168385 + tau1*(-1.91583926775744 + tau1*(
    0.47316115539684 + (-0.066465668798004 + 0.0040607314991784
    *tau1)*tau1)))));
  gpi := pi1*(pi1*((0.000095038934535162 + o[4]*(
    8.4812393955936e-6 + 2.55615384360309e-9*o[7]))*o[8] + pi1*
    (o[11]*(8.9701127632e-6 + (2.60684891582404e-6 +
    5.7366919751696e-13*o[12])*o[2]) + pi1*(2.02584984300585e-6
    /o[5] + o[16]*(o[19]*(o[15]*(o[20]*(-7.63737668221055e-22/(
    o[1]*o[22]*o[4]) + pi1*(3.5842867920213e-22*o[28] + pi1*(-5.65070932023524e-23
    *o[26] + 2.99318679335866e-24*o[24]*pi1))) -
    3.33001080055983e-19/(o[1]*o[21]*o[4]*o[5]*tau1)) +
    1.44400475720615e-17/(o[21]*o[4]*o[5]*tau1)) + (
    1.01874413933128e-8 + 1.39398969845072e-9*o[10])/(o[1]*o[5]
    *tau1))))) + o[3]*(0.00094368642146534 + o[2]*(
    0.00060003561586052 + (-0.000095322787813974 + o[1]*(
    8.8283690661692e-6 + 1.45389992595188e-15*o[9]))*tau1))) +
    o[14]*(-0.00028319080123804 + o[1]*(0.00060706301565874 + o[
    7]*(0.018990068218419 + tau1*(0.032529748770505 + (
    0.021841717175414 + 0.00005283835796993*o[1])*tau1))));
end g1pitau;
