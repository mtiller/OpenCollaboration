within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Isentropic;
function hofpT1
  "intermediate function for isentropic specific enthalpy in region 1"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature (K)";
  output SI.SpecificEnthalpy h "specific enthalpy";
protected
  Real[13] o "vector of auxiliary variables";
  Real pi1 "dimensionless pressure";
  Real tau "dimensionless temperature";
  Real tau1 "dimensionless temperature";
algorithm
  tau := data.TSTAR1/T;
  pi1 := 7.1 - p/data.PSTAR1;
  assert(p > triple.ptriple,
    "IF97 medium function hofpT1  called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");
  tau1 := -1.222 + tau;
  o[1] := tau1*tau1;
  o[2] := o[1]*tau1;
  o[3] := o[1]*o[1];
  o[4] := o[3]*o[3];
  o[5] := o[1]*o[4];
  o[6] := o[1]*o[3];
  o[7] := o[3]*tau1;
  o[8] := o[3]*o[4];
  o[9] := pi1*pi1;
  o[10] := o[9]*o[9];
  o[11] := o[10]*o[10];
  o[12] := o[4]*o[4];
  o[13] := o[12]*o[12];

  h := data.RH2O*T*tau*(pi1*((-0.00254871721114236 + o[1]*(
    0.00424944110961118 + (0.018990068218419 + (-0.021841717175414
     - 0.00015851507390979*o[1])*o[1])*o[6]))/o[5] + pi1*((
    0.00141552963219801 + o[3]*(0.000047661393906987 + o[1]*(-0.0000132425535992538
     - 1.2358149370591e-14*o[1]*o[3]*o[4])))/o[3] + pi1*((
    0.000126718579380216 - 5.11230768720618e-9*o[5])/o[7] + pi1
    *((0.000011212640954 + o[2]*(1.30342445791202e-6 -
    1.4341729937924e-12*o[8]))/o[6] + pi1*(o[9]*pi1*((
    1.40077319158051e-8 + 1.04549227383804e-9*o[7])/o[8] + o[10]
    *o[11]*pi1*(1.9941018075704e-17/(o[1]*o[12]*o[3]*o[4]) + o[
    9]*(-4.48827542684151e-19/o[13] + o[10]*o[9]*(pi1*(
    4.65957282962769e-22/(o[13]*o[4]) + pi1*((
    3.83502057899078e-24*pi1)/(o[1]*o[13]*o[4]) -
    7.2912378325616e-23/(o[13]*o[4]*tau1))) -
    1.00075970318621e-21/(o[1]*o[13]*o[3]*tau1))))) +
    3.24135974880936e-6/(o[4]*tau1)))))) + (-0.29265942426334
     + tau1*(0.84548187169114 + o[1]*(3.3855169168385 + tau1*(-1.91583926775744
     + tau1*(0.47316115539684 + (-0.066465668798004 +
    0.0040607314991784*tau1)*tau1)))))/o[2]);
end hofpT1;
