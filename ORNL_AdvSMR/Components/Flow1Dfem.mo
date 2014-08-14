within ORNL_AdvSMR.Components;
model Flow1Dfem
  "1-dimensional fluid flow model for water/steam (finite elements)"

  extends ThermoPower3.Water.Flow1DBase;
  import Modelica.Math.*;
  import ThermoPower3.Choices.Flow1D.FFtypes;
  import ThermoPower3.Choices.Flow1D.HCtypes;
  Medium.ThermodynamicState fluidState[N]
    "Thermodynamic state of the fluid at the nodes";
  parameter Real alpha(
    min=0,
    max=1) = 1 "Numerical stabilization coefficient";
  parameter Real ML(
    min=0,
    max=1) = 0 "Mass Lumping Coefficient";
  parameter Real wnf_bc=0.01
    "Fraction of the nominal total mass flow rate for FEM regularization";
  constant Real g=Modelica.Constants.g_n;
  final parameter Boolean evenN=(div(N, 2)*2 == N)
    "The number of nodes is even";
  Modelica.SIunits.Length omega_hyd "Hydraulic perimeter (single tube)";
  Real Kf[N] "Friction coefficients";
  Real Cf[N] "Fanning friction factors";
  Real dwdt "Dynamic momentum term";
  Medium.AbsolutePressure p(start=pstart) "Fluid pressure";
  Modelica.SIunits.Pressure Dpfric "Pressure drop due to friction (total)";
  Modelica.SIunits.Pressure Dpfric1
    "Pressure drop due to friction (from inlet to capacitance)";
  Modelica.SIunits.Pressure Dpfric2
    "Pressure drop due to friction (from capacitance to outlet)";
  Modelica.SIunits.Pressure Dpstat "Pressure drop due to static head";
  Modelica.SIunits.MassFlowRate w[N](each start=wnom/Nt)
    "Mass flowrate (single tube)";
  Modelica.SIunits.Velocity u[N] "Fluid velocity";
  Modelica.SIunits.HeatFlux phi[N] "External heat flux";
  Medium.Temperature T[N] "Fluid temperature";
  Medium.SpecificEnthalpy h[N](start=hstart) "Fluid specific enthalpy";
  Medium.Density rho[N] "Fluid density";
  Modelica.SIunits.SpecificVolume v[N] "Fluid specific volume";
  Modelica.SIunits.Mass Mtot "Total mass of fluid";
protected
  Modelica.SIunits.DerDensityByEnthalpy drdh[N]
    "Derivative of density by enthalpy";
  Modelica.SIunits.DerDensityByPressure drdp[N]
    "Derivative of density by pressure";

  Real Y[N, N];
  Real M[N, N];
  Real D[N];
  Real D1[N];
  Real D2[N];
  Real G[N];
  Real B[N, N];
  Real C[N, N];
  Real K[N, N];

  Real alpha_sgn;

  Real YY[N, N];

