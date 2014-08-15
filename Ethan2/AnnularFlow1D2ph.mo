within Ethan2;
model AnnularFlow1D2ph
  "2 DHT port 1-dimensional fluid flow model for water/steam (finite volumes, 2-phase)"
  extends Ethan2.AnnularFlow1DBase(redeclare replaceable package Medium =
        ThermoPower3.Water.StandardWater constrainedby
      Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model",
      FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.TwoPhases);
  import ThermoPower3.Choices.Flow1D.FFtypes;
  import ThermoPower3.Choices.Flow1D.HCtypes;
  package SmoothMedium = Medium (final smoothModel=true);
  constant Modelica.SIunits.Pressure pzero=10 "Small deltap for calculations";
  constant Modelica.SIunits.Pressure pc=Medium.fluidConstants[1].criticalPressure;
  constant Modelica.SIunits.SpecificEnthalpy hzero=1e-3
    "Small value for deltah";
  SmoothMedium.ThermodynamicState fluidState[N]
    "Thermodynamic state of the fluid at the nodes";
  Medium.SaturationProperties sat "Properties of saturated fluid";
  Modelica.SIunits.Length omega_hyd "Wet perimeter (single tube)";
  Modelica.SIunits.Pressure Dpfric "Pressure drop due to friction";
  Modelica.SIunits.Pressure Dpstat "Pressure drop due to static head";
  Real Kf[N - 1] "Friction coefficient";
  Real Kfl[N - 1] "Linear friction coefficient";
  Real Cf[N - 1] "Fanning friction factor";
  Real dwdt "Dynamic momentum term";
  Medium.AbsolutePressure p(start=pstart, stateSelect=StateSelect.prefer)
    "Fluid pressure for property calculations";
  Modelica.SIunits.Pressure dpf[N - 1]
    "Pressure drop due to friction between two nodes";
  Modelica.SIunits.MassFlowRate w(start=wnom/Nt) "Mass flowrate (single tube)";
  Modelica.SIunits.MassFlowRate wbar[N - 1](each start=wnom/Nt);
  Modelica.SIunits.Velocity u[N] "Fluid velocity";
  Medium.Temperature T[N] "Fluid temperature";
  Medium.Temperature Ts "Saturated water temperature";
  Medium.SpecificEnthalpy h[N](start=hstart) "Fluid specific enthalpy";
  Medium.SpecificEnthalpy htilde[N - 1](start=hstart[2:N], stateSelect=
        StateSelect.prefer) "Enthalpy state variables";
  Medium.SpecificEnthalpy hl "Saturated liquid temperature";
  Medium.SpecificEnthalpy hv "Saturated vapour temperature";
  Real x[N] "Steam quality";
  Medium.Density rho[N] "Fluid density";
  ThermoPower3.LiquidDensity rhol "Saturated liquid density";
  ThermoPower3.GasDensity rhov "Saturated vapour density";
  Modelica.SIunits.Mass M "Fluid mass";
protected
  Modelica.SIunits.DerEnthalpyByPressure dhldp
    "Derivative of saturated liquid enthalpy by pressure";
  Modelica.SIunits.DerEnthalpyByPressure dhvdp
    "Derivative of saturated vapour enthalpy by pressure";
  ThermoPower3.Density rhobar[N - 1] "Fluid average density";
  Modelica.SIunits.DerDensityByPressure drdp[N]
    "Derivative of density by pressure";
  Modelica.SIunits.DerDensityByPressure drbdp[N - 1]
    "Derivative of average density by pressure";
  Modelica.SIunits.DerDensityByPressure drldp
    "Derivative of saturated liquid density by pressure";
  Modelica.SIunits.DerDensityByPressure drvdp
    "Derivative of saturated vapour density by pressure";
  Modelica.SIunits.SpecificVolume vbar[N - 1] "Average specific volume";
  Modelica.SIunits.HeatFlux phibar[N - 1] "Average heat flux";
  Modelica.SIunits.DerDensityByEnthalpy drdh[N]
    "Derivative of density by enthalpy";
  Modelica.SIunits.DerDensityByEnthalpy drbdh1[N - 1]
    "Derivative of average density by left enthalpy";
  Modelica.SIunits.DerDensityByEnthalpy drbdh2[N - 1]
    "Derivative of average density by right enthalpy";
  Real AA;
  Real AA1;
  Real dMdt[N - 1] "Derivative of fluid mass in each volume";
