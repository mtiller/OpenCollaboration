within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function g2metastable "Gibbs function for metastable part of region 2: g(p,T)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature (K)";
  output Common.GibbsDerivs g
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
protected
  Real pi "dimensionless pressure";
  Real tau "dimensionless temperature";
  Real tau2 "dimensionless temperature";
  Real[27] o "vector of auxiliary variables";
algorithm
  assert(p > triple.ptriple,
    "IF97 medium function g2metastable called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");
  assert(p <= 100.0e6,
    "IF97 medium function g2metastable: the input pressure (= "
     + String(p) + " Pa) is higher than 100 Mpa");
  assert(T >= 273.15,
    "IF97 medium function g2metastable: the temperature (= " +
    String(T) + " K) is lower than 273.15 K!");
  assert(T <= 1073.15,
    "IF97 medium function g2metastable: the input temperature (= "
     + String(T) + " K) is higher than the limit of 1073.15 K");
  g.p := p;
  g.T := T;
  g.R := data.RH2O;
  g.pi := p/data.PSTAR2;
  g.tau := data.TSTAR2/T;
  tau2 := -0.5 + g.tau;
  o[1] := tau2*tau2;
  o[2] := o[1]*tau2;
  o[3] := o[1]*o[1];
  o[4] := o[1]*o[3];
  o[5] := -0.0040813178534455*o[4];
  o[6] := -0.072334555213245 + o[5];
  o[7] := o[2]*o[6];
  o[8] := -0.088223831943146 + o[7];
  o[9] := o[1]*o[8];
  o[10] := o[3]*o[3];
  o[11] := o[10]*tau2;
  o[12] := o[10]*o[3];
  o[13] := o[1]*o[3]*tau2;
  o[14] := g.tau*g.tau;
  o[15] := o[14]*o[14];
  o[16] := -0.015238081817394*o[11];
  o[17] := -0.106091843797284 + o[16];
  o[18] := o[17]*o[4];
  o[19] := 0.0040195606760414 + o[18];
  o[20] := o[19]*tau2;
  o[21] := g.pi*g.pi;
  o[22] := -0.0448944963879005*o[4];
  o[23] := -0.361672776066225 + o[22];
  o[24] := o[2]*o[23];
  o[25] := -0.176447663886292 + o[24];
  o[26] := o[25]*tau2;
  o[27] := o[3]*tau2;

  g.g := g.pi*(-0.0073362260186506 + o[9] + g.pi*(g.pi*((-0.0063498037657313
     - 0.086043093028588*o[12])*o[3] + g.pi*(o[13]*(
    0.007532158152277 - 0.0079238375446139*o[2]) + o[11]*g.pi*(
    -0.00022888160778447 - 0.002645650148281*tau2))) + (
    0.0020097803380207 + (-0.053045921898642 -
    0.007619040908697*o[11])*o[4])*tau2)) + (-0.00560879118302
     + g.tau*(0.07145273881455 + g.tau*(-0.4071049823928 + g.tau
    *(1.424081971444 + g.tau*(-4.38395111945 + g.tau*(-9.6937268393049
     + g.tau*(10.087275970006 + (-0.2840863260772 +
    0.02126846353307*g.tau)*g.tau) + Modelica.Math.log(g.pi)))))))
    /(o[15]*g.tau);

  g.gpi := (1.0 + g.pi*(-0.0073362260186506 + o[9] + g.pi*(o[20]
     + g.pi*((-0.0190494112971939 - 0.258129279085764*o[12])*o[
    3] + g.pi*(o[13]*(0.030128632609108 - 0.0316953501784556*o[
    2]) + o[11]*g.pi*(-0.00114440803892235 - 0.013228250741405*
    tau2))))))/g.pi;

  g.gpipi := (-1. + o[21]*(o[20] + g.pi*((-0.0380988225943878
     - 0.516258558171528*o[12])*o[3] + g.pi*(o[13]*(
    0.090385897827324 - 0.0950860505353668*o[2]) + o[11]*g.pi*(
    -0.0045776321556894 - 0.05291300296562*tau2)))))/o[21];

  g.gtau := (0.0280439559151 + g.tau*(-0.2858109552582 + g.tau*
    (1.2213149471784 + g.tau*(-2.848163942888 + g.tau*(
    4.38395111945 + o[14]*(10.087275970006 + (-0.5681726521544
     + 0.06380539059921*g.tau)*g.tau))))))/(o[14]*o[15]) + g.pi
    *(o[26] + g.pi*(0.0020097803380207 + (-0.371321453290494 -
    0.121904654539152*o[11])*o[4] + g.pi*((-0.0253992150629252
     - 1.37668948845741*o[12])*o[2] + g.pi*((0.052725107065939
     - 0.079238375446139*o[2])*o[4] + o[10]*g.pi*(-0.00205993447006023
     - 0.02645650148281*tau2)))));

  g.gtautau := (-0.1682637354906 + g.tau*(1.429054776291 + g.tau
    *(-4.8852597887136 + g.tau*(8.544491828664 + g.tau*(-8.7679022389
     + o[14]*(-0.5681726521544 + 0.12761078119842*g.tau)*g.tau)))))
    /(o[14]*o[15]*g.tau) + g.pi*(-0.176447663886292 + o[2]*(-1.4466911042649
     - 0.448944963879005*o[4]) + g.pi*((-2.22792871974296 -
    1.82856981808728*o[11])*o[27] + g.pi*(o[1]*(-0.0761976451887756
     - 20.6503423268611*o[12]) + g.pi*((0.316350642395634 -
    0.713145379015251*o[2])*o[27] + o[13]*g.pi*(-0.0164794757604818
     - 0.23810851334529*tau2)))));

  g.gtaupi := o[26] + g.pi*(0.0040195606760414 + (-0.742642906580988
     - 0.243809309078304*o[11])*o[4] + g.pi*((-0.0761976451887756
     - 4.13006846537222*o[12])*o[2] + g.pi*((0.210900428263756
     - 0.316953501784556*o[2])*o[4] + o[10]*g.pi*(-0.0102996723503012
     - 0.13228250741405*tau2))));
end g2metastable;