equation
  assert(FFtype == FFtypes.NoFriction or dpnom > 0,
    "dpnom=0 not supported, it is also used in the homotopy trasformation during the inizialization");
  //All equations are referred to a single tube

  // Selection of representative pressure variable
  if HydraulicCapacitance == HCtypes.Middle then
    p = infl.p - Dpfric1 - Dpstat/2;
  elseif HydraulicCapacitance == HCtypes.Upstream then
    p = infl.p;
  elseif HydraulicCapacitance == HCtypes.Downstream then
    p = outfl.p;
  else
    assert(false, "Unsupported HydraulicCapacitance option");
  end if;

  //Friction factor selection
  omega_hyd = 4*A/Dhyd;
  for i in 1:N loop
    if FFtype == FFtypes.Kfnom then
      Kf[i] = Kfnom*Kfc;
    elseif FFtype == FFtypes.OpPoint then
      Kf[i] = dpnom*rhonom/(wnom/Nt)^2*Kfc;
    elseif FFtype == FFtypes.Cfnom then
      Cf[i] = Cfnom*Kfc;
    elseif FFtype == FFtypes.Colebrook then
      Cf[i] = ThermoPower3.Water.f_colebrook(
        w[i],
        Dhyd/A,
        e,
        Medium.dynamicViscosity(fluidState[i]))*Kfc;
    elseif FFtype == FFtypes.NoFriction then
      Cf[i] = 0;
    end if;
    assert(Kf[i] >= 0, "Negative friction coefficient");
    Kf[i] = Cf[i]*omega_hyd*L/(2*A^3)
      "Relationship between friction coefficient and Fanning friction factor";
  end for;

  //Dynamic Momentum [not] accounted for
  if DynamicMomentum then
    if HydraulicCapacitance == HCtypes.Upstream then
      dwdt = der(w[N]);
    elseif HydraulicCapacitance == HCtypes.Downstream then
      dwdt = der(w[1]);
    else
      assert(false,
        "DynamicMomentum == true requires either Upstream or Downstream capacitance");
    end if;
  else
    dwdt = 0;
  end if;

  L/A*dwdt + (outfl.p - infl.p) + Dpstat + Dpfric = 0
    "Momentum balance equation";

  w[1] = infl.m_flow/Nt "Inlet flow rate - single tube";
  w[N] = -outfl.m_flow/Nt "Outlet flow rate - single tube";

  Dpfric = Dpfric1 + Dpfric2 "Total pressure drop due to friction";

  if FFtype == FFtypes.NoFriction then
    Dpfric1 = 0;
    Dpfric2 = 0;
  else
    Dpfric1 = homotopy(sum(Kf[i]/L*squareReg(w[i], wnom/Nt*wnf)*D1[i]/rho[i]
      for i in 1:N), dpnom/2/(wnom/Nt)*w[1])
      "Pressure drop from inlet to capacitance";
    Dpfric2 = homotopy(sum(Kf[i]/L*squareReg(w[i], wnom/Nt*wnf)*D2[i]/rho[i]
      for i in 1:N), dpnom/2/(wnom/Nt)*w[N])
      "Pressure drop from capacitance to outlet";
  end if "Pressure drop due to friction";

  Dpstat = if abs(dzdx) < 1e-6 then 0 else g*dzdx*rho*D
    "Pressure drop due to static head";
  ((1 - ML)*Y + ML*YY)*der(h) + B/A*h + C*h/A = der(p)*G + M*(omega/A)*phi + K*
    w/A "Energy balance equation";

  // Fluid property calculations
  for j in 1:N loop
    fluidState[j] = Medium.setState_ph(p, h[j]);
    T[j] = Medium.temperature(fluidState[j]);
    rho[j] = Medium.density(fluidState[j]);
    drdp[j] = if Medium.singleState then 0 else Medium.density_derp_h(
      fluidState[j]);
    drdh[j] = Medium.density_derh_p(fluidState[j]);
    v[j] = 1/rho[j];
    u[j] = w[j]/(rho[j]*A);
  end for;

  //Wall energy flux and  temperature
  T = wall.T;
  phi = wall.phi;

  //Boundary Values of outflowing fluid enthalpies
  h[1] = infl.h_outflow;
  h[N] = outfl.h_outflow;

  alpha_sgn = alpha*sign(infl.m_flow - outfl.m_flow);

  for i in 1:N - 1 loop
    (w[i + 1] - w[i]) = -A*l*(der(p)*1/2*(drdp[i + 1] + drdp[i]) + 1/6*(der(h[i])
      *(2*drdh[i] + drdh[i + 1]) + der(h[i + 1])*(drdh[i] + 2*drdh[i + 1])))
      "Mass balance equations";
  end for;

  // Energy equation FEM matrices
  Y[1, 1] = rho[1]*((-l/12)*(2*alpha_sgn - 3)) + rho[2]*((-l/12)*(alpha_sgn - 1));
  Y[1, 2] = rho[1]*((-l/12)*(alpha_sgn - 1)) + rho[2]*((-l/12)*(2*alpha_sgn - 1));
  Y[N, N] = rho[N - 1]*((l/12)*(alpha_sgn + 1)) + rho[N]*((l/12)*(2*alpha_sgn
     + 3));
  Y[N, N - 1] = rho[N - 1]*((l/12)*(2*alpha_sgn + 1)) + rho[N]*((l/12)*(
    alpha_sgn + 1));
  if N > 2 then
    for i in 2:N - 1 loop
      Y[i, i - 1] = rho[i - 1]*((l/12)*(2*alpha_sgn + 1)) + rho[i]*((l/12)*(
        alpha_sgn + 1));
      Y[i, i] = rho[i - 1]*((l/12)*(alpha_sgn + 1)) + rho[i]*(l/2) + rho[i + 1]
        *(-(l/12)*(alpha_sgn - 1));
      Y[i, i + 1] = rho[i]*((-l/12)*(alpha_sgn - 1)) + rho[i + 1]*((-l/12)*(2*
        alpha_sgn - 1));
      Y[1, i + 1] = 0;
      Y[N, i - 1] = 0;
      for j in 1:(i - 2) loop
        Y[i, j] = 0;
      end for;
      for j in (i + 2):N loop
        Y[i, j] = 0;
      end for;
    end for;
  end if;

  for i in 1:N loop
    for j in 1:N loop
      YY[i, j] = if (i <> j) then 0 else sum(Y[:, j]);
    end for;
  end for;

  M[1, 1] = l/3 - l*alpha_sgn/4;
  M[N, N] = l/3 + l*alpha_sgn/4;
  M[1, 2] = l/6 - l*alpha_sgn/4;
  M[N, (N - 1)] = l/6 + l*alpha_sgn/4;
  if N > 2 then
    for i in 2:N - 1 loop
      M[i, i - 1] = l/6 + l*alpha_sgn/4;
      M[i, i] = 2*l/3;
      M[i, i + 1] = l/6 - l*alpha_sgn/4;
      M[1, i + 1] = 0;
      M[N, i - 1] = 0;
      for j in 1:(i - 2) loop
        M[i, j] = 0;
      end for;
      for j in (i + 2):N loop
        M[i, j] = 0;
      end for;
    end for;
  end if;

  B[1, 1] = (-1/3 + alpha_sgn/4)*w[1] + (-1/6 + alpha_sgn/4)*w[2];
  B[1, 2] = (1/3 - alpha_sgn/4)*w[1] + (1/6 - alpha_sgn/4)*w[2];
  B[N, N] = (1/6 + alpha_sgn/4)*w[N - 1] + (1/3 + alpha_sgn/4)*w[N];
  B[N, N - 1] = (-1/(6) - alpha_sgn/4)*w[N - 1] + (-1/3 - alpha_sgn/4)*w[N];
  if N > 2 then
    for i in 2:N - 1 loop
      B[i, i - 1] = (-1/6 - alpha_sgn/4)*w[i - 1] + (-1/3 - alpha_sgn/4)*w[i];
      B[i, i] = (1/6 + alpha_sgn/4)*w[i - 1] + (alpha_sgn/2)*w[i] + (-1/6 +
        alpha_sgn/4)*w[i + 1];
      B[i, i + 1] = (1/3 - alpha_sgn/4)*w[i] + (1/6 - alpha_sgn/4)*w[i + 1];
      B[1, i + 1] = 0;
      B[N, i - 1] = 0;
      for j in 1:(i - 2) loop
        B[i, j] = 0;
      end for;
      for j in (i + 2):N loop
        B[i, j] = 0;
      end for;
    end for;
  end if;

  if Medium.singleState then
    G = zeros(N) "No influence of pressure";
  else
    G[1] = l/2*(1 - alpha_sgn);
    G[N] = l/2*(1 + alpha_sgn);
    if N > 2 then
      for i in 2:N - 1 loop
        G[i] = l;
      end for;
    end if;
  end if;

  // boundary condition matrices
  // step change is regularized, no negative undershoot
  C[1, 1] = ThermoPower3.Functions.stepReg(
    infl.m_flow - wnom*wnf_bc,
    (1 - alpha_sgn/2)*w[1],
    0,
    wnom*wnf_bc);
  C[N, N] = ThermoPower3.Functions.stepReg(
    outfl.m_flow - wnom*wnf_bc,
    -(1 + alpha_sgn/2)*w[N],
    0,
    wnom*wnf_bc);
  //  C[1, 1] = if infl.m_flow >= 0 then (1 - alpha_sgn/2)*w[1] else 0;
  //  C[N, N] = if outfl.m_flow >= 0 then -(1 + alpha_sgn/2)*w[N] else 0;
  C[N, 1] = 0;
  C[1, N] = 0;
  if (N > 2) then
    for i in 2:(N - 1) loop
      C[1, i] = 0;
      C[N, i] = 0;
      for j in 1:N loop
        C[i, j] = 0;
      end for;
    end for;
  end if;

  K[1, 1] = ThermoPower3.Functions.stepReg(
    infl.m_flow - wnom*wnf_bc,
    (1 - alpha_sgn/2)*inStream(infl.h_outflow),
    0,
    wnom*wnf_bc);
  K[N, N] = ThermoPower3.Functions.stepReg(
    outfl.m_flow - wnom*wnf_bc,
    -(1 + alpha_sgn/2)*inStream(outfl.h_outflow),
    0,
    wnom*wnf_bc);
  //  K[1, 1] = if infl.m_flow >= 0 then (1 - alpha_sgn/2)*inStream(infl.h_outflow) else 0;
  //  K[N, N] = if outfl.m_flow >= 0 then -(1 + alpha_sgn/2)*inStream(outfl.h_outflow) else 0;
  K[N, 1] = 0;
  K[1, N] = 0;
  if (N > 2) then
    for i in 2:(N - 1) loop
      K[1, i] = 0;
      K[N, i] = 0;
      for j in 1:N loop
        K[i, j] = 0;
      end for;
    end for;
  end if;

  // Momentum and Mass balance equation matrices
  D[1] = l/2;
  D[N] = l/2;
  for i in 2:N - 1 loop
    D[i] = l;
  end for;
  if HydraulicCapacitance == HCtypes.Middle then
    D1 = l*(if N == 2 then {3/8,1/8} else if evenN then cat(
      1,
      {1/2},
      ones(max(0, div(N, 2) - 2)),
      {7/8,1/8},
      zeros(div(N, 2) - 1)) else cat(
      1,
      {1/2},
      ones(div(N, 2) - 1),
      {1/2},
      zeros(div(N, 2))));
    D2 = l*(if N == 2 then {1/8,3/8} else if evenN then cat(
      1,
      zeros(div(N, 2) - 1),
      {1/8,7/8},
      ones(max(div(N, 2) - 2, 0)),
      {1/2}) else cat(
      1,
      zeros(div(N, 2)),
      {1/2},
      ones(div(N, 2) - 1),
      {1/2}));
  elseif HydraulicCapacitance == HCtypes.Upstream then
    D1 = zeros(N);
    D2 = D;
  elseif HydraulicCapacitance == HCtypes.Downstream then
    D1 = D;
    D2 = zeros(N);
  else
    assert(false, "Unsupported HydraulicCapacitance option");
  end if;

  Q = Nt*omega*D*phi "Total heat flow through lateral boundary";
  Mtot = Nt*D*rho*A "Total mass of fluid";
  Tr = noEvent(Mtot/max(abs(infl.m_flow), Modelica.Constants.eps))
    "Residence time";
