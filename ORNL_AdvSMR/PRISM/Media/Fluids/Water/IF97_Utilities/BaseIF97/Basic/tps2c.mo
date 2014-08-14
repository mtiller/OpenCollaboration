within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function tps2c "reverse function for region 2c: T(p,s)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  output SI.Temperature T "temperature (K)";
protected
  constant Real IPSTAR=1.0e-6 "scaling variable";
  constant Real ISSTAR2C=1/2925.1 "scaling variable";
  Real pi "dimensionless pressure";
  Real sigma2c "dimensionless specific entropy";
  Real[3] o "vector of auxiliary variables";
algorithm
  pi := p*IPSTAR;
  sigma2c := 2.0 - s*ISSTAR2C;
  o[1] := pi*pi;
  o[2] := sigma2c*sigma2c;
  o[3] := o[2]*o[2];
  T := (909.68501005365 + 2404.56670884200*sigma2c + pi*(-591.62326387130
     + pi*(541.45404128074 + sigma2c*(-270.983084111920 + (
    979.76525097926 - 469.66772959435*sigma2c)*sigma2c) + pi*(
    14.3992746047230 + (-19.1042042304290 + o[2]*(
    5.3299167111971 - 21.2529753759340*sigma2c))*sigma2c + pi*(
    -0.311473344137600 + (0.60334840894623 - 0.042764839702509*
    sigma2c)*sigma2c + pi*(0.0058185597255259 + (-0.0145970082847530
     + 0.0056631175631027*o[3])*sigma2c + pi*(-0.000076155864584577
     + sigma2c*(0.000224403429193320 - 0.0000125610950134130*o[
    2]*sigma2c) + pi*(6.3323132660934e-7 + (-2.05419896753750e-6
     + 3.6405370390082e-8*sigma2c)*sigma2c + pi*(-2.97598977892150e-9
     + 1.01366185297630e-8*sigma2c + pi*(5.9925719692351e-12 +
    sigma2c*(-2.06778701051640e-11 + o[2]*(-2.08742781818860e-11
     + (1.01621668250890e-10 - 1.64298282813470e-10*sigma2c)*
    sigma2c))))))))))))/o[1];
end tps2c;
