within ORNL_AdvSMR.Media.HelmholtzMedia.Interfaces.PartialHelmholtzMedium.EoS;
function setHelmholtzDerivsFirst

  input Density d;
  input Temperature T;
  input FixedPhase phase=1;
  output HelmholtzDerivs f;

protected
  constant MolarMass MM=fluidConstants[1].molarMass;
  constant Density d_crit=MM/fluidConstants[1].criticalMolarVolume;
  constant Temperature T_crit=fluidConstants[1].criticalTemperature;
  constant Real delta(unit="1") = d/d_crit "reduced density";
  constant Real tau(unit="1") = T_crit/T "inverse reduced temperature";

algorithm
  f.d := d;
  f.T := T;
  f.delta := delta;
  f.tau := tau;

  if (phase == 1) then
    f.i := f_i(tau=tau, delta=delta);
    f.it := f_it(tau=tau, delta=delta);

    f.r := f_r(tau=tau, delta=delta);
    f.rt := f_rt(tau=tau, delta=delta);
    f.rd := f_rd(tau=tau, delta=delta);
  else
    assert(false,
      "This function will return valid values for single phase input only!");
  end if;

end setHelmholtzDerivsFirst;