initial equation
  if initOpt == ThermoPower3.Choices.Init.Options.noInit then
    // do nothing
  elseif initOpt == ThermoPower3.Choices.Init.Options.steadyState then
    der(h) = zeros(N);
    if (not Medium.singleState) then
      der(p) = 0;
    end if;
  elseif initOpt == ThermoPower3.Choices.Init.Options.steadyStateNoP then
    der(h) = zeros(N);
  elseif initOpt == ThermoPower3.Choices.Init.Options.steadyStateNoT and not
      Medium.singleState then
    der(p) = 0;
  else
    assert(false, "Unsupported initialisation option");
  end if;
  annotation (
    Diagram(graphics),
    Icon(graphics={Text(extent={{-100,-52},{100,-82}}, textString="%name")}),
    Documentation(info="<HTML>
<p>This model describes the flow of water or steam in a rigid tube. The basic modelling assumptions are:
<ul><li>The fluid state is always one-phase (i.e. subcooled liquid or superheated steam).
<li>Uniform velocity is assumed on the cross section, leading to a 1-D distributed parameter model.
<li>Turbulent friction is always assumed; a small linear term is added to avoid numerical singularities at zero flowrate. The friction effects are not accurately computed in the laminar and transitional flow regimes, which however should not be an issue in most applications using water or steam as a working fluid.
<li>The model is based on dynamic mass, momentum, and energy balances. The dynamic momentum term can be switched off, to avoid the fast oscillations that can arise from its coupling with the mass balance (sound wave dynamics). 
<li>The longitudinal heat diffusion term is neglected.
<li>The energy balance equation is written by assuming a uniform pressure distribution; the pressure drop is lumped either at the inlet or at the outlet.
<li>The fluid flow can exchange thermal power through the lateral surface, which is represented by the <tt>wall</tt> connector. The actual heat flux must be computed by a connected component (heat transfer computation module).
</ul>
<p>The mass, momentum, and energy balance equation are discretised with the finite element method. The state variables are one pressure, one flowrate (optional) and N specific enthalpies.
<p>The turbulent friction factor can be either assumed as a constant, or computed by Colebrook's equation. In the former case, the friction factor can be supplied directly, or given implicitly by a specified operating point. In any case, the multiplicative correction coefficient <tt>Kfc</tt> can be used to modify the friction coefficient, e.g. to fit experimental data.
<p>A small linear pressure drop is added to avoid numerical singularities at low or zero flowrate. The <tt>wnom</tt> parameter must be always specified: the additional linear pressure drop is such that it is equal to the turbulent pressure drop when the flowrate is equal to <tt>wnf*wnom</tt> (the default value is 1% of the nominal flowrate). Increase <tt>wnf</tt> if numerical instabilities occur in tubes with very low pressure drops.
<p>Flow reversal is fully supported.
<p><b>Modelling options</b></p>
<p>Thermal variables (enthalpy, temperature, density) are computed in <tt>N</tt> equally spaced nodes, including the inlet (node 1) and the outlet (node N); <tt>N</tt> must be greater or equal than 2.
<p>The dynamic momentum term is included or neglected depending on the <tt>DynamicMomentum</tt> parameter.
<p> Two parameters are available to tune the numerical method. The stabilisation coefficient <tt>alpha</tt> varies from 0.0 to 1.0; <tt>alpha=0.0</tt> corresponds to a non-stabilised method, which gives rise to non-physical oscillations; the default value of 1.0 corresponds to a stabilised method, with well-damped oscillations. The mass lumping coefficient (<tt>ML</tt>) allows to use a hybrid finite-element/finite-volume discretisation method for the dynamic matrix; the default value <tt>ML=0.0</tt> corresponds to a standard FEM model, <tt>ML=1.0</tt> corresponds to a full finite-volume method, with the associated numerical diffusion effects. Intermediate values can be used.
<p>The following options are available to specify the friction coefficient:
<ul><li><tt>FFtype = FFtypes.Kfnom</tt>: the hydraulic friction coefficient <tt>Kf</tt> is set directly to <tt>Kfnom</tt>.
<li><tt>FFtype = FFtypes.OpPoint</tt>: the hydraulic friction coefficient is specified by a nominal operating point (<tt>wnom</tt>,<tt>dpnom</tt>, <tt>rhonom</tt>).
<li><tt>FFtype = FFtypes.Cfnom</tt>: the friction coefficient is computed by giving the (constant) value of the Fanning friction factor <tt>Cfnom</tt>.
<li><tt>FFtype = FFtypes.Colebrook</tt>: the Fanning friction factor is computed by Colebrook's equation (assuming Re > 2100, e.g. turbulent flow).
<li><tt>FFtype = FFtypes.NoFriction</tt>: no friction is assumed across the pipe.</ul>
<p>If <tt>HydraulicCapacitance = 2</tt> (default option) then the mass buildup term depending on the pressure is lumped at the outlet, while the optional momentum buildup term depending on the flowrate is lumped at the inlet. If <tt>HydraulicCapacitance = 1</tt> the reverse takes place.
<p>Start values for pressure and flowrate are specified by <tt>pstart</tt>, <tt>wstart</tt>. The start values for the node enthalpies are linearly distributed from <tt>hstartin</tt> at the inlet to <tt>hstartout</tt> at the outlet.
<p>A bank of <tt>Nt</tt> identical tubes working in parallel can be modelled by setting <tt>Nt > 1</tt>. The geometric parameters always refer to a <i>single</i> tube.
<p>This models makes the temperature and external heat flow distributions visible through the <tt>wall</tt> connector. If other variables (e.g. the heat transfer coefficient) are needed by external components to compute the actual heat flow, the <tt>wall</tt> connector can be replaced by an extended version of the <tt>DHT</tt> connector.
</HTML>", revisions="<html>
<ul>
<li><i>24 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       <tt>FFtypes</tt> package and <tt>NoFriction</tt> option added.</li>
<li><i>1 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Residence time added.</li>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>8 Oct 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Model now based on <tt>Flow1DBase</tt>.
<li><i>24 Sep 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Removed <tt>wstart</tt>, <tt>pstart</tt>. Added <tt>pstartin</tt>, <tt>pstartout</tt>.
<li><i>23 Jul 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<li><i>1 Jul 2004</i>
    by <a href=\"mailto:francesco.schiavo@polimi.it\">Francesco Schiavo</a>:<br>
       Mass flow-rate spatial distribution treatment added.</li>
<li><i>15 Jan 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Computation of fluid velocity <i>u</i> added. Improved treatment of geometric parameters</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.schiavo@polimi.it\">Francesco Schiavo</a>:<br>
       First release.</li>
</ul>
</html>"));
end Flow1Dfem;
