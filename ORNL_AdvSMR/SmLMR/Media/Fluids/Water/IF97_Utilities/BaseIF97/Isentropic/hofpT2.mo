within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Isentropic;
function hofpT2
  "intermediate function for isentropic specific enthalpy in region 2"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature (K)";
  output SI.SpecificEnthalpy h "specific enthalpy";
protected
  Real[16] o "vector of auxiliary variables";
  Real pi "dimensionless pressure";
  Real tau "dimensionless temperature";
  Real tau2 "dimensionless temperature";
algorithm
  assert(p > triple.ptriple,
    "IF97 medium function hofpT2 called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");
  pi := p/data.PSTAR2;
  tau := data.TSTAR2/T;
  tau2 := -0.5 + tau;
  o[1] := tau*tau;
  o[2] := o[1]*o[1];
  o[3] := tau2*tau2;
  o[4] := o[3]*tau2;
  o[5] := o[3]*o[3];
  o[6] := o[5]*o[5];
  o[7] := o[6]*o[6];
  o[8] := o[5]*o[6]*o[7]*tau2;
  o[9] := o[3]*o[5];
  o[10] := o[5]*o[6]*tau2;
  o[11] := o[3]*o[7]*tau2;
  o[12] := o[3]*o[5]*o[6];
  o[13] := o[5]*o[6]*o[7];
  o[14] := pi*pi;
  o[15] := o[14]*o[14];
  o[16] := o[7]*o[7];

  h := data.RH2O*T*tau*((0.0280439559151 + tau*(-0.2858109552582
     + tau*(1.2213149471784 + tau*(-2.848163942888 + tau*(
    4.38395111945 + o[1]*(10.08665568018 + (-0.5681726521544 +
    0.06380539059921*tau)*tau))))))/(o[1]*o[2]) + pi*(-0.017834862292358
     + tau2*(-0.09199202739273 + (-0.172743777250296 -
    0.30195167236758*o[4])*tau2) + pi*(-0.000033032641670203 +
    (-0.0003789797503263 + o[3]*(-0.015757110897342 + o[4]*(-0.306581069554011
     - 0.000960283724907132*o[8])))*tau2 + pi*(
    4.3870667284435e-7 + o[3]*(-0.00009683303171571 + o[4]*(-0.0090203547252888
     - 1.42338887469272*o[8])) + pi*(-7.8847309559367e-10 + (
    2.558143570457e-8 + 1.44676118155521e-6*tau2)*tau2 + pi*(
    0.0000160454534363627*o[9] + pi*((-5.0144299353183e-11 + o[
    10]*(-0.033874355714168 - 836.35096769364*o[11]))*o[3] + pi
    *((-0.0000138839897890111 - 0.973671060893475*o[12])*o[3]*o[
    6] + pi*((9.0049690883672e-11 - 296.320827232793*o[13])*o[3]
    *o[5]*tau2 + pi*(2.57526266427144e-7*o[5]*o[6] + pi*(o[4]*(
    4.1627860840696e-19 + (-1.0234747095929e-12 -
    1.40254511313154e-8*o[5])*o[9]) + o[14]*o[15]*(o[13]*(-2.34560435076256e-9
     + 5.3465159397045*o[5]*o[7]*tau2) + o[14]*(-19.1874828272775
    *o[16]*o[6]*o[7] + o[14]*(o[11]*(1.78371690710842e-23 + (
    1.07202609066812e-11 - 0.000201611844951398*o[10])*o[3]*o[5]
    *o[6]*tau2) + pi*(-1.24017662339842e-24*o[5]*o[7] + pi*(
    0.000200482822351322*o[16]*o[5]*o[7] + pi*(-4.97975748452559e-14
    *o[16]*o[3]*o[5] + o[6]*o[7]*(1.90027787547159e-27 + o[12]*
    (2.21658861403112e-15 - 0.0000547344301999018*o[3]*o[7]))*
    pi*tau2)))))))))))))))));
end hofpT2;
