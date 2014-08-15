within Ethan2;
model AnnularFlow1D
  "Annular 1-dimensional fluid flow model for water/steam (finite volumes)"
  extends Ethan2.AnnularFlow1DBase;
  import ThermoPower3.Choices.Flow1D.FFtypes;
  import ThermoPower3.Choices.Flow1D.HCtypes;
  Medium.ThermodynamicState fluidState[N]
    "Thermodynamic state of the fluid at the nodes";
  Modelica.SIunits.Length omega_hyd "Wet perimeter (single tube)";
  Modelica.SIunits.Pressure Dpfric "Pressure drop due to friction (total)";
  Modelica.SIunits.Pressure Dpfric1
    "Pressure drop due to friction (from inlet to capacitance)";
  Modelica.SIunits.Pressure Dpfric2
    "Pressure drop due to friction (from capacitance to outlet)";
  Modelica.SIunits.Pressure Dpstat "Pressure drop due to static head";
  Modelica.SIunits.MassFlowRate win "Flow rate at the inlet (single tube)";
  Modelica.SIunits.MassFlowRate wout "Flow rate at the outlet (single tube)";
  Real Kf "Hydraulic friction coefficient";
  Real dwdt "Dynamic momentum term";
  Real Cf "Fanning friction factor";
  Medium.AbsolutePressure p(start=pstart)
    "Fluid pressure for property calculations";
  Modelica.SIunits.MassFlowRate w(start=wnom/Nt) "Mass flowrate (single tube)";
  Modelica.SIunits.MassFlowRate wbar[N - 1](each start=wnom/Nt);
  Modelica.SIunits.Velocity u[N] "Fluid velocity";
  Medium.Temperature T[N] "Fluid temperature";
  Medium.SpecificEnthalpy h[N](start=hstart)
    "Fluid specific enthalpy at the nodes";
  Medium.SpecificEnthalpy htilde[N - 1](start=hstart[2:N])
    "Enthalpy state variables";
  Medium.Density rho[N] "Fluid nodal density";
  Modelica.SIunits.Mass M "Fluid mass";
  Real dMdt[N - 1] "Time derivative of mass in each cell between two nodes";
protected
  ThermoPower3.Density rhobar[N - 1] "Fluid average density";
  Modelica.SIunits.SpecificVolume vbar[N - 1] "Fluid average specific volume";
  Modelica.SIunits.HeatFlux phibar[N - 1] "Average heat flux";
  Modelica.SIunits.DerDensityByEnthalpy drdh[N]
    "Derivative of density by enthalpy";
  Modelica.SIunits.DerDensityByEnthalpy drbdh[N - 1]
    "Derivative of average density by enthalpy";
  Modelica.SIunits.DerDensityByPressure drdp[N]
    "Derivative of density by pressure";
  Modelica.SIunits.DerDensityByPressure drbdp[N - 1]
    "Derivative of average density by pressure";
