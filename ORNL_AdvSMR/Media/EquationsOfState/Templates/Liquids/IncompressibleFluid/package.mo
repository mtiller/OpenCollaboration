within ORNL_AdvSMR.Media.EquationsOfState.Templates.Liquids;
package IncompressibleFluid "EoS for an incompressible liquid"
extends ORNL_AdvSMR.Media.EquationsOfState.Interfaces.Liquids(
    CompressibilityType=Types.Compressibility.ConstantDensity,
    analyticInverseTfromh=true);
import Modelon.Media.Interfaces.Types;
constant Modelon.Media.DataDefinitions.LinearLiquids.LinearFluid data;
constant Modelon.Media.Interfaces.Types.ValidityLimits limits(
  TMIN=200.0,
  TMAX=400.0,
  PMIN=0.001,
  PMAX=100.0e6,
  DMIN=1e-6,
  DMAX=1500.0)
  "Validity limits: several are arbitrarily chosen to provide good iteration bounds";


redeclare function extends h_pTX
  algorithm
  h := data.reference_h + (T - data.reference_T)*data.cp_const + (p - data.reference_p)
    /data.reference_d;
  annotation (smoothOrder=2.0);
  end h_pTX;


redeclare function T_phX
  "Return temperature from pressure, specific entropy and mass fraction"
  import Modelon;
  input Modelon.Media.Interfaces.State.Units.AbsolutePressure p "Pressure";
  input Modelon.Media.Interfaces.State.Units.SpecificEnthalpy h
    "Specific enthalpy";
  input Modelon.Media.Interfaces.State.Units.MassFraction[:] X
    "Mass fractions of composition";
  output Modelon.Media.Interfaces.State.Units.Temperature T "temperature";
  algorithm
  T := data.reference_T + (h - data.reference_h - (p - data.reference_p)/data.reference_d)
    /data.cp_const;
  end T_phX;


redeclare function extends s_pTX
  algorithm
  s := data.reference_s + data.cp_const*Modelica.Math.log(T/data.reference_T);
  annotation (smoothOrder=2.0);
  end s_pTX;


redeclare function extends T_psX
  "Return temperature from pressure, specific entropy and mass fraction"
  algorithm
  T := data.reference_T*Modelica.Math.exp((s - data.reference_s)/data.cp_const);
  end T_psX;


redeclare function extends d_pTX
  algorithm
  d := data.reference_d;
  annotation (smoothOrder=2.0);
  end d_pTX;


redeclare function extends v_pTX
  algorithm
  v := 1/data.reference_d;
  annotation (smoothOrder=2.0);
  end v_pTX;


redeclare function extends cp_pTX
  algorithm
  cp := data.cp_const;
  annotation (smoothOrder=2.0);
  end cp_pTX;


redeclare function extends beta_pTX
  algorithm
  beta := data.beta_const;
  annotation (smoothOrder=2.0);
  end beta_pTX;


redeclare function extends kappa_pTX
  algorithm
  kappa := data.kappa_const;
  annotation (smoothOrder=2.0);
  end kappa_pTX;


redeclare function extends his_pTX_p2
  import Modelon;
protected
  Modelon.Media.Interfaces.State.Units.SpecificEntropy s "Upstream entropy";
  Modelon.Media.Interfaces.State.Units.Temperature T2 "Downstream temperature";
  algorithm
  s := s_pTX(
      p,
      T,
      X);
  T2 := T_psX(
      p2,
      s,
      X);
  his := h_pTX(
      p2,
      T2,
      X);
  end his_pTX_p2;


redeclare function extends vaporPressure_pTX
  algorithm
  assert(false, "Vapor pressure not implemented for incompressible fluid");
  end vaporPressure_pTX;


redeclare function extends dddp_pTX
  algorithm
  dddp := 0;
  end dddp_pTX;


redeclare function extends dddT_pTX
  algorithm
  dddT := 0;
  end dddT_pTX;


redeclare function extends dddX_pTX
  algorithm
  dddX := fill(0.0, size(X, 1));
  end dddX_pTX;


redeclare function extends dudp_pTX
  algorithm
  dudp := 0;
  end dudp_pTX;


redeclare function extends dudT_pTX
  algorithm
  dudT := data.cp_const;
  end dudT_pTX;


annotation (Documentation(info="<html>
<p>Implementation of an incompressible fluid. Assumptions:</p>
<p><ul>
<li>No compressibility, i.e. density is independent of the thermodynamic state</li>
<li>Constant specific heat capacity</li>
</ul></p>
<p><br/>An analytic inverse of h(T) is implemented and used when calling T(h).</p>
</html>"));
end IncompressibleFluid;
