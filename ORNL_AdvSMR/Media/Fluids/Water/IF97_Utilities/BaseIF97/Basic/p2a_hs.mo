within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function p2a_hs
  "pressure as a function of enthalpy and entropy in subregion 2a"
  extends Modelica.Icons.Function;
  input SI.SpecificEnthalpy h "specific enthalpy";
  input SI.SpecificEntropy s "specific entropy";
  output SI.Pressure p "Pressure";
  constant Real[:] n={-0.182575361923032e-1,-0.125229548799536,
      0.592290437320145,0.604769706185122e1,0.238624965444474e3,-0.298639090222922e3,
      0.512250813040750e-1,-0.437266515606486,0.413336902999504,-0.516468254574773e1,
      -0.557014838445711e1,0.128555037824478e2,0.114144108953290e2,-0.119504225652714e3,
      -0.284777985961560e4,0.431757846408006e4,0.112894040802650e1,
      0.197409186206319e4,0.151612444706087e4,0.141324451421235e-1,
      0.585501282219601,-0.297258075863012e1,0.594567314847319e1,-0.623656565798905e4,
      0.965986235133332e4,0.681500934948134e1,-0.633207286824489e4,-0.558919224465760e1,
      0.400645798472063e-1};
  constant Real[:] I={0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,2,2,2,3,3,3,3,3,4,5,5,6,7};
  constant Real[:] J={1,3,6,16,20,22,0,1,2,3,5,6,10,16,20,22,3,16,20,0,2,3,6,16,
      16,3,16,3,1};
  constant SI.SpecificEnthalpy hstar=4200e3 "normalization enthalpy";
  constant SI.Pressure pstar=4e6 "normalization pressure";
  constant SI.SpecificEntropy sstar=12e3 "normalization entropy";
protected
  Real eta=h/hstar "normalized specific enthalpy";
  Real sigma=s/sstar "normalized specific entropy";
algorithm
  p := sum(n[i]*(eta - 0.5)^I[i]*(sigma - 1.2)^J[i] for i in 1:29)^4*pstar;
  annotation (Documentation(info="<html>
  <p>
  Equation number 3 from:<br>
  The International Association for the Properties of Water and Steam<br>
  Gaithersburg, Maryland, USA<br>
  September 2001<br>
  Supplementary Release on&nbsp; Backward Equations for Pressure as a
  Function of Enthalpy and Entropy p(h,s) to the IAPWS Industrial
  Formulation 1997 for the Thermodynamic Properties of Water and Steam<br>
</p>
  </html>
  "));
end p2a_hs;