equation
  assert(FFtype == FFtypes.NoFriction or dpnom > 0,
    "dpnom=0 not supported, it is also used in the homotopy trasformation during the inizialization");
  //All equations are referred to a single tube
  // Friction factor selection
  omega_hyd = 4*A/(Dhyd1+Dhyd2);
  if FFtype == FFtypes.Kfnom then
    Kf = Kfnom*Kfc;
  elseif FFtype == FFtypes.OpPoint then
    Kf = dpnom*rhonom/(wnom/Nt)^2*Kfc;
  elseif FFtype == FFtypes.Cfnom then
    Cf = Cfnom*Kfc;
  elseif FFtype == FFtypes.Colebrook then
    Cf = ThermoPower3.Water.f_colebrook(
      w,
      (Dhyd1+Dhyd2)/A,
      e,
      Medium.dynamicViscosity(fluidState[integer(N/2)]))*Kfc;
  elseif FFtype == FFtypes.NoFriction then
    Cf = 0;
  end if;
  Kf = Cf*omega_hyd*L/(2*A^3)
    "Relationship between friction coefficient and Fanning friction factor";
  assert(Kf >= 0, "Negative friction coefficient");

  // Dynamic momentum term
  if DynamicMomentum then
    dwdt = der(w);
  else
    dwdt = 0;
  end if;

  sum(dMdt) = (infl.m_flow + outfl.m_flow)/Nt "Mass balance";
  L/A*dwdt + (outfl.p - infl.p) + Dpstat + Dpfric = 0 "Momentum balance";
  Dpfric = Dpfric1 + Dpfric2 "Total pressure drop due to friction";
  if FFtype == FFtypes.NoFriction then
    Dpfric1 = 0;
    Dpfric2 = 0;
  elseif HydraulicCapacitance == HCtypes.Middle then
    //assert((N-1)-integer((N-1)/2)*2 == 0, "N must be odd");
    Dpfric1 = homotopy(Kf*squareReg(win, wnom/Nt*wnf)*sum(vbar[1:integer((N
       - 1)/2)])/(N - 1), dpnom/2/(wnom/Nt)*win)
      "Pressure drop from inlet to capacitance";
    Dpfric2 = homotopy(Kf*squareReg(wout, wnom/Nt*wnf)*sum(vbar[1 + integer((
      N - 1)/2):N - 1])/(N - 1), dpnom/2/(wnom/Nt)*wout)
      "Pressure drop from capacitance to outlet";
  elseif HydraulicCapacitance == HCtypes.Upstream then
    Dpfric1 = 0 "Pressure drop from inlet to capacitance";
    Dpfric2 = homotopy(Kf*squareReg(wout, wnom/Nt*wnf)*sum(vbar)/(N - 1),
      dpnom/(wnom/Nt)*wout) "Pressure drop from capacitance to outlet";
  elseif HydraulicCapacitance == HCtypes.Downstream then
    Dpfric1 = homotopy(Kf*squareReg(win, wnom/Nt*wnf)*sum(vbar)/(N - 1),
      dpnom/(wnom/Nt)*win) "Pressure drop from inlet to capacitance";
    Dpfric2 = 0 "Pressure drop from capacitance to outlet";
  else
    assert(false, "Unsupported HydraulicCapacitance option");
  end if "Pressure drop due to friction";
  Dpstat = if abs(dzdx) < 1e-6 then 0 else g*l*dzdx*sum(rhobar)
    "Pressure drop due to static head";
  for j in 1:N - 1 loop
    if Medium.singleState then
      A*l*rhobar[j]*der(htilde[j]) + wbar[j]*(h[j + 1] - h[j]) = l*omega*
        phibar[j] "Energy balance (pressure effects neglected)";
    else
      A*l*rhobar[j]*der(htilde[j]) + wbar[j]*(h[j + 1] - h[j]) - A*l*der(p) =
        l*omega*phibar[j] "Energy balance";
    end if;
    dMdt[j] = A*l*(drbdh[j]*der(htilde[j]) + drbdp[j]*der(p))
      "Mass derivative for each volume";
    // Average volume quantities
    rhobar[j] = (rho[j] + rho[j + 1])/2;
    drbdp[j] = (drdp[j] + drdp[j + 1])/2;
    drbdh[j] = (drdh[j] + drdh[j + 1])/2;
    vbar[j] = 1/rhobar[j];
    wbar[j] = homotopy(infl.m_flow/Nt - sum(dMdt[1:j - 1]) - dMdt[j]/2, wnom/
      Nt);
  end for;

  // Fluid property calculations
  for j in 1:N loop
    fluidState[j] = Medium.setState_ph(p, h[j]);
    T[j] = Medium.temperature(fluidState[j]);
    rho[j] = Medium.density(fluidState[j]);
    drdp[j] = if Medium.singleState then 0 else Medium.density_derp_h(
      fluidState[j]);
    drdh[j] = Medium.density_derh_p(fluidState[j]);
    u[j] = w/(rho[j]*A);
  end for;

  // Boundary conditions
  win = infl.m_flow/Nt;
  wout = -outfl.m_flow/Nt;
  if HydraulicCapacitance == HCtypes.Middle then
    p = infl.p - Dpfric1 - Dpstat/2;
    w = win;
  elseif HydraulicCapacitance == HCtypes.Upstream then
    p = infl.p;
    w = -outfl.m_flow/Nt;
  elseif HydraulicCapacitance == HCtypes.Downstream then
    p = outfl.p;
    w = win;
  else
    assert(false, "Unsupported HydraulicCapacitance option");
  end if;
  infl.h_outflow = htilde[1];
  outfl.h_outflow = htilde[N - 1];

  h[1] = inStream(infl.h_outflow);
  h[2:N] = htilde;

  T = wall1.T;  //Ethan's Change
  T = wall2.T; //Ethan's Change
  if cardinality(wall2) == 0 then
     phibar = (wall1.phi[1:N - 1] + wall1.phi[2:N])/2;
  else
     phibar = (wall1.phi[1:N - 1] + wall1.phi[2:N] + wall2.phi[1:N - 1] + wall2.phi[2:N])/2;
  end if;

  Q = Nt*l*omega*sum(phibar) "Total heat flow through lateral boundary";
  M = sum(rhobar)*A*l "Total fluid mass";
  Tr = noEvent(M/max(win, Modelica.Constants.eps)) "Residence time";
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
    Icon(graphics),
    Documentation(info="<HTML>
<p>This model describes the flow of water or steam in a rigid tube. The basic modelling assumptions are:
<ul><li>The fluid state is always one-phase (i.e. subcooled liquid or superheated steam).
<li>Uniform velocity is assumed on the cross section, leading to a 1-D distributed parameter model.
<li>Turbulent friction is always assumed; a small linear term is added to avoid numerical singularities at zero flowrate. The friction effects are not accurately computed in the laminar and transitional flow regimes, which however should not be an issue in most applications using water or steam as a working fluid.
<li>The model is based on dynamic mass, momentum, and energy balances. The dynamic momentum term can be switched off, to avoid the fast oscillations that can arise from its coupling with the mass balance (sound wave dynamics). 
<li>The longitudinal heat diffusion term is neglected.
<li>The energy balance equation is written by assuming a uniform pressure distribution; the compressibility effects are lumped at the inlet, at the outlet, or at the middle of the pipe.
<li>The fluid flow can exchange thermal power through the lateral surface, which is represented by the <tt>wall</tt> connector. The actual heat flux must be computed by a connected component (heat transfer computation module).
</ul>
<p>The mass, momentum and energy balance equation are discretised with the finite volume method. The state variables are one pressure, one flowrate (optional) and N-1 specific enthalpies.
<p>The turbulent friction factor can be either assumed as a constant, or computed by Colebrook's equation. In the former case, the friction factor can be supplied directly, or given implicitly by a specified operating point. In any case, the multiplicative correction coefficient <tt>Kfc</tt> can be used to modify the friction coefficient, e.g. to fit experimental data.
<p>A small linear pressure drop is added to avoid numerical singularities at low or zero flowrate. The <tt>wnom</tt> parameter must be always specified: the additional linear pressure drop is such that it is equal to the turbulent pressure drop when the flowrate is equal to <tt>wnf*wnom</tt> (the default value is 1% of the nominal flowrate). Increase <tt>wnf</tt> if numerical instabilities occur in tubes with very low pressure drops.
<p>Flow reversal is fully supported.
<p><b>Modelling options</b></p>
<p>Thermal variables (enthalpy, temperature, density) are computed in <tt>N</tt> equally spaced nodes, including the inlet (node 1) and the outlet (node N); <tt>N</tt> must be greater than or equal to 2.
<p>The following options are available to specify the friction coefficient:
<ul><li><tt>FFtype = FFtypes.Kfnom</tt>: the hydraulic friction coefficient <tt>Kf</tt> is set directly to <tt>Kfnom</tt>.
<li><tt>FFtype = FFtypes.OpPoint</tt>: the hydraulic friction coefficient is specified by a nominal operating point (<tt>wnom</tt>,<tt>dpnom</tt>, <tt>rhonom</tt>).
<li><tt>FFtype = FFtypes.Cfnom</tt>: the friction coefficient is computed by giving the (constant) value of the Fanning friction factor <tt>Cfnom</tt>.
<li><tt>FFtype = FFtypes.Colebrook</tt>: the Fanning friction factor is computed by Colebrook's equation (assuming Re > 2100, e.g. turbulent flow).
<li><tt>FFtype = FFtypes.NoFriction</tt>: no friction is assumed across the pipe.</ul>
<p>The dynamic momentum term is included or neglected depending on the <tt>DynamicMomentum</tt> parameter.
<p>If <tt>HydraulicCapacitance = HCtypes.Downstream</tt> (default option) then the compressibility effect depending on the pressure derivative is lumped at the outlet, while the optional dynamic momentum term depending on the flowrate is lumped at the inlet; therefore, the state variables are the outlet pressure and the inlet flowrate. If <tt>HydraulicCapacitance = HCtypes.Upstream</tt> the reverse takes place.
 If <tt>HydraulicCapacitance = HCtypes.Middle</tt>, the compressibility effect is lumped at the middle of the pipe; to use this option, an odd number of nodes N is required.
<p>Start values for the pressure and flowrate state variables are specified by <tt>pstart</tt>, <tt>wstart</tt>. The start values for the node enthalpies are linearly distributed from <tt>hstartin</tt> at the inlet to <tt>hstartout</tt> at the outlet.
<p>A bank of <tt>Nt</tt> identical tubes working in parallel can be modelled by setting <tt>Nt > 1</tt>. The geometric parameters always refer to a <i>single</i> tube.
<p>This models makes the temperature and external heat flow distributions available to connected components through the <tt>wall</tt> connector. If other variables (e.g. the heat transfer coefficient) are needed by external components to compute the actual heat flow, the <tt>wall</tt> connector can be replaced by an extended version of the <tt>DHT</tt> connector.
</HTML>",
        revisions="<html>
<ul>
<li><i>16 Sep 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Option to lump compressibility at the middle added.</li>
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
<li><i>22 Jun 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.
<li><i>15 Jan 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Computation of fluid velocity <i>u</i> added. Improved treatment of geometric parameters</li>.
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>
"));
end AnnularFlow1D;
