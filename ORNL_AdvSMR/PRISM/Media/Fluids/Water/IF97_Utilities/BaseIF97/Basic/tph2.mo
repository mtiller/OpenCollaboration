within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function tph2 "reverse function for region 2: T(p,h)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  output SI.Temperature T "temperature (K)";
protected
  Real pi "dimensionless pressure";
  Real pi2b "dimensionless pressure";
  Real pi2c "dimensionless pressure";
  Real eta "dimensionless specific enthalpy";
  Real etabc "dimensionless specific enthalpy";
  Real eta2a "dimensionless specific enthalpy";
  Real eta2b "dimensionless specific enthalpy";
  Real eta2c "dimensionless specific enthalpy";
  Real[8] o "vector of auxiliary variables";
algorithm
  pi := p*data.IPSTAR;
  eta := h*data.IHSTAR;
  etabc := h*1.0e-3;
  if (pi < 4.0) then
    eta2a := eta - 2.1;
    o[1] := eta2a*eta2a;
    o[2] := o[1]*o[1];
    o[3] := pi*pi;
    o[4] := o[3]*o[3];
    o[5] := o[3]*pi;
    T := 1089.89523182880 + (1.84457493557900 -
      0.0061707422868339*pi)*pi + eta2a*(849.51654495535 -
      4.1792700549624*pi + eta2a*(-107.817480918260 + (
      6.2478196935812 - 0.310780466295830*pi)*pi + eta2a*(
      33.153654801263 - 17.3445631081140*pi + o[2]*(-7.4232016790248
       + pi*(-200.581768620960 + 11.6708730771070*pi) + o[1]*(
      271.960654737960*pi + o[1]*(-455.11318285818*pi + eta2a*(
      1.38657242832260*o[4] + o[1]*o[2]*(3091.96886047550*pi +
      o[1]*(11.7650487243560 + o[2]*(-13551.3342407750*o[5] + o[
      2]*(-62.459855192507*o[3]*o[4]*pi + o[2]*(o[4]*(
      235988.325565140 + 7399.9835474766*pi) + o[1]*(
      19127.7292396600*o[3]*o[4] + o[1]*(o[3]*(
      1.28127984040460e8 - 551966.97030060*o[5]) + o[1]*(-9.8554909623276e8
      *o[3] + o[1]*(2.82245469730020e9*o[3] + o[1]*(o[3]*(-3.5948971410703e9
       + 3.7154085996233e6*o[5]) + o[1]*pi*(252266.403578720 +
      pi*(1.72273499131970e9 + pi*(1.28487346646500e7 + (-1.31052365450540e7
       - 415351.64835634*o[3])*pi))))))))))))))))))));
  elseif (pi < (0.12809002730136e-03*etabc - 0.67955786399241)*
      etabc + 0.90584278514723e3) then
    eta2b := eta - 2.6;
    pi2b := pi - 2.0;
    o[1] := pi2b*pi2b;
    o[2] := o[1]*pi2b;
    o[3] := o[1]*o[1];
    o[4] := eta2b*eta2b;
    o[5] := o[4]*o[4];
    o[6] := o[4]*o[5];
    o[7] := o[5]*o[5];
    T := 1489.50410795160 + 0.93747147377932*pi2b + eta2b*(
      743.07798314034 + o[2]*(0.000110328317899990 -
      1.75652339694070e-18*o[1]*o[3]) + eta2b*(-97.708318797837
       + pi2b*(3.3593118604916 + pi2b*(-0.0218107553247610 +
      pi2b*(0.000189552483879020 + (2.86402374774560e-7 -
      8.1456365207833e-14*o[2])*pi2b))) + o[5]*(3.3809355601454
      *pi2b + o[4]*(-0.108297844036770*o[1] + o[5]*(
      2.47424647056740 + (0.168445396719040 + o[1]*(
      0.00308915411605370 - 0.0000107798573575120*pi2b))*pi2b
       + o[6]*(-0.63281320016026 + pi2b*(0.73875745236695 + (-0.046333324635812
       + o[1]*(-0.000076462712454814 + 2.82172816350400e-7*pi2b))
      *pi2b) + o[6]*(1.13859521296580 + pi2b*(-0.47128737436186
       + o[1]*(0.00135555045549490 + (0.0000140523928183160 +
      1.27049022719450e-6*pi2b)*pi2b)) + o[5]*(-0.47811863648625
       + (0.150202731397070 + o[2]*(-0.0000310838143314340 + o[
      1]*(-1.10301392389090e-8 - 2.51805456829620e-11*pi2b)))*
      pi2b + o[5]*o[7]*(0.0085208123431544 + pi2b*(-0.00217641142197500
       + pi2b*(0.000071280351959551 + o[1]*(-1.03027382121030e-6
       + (7.3803353468292e-8 + 8.6934156344163e-15*o[3])*pi2b))))))))))));
  else
    eta2c := eta - 1.8;
    pi2c := pi + 25.0;
    o[1] := pi2c*pi2c;
    o[2] := o[1]*o[1];
    o[3] := o[1]*o[2]*pi2c;
    o[4] := 1/o[3];
    o[5] := o[1]*o[2];
    o[6] := eta2c*eta2c;
    o[7] := o[2]*o[2];
    o[8] := o[6]*o[6];
    T := eta2c*((859777.22535580 + o[1]*(482.19755109255 +
      1.12615974072300e-12*o[5]))/o[1] + eta2c*((-5.8340131851590e11
       + (2.08255445631710e10 + 31081.0884227140*o[2])*pi2c)/o[
      5] + o[6]*(o[8]*(o[6]*(1.23245796908320e-7*o[5] + o[6]*(-1.16069211309840e-6
      *o[5] + o[8]*(0.0000278463670885540*o[5] + (-0.00059270038474176
      *o[5] + 0.00129185829918780*o[5]*o[6])*o[8]))) -
      10.8429848800770*pi2c) + o[4]*(7.3263350902181e12 + o[7]*
      (3.7966001272486 + (-0.045364172676660 -
      1.78049822406860e-11*o[2])*pi2c))))) + o[4]*(-3.2368398555242e12
       + pi2c*(3.5825089945447e11 + pi2c*(-1.07830682174700e10
       + o[1]*pi2c*(610747.83564516 + pi2c*(-25745.7236041700
       + (1208.23158659360 + 1.45591156586980e-13*o[5])*pi2c)))));
  end if;
end tph2;
