within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function v3b_ps "Region 3 b: inverse function v(p,s)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "Pressure";
  input SI.SpecificEntropy s "specific entropy";
  output SI.SpecificVolume v "specific volume";
protected
  constant Real[:] n={0.591599780322238e-4,-0.185465997137856e-2,
      0.104190510480013e-1,0.598647302038590e-2,-0.771391189901699,
      0.172549765557036e1,-0.467076079846526e-3,
      0.134533823384439e-1,-0.808094336805495e-1,
      0.508139374365767,0.128584643361683e-2,-0.163899353915435e1,
      0.586938199318063e1,-0.292466667918613e1,-0.614076301499537e-2,
      0.576199014049172e1,-0.121613320606788e2,
      0.167637540957944e1,-0.744135838773463e1,
      0.378168091437659e-1,0.401432203027688e1,
      0.160279837479185e2,0.317848779347728e1,-0.358362310304853e1,
      -0.115995260446827e7,0.199256573577909,-0.122270624794624,
      -0.191449143716586e2,-0.150448002905284e-1,
      0.146407900162154e2,-0.327477787188230e1};
  constant Real[:] I={-12,-12,-12,-12,-12,-12,-10,-10,-10,-10,-8,
      -5,-5,-5,-4,-4,-4,-4,-3,-2,-2,-2,-2,-2,-2,0,0,0,1,1,2};
  constant Real[:] J={0,1,2,3,5,6,0,1,2,4,0,1,2,3,0,1,2,3,1,0,1,
      2,3,4,12,0,1,2,0,2,2};
  constant SI.Volume vstar=0.0088 "normalization temperature";
  constant SI.Pressure pstar=100e6 "normalization pressure";
  constant SI.SpecificEntropy sstar=5.3e3 "normalization entropy";
  Real pi=p/pstar "normalized specific pressure";
  Real sigma=s/sstar "normalized specific entropy";
algorithm
  v := sum(n[i]*(pi + 0.298)^I[i]*(sigma - 0.816)^J[i] for i in
        1:31)*vstar;
  annotation (Documentation(info="<html>
 <p>
 &nbsp;Equation number 9 from:<br>
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
end v3b_ps;
