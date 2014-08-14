within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function tps2b "reverse function for region 2b: T(p,s)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  output SI.Temperature T "temperature (K)";
protected
  Real[8] o "vector of auxiliary variables";
  constant Real IPSTAR=1.0e-6 "scaling variable";
  constant Real ISSTAR2B=1/785.3 "scaling variable";
  Real pi "dimensionless pressure";
  Real sigma2b "dimensionless specific entropy";
algorithm
  pi := p*IPSTAR;
  sigma2b := 10.0 - s*ISSTAR2B;
  o[1] := pi*pi;
  o[2] := o[1]*o[1];
  o[3] := sigma2b*sigma2b;
  o[4] := o[3]*o[3];
  o[5] := o[4]*o[4];
  o[6] := o[3]*o[5]*sigma2b;
  o[7] := o[3]*o[5];
  o[8] := o[3]*sigma2b;
  T := (316876.65083497 + 20.8641758818580*o[6] + pi*(-398593.99803599
     - 21.8160585188770*o[6] + pi*(223697.851942420 + (-2784.17034458170
     + 9.9207436071480*o[7])*sigma2b + pi*(-75197.512299157 + (
    2970.86059511580 + o[7]*(-3.4406878548526 +
    0.38815564249115*sigma2b))*sigma2b + pi*(17511.2950857500
     + sigma2b*(-1423.71128544490 + (1.09438033641670 +
    0.89971619308495*o[4])*o[4]*sigma2b) + pi*(-3375.9740098958
     + (471.62885818355 + o[4]*(-1.91882419936790 + o[8]*(
    0.41078580492196 - 0.33465378172097*sigma2b)))*sigma2b + pi
    *(1387.00347775050 + sigma2b*(-406.63326195838 + sigma2b*(
    41.727347159610 + o[3]*(2.19325494345320 + sigma2b*(-1.03200500090770
     + (0.35882943516703 + 0.0052511453726066*o[8])*sigma2b))))
     + pi*(12.8389164507050 + sigma2b*(-2.86424372193810 +
    sigma2b*(0.56912683664855 + (-0.099962954584931 + o[4]*(-0.0032632037778459
     + 0.000233209225767230*sigma2b))*sigma2b)) + pi*(-0.153348098574500
     + (0.0290722882399020 + 0.00037534702741167*o[4])*sigma2b
     + pi*(0.00172966917024110 + (-0.00038556050844504 -
    0.000035017712292608*o[3])*sigma2b + pi*(-0.0000145663936314920
     + 5.6420857267269e-6*sigma2b + pi*(4.1286150074605e-8 + (-2.06846711188240e-8
     + 1.64093936747250e-9*sigma2b)*sigma2b))))))))))))/(o[1]*o[
    2]);
end tps2b;
