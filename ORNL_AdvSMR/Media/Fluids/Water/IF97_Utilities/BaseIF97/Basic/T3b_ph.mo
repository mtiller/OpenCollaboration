within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function T3b_ph "Region 3 b: inverse function T(p,h)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "Pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  output SI.Temp_K T "Temperature";
protected
  constant Real[:] n={0.323254573644920e-4,-0.127575556587181e-3,-0.475851877356068e-3,
      0.156183014181602e-2,0.105724860113781,-0.858514221132534e2,
      0.724140095480911e3,0.296475810273257e-2,-0.592721983365988e-2,-0.126305422818666e-1,
      -0.115716196364853,0.849000969739595e2,-0.108602260086615e-1,
      0.154304475328851e-1,0.750455441524466e-1,0.252520973612982e-1,-0.602507901232996e-1,
      -0.307622221350501e1,-0.574011959864879e-1,0.503471360939849e1,-0.925081888584834,
      0.391733882917546e1,-0.773146007130190e2,0.949308762098587e4,-0.141043719679409e7,
      0.849166230819026e7,0.861095729446704,0.323346442811720,0.873281936020439,
      -0.436653048526683,0.286596714529479,-0.131778331276228,
      0.676682064330275e-2};
  constant Real[:] I={-12,-12,-10,-10,-10,-10,-10,-8,-8,-8,-8,-8,-6,-6,-6,-4,-4,
      -3,-2,-2,-1,-1,-1,-1,-1,-1,0,0,1,3,5,6,8};
  constant Real[:] J={0,1,0,1,5,10,12,0,1,2,4,10,0,1,2,0,1,5,0,4,2,4,6,10,14,16,
      0,2,1,1,1,1,1};
  constant SI.Temp_K Tstar=860 "normalization temperature";
  constant SI.Pressure pstar=100e6 "normalization pressure";
  constant SI.SpecificEnthalpy hstar=2800e3 "normalization enthalpy";
  Real pi=p/pstar "normalized specific pressure";
  Real eta=h/hstar "normalized specific enthalpy";
algorithm
  T := sum(n[i]*(pi + 0.298)^I[i]*(eta - 0.720)^J[i] for i in 1:33)*Tstar;
  annotation (Documentation(info="<html>
 <p>
 &nbsp;Equation number 3 from:<br>
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
end T3b_ph;
