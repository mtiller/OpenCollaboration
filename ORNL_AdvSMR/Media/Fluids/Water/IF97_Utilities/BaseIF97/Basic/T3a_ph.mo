within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function T3a_ph "Region 3 a: inverse function T(p,h)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "Pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  output SI.Temp_K T "Temperature";
protected
  constant Real[:] n={-0.133645667811215e-6,0.455912656802978e-5,-0.146294640700979e-4,
      0.639341312970080e-2,0.372783927268847e3,-0.718654377460447e4,
      0.573494752103400e6,-0.267569329111439e7,-0.334066283302614e-4,-0.245479214069597e-1,
      0.478087847764996e2,0.764664131818904e-5,0.128350627676972e-2,
      0.171219081377331e-1,-0.851007304583213e1,-0.136513461629781e-1,-0.384460997596657e-5,
      0.337423807911655e-2,-0.551624873066791,0.729202277107470,-0.992522757376041e-2,
      -0.119308831407288,0.793929190615421,0.454270731799386,0.209998591259910,
      -0.642109823904738e-2,-0.235155868604540e-1,0.252233108341612e-2,-0.764885133368119e-2,
      0.136176427574291e-1,-0.133027883575669e-1};
  constant Real[:] I={-12,-12,-12,-12,-12,-12,-12,-12,-10,-10,-10,-8,-8,-8,-8,-5,
      -3,-2,-2,-2,-1,-1,0,0,1,3,3,4,4,10,12};
  constant Real[:] J={0,1,2,6,14,16,20,22,1,5,12,0,2,4,10,2,0,1,3,4,0,2,0,1,1,0,
      1,0,3,4,5};
  constant SI.SpecificEnthalpy hstar=2300e3 "normalization enthalpy";
  constant SI.Pressure pstar=100e6 "normalization pressure";
  constant SI.Temp_K Tstar=760 "normalization temperature";
  Real pi=p/pstar "normalized specific pressure";
  Real eta=h/hstar "normalized specific enthalpy";
algorithm
  T := sum(n[i]*(pi + 0.240)^I[i]*(eta - 0.615)^J[i] for i in 1:31)*Tstar;
  annotation (Documentation(info="<html>
 <p>
 &nbsp;Equation number 2 from:<br>
 <div style=\"text-align: center;\">&nbsp;[1] The international Association
 for the Properties of Water and Steam<br>
 &nbsp;Vejle, Denmark<br>
 &nbsp;August 2003<br>
 &nbsp;Supplementary Release on Backward Equations for the Fucnctions
 T(p,h), v(p,h) and T(p,s), <br>
 &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
 the Thermodynamic Properties of<br>
 &nbsp;Water and Steam</div>
</p>
 </html>"));
end T3a_ph;
