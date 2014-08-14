within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function h3ab_p "ergion 3 a b boundary for pressure/enthalpy"
  extends Modelica.Icons.Function;
  output SI.SpecificEnthalpy h "Enthalpy";
  input SI.Pressure p "Pressure";
protected
  constant Real[:] n={0.201464004206875e4,0.374696550136983e1,-0.219921901054187e-1,
      0.875131686009950e-4};
  constant SI.SpecificEnthalpy hstar=1000 "normalization enthalpy";
  constant SI.Pressure pstar=1e6 "normalization pressure";
  Real pi=p/pstar "normalized specific pressure";

algorithm
  h := (n[1] + n[2]*pi + n[3]*pi^2 + n[4]*pi^3)*hstar;
  annotation (Documentation(info="<html>
      <p>
      &nbsp;Equation number 1 from:<br>
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
end h3ab_p;
