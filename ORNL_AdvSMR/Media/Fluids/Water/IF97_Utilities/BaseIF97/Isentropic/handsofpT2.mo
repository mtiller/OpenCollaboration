within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Isentropic;
function handsofpT2
  "function for isentropic specific enthalpy and specific entropy in region 2"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature (K)";
  output SI.SpecificEnthalpy h "specific enthalpy";
  output SI.SpecificEntropy s "specific entropy";
protected
  Real[22] o "vector of auxiliary variables";
  Real pi "dimensionless pressure";
  Real tau "dimensionless temperature";
  Real tau2 "dimensionless temperature";
  Real g "dimensionless Gibbs energy";
  Real gtau "derivative of  dimensionless Gibbs energy w.r.t. tau";
algorithm
  assert(p > triple.ptriple,
    "IF97 medium function handsofpT2 called with too low pressure\n" + "p = "
     + String(p) + " Pa <= " + String(triple.ptriple) +
    " Pa (triple point pressure)");
  tau := data.TSTAR2/T;
  pi := p/data.PSTAR2;
  tau2 := tau - 0.5;
  o[1] := tau2*tau2;
  o[2] := o[1]*tau2;
  o[3] := o[1]*o[1];
  o[4] := o[3]*o[3];
  o[5] := o[4]*o[4];
  o[6] := o[3]*o[4]*o[5]*tau2;
  o[7] := o[1]*o[3]*tau2;
  o[8] := o[3]*o[4]*tau2;
  o[9] := o[1]*o[5]*tau2;
  o[10] := o[1]*o[3]*o[4];
  o[11] := o[3]*o[4]*o[5];
  o[12] := o[1]*o[3];
  o[13] := pi*pi;
  o[14] := o[13]*o[13];
  o[15] := o[13]*o[14];
  o[16] := o[3]*o[5]*tau2;
  o[17] := o[5]*o[5];
  o[18] := o[3]*o[5];
  o[19] := o[1]*o[3]*o[4]*tau2;
  o[20] := o[1]*o[5];
  o[21] := tau*tau;
  o[22] := o[21]*o[21];

  g := pi*(-0.0017731742473213 + tau2*(-0.017834862292358 + tau2*(-0.045996013696365
     + (-0.057581259083432 - 0.05032527872793*o[2])*tau2)) + pi*(tau2*(-0.000033032641670203
     + (-0.00018948987516315 + o[1]*(-0.0039392777243355 + o[2]*(-0.043797295650573
     - 0.000026674547914087*o[6])))*tau2) + pi*(2.0481737692309e-8 + (
    4.3870667284435e-7 + o[1]*(-0.00003227767723857 + o[2]*(-0.0015033924542148
     - 0.040668253562649*o[6])))*tau2 + pi*(tau2*(-7.8847309559367e-10 + (
    1.2790717852285e-8 + 4.8225372718507e-7*tau2)*tau2) + pi*(
    2.2922076337661e-6*o[7] + pi*(o[2]*(-1.6714766451061e-11 + o[8]*(-0.0021171472321355
     - 23.895741934104*o[9])) + pi*(-5.905956432427e-18 + o[1]*(-1.2621808899101e-6
     - 0.038946842435739*o[10])*o[4]*tau2 + pi*((1.1256211360459e-11 -
    8.2311340897998*o[11])*o[4] + pi*(1.9809712802088e-8*o[8] + pi*((
    1.0406965210174e-19 + o[12]*(-1.0234747095929e-13 - 1.0018179379511e-9*o[3]))
    *o[3] + o[15]*((-8.0882908646985e-11 + 0.10693031879409*o[16])*o[6] + o[13]
    *(-0.33662250574171*o[17]*o[4]*o[5]*tau2 + o[13]*(o[18]*(
    8.9185845355421e-25 + o[19]*(3.0629316876232e-13 - 4.2002467698208e-6*o[8]))
     + pi*(-5.9056029685639e-26*o[16] + pi*(3.7826947613457e-6*o[17]*o[3]*o[5]*
    tau2 + pi*(o[1]*(7.3087610595061e-29 + o[10]*(5.5414715350778e-17 -
    9.436970724121e-7*o[20]))*o[4]*o[5]*pi - 1.2768608934681e-15*o[1]*o[17]*o[3]
    *tau2)))))))))))))))) + (-0.00560879118302 + tau*(0.07145273881455 + tau*(-0.4071049823928
     + tau*(1.424081971444 + tau*(-4.38395111945 + tau*(-9.692768600217 + tau*(
    10.08665568018 + (-0.2840863260772 + 0.02126846353307*tau)*tau) +
    Modelica.Math.log(pi)))))))/(o[22]*tau);

  gtau := (0.0280439559151 + tau*(-0.2858109552582 + tau*(1.2213149471784 + tau
    *(-2.848163942888 + tau*(4.38395111945 + o[21]*(10.08665568018 + (-0.5681726521544
     + 0.06380539059921*tau)*tau))))))/(o[21]*o[22]) + pi*(-0.017834862292358
     + tau2*(-0.09199202739273 + (-0.172743777250296 - 0.30195167236758*o[2])*
    tau2) + pi*(-0.000033032641670203 + (-0.0003789797503263 + o[1]*(-0.015757110897342
     + o[2]*(-0.306581069554011 - 0.000960283724907132*o[6])))*tau2 + pi*(
    4.3870667284435e-7 + o[1]*(-0.00009683303171571 + o[2]*(-0.0090203547252888
     - 1.42338887469272*o[6])) + pi*(-7.8847309559367e-10 + (2.558143570457e-8
     + 1.44676118155521e-6*tau2)*tau2 + pi*(0.0000160454534363627*o[12] + pi*(o[
    1]*(-5.0144299353183e-11 + o[8]*(-0.033874355714168 - 836.35096769364*o[9]))
     + pi*(o[1]*(-0.0000138839897890111 - 0.973671060893475*o[10])*o[4] + pi*((
    9.0049690883672e-11 - 296.320827232793*o[11])*o[7] + pi*(
    2.57526266427144e-7*o[3]*o[4] + pi*(o[2]*(4.1627860840696e-19 + o[12]*(-1.0234747095929e-12
     - 1.40254511313154e-8*o[3])) + o[15]*(o[11]*(-2.34560435076256e-9 +
    5.3465159397045*o[16]) + o[13]*(-19.1874828272775*o[17]*o[4]*o[5] + o[13]*(
    (1.78371690710842e-23 + o[19]*(1.07202609066812e-11 - 0.000201611844951398*
    o[8]))*o[9] + pi*(-1.24017662339842e-24*o[18] + pi*(0.000200482822351322*o[
    17]*o[3]*o[5] + pi*(-4.97975748452559e-14*o[1]*o[17]*o[3] + (
    1.90027787547159e-27 + o[10]*(2.21658861403112e-15 - 0.0000547344301999018*
    o[20]))*o[4]*o[5]*pi*tau2))))))))))))))));

  h := data.RH2O*T*tau*gtau;
  s := data.RH2O*(tau*gtau - g);
end handsofpT2;