equation
  assert(FFtype == FFtypes.NoFriction or dpnom > 0,
    "dpnom=0 not supported, it is also used in the homotopy trasformation during the inizialization");
  //All equations are referred to a single tube
  omega_hyd = 4*A/(Dhyd1+Dhyd2);
  // Friction factor selection
  for j in 1:(N - 1) loop
    if FFtype == FFtypes.Kfnom then
      Kf[j] = Kfnom*Kfc/(N - 1);
      Cf[j] = 2*Kf[j]*A^3/(omega_hyd*l);
    elseif FFtype == FFtypes.OpPoint then
      Kf[j] = dpnom*rhonom/(wnom/Nt)^2/(N - 1)*Kfc;
      Cf[j] = 2*Kf[j]*A^3/(omega_hyd*l);
    elseif FFtype == FFtypes.Cfnom then
      Kf[j] = Cfnom*omega_hyd*l/(2*A^3)*Kfc;
      Cf[j] = 2*Kf[j]*A^3/(omega_hyd*l);
    elseif FFtype == FFtypes.Colebrook then
      Cf[j] = if noEvent(htilde[j] < hl or htilde[j] > hv) then
        ThermoPower3.Water.f_colebrook(
        w,
        (Dhyd1+Dhyd2)/A,
        e,
        Medium.dynamicViscosity(fluidState[j]))*Kfc else
        ThermoPower3.Water.f_colebrook_2ph(
        w,
        (Dhyd1+Dhyd2)/A,
        e,
        Medium.dynamicViscosity(Medium.setBubbleState(sat, 1)),
        Medium.dynamicViscosity(Medium.setDewState(sat, 1)),
        x[j])*Kfc;
      Kf[j] = Cf[j]*omega_hyd*l/(2*A^3);
    elseif FFtype == FFtypes.NoFriction then
      Cf[j] = 0;
      Kf[j] = 0;
    else
      assert(FFtype <> FFtypes.NoFriction, "Unsupported FFtype");
      Cf[j] = 0;
      Kf[j] = 0;
    end if;
    assert(Kf[j] >= 0, "Negative friction coefficient");
    Kfl[j] = wnom/Nt*wnf*Kf[j];
  end for;

  // Dynamic momentum term
  if DynamicMomentum then
    dwdt = der(w);
  else
    dwdt = 0;
  end if;

  sum(dMdt) = (infl.m_flow/Nt + outfl.m_flow/Nt) "Mass balance";
  sum(dpf) = Dpfric "Total pressure drop due to friction";
  Dpstat = if abs(dzdx) < 1e-6 then 0 else g*l*dzdx*sum(rhobar)
    "Pressure drop due to static head";
  L/A*dwdt + (outfl.p - infl.p) + Dpstat + Dpfric = 0 "Momentum balance";
  for j in 1:(N - 1) loop
    A*l*rhobar[j]*der(htilde[j]) + wbar[j]*(h[j + 1] - h[j]) - A*l*der(p) = l
      *omega*phibar[j] "Energy balance";
    dMdt[j] = A*l*(drbdh1[j]*der(h[j]) + drbdh2[j]*der(h[j + 1]) + drbdp[j]*
      der(p)) "Mass balance for each volume";
    // Average volume quantities
    vbar[j] = 1/rhobar[j] "Average specific volume";
    wbar[j] = homotopy(infl.m_flow/Nt - sum(dMdt[1:j - 1]) - dMdt[j]/2, wnom/
      Nt);
    dpf[j] = (if FFtype == FFtypes.NoFriction then 0 else homotopy(smooth(1,
      Kf[j]*squareReg(w, wnom/Nt*wnf))*vbar[j], dpnom/(N - 1)/(wnom/Nt)*w));
    if avoidInletEnthalpyDerivative and j == 1 then
      // first volume properties computed by the outlet properties
      rhobar[j] = rho[j + 1];
      drbdp[j] = drdp[j + 1];
      drbdh1[j] = 0;
      drbdh2[j] = drdh[j + 1];
    elseif noEvent((h[j] < hl and h[j + 1] < hl) or (h[j] > hv and h[j + 1]
         > hv) or p >= (pc - pzero) or abs(h[j + 1] - h[j]) < hzero) then
      // 1-phase or almost uniform properties
      rhobar[j] = (rho[j] + rho[j + 1])/2;
      drbdp[j] = (drdp[j] + drdp[j + 1])/2;
      drbdh1[j] = drdh[j]/2;
      drbdh2[j] = drdh[j + 1]/2;
    elseif noEvent(h[j] >= hl and h[j] <= hv and h[j + 1] >= hl and h[j + 1]
         <= hv) then
      // 2-phase
      rhobar[j] = AA*Modelica.Math.log(rho[j]/rho[j + 1])/(h[j + 1] - h[j]);
      drbdp[j] = (AA1*Modelica.Math.log(rho[j]/rho[j + 1]) + AA*(1/rho[j]*drdp[
        j] - 1/rho[j + 1]*drdp[j + 1]))/(h[j + 1] - h[j]);
      drbdh1[j] = (rhobar[j] - rho[j])/(h[j + 1] - h[j]);
      drbdh2[j] = (rho[j + 1] - rhobar[j])/(h[j + 1] - h[j]);
    elseif noEvent(h[j] < hl and h[j + 1] >= hl and h[j + 1] <= hv) then
      // liquid/2-phase
      rhobar[j] = ((rho[j] + rhol)*(hl - h[j])/2 + AA*Modelica.Math.log(rhol/
        rho[j + 1]))/(h[j + 1] - h[j]);
      drbdp[j] = ((drdp[j] + drldp)*(hl - h[j])/2 + (rho[j] + rhol)/2*dhldp +
        AA1*Modelica.Math.log(rhol/rho[j + 1]) + AA*(1/rhol*drldp - 1/rho[j + 1]
        *drdp[j + 1]))/(h[j + 1] - h[j]);
      drbdh1[j] = (rhobar[j] - (rho[j] + rhol)/2 + drdh[j]*(hl - h[j])/2)/(h[
        j + 1] - h[j]);
      drbdh2[j] = (rho[j + 1] - rhobar[j])/(h[j + 1] - h[j]);
    elseif noEvent(h[j] >= hl and h[j] <= hv and h[j + 1] > hv) then
      // 2-phase/vapour
      rhobar[j] = (AA*Modelica.Math.log(rho[j]/rhov) + (rhov + rho[j + 1])*(h[j +
        1] - hv)/2)/(h[j + 1] - h[j]);
      drbdp[j] = (AA1*Modelica.Math.log(rho[j]/rhov) + AA*(1/rho[j]*drdp[j] - 1/
        rhov*drvdp) + (drvdp + drdp[j + 1])*(h[j + 1] - hv)/2 - (rhov + rho[j +
        1])/2*dhvdp)/(h[j + 1] - h[j]);
      drbdh1[j] = (rhobar[j] - rho[j])/(h[j + 1] - h[j]);
      drbdh2[j] = ((rhov + rho[j + 1])/2 - rhobar[j] + drdh[j + 1]*(h[j + 1]
         - hv)/2)/(h[j + 1] - h[j]);
    elseif noEvent(h[j] < hl and h[j + 1] > hv) then
      // liquid/2-phase/vapour
      rhobar[j] = ((rho[j] + rhol)*(hl - h[j])/2 + AA*Modelica.Math.log(rhol/
        rhov) + (rhov + rho[j + 1])*(h[j + 1] - hv)/2)/(h[j + 1] - h[j]);
      drbdp[j] = ((drdp[j] + drldp)*(hl - h[j])/2 + (rho[j] + rhol)/2*dhldp +
        AA1*Modelica.Math.log(rhol/rhov) + AA*(1/rhol*drldp - 1/rhov*drvdp) + (
        drvdp + drdp[j + 1])*(h[j + 1] - hv)/2 - (rhov + rho[j + 1])/2*dhvdp)/(
        h[j + 1] - h[j]);
      drbdh1[j] = (rhobar[j] - (rho[j] + rhol)/2 + drdh[j]*(hl - h[j])/2)/(h[
        j + 1] - h[j]);
      drbdh2[j] = ((rhov + rho[j + 1])/2 - rhobar[j] + drdh[j + 1]*(h[j + 1]
         - hv)/2)/(h[j + 1] - h[j]);
    elseif noEvent(h[j] >= hl and h[j] <= hv and h[j + 1] < hl) then
      // 2-phase/liquid
      rhobar[j] = (AA*Modelica.Math.log(rho[j]/rhol) + (rhol + rho[j + 1])*(h[j +
        1] - hl)/2)/(h[j + 1] - h[j]);
      drbdp[j] = (AA1*Modelica.Math.log(rho[j]/rhol) + AA*(1/rho[j]*drdp[j] - 1/
        rhol*drldp) + (drldp + drdp[j + 1])*(h[j + 1] - hl)/2 - (rhol + rho[j +
        1])/2*dhldp)/(h[j + 1] - h[j]);
      drbdh1[j] = (rhobar[j] - rho[j])/(h[j + 1] - h[j]);
      drbdh2[j] = ((rhol + rho[j + 1])/2 - rhobar[j] + drdh[j + 1]*(h[j + 1]
         - hl)/2)/(h[j + 1] - h[j]);
    elseif noEvent(h[j] > hv and h[j + 1] < hl) then
      // vapour/2-phase/liquid
      rhobar[j] = ((rho[j] + rhov)*(hv - h[j])/2 + AA*Modelica.Math.log(rhov/
        rhol) + (rhol + rho[j + 1])*(h[j + 1] - hl)/2)/(h[j + 1] - h[j]);
      drbdp[j] = ((drdp[j] + drvdp)*(hv - h[j])/2 + (rho[j] + rhov)/2*dhvdp +
        AA1*Modelica.Math.log(rhov/rhol) + AA*(1/rhov*drvdp - 1/rhol*drldp) + (
        drldp + drdp[j + 1])*(h[j + 1] - hl)/2 - (rhol + rho[j + 1])/2*dhldp)/(
        h[j + 1] - h[j]);
      drbdh1[j] = (rhobar[j] - (rho[j] + rhov)/2 + drdh[j]*(hv - h[j])/2)/(h[
        j + 1] - h[j]);
      drbdh2[j] = ((rhol + rho[j + 1])/2 - rhobar[j] + drdh[j + 1]*(h[j + 1]
         - hl)/2)/(h[j + 1] - h[j]);
    else
      // vapour/2-phase
      rhobar[j] = ((rho[j] + rhov)*(hv - h[j])/2 + AA*Modelica.Math.log(rhov/
        rho[j + 1]))/(h[j + 1] - h[j]);
      drbdp[j] = ((drdp[j] + drvdp)*(hv - h[j])/2 + (rho[j] + rhov)/2*dhvdp +
        AA1*Modelica.Math.log(rhov/rho[j + 1]) + AA*(1/rhov*drvdp - 1/rho[j + 1]
        *drdp[j + 1]))/(h[j + 1] - h[j]);
      drbdh1[j] = (rhobar[j] - (rho[j] + rhov)/2 + drdh[j]*(hv - h[j])/2)/(h[
        j + 1] - h[j]);
      drbdh2[j] = (rho[j + 1] - rhobar[j])/(h[j + 1] - h[j]);
    end if;
  end for;

  // Saturated fluid property calculations
  sat = Medium.setSat_p(p);
  Ts = sat.Tsat;
  rhol = Medium.bubbleDensity(sat);
  rhov = Medium.dewDensity(sat);
  hl = Medium.bubbleEnthalpy(sat);
  hv = Medium.dewEnthalpy(sat);
  drldp = Medium.dBubbleDensity_dPressure(sat);
  drvdp = Medium.dDewDensity_dPressure(sat);
  dhldp = Medium.dBubbleEnthalpy_dPressure(sat);
  dhvdp = Medium.dDewEnthalpy_dPressure(sat);
  AA = (hv - hl)/(1/rhov - 1/rhol);
  AA1 = ((dhvdp - dhldp)*(rhol - rhov)*rhol*rhov - (hv - hl)*(rhov^2*drldp -
    rhol^2*drvdp))/(rhol - rhov)^2;

  // Fluid property calculations
  for j in 1:N loop
    fluidState[j] = Medium.setState_ph(p, h[j]);
    T[j] = Medium.temperature(fluidState[j]);
    rho[j] = Medium.density(fluidState[j]);
    drdp[j] = Medium.density_derp_h(fluidState[j]);
    drdh[j] = Medium.density_derh_p(fluidState[j]);
    u[j] = w/(rho[j]*A);
    x[j] = noEvent(if h[j] <= hl then 0 else if h[j] >= hv then 1 else (h[j]
       - hl)/(hv - hl));
  end for;

  // Selection of representative pressure and flow rate variables
  if HydraulicCapacitance == HCtypes.Upstream then
    p = infl.p;
    w = -outfl.m_flow/Nt;
  else
    p = outfl.p;
    w = infl.m_flow/Nt;
  end if;

  // Boundary conditions
  infl.h_outflow = htilde[1];
  outfl.h_outflow = htilde[N - 1];
  h[1] = inStream(infl.h_outflow);
  h[2:N] = htilde;
  T = wall1.T;
  T = wall2.T;
  if cardinality(wall2) == 0 then
     phibar = (wall1.phi[1:N - 1] + wall1.phi[2:N])/2;
  else
     phibar = (wall1.phi[1:N - 1] + wall1.phi[2:N] + wall2.phi[1:N - 1] + wall2.phi[2:N])/2;
  end if;

  Q = Nt*l*omega*sum(phibar) "Total heat flow through lateral boundary";
  M = sum(rhobar)*A*l "Fluid mass (single tube)";
  Tr = noEvent(M/max(infl.m_flow/Nt, Modelica.Constants.eps)) "Residence time";

