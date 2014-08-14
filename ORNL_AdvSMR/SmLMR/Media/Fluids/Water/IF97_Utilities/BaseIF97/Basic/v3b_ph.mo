within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function v3b_ph "Region 3 b: inverse function v(p,h)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "Pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  output SI.SpecificVolume v "specific volume";
protected
  constant Real[:] n={-0.225196934336318e-8,
      0.140674363313486e-7,0.233784085280560e-5,-0.331833715229001e-4,
      0.107956778514318e-2,-0.271382067378863,
      0.107202262490333e1,-0.853821329075382,-0.215214194340526e-4,
      0.769656088222730e-3,-0.431136580433864e-2,
      0.453342167309331,-0.507749535873652,-0.100475154528389e3,
      -0.219201924648793,-0.321087965668917e1,
      0.607567815637771e3,0.557686450685932e-3,
      0.187499040029550,0.905368030448107e-2,0.285417173048685,
      0.329924030996098e-1,0.239897419685483,
      0.482754995951394e1,-0.118035753702231e2,
      0.169490044091791,-0.179967222507787e-1,
      0.371810116332674e-1,-0.536288335065096e-1,
      0.160697101092520e1};
  constant Real[:] I={-12,-12,-8,-8,-8,-8,-8,-8,-6,-6,-6,-6,-6,
      -6,-4,-4,-4,-3,-3,-2,-2,-1,-1,-1,-1,0,1,1,2,2};
  constant Real[:] J={0,1,0,1,3,6,7,8,0,1,2,5,6,10,3,6,10,0,2,1,
      2,0,1,4,5,0,0,1,2,6};
  constant SI.Volume vstar=0.0088 "normalization temperature";
  constant SI.Pressure pstar=100e6 "normalization pressure";
  constant SI.SpecificEnthalpy hstar=2800e3 "normalization enthalpy";
  Real pi=p/pstar "normalized specific pressure";
  Real eta=h/hstar "normalized specific enthalpy";
algorithm
  v := sum(n[i]*(pi + 0.0661)^I[i]*(eta - 0.720)^J[i] for i in
    1:30)*vstar;
  annotation (Documentation(info="<html>
 <p>
 &nbsp;Equation number 5 from:<br>
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
end v3b_ph;
