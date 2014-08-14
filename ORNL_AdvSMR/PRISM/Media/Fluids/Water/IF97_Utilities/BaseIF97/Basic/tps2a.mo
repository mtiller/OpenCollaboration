within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function tps2a "reverse function for region 2a: T(p,s)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  output SI.Temperature T "temperature (K)";
protected
  Real[12] o "vector of auxiliary variables";
  constant Real IPSTAR=1.0e-6 "scaling variable";
  constant Real ISSTAR2A=1/2000.0 "scaling variable";
  Real pi "dimensionless pressure";
  Real sigma2a "dimensionless specific entropy";
algorithm
  pi := p*IPSTAR;
  sigma2a := s*ISSTAR2A - 2.0;
  o[1] := pi^0.5;
  o[2] := sigma2a*sigma2a;
  o[3] := o[2]*o[2];
  o[4] := o[3]*o[3];
  o[5] := o[4]*o[4];
  o[6] := pi^0.25;
  o[7] := o[2]*o[4]*o[5];
  o[8] := 1/o[7];
  o[9] := o[3]*sigma2a;
  o[10] := o[2]*o[3]*sigma2a;
  o[11] := o[3]*o[4]*sigma2a;
  o[12] := o[2]*sigma2a;
  T := ((-392359.83861984 + (515265.73827270 + o[3]*(
    40482.443161048 + o[2]*o[3]*(-321.93790923902 + o[2]*(
    96.961424218694 - 22.8678463717730*sigma2a))))*sigma2a)/(o[
    4]*o[5]) + o[6]*((-449429.14124357 + o[3]*(-5011.8336020166
     + 0.35684463560015*o[4]*sigma2a))/(o[2]*o[5]*sigma2a) + o[
    6]*(o[8]*(44235.335848190 + o[9]*(-13673.3888117080 + o[3]*
    (421632.60207864 + (22516.9258374750 + o[10]*(
    474.42144865646 - 149.311307976470*sigma2a))*sigma2a))) + o[
    6]*((-197811.263204520 - 23554.3994707600*sigma2a)/(o[2]*o[
    3]*o[4]*sigma2a) + o[6]*((-19070.6163020760 + o[11]*(
    55375.669883164 + (3829.3691437363 - 603.91860580567*o[2])*
    o[3]))*o[8] + o[6]*((1936.31026203310 + o[2]*(
    4266.0643698610 + o[2]*o[3]*o[4]*(-5978.0638872718 -
    704.01463926862*o[9])))/(o[2]*o[4]*o[5]*sigma2a) + o[1]*((
    338.36784107553 + o[12]*(20.8627866351870 + (
    0.033834172656196 - 0.000043124428414893*o[12])*o[3]))*
    sigma2a + o[6]*(166.537913564120 + sigma2a*(-139.862920558980
     + o[3]*(-0.78849547999872 + (0.072132411753872 + o[3]*(-0.0059754839398283
     + (-0.0000121413589539040 + 2.32270967338710e-7*o[2])*o[3]))
    *sigma2a)) + o[6]*(-10.5384635661940 + o[3]*(
    2.07189254965020 + (-0.072193155260427 +
    2.07498870811200e-7*o[4])*o[9]) + o[6]*(o[6]*(o[12]*(
    0.210375278936190 + 0.000256812397299990*o[3]*o[4]) + (-0.0127990029337810
     - 8.2198102652018e-6*o[11])*o[6]*o[9]) + o[10]*(-0.0183406579113790
     + 2.90362723486960e-7*o[2]*o[4]*sigma2a)))))))))))/(o[1]*
    pi);
end tps2a;
