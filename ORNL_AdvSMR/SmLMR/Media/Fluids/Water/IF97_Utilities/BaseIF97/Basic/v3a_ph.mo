within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function v3a_ph "Region 3 a: inverse function v(p,h)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "Pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  output SI.SpecificVolume v "specific volume";
protected
  constant Real[:] n={0.529944062966028e-2,-0.170099690234461,
      0.111323814312927e2,-0.217898123145125e4,-0.506061827980875e-3,
      0.556495239685324,-0.943672726094016e1,-0.297856807561527,
      0.939353943717186e2,0.192944939465981e-1,
      0.421740664704763,-0.368914126282330e7,-0.737566847600639e-2,
      -0.354753242424366,-0.199768169338727e1,
      0.115456297059049e1,0.568366875815960e4,
      0.808169540124668e-2,0.172416341519307,
      0.104270175292927e1,-0.297691372792847,0.560394465163593,
      0.275234661176914,-0.148347894866012,-0.651142513478515e-1,
      -0.292468715386302e1,0.664876096952665e-1,
      0.352335014263844e1,-0.146340792313332e-1,-0.224503486668184e1,
      0.110533464706142e1,-0.408757344495612e-1};
  constant Real[:] I={-12,-12,-12,-12,-10,-10,-10,-8,-8,-6,-6,-6,
      -4,-4,-3,-2,-2,-1,-1,-1,-1,0,0,1,1,1,2,2,3,4,5,8};
  constant Real[:] J={6,8,12,18,4,7,10,5,12,3,4,22,2,3,7,3,16,0,
      1,2,3,0,1,0,1,2,0,2,0,2,2,2};
  constant SI.Volume vstar=0.0028 "normalization temperature";
  constant SI.Pressure pstar=100e6 "normalization pressure";
  constant SI.SpecificEnthalpy hstar=2100e3 "normalization enthalpy";
  Real pi=p/pstar "normalized specific pressure";
  Real eta=h/hstar "normalized specific enthalpy";
algorithm
  v := sum(n[i]*(pi + 0.128)^I[i]*(eta - 0.727)^J[i] for i in 1
    :32)*vstar;
  annotation (Documentation(info="<html>
 <p>
 &nbsp;Equation number 4 from:<br>
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
end v3a_ph;
