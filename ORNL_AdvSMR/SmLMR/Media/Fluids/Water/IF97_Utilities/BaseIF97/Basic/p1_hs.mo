within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function p1_hs "pressure as a function of ehtnalpy and entropy in region 1"
  extends Modelica.Icons.Function;
  input SI.SpecificEnthalpy h "specific enthalpy";
  input SI.SpecificEntropy s "specific entropy";
  output SI.Pressure p "Pressure";
  constant Real[:] n={-0.691997014660582,-0.183612548787560e2,-0.928332409297335e1,
      0.659639569909906e2,-0.162060388912024e2,
      0.450620017338667e3,0.854680678224170e3,
      0.607523214001162e4,0.326487682621856e2,-0.269408844582931e2,
      -0.319947848334300e3,-0.928354307043320e3,
      0.303634537455249e2,-0.650540422444146e2,-0.430991316516130e4,
      -0.747512324096068e3,0.730000345529245e3,
      0.114284032569021e4,-0.436407041874559e3};
  constant Real[:] I={0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,3,4,4,5};
  constant Real[:] J={0,1,2,4,5,6,8,14,0,1,4,6,0,1,10,4,1,4,0};
  constant SI.SpecificEnthalpy hstar=3400e3 "normalization enthalpy";
  constant SI.Pressure pstar=100e6 "normalization pressure";
  constant SI.SpecificEntropy sstar=7.6e3 "normalization entropy";
protected
  Real eta=h/hstar "normalized specific enthalpy";
  Real sigma=s/sstar "normalized specific entropy";
algorithm
  p := sum(n[i]*(eta + 0.05)^I[i]*(sigma + 0.05)^J[i] for i in
    1:19)*pstar;
  annotation (Documentation(info="<html>
<p>
  Equation number 1 from:<br>
  The International Association for the Properties of Water and Steam<br>
  Gaithersburg, Maryland, USA<br>
  September 2001<br>
  Supplementary Release on&nbsp; Backward Equations for Pressure as a
  Function of Enthalpy and Entropy p(h,s) to the IAPWS Industrial
  Formulation 1997 for the Thermodynamic Properties of Water and Steam<br>
</p>
  </html>
  "));
end p1_hs;
