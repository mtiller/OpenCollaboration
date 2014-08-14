within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function p2b_hs
  "pressure as a function of enthalpy and entropy in subregion 2a"
  extends Modelica.Icons.Function;
  input SI.SpecificEnthalpy h "specific enthalpy";
  input SI.SpecificEntropy s "specific entropy";
  output SI.Pressure p "Pressure";
  constant Real[:] n={0.801496989929495e-1,-0.543862807146111,
      0.337455597421283,0.890555451157450e1,0.313840736431485e3,
      0.797367065977789,-0.121616973556240e1,
      0.872803386937477e1,-0.169769781757602e2,-0.186552827328416e3,
      0.951159274344237e5,-0.189168510120494e2,-0.433407037194840e4,
      0.543212633012715e9,0.144793408386013,0.128024559637516e3,
      -0.672309534071268e5,0.336972380095287e8,-0.586634196762720e3,
      -0.221403224769889e11,0.171606668708389e4,-0.570817595806302e9,
      -0.312109693178482e4,-0.207841384633010e7,
      0.305605946157786e13,0.322157004314333e4,
      0.326810259797295e12,-0.144104158934487e4,
      0.410694867802691e3,0.109077066873024e12,-0.247964654258893e14,
      0.188801906865134e10,-0.123651009018773e15};
  constant Real[:] I={0,0,0,0,0,1,1,1,1,1,1,2,2,2,3,3,3,3,4,4,5,
      5,6,6,6,7,7,8,8,8,8,12,14};
  constant Real[:] J={0,1,2,4,8,0,1,2,3,5,12,1,6,18,0,1,7,12,1,
      16,1,12,1,8,18,1,16,1,3,14,18,10,16};
  constant SI.SpecificEnthalpy hstar=4100e3 "normalization enthalpy";
  constant SI.Pressure pstar=100e6 "normalization pressure";
  constant SI.SpecificEntropy sstar=7.9e3 "normalization entropy";
protected
  Real eta=h/hstar "normalized specific enthalpy";
  Real sigma=s/sstar "normalized specific entropy";
algorithm
  p := sum(n[i]*(eta - 0.6)^I[i]*(sigma - 1.01)^J[i] for i in 1
    :33)^4*pstar;
  annotation (Documentation(info="<html>
<p>
Equation number 4 from:<br>
The International Association for the Properties of Water and Steam<br>
Gaithersburg, Maryland, USA<br>
September 2001<br>
Supplementary Release on&nbsp; Backward Equations for Pressure as a
Function of Enthalpy and Entropy p(h,s) to the IAPWS Industrial
Formulation 1997 for the Thermodynamic Properties of Water and Steam<br>
</p>
      </html>
"));
end p2b_hs;
