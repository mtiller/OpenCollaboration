within ORNL_AdvSMR.Media.HelmholtzMedia.Interfaces.PartialHelmholtzMedium.Transport;
function dynamicViscosity_dilute
  "Returns dynamic Viscosity dilute contribution"
  input ThermodynamicState state;
  output DynamicViscosity eta_0;

protected
  DynamicViscosityModel dynamicViscosityModel=dynamicViscosityCoefficients.dynamicViscosityModel;
  CollisionIntegralModel collisionIntegralModel=dynamicViscosityCoefficients.collisionIntegralModel;

  Temperature T_crit=fluidConstants[1].criticalTemperature;
  Temperature T_red_0=dynamicViscosityCoefficients.reducingTemperature_0;
  Temperature T_red_residual=dynamicViscosityCoefficients.reducingTemperature_residual;
  Real T_star "reduced temperature";
  Real tau "reduced temperature";

  Real[size(dynamicViscosityCoefficients.a, 1), 2] a=
      dynamicViscosityCoefficients.a;

  Real[size(dynamicViscosityCoefficients.CET, 1), 2] CET=
      dynamicViscosityCoefficients.CET;
  // Chapman-Enskog-Term
  Real Omega=0 "reduced effective cross section / Omega collision integral";
  Real sigma=dynamicViscosityCoefficients.sigma;

  Real eta_red_0=dynamicViscosityCoefficients.reducingViscosity_0;

algorithm
  // collision integral
  if (collisionIntegralModel == CollisionIntegralModel.CI0) then
    T_star := (state.T/dynamicViscosityCoefficients.epsilon_kappa);
    Omega := 1.16145/T_star^0.14874 + 0.52487*exp(-0.77320*T_star) + 2.16178*
      exp(-2.43787*T_star);
  elseif (collisionIntegralModel == CollisionIntegralModel.CI1) then
    T_star := Modelica.Math.log(state.T/dynamicViscosityCoefficients.epsilon_kappa);
    Omega := exp(sum(a[i, 1]*(T_star)^a[i, 2] for i in 1:size(a, 1)));
  elseif (collisionIntegralModel == CollisionIntegralModel.CI2) then
    T_star := (dynamicViscosityCoefficients.epsilon_kappa/state.T)^(1/3);
    Omega := 1/(sum(a[i, 1]*(T_star)^(4 - i) for i in 1:size(a, 1)));
  end if;

  // dilute gas (zero density) contribution
  // using the Chapman-Enskog-Term and the collision integral Omega
  if ((dynamicViscosityModel == DynamicViscosityModel.VS1) or (
      dynamicViscosityModel == DynamicViscosityModel.VS1_alternative)) then
    tau := state.T/T_red_0;
    // first term is the Chapman-Enskog-Term
    eta_0 := CET[1, 1]*sqrt(tau)/(sigma^2*Omega);
    // possibly further empirical terms
    eta_0 := eta_0 + sum(CET[i, 1]*(tau)^CET[i, 2] for i in 2:size(CET, 1));
  elseif (dynamicViscosityModel == DynamicViscosityModel.VS2) then
    eta_0 := CET[1, 1]*state.T^CET[1, 2]/(sigma^2*Omega);
  elseif (dynamicViscosityModel == DynamicViscosityModel.VS4) then
  end if;
  eta_0 := eta_0*eta_red_0;

  /* // following lines are for debugging only
  Modelica.Utilities.Streams.print("===========================================");
  Modelica.Utilities.Streams.print("        T = " + String(state.T));
  Modelica.Utilities.Streams.print("   T_star = " + String(T_star));
  Modelica.Utilities.Streams.print("      tau = " + String(tau));
  Modelica.Utilities.Streams.print("===========================================");
  Modelica.Utilities.Streams.print("    Omega = " + String(Omega));
  Modelica.Utilities.Streams.print("    eta_0 = " + String(eta_0));
  Modelica.Utilities.Streams.print("===========================================");
  */

  annotation (Documentation(info="<html>
<p>
This model is identical to the RefProp VS1 or VS2 model.

The viscosity is split into three contributions: 
zero density (dilute gas) viscosity eta_0, 
initial density contribution eta_1
and residual contribution eta_r.

This allows to develop functions for each contribution seperately.
The so called background viscosity is the sum of initial and residual viscosity.

At the critical point and a small region around the critical point, the viscosity is enhanced. 
As this critical enhancement is small, it is neglected here.

Special thanks go to Eric W. Lemmon for answering all my emails 
and programming a special version of RefProp that outputs also intermediate values.

</p>

<dl>
<dt> Lemmon, Eric W.; Huber, M. L. and McLinden, M. O.</dt>
<dd> <b>NIST Standard Reference Database 23: Reference Fluid Thermodynamic and Transport Properties - REFPROP. 9.0</b><br>
     National Institute of Standards and Technology, Standard Reference Data Program. Gaithersburg<br>
     URL: <a href=\"http://www.nist.gov/srd/nist23.cfm\">http://www.nist.gov/srd/nist23.cfm</a>
</dd>
<dt>Vogel, E.; K�chenmeister, C. and Birch, E.</dt>
<dd> <b>Reference correlation of the viscosity of propane</b>.<br>
     Journal of Thermophysics (1998) 10, 417-426.<br>
     DOI: <a href=\"http://dx.doi.org/10.1007/BF01133538\">10.1007/BF01133538</a>
</dd>
</dl>
</html>"));
end dynamicViscosity_dilute;
