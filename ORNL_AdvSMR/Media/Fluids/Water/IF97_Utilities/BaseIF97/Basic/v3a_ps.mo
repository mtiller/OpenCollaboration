within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function v3a_ps "Region 3 a: inverse function v(p,s)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "Pressure";
  input SI.SpecificEntropy s "specific entropy";
  output SI.SpecificVolume v "specific volume";
protected
  constant Real[:] n={0.795544074093975e2,-0.238261242984590e4,
      0.176813100617787e5,-0.110524727080379e-2,-0.153213833655326e2,
      0.297544599376982e3,-0.350315206871242e8,0.277513761062119,-0.523964271036888,
      -0.148011182995403e6,0.160014899374266e7,0.170802322663427e13,
      0.246866996006494e-3,0.165326084797980e1,-0.118008384666987,
      0.253798642355900e1,0.965127704669424,-0.282172420532826e2,
      0.203224612353823,0.110648186063513e1,0.526127948451280,0.277000018736321,
      0.108153340501132e1,-0.744127885357893e-1,0.164094443541384e-1,-0.680468275301065e-1,
      0.257988576101640e-1,-0.145749861944416e-3};
  constant Real[:] I={-12,-12,-12,-10,-10,-10,-10,-8,-8,-8,-8,-6,-5,-4,-3,-3,-2,
      -2,-1,-1,0,0,0,1,2,4,5,6};
  constant Real[:] J={10,12,14,4,8,10,20,5,6,14,16,28,1,5,2,4,3,8,1,2,0,1,3,0,0,
      2,2,0};
  constant SI.Volume vstar=0.0028 "normalization temperature";
  constant SI.Pressure pstar=100e6 "normalization pressure";
  constant SI.SpecificEntropy sstar=4.4e3 "normalization entropy";
  Real pi=p/pstar "normalized specific pressure";
  Real sigma=s/sstar "normalized specific entropy";
algorithm
  v := sum(n[i]*(pi + 0.187)^I[i]*(sigma - 0.755)^J[i] for i in 1:28)*vstar;
  annotation (Documentation(info="<html>
 <p>
 &nbsp;Equation number 8 from:<br>
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
end v3a_ps;