initial equation
  if initOpt == ThermoPower3.Choices.Init.Options.noInit then
    // do nothing
  elseif initOpt == ThermoPower3.Choices.Init.Options.steadyState then
    der(htilde) = zeros(N - 1);
    if (not Medium.singleState) then
      der(p) = 0;
    end if;
  elseif initOpt == ThermoPower3.Choices.Init.Options.steadyStateNoP then
    der(htilde) = zeros(N - 1);
  elseif initOpt == ThermoPower3.Choices.Init.Options.steadyStateNoT and not
      Medium.singleState then
    der(p) = 0;
  else
    assert(false, "Unsupported initialisation option");
  end if;

  annotation (
    Diagram(graphics),
    Icon(graphics={Text(extent={{-100,-54},{100,-80}}, textString="%name")}),
    Documentation(info="<HTML>
<p>This model describes the flow of water or steam in a rigid tube. The basic modelling assumptions are:
<ul><li>The fluid state is either one-phase, or a two-phase mixture.
<li>In case of two-phase flow, the same velocity is assumed for both phases (homogeneous model).
<li>Uniform velocity is assumed on the cross section, leading to a 1-D distributed parameter model.
<li>Turbulent friction is always assumed; a small linear term is added to avoid numerical singularities at zero flowrate. The friction effects are not accurately computed in the laminar and transitional flow regimes, which however should not be an issue in most applications using water or steam as a working fluid.
<li>The model is based on dynamic mass, momentum, and energy balances. The dynamic momentum term can be switched off, to avoid the fast oscillations that can arise from its coupling with the mass balance (sound wave dynamics). 
<li>The longitudinal heat diffusion term is neglected.
<li>The energy balance equation is written by assuming a uniform pressure distribution; the pressure drop is lumped either at the inlet or at the outlet.
<li>The fluid flow can exchange thermal power through the lateral surface, which is represented by the <tt>wall</tt> connector. The actual heat flux must be computed by a connected component (heat transfer computation module).
</ul>
<p>The mass, momentum, and energy balance equation are discretised with the finite volume method. The state variables are one pressure, one flowrate (optional) and N-1 specific enthalpies.
<p>The turbulent friction factor can be either assumed as a constant, or computed by Colebrook's equation. In the former case, the friction factor can be supplied directly, or given implicitly by a specified operating point. In any case, the multiplicative correction coefficient <tt>Kfc</tt> can be used to modify the friction coefficient, e.g. to fit experimental data.
<p>A small linear pressure drop is added to avoid numerical singularities at low or zero flowrate. The <tt>wnom</tt> parameter must be always specified: the additional linear pressure drop is such that it is equal to the turbulent pressure drop when the flowrate is equal to <tt>wnf*wnom</tt> (the default value is 1% of the nominal flowrate). Increase <tt>wnf</tt> if numerical instabilities occur in tubes with very low pressure drops.
<p>The model assumes that the mass flow rate is always from the inlet to the outlet. Small reverse flow is allowed (e.g. when closing a valve at the outlet), but the model will not account for it explicitly.
<p><b>Modelling options</b></p>
<p>Thermal variables (enthalpy, temperature, density) are computed in <tt>N</tt> equally spaced nodes, including the inlet (node 1) and the outlet (node N); <tt>N</tt> must be greater than or equal to 2.
<p>The dynamic momentum term is included or neglected depending on the <tt>DynamicMomentum</tt> parameter.
<p>The density is computed assuming a linear distribution of the specific
enthalpy between the nodes; this requires the availability of the time derivative of the inlet enthalpy. If this is not available, it is possible to set <tt>avoidInletEnthalpyDerivative</tt> to true, which will cause the mean density of the first volume to be approximated as its outlet density, thus avoiding the need of the inlet enthalpy derivative.
<p>The following options are available to specify the friction coefficient:
<ul><li><tt>FFtype = FFtypes.Kfnom</tt>: the hydraulic friction coefficient <tt>Kf</tt> is set directly to <tt>Kfnom</tt>.
<li><tt>FFtype = FFtypes.OpPoint</tt>: the hydraulic friction coefficient is specified by a nominal operating point (<tt>wnom</tt>,<tt>dpnom</tt>, <tt>rhonom</tt>).
<li><tt>FFtype = FFtypes.Cfnom</tt>: the friction coefficient is computed by giving the (constant) value of the Fanning friction factor <tt>Cfnom</tt>.
<li><tt>FFtype = FFtypes.Colebrook</tt>: the Fanning friction factor is computed by Colebrook's equation (assuming Re > 2100, e.g. turbulent flow).
<li><tt>FFtype = FFtypes.NoFriction</tt>: no friction is assumed across the pipe.</ul><p>If <tt>HydraulicCapacitance = 2</tt> (default option) then the mass storage term depending on the pressure is lumped at the outlet, while the optional momentum storage term depending on the flowrate is lumped at the inlet. If <tt>HydraulicCapacitance = 1</tt> the reverse takes place.
<p>Start values for pressure and flowrate are specified by <tt>pstart</tt>, <tt>wstart</tt>. The start values for the node enthalpies are linearly distributed from <tt>hstartin</tt> at the inlet to <tt>hstartout</tt> at the outlet.
<p>A bank of <tt>Nt</tt> identical tubes working in parallel can be modelled by setting <tt>Nt > 1</tt>. The geometric parameters always refer to a <i>single</i> tube.
<p>This models makes the temperature and external heat flow distributions visible through the <tt>wall</tt> connector. If other variables (e.g. the heat transfer coefficient) are needed by external components to compute the actual heat flow, the <tt>wall</tt> connector can be replaced by an extended version of the <tt>DHT</tt> connector.
</HTML>",
        revisions="<html>
<ul>
<li><i>27 Jul 2007</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Corrected error in the mass balance equation, which lead to loss/gain of
       mass during transients.</li>
<li><i>30 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Initialisation support added.</li>
<li><i>24 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       <tt>FFtypes</tt> package and <tt>NoFriction</tt> option added.</li>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>8 Oct 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Model now based on <tt>Flow1DBase</tt>.
<li><i>24 Sep 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Removed <tt>wstart</tt>, <tt>pstart</tt>. Added <tt>pstartin</tt>, <tt>pstartout</tt>.
<li><i>28 Jul 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to <tt>Modelica.Media</tt>.
<li><i>15 Jan 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Computation of fluid velocity <i>u</i> added. Improved treatment of geometric parameters</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
end AnnularFlow1D2ph;
