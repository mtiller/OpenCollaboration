within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Isentropic;
function handsofpT1
  "special function for specific enthalpy and specific entropy in region 1"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature (K)";
  output SI.SpecificEnthalpy h "specific enthalpy";
  output SI.SpecificEntropy s "specific entropy";
protected
  Real[28] o "vector of auxiliary variables";
  Real pi1 "dimensionless pressure";
  Real tau "dimensionless temperature";
  Real tau1 "dimensionless temperature";
  Real g "dimensionless Gibbs energy";
  Real gtau "derivative of  dimensionless Gibbs energy w.r.t. tau";
algorithm
  assert(p > triple.ptriple,
    "IF97 medium function handsofpT1 called with too low pressure\n" + "p = "
     + String(p) + " Pa <= " + String(triple.ptriple) +
    " Pa (triple point pressure)");
  tau := data.TSTAR1/T;
  pi1 := 7.1 - p/data.PSTAR1;
  tau1 := -1.222 + tau;
  o[1] := tau1*tau1;
  o[2] := o[1]*o[1];
  o[3] := o[2]*o[2];
  o[4] := o[3]*tau1;
  o[5] := 1/o[4];
  o[6] := o[1]*o[2];
  o[7] := o[1]*tau1;
  o[8] := 1/o[7];
  o[9] := o[1]*o[2]*o[3];
  o[10] := 1/o[2];
  o[11] := o[2]*tau1;
  o[12] := 1/o[11];
  o[13] := o[2]*o[3];
  o[14] := pi1*pi1;
  o[15] := o[14]*pi1;
  o[16] := o[14]*o[14];
  o[17] := o[16]*o[16];
  o[18] := o[16]*o[17]*pi1;
  o[19] := o[14]*o[16];
  o[20] := o[3]*o[3];
  o[21] := o[20]*o[20];
  o[22] := o[21]*o[3]*tau1;
  o[23] := 1/o[22];
  o[24] := o[21]*o[3];
  o[25] := 1/o[24];
  o[26] := o[1]*o[2]*o[21]*tau1;
  o[27] := 1/o[26];
  o[28] := o[1]*o[3];

  g := pi1*(pi1*(pi1*(o[10]*(-0.000031679644845054 + o[2]*(-2.8270797985312e-6
     - 8.5205128120103e-10*o[6])) + pi1*(o[12]*(-2.2425281908e-6 + (-6.5171222895601e-7
     - 1.4341729937924e-13*o[13])*o[7]) + pi1*(-4.0516996860117e-7/o[3] + o[15]
    *(o[18]*(o[14]*(o[19]*(2.6335781662795e-23/(o[1]*o[2]*o[21]) + pi1*(-1.1947622640071e-23
    *o[27] + pi1*(1.8228094581404e-24*o[25] - 9.3537087292458e-26*o[23]*pi1)))
     + 1.4478307828521e-20/(o[1]*o[2]*o[20]*o[3]*tau1)) - 6.8762131295531e-19/(
    o[2]*o[20]*o[3]*tau1)) + (-1.2734301741641e-9 - 1.7424871230634e-10*o[11])/
    (o[1]*o[3]*tau1))))) + o[8]*(-0.00047184321073267 + o[7]*(-0.00030001780793026
     + (0.000047661393906987 + o[1]*(-4.4141845330846e-6 - 7.2694996297594e-16*
    o[9]))*tau1))) + o[5]*(0.00028319080123804 + o[1]*(-0.00060706301565874 + o[
    6]*(-0.018990068218419 + tau1*(-0.032529748770505 + (-0.021841717175414 -
    0.00005283835796993*o[1])*tau1))))) + (0.14632971213167 + tau1*(-0.84548187169114
     + tau1*(-3.756360367204 + tau1*(3.3855169168385 + tau1*(-0.95791963387872
     + tau1*(0.15772038513228 + (-0.016616417199501 + 0.00081214629983568*tau1)
    *tau1))))))/o[1];

  gtau := pi1*((-0.00254871721114236 + o[1]*(0.00424944110961118 + (
    0.018990068218419 + (-0.021841717175414 - 0.00015851507390979*o[1])*o[1])*o[
    6]))/o[28] + pi1*(o[10]*(0.00141552963219801 + o[2]*(0.000047661393906987
     + o[1]*(-0.0000132425535992538 - 1.2358149370591e-14*o[9]))) + pi1*(o[12]*
    (0.000126718579380216 - 5.11230768720618e-9*o[28]) + pi1*((
    0.000011212640954 + (1.30342445791202e-6 - 1.4341729937924e-12*o[13])*o[7])
    /o[6] + pi1*(3.24135974880936e-6*o[5] + o[15]*((1.40077319158051e-8 +
    1.04549227383804e-9*o[11])/o[13] + o[18]*(1.9941018075704e-17/(o[1]*o[2]*o[
    20]*o[3]) + o[14]*(-4.48827542684151e-19/o[21] + o[19]*(-1.00075970318621e-21
    *o[27] + pi1*(4.65957282962769e-22*o[25] + pi1*(-7.2912378325616e-23*o[23]
     + (3.83502057899078e-24*pi1)/(o[1]*o[21]*o[3])))))))))))) + o[8]*(-0.29265942426334
     + tau1*(0.84548187169114 + o[1]*(3.3855169168385 + tau1*(-1.91583926775744
     + tau1*(0.47316115539684 + (-0.066465668798004 + 0.0040607314991784*tau1)*
    tau1)))));

  h := data.RH2O*T*tau*gtau;
  s := data.RH2O*(tau*gtau - g);
end handsofpT1;
