within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function p2c_hs
  "pressure as a function of enthalpy and entropy in subregion 2c"
  extends Modelica.Icons.Function;
  input SI.SpecificEnthalpy h "specific enthalpy";
  input SI.SpecificEntropy s "specific entropy";
  output SI.Pressure p "Pressure";
  constant Real[:] n={0.112225607199012,-0.339005953606712e1,-0.320503911730094e2,
      -0.197597305104900e3,-0.407693861553446e3,
      0.132943775222331e5,0.170846839774007e1,
      0.373694198142245e2,0.358144365815434e4,
      0.423014446424664e6,-0.751071025760063e9,
      0.523446127607898e2,-0.228351290812417e3,-0.960652417056937e6,
      -0.807059292526074e8,0.162698017225669e13,
      0.772465073604171,0.463929973837746e5,-0.137317885134128e8,
      0.170470392630512e13,-0.251104628187308e14,
      0.317748830835520e14,0.538685623675312e2,-0.553089094625169e5,
      -0.102861522421405e7,0.204249418756234e13,
      0.273918446626977e9,-0.263963146312685e16,-0.107890854108088e10,
      -0.296492620980124e11,-0.111754907323424e16};
  constant Real[:] I={0,0,0,0,0,0,1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,
      4,5,5,5,5,6,6,10,12,16};
  constant Real[:] J={0,1,2,3,4,8,0,2,5,8,14,2,3,7,10,18,0,5,8,
      16,18,18,1,4,6,14,8,18,7,7,10};
  constant SI.SpecificEnthalpy hstar=3500e3 "normalization enthalpy";
  constant SI.Pressure pstar=100e6 "normalization pressure";
  constant SI.SpecificEntropy sstar=5.9e3 "normalization entropy";
protected
  Real eta=h/hstar "normalized specific enthalpy";
  Real sigma=s/sstar "normalized specific entropy";
algorithm
  p := sum(n[i]*(eta - 0.7)^I[i]*(sigma - 1.1)^J[i] for i in 1:
    31)^4*pstar;
  annotation (Documentation(info="<html>
      <p>
      Equation number 5 from:<br>
      The International Association for the Properties of Water and Steam<br>
      Gaithersburg, Maryland, USA<br>
      September 2001<br>
      Supplementary Release on&nbsp; Backward Equations for Pressure as a
      Function of Enthalpy and Entropy p(h,s) to the IAPWS Industrial
      Formulation 1997 for the Thermodynamic Properties of Water and Steam<br>
   </p>
      </html>
      "));
end p2c_hs;
