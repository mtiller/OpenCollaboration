within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function h2ab_s "boundary between regions 2a and 2b"
  extends Modelica.Icons.Function;
  output SI.SpecificEnthalpy h "Enthalpy";
  input SI.SpecificEntropy s "Entropy";
protected
  constant Real[:] n={-0.349898083432139e4,0.257560716905876e4,
      -0.421073558227969e3,0.276349063799944e2};
  constant SI.SpecificEnthalpy hstar=1e3 "normalization enthalpy";
  constant SI.SpecificEntropy sstar=1e3 "normalization entropy";
  Real sigma=s/sstar "normalized specific entropy";
algorithm
  h := (n[1] + n[2]*sigma + n[3]*sigma^2 + n[4]*sigma^3)*hstar;
  annotation (Documentation(info="<html>
  <p>
  Equation number 2 from:<br>
  The International Association for the Properties of Water and Steam<br>
  Gaithersburg, Maryland, USA<br>
  September 2001<br>
  Supplementary Release on&nbsp; Backward Equations for Pressure as a
  Function of Enthalpy and Entropy p(h,s) to the IAPWS Industrial
  Formulation 1997 for the Thermodynamic Properties of Water and Steam<br>
</p>
  </html>
  "));
end h2ab_s;
