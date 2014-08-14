within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function T3b_ps "Region 3 b: inverse function T(p,s)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "Pressure";
  input SI.SpecificEntropy s "specific entropy";
  output SI.Temp_K T "Temperature";
protected
  constant Real[:] n={0.527111701601660,-0.401317830052742e2,
      0.153020073134484e3,-0.224799398218827e4,-0.193993484669048,-0.140467557893768e1,
      0.426799878114024e2,0.752810643416743,0.226657238616417e2,-0.622873556909932e3,
      -0.660823667935396,0.841267087271658,-0.253717501764397e2,
      0.485708963532948e3,0.880531517490555e3,0.265015592794626e7,-0.359287150025783,
      -0.656991567673753e3,0.241768149185367e1,0.856873461222588,
      0.655143675313458,-0.213535213206406,0.562974957606348e-2,-0.316955725450471e15,
      -0.699997000152457e-3,0.119845803210767e-1,0.193848122022095e-4,-0.215095749182309e-4};
  constant Real[:] I={-12,-12,-12,-12,-8,-8,-8,-6,-6,-6,-5,-5,-5,-5,-5,-4,-3,-3,
      -2,0,2,3,4,5,6,8,12,14};
  constant Real[:] J={1,3,4,7,0,1,3,0,2,4,0,1,2,4,6,12,1,6,2,0,1,1,0,24,0,3,1,2};
  constant SI.Temp_K Tstar=860 "normalization temperature";
  constant SI.Pressure pstar=100e6 "normalization pressure";
  constant SI.SpecificEntropy sstar=5.3e3 "normalization entropy";
  Real pi=p/pstar "normalized specific pressure";
  Real sigma=s/sstar "normalized specific entropy";
algorithm
  T := sum(n[i]*(pi + 0.760)^I[i]*(sigma - 0.818)^J[i] for i in 1:28)*Tstar;
  annotation (Documentation(info="<html>
 <p>
 &nbsp;Equation number 7 from:<br>
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
end T3b_ps;
