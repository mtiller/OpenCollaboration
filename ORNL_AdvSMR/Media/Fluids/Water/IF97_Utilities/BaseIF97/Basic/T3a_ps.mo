within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function T3a_ps "Region 3 a: inverse function T(p,s)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "Pressure";
  input SI.SpecificEntropy s "specific entropy";
  output SI.Temp_K T "Temperature";
protected
  constant Real[:] n={0.150042008263875e10,-0.159397258480424e12,
      0.502181140217975e-3,-0.672057767855466e2,0.145058545404456e4,-0.823889534888890e4,
      -0.154852214233853,0.112305046746695e2,-0.297000213482822e2,
      0.438565132635495e11,0.137837838635464e-2,-0.297478527157462e1,
      0.971777947349413e13,-0.571527767052398e-4,0.288307949778420e5,-0.744428289262703e14,
      0.128017324848921e2,-0.368275545889071e3,0.664768904779177e16,
      0.449359251958880e-1,-0.422897836099655e1,-0.240614376434179,-0.474341365254924e1,
      0.724093999126110,0.923874349695897,0.399043655281015e1,
      0.384066651868009e-1,-0.359344365571848e-2,-0.735196448821653,
      0.188367048396131,0.141064266818704e-3,-0.257418501496337e-2,
      0.123220024851555e-2};
  constant Real[:] I={-12,-12,-10,-10,-10,-10,-8,-8,-8,-8,-6,-6,-6,-5,-5,-5,-4,
      -4,-4,-2,-2,-1,-1,0,0,0,1,2,2,3,8,8,10};
  constant Real[:] J={28,32,4,10,12,14,5,7,8,28,2,6,32,0,14,32,6,10,36,1,4,1,6,
      0,1,4,0,0,3,2,0,1,2};
  constant SI.Temp_K Tstar=760 "normalization temperature";
  constant SI.Pressure pstar=100e6 "normalization pressure";
  constant SI.SpecificEntropy sstar=4.4e3 "normalization entropy";
  Real pi=p/pstar "normalized specific pressure";
  Real sigma=s/sstar "normalized specific entropy";
algorithm
  T := sum(n[i]*(pi + 0.240)^I[i]*(sigma - 0.703)^J[i] for i in 1:33)*Tstar;
  annotation (Documentation(info="<html>
 <p>
 &nbsp;Equation number 6 from:<br>
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
end T3a_ps;
