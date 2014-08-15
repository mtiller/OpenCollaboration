within Ethan2;
model Flow1D "1-dimensional fluid flow model for gas (finite volumes)"
  extends ThermoPower3.Icons.Gas.Tube;
  import ThermoPower3.Choices.Flow1D.FFtypes;
  import ThermoPower3.Choices.Flow1D.HCtypes;
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
  parameter Integer N(min=2) = 2 "Number of nodes for thermal variables";
  parameter Integer Nt=1 "Number of tubes in parallel";
  parameter Modelica.SIunits.Distance L "Tube length";
  parameter Modelica.SIunits.Position H=0 "Elevation of outlet over inlet";
  parameter Modelica.SIunits.Area A "Cross-sectional area (single tube)";
  parameter Modelica.SIunits.Length omega
    "Perimeter of heat transfer surface (single tube)";
  parameter Modelica.SIunits.Length Dhyd "Hydraulic Diameter (single tube)";
  parameter Modelica.SIunits.MassFlowRate wnom "Nominal mass flowrate (total)";
  parameter FFtypes FFtype "Friction Factor Type";
  parameter Real Kfnom=0 "Nominal hydraulic resistance coefficient";
  parameter Modelica.SIunits.Pressure dpnom=0 "Nominal pressure drop";
  parameter ThermoPower3.Density rhonom=0 "Nominal inlet density";
  parameter Real Cfnom=0 "Nominal Fanning friction factor";
  parameter Real e=0 "Relative roughness (ratio roughness/diameter)";
  parameter Boolean DynamicMomentum=false "Inertial phenomena accounted for"
    annotation (Evaluate=true);
  parameter Boolean UniformComposition=true
    "Uniform gas composition is assumed" annotation (Evaluate=true);
  parameter Boolean QuasiStatic=false
    "Quasi-static model (mass, energy and momentum static balances"
    annotation (Evaluate=true);
  parameter Integer HydraulicCapacitance=HCtypes.Downstream
    "1: Upstream, 2: Downstream";
  parameter Boolean avoidInletEnthalpyDerivative=true
    "Avoid inlet enthalpy derivative";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ThermoPower3.System system "System wide properties";
  parameter Modelica.SIunits.Pressure pstart=1e5 "Pressure start value"
    annotation (Dialog(tab="Initialisation"));
  parameter ThermoPower3.AbsoluteTemperature Tstartbar=300
    "Avarage temperature start value" annotation (Dialog(tab="Initialisation"));
  parameter ThermoPower3.AbsoluteTemperature Tstartin=Tstartbar
    "Inlet temperature start value" annotation (Dialog(tab="Initialisation"));
  parameter ThermoPower3.AbsoluteTemperature Tstartout=Tstartbar
    "Outlet temperature start value" annotation (Dialog(tab="Initialisation"));
  parameter ThermoPower3.AbsoluteTemperature Tstart[N]=linspace(
      Tstartin,
      Tstartout,
      N) "Start value of temperature vector (initialized by default)"
    annotation (Dialog(tab="Initialisation"));
  final parameter Modelica.SIunits.Velocity unom=10
    "Nominal velocity for simplified equation";
  parameter Real wnf=0.01
    "Fraction of nominal flow rate at which linear friction equals turbulent friction";
  parameter Real Kfc=1 "Friction factor correction coefficient";
  parameter Modelica.SIunits.MassFraction Xstart[nX]=Medium.reference_X
    "Start gas composition" annotation (Dialog(tab="Initialisation"));
  parameter ThermoPower3.Choices.Init.Options initOpt=ThermoPower3.Choices.Init.Options.noInit
    "Initialisation option" annotation (Dialog(tab="Initialisation"));
  function squareReg = ThermoPower3.Functions.squareReg;
protected
  parameter Integer nXi=Medium.nXi "number of independent mass fractions";
  parameter Integer nX=Medium.nX "total number of mass fractions";
  constant Real g=Modelica.Constants.g_n;
public
  ThermoPower3.Gas.FlangeA infl(redeclare package Medium = Medium, m_flow(start=
         wnom, min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}, rotation=
           0)));
  ThermoPower3.Gas.FlangeB outfl(redeclare package Medium = Medium, m_flow(
        start=-wnom, max=if allowFlowReversal then +Modelica.Constants.inf
           else 0)) annotation (Placement(transformation(extent={{80,-20},{120,20}},
          rotation=0)));
  replaceable ThermoPower3.Thermal.DHT wall(N=N) annotation (Dialog(enable=false),
      Placement(transformation(extent={{-60,40},{60,60}}, rotation=0)));
public
  Medium.BaseProperties gas[N] "Gas nodal properties";
  // Xi(start=fill(Xstart[1:nXi],N)),
  // X(start=fill(Xstart,N)),
  Modelica.SIunits.Pressure Dpfric "Pressure drop due to friction";
  Modelica.SIunits.Length omega_hyd "Wet perimeter (single tube)";
  Real Kf "Friction factor";
  Real Kfl "Linear friction factor";
  Real dwdt "Time derivative of mass flow rate";
  Real Cf "Fanning friction factor";
  Modelica.SIunits.MassFlowRate w(start=wnom/Nt) "Mass flowrate (single tube)";
  ThermoPower3.AbsoluteTemperature Ttilde[N - 1](start=ones(N - 1)*Tstartin + (1
        :(N - 1))/(N - 1)*(Tstartout - Tstartin), stateSelect=StateSelect.prefer)
    "Temperature state variables";
  ThermoPower3.AbsoluteTemperature Tin(start=Tstartin);
  Real Xtilde[if UniformComposition or Medium.fixedX then 1 else N - 1, nX](
      start=ones(size(Xtilde, 1), size(Xtilde, 2))*diagonal(Xstart[1:nX]),
      stateSelect=StateSelect.prefer) "Composition state variables";
  Modelica.SIunits.MassFlowRate wbar[N - 1](each start=wnom/Nt);
  Modelica.SIunits.Velocity u[N] "Fluid velocity";
  Modelica.SIunits.Pressure p(start=pstart, stateSelect=StateSelect.prefer);
  Modelica.SIunits.Time Tr "Residence time";
  Modelica.SIunits.Mass M "Gas Mass";
  Real Q "Total heat flow through the wall (all Nt tubes)";
protected
  parameter Real dzdx=H/L "Slope";
  parameter Modelica.SIunits.Length l=L/(N - 1) "Length of a single volume";
  ThermoPower3.Density rhobar[N - 1] "Fluid average density";
  Modelica.SIunits.SpecificVolume vbar[N - 1] "Fluid average specific volume";
  Modelica.SIunits.HeatFlux phibar[N - 1] "Average heat flux";
  Modelica.SIunits.DerDensityByPressure drbdp[N - 1]
    "Derivative of average density by pressure";
  Modelica.SIunits.DerDensityByTemperature drbdT1[N - 1]
    "Derivative of average density by left temperature";
  Modelica.SIunits.DerDensityByTemperature drbdT2[N - 1]
    "Derivative of average density by right temperature";
  Real drbdX1[N - 1, nX](unit="kg/m3")
    "Derivative of average density by left composition";
  Real drbdX2[N - 1, nX](unit="kg/m3")
    "Derivative of average density by right composition";
  Medium.SpecificHeatCapacity cvbar[N - 1] "Average cv";
  Real dMdt[N - 1] "Derivative of mass in a finite volume";
  Medium.SpecificHeatCapacity cv[N];
  Medium.DerDensityByTemperature dddT[N] "Derivative of density by temperature";
  Medium.DerDensityByPressure dddp[N] "Derivative of density by pressure";
  Real dddX[N, nX](unit="kg/m3") "Derivative of density by composition";
equation
  assert(FFtype == FFtypes.NoFriction or dpnom > 0,
    "dpnom=0 not supported, it is also used in the homotopy trasformation during the inizialization");
  //All equations are referred to a single tube
  // Friction factor selection
  omega_hyd = 4*A/Dhyd;
  if FFtype == FFtypes.Kfnom then
    Kf = Kfnom*Kfc;
    Cf = 2*Kf*A^3/(omega_hyd*L);
  elseif FFtype == FFtypes.OpPoint then
    Kf = dpnom*rhonom/(wnom/Nt)^2*Kfc;
    Cf = 2*Kf*A^3/(omega_hyd*L);
  elseif FFtype == FFtypes.Cfnom then
    Kf = Cfnom*omega_hyd*L/(2*A^3)*Kfc;
    Cf = Cfnom*Kfc;
  elseif FFtype == FFtypes.Colebrook then
    Cf = ThermoPower3.Gas.f_colebrook(
      w,
      Dhyd/A,
      e,
      Medium.dynamicViscosity(gas[integer(N/2)].state))*Kfc;
    Kf = Cf*omega_hyd*L/(2*A^3);
  elseif FFtype == FFtypes.NoFriction then
    Cf = 0;
    Kf = 0;
  end if;
  assert(Kf >= 0, "Negative friction coefficient");
  Kfl = wnom/Nt*wnf*Kf "Linear friction factor";

  // Dynamic momentum term
  dwdt = if DynamicMomentum and not QuasiStatic then der(w) else 0;

  sum(dMdt) = (infl.m_flow + outfl.m_flow)/Nt "Mass balance";
  L/A*dwdt + (outfl.p - infl.p) + Dpfric + sum(rhobar)*g*H/N = 0
    "Momentum balance";
  Dpfric = (if FFtype == FFtypes.NoFriction then 0 else homotopy((smooth(1,
    Kf*squareReg(w, wnom/Nt*wnf))*sum(vbar)/(N - 1)), dpnom/(wnom/Nt)*w))
    "Pressure drop due to friction";
  for j in 1:N - 1 loop
    if not QuasiStatic then
      // Dynamic mass and energy balances
      A*l*rhobar[j]*cvbar[j]*der(Ttilde[j]) + wbar[j]*(gas[j + 1].h - gas[j].h)
        -  wbar[j]*g*H/N = l*omega*phibar[j] "Energy balance";
      dMdt[j] = A*l*(drbdp[j]*der(p) + drbdT1[j]*der(gas[j].T) + drbdT2[j]*
        der(gas[j + 1].T) + vector(drbdX1[j, :])*vector(der(gas[j].X)) +
        vector(drbdX2[j, :])*vector(der(gas[j + 1].X))) "Mass balance";
      /*
      dMdt[j] = A*l*(drbdT[j]*der(Ttilde[j]) + drbdp[j]*der(p) + vector(drbdX[j, :])*
      vector(der(Xtilde[if UniformComposition then 1 else j, :]))) 
      "Mass balance";
*/
      // Average volume quantities
      if avoidInletEnthalpyDerivative and j == 1 then
        // first volume properties computed by the volume outlet properties
        rhobar[j] = gas[j + 1].d;
        drbdp[j] = dddp[j + 1];
        drbdT1[j] = 0;
        drbdT2[j] = dddT[j + 1];
        drbdX1[j, :] = zeros(size(Xtilde, 2));
        drbdX2[j, :] = dddX[j + 1, :];
      else
        // volume properties computed by averaging
        rhobar[j] = (gas[j].d + gas[j + 1].d)/2;
        drbdp[j] = (dddp[j] + dddp[j + 1])/2;
        drbdT1[j] = dddT[j]/2;
        drbdT2[j] = dddT[j + 1]/2;
        drbdX1[j, :] = dddX[j, :]/2;
        drbdX2[j, :] = dddX[j + 1, :]/2;
      end if;
      vbar[j] = 1/rhobar[j];
      wbar[j] = homotopy(infl.m_flow/Nt - sum(dMdt[1:j - 1]) - dMdt[j]/2,
        wnom/Nt);
      cvbar[j] = (cv[j] + cv[j + 1])/2;
    else
      // Static mass and energy balances
      wbar[j]*(gas[j + 1].h - gas[j].h) = l*omega*phibar[j] "Energy balance";
      dMdt[j] = 0 "Mass balance";
      // Dummy values for unused average quantities
      rhobar[j] = 0;
      drbdp[j] = 0;
      drbdT1[j] = 0;
      drbdT2[j] = 0;
      drbdX1[j, :] = zeros(nX);
      drbdX2[j, :] = zeros(nX);
      vbar[j] = 0;
      wbar[j] = infl.m_flow/Nt;
      cvbar[j] = 0;
    end if;
  end for;
  Q = Nt*l*omega*sum(phibar) "Total heat flow through the lateral boundary";
  if Medium.fixedX then
    Xtilde = fill(Medium.reference_X, 1);
  elseif QuasiStatic then
    Xtilde = fill(gas[1].X, size(Xtilde, 1))
      "Gas composition equal to actual inlet";
  elseif UniformComposition then
    der(Xtilde[1, :]) = homotopy(1/L*sum(u)/N*(gas[1].X - gas[N].X), 1/L*unom
      *(gas[1].X - gas[N].X)) "Partial mass balance for the whole pipe";
  else
    for j in 1:N - 1 loop
      der(Xtilde[j, :]) = homotopy((u[j + 1] + u[j])/(2*l)*(gas[j].X - gas[j
         + 1].X), 1/L*unom*(gas[j].X - gas[j + 1].X))
        "Partial mass balance for single volume";
    end for;
  end if;
  for j in 1:N loop
    u[j] = w/(gas[j].d*A) "Gas velocity";
    gas[j].p = p;
  end for;
  // Fluid property computations
  for j in 1:N loop
    if not QuasiStatic then
      cv[j] = Medium.heatCapacity_cv(gas[j].state);
      dddT[j] = Medium.density_derT_p(gas[j].state);
      dddp[j] = Medium.density_derp_T(gas[j].state);
      if nX > 0 then
        dddX[j, :] = Medium.density_derX(gas[j].state);
      end if;
    else
      // Dummy values (not needed by dynamic equations)
      cv[j] = 0;
      dddT[j] = 0;
      dddp[j] = 0;
      dddX[j, :] = zeros(nX);
    end if;
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
  infl.h_outflow = gas[1].h;
  outfl.h_outflow = gas[N].h;
  infl.Xi_outflow = gas[1].Xi;
  outfl.Xi_outflow = gas[N].Xi;

  gas[1].h = inStream(infl.h_outflow);
  gas[2:N].T = Ttilde;
  gas[1].Xi = inStream(infl.Xi_outflow);
  for j in 2:N loop
    gas[j].Xi = Xtilde[if UniformComposition then 1 else j - 1, 1:nXi];
  end for;
  /*
  if w >= 0 then
    gas[1].h = infl.hBA;
    gas[2:N].T = Ttilde;
    gas[1].Xi = infl.XBA;
    for j in 2:N loop
      gas[j].Xi = Xtilde[if UniformComposition then 1 else j - 1, 1:nXi];
    end for;
  else
    gas[N].h = outfl.hAB;
    gas[1:N - 1].T = Ttilde;
    gas[N].Xi = outfl.XAB;
    for j in 1:N - 1 loop
      gas[j].Xi = Xtilde[if UniformComposition then 1 else j, 1:nXi];
    end for;
  end if;
*/

  gas.T = wall.T;
  Tin = gas[1].T;
  phibar = (wall.phi[1:N - 1] + wall.phi[2:N])/2;

  M = sum(rhobar)*A*l "Total gas mass";
  Tr = noEvent(M/max(infl.m_flow/Nt, Modelica.Constants.eps)) "Residence time";
initial equation
  if initOpt == ThermoPower3.Choices.Init.Options.noInit or QuasiStatic then
    // do nothing
  elseif initOpt == ThermoPower3.Choices.Init.Options.steadyState then
    if (not Medium.singleState) then
      der(p) = 0;
    end if;
    der(Ttilde) = zeros(N - 1);
    if (not Medium.fixedX) then
      der(Xtilde) = zeros(size(Xtilde, 1), size(Xtilde, 2));
    end if;
  elseif initOpt == ThermoPower3.Choices.Init.Options.steadyStateNoP then
    der(Ttilde) = zeros(N - 1);
    if (not Medium.fixedX) then
      der(Xtilde) = zeros(size(Xtilde, 1), size(Xtilde, 2));
    end if;
  else
    assert(false, "Unsupported initialisation option");
  end if;

  annotation (
    Icon(graphics={Text(extent={{-100,-40},{100,-80}}, textString="%name")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
            graphics),
    Documentation(info="<html>
<p>This model describes the flow of a gas in a rigid tube. The basic modelling assumptions are:
<ul>
<li>Uniform velocity is assumed on the cross section, leading to a 1-D distributed parameter model.
<li>Turbulent friction is always assumed; a small linear term is added to avoid numerical singularities at zero flowrate. The friction effects are not accurately computed in the laminar and transitional flow regimes, which however should not be an issue in most power generation applications.
<li>The model is based on dynamic mass, momentum, and energy balances. The dynamic momentum term can be switched off, to avoid the fast oscillations that can arise from its coupling with the mass balance (sound wave dynamics). 
<li>The longitudinal heat diffusion term is neglected.
<li>The energy balance equation is written by assuming a uniform pressure distribution; the pressure drop is lumped either at the inlet or at the outlet.
<li>The fluid flow can exchange thermal power through the lateral surface, which is represented by the <tt>wall</tt> connector. The actual heat flux must be computed by a connected component (heat transfer computation module).
</ul>
<p>The mass, momentum and energy balance equation are discretised with the finite volume method. The state variables are one pressure, one flowrate (optional), N-1 temperatures, and either one or N-1 gas composition vectors.
<p>The turbulent friction factor can be either assumed as a constant, or computed by Colebrook's equation. In the former case, the friction factor can be supplied directly, or given implicitly by a specified operating point. In any case, the multiplicative correction coefficient <tt>Kfc</tt> can be used to modify the friction coefficient, e.g. to fit experimental data.
<p>A small linear pressure drop is added to avoid numerical singularities at low or zero flowrate. The <tt>wnom</tt> parameter must be always specified: the additional linear pressure drop is such that it is equal to the turbulent pressure drop when the flowrate is equal to <tt>wnf*wnom</tt> (the default value is 1% of the nominal flowrate). Increase <tt>wnf</tt> if numerical problems occur in tubes with very low pressure drops.
<p>Flow reversal is fully supported.
<p><b>Modelling options</b></p>
<p>The actual gas used in the component is determined by the replaceable <tt>Medium</tt> package.In the case of multiple component, variable composition gases, the start composition is given by <tt>Xstart</tt>, whose default value is <tt>Medium.reference_X</tt>.
<p>Thermal variables (enthalpy, temperature, density) are computed in <tt>N</tt> equally spaced nodes, including the inlet (node 1) and the outlet (node N); <tt>N</tt> must be greater than or equal to 2.
<p>if <tt>UniformComposition</tt> is true, then a uniform compostion is assumed for the gas through the entire tube lenght; otherwise, the gas compostion is computed in <tt>N</tt> equally spaced nodes, as in the case of thermal variables.
<p>The following options are available to specify the friction coefficient:
<ul><li><tt>FFtype = FFtypes.Kfnom</tt>: the hydraulic friction coefficient <tt>Kf</tt> is set directly to <tt>Kfnom</tt>.
<li><tt>FFtype = FFtypes.OpPoint</tt>: the hydraulic friction coefficient is specified by a nominal operating point (<tt>wnom</tt>,<tt>dpnom</tt>, <tt>rhonom</tt>).
<li><tt>FFtype = FFtypes.Cfnom</tt>: the friction coefficient is computed by giving the (constant) value of the Fanning friction factor <tt>Cfnom</tt>.
<li><tt>FFtype = FFtypes.Colebrook</tt>: the Fanning friction factor is computed by Colebrook's equation (assuming Re > 2100, e.g. turbulent flow).
<li><tt>FFtype = FFtypes.NoFriction</tt>: no friction is assumed across the pipe.</ul>
<p>If <tt>QuasiStatic</tt> is set to true, the dynamic terms are neglected in the mass, momentum, and energy balances, i.e., quasi-static behaviour is modelled. It is also possible to neglect only the dynamic momentum term by setting <tt>DynamicMomentum = false</tt>.
<p>If <tt>HydraulicCapacitance = 2</tt> (default option) then the mass buildup term depending on the pressure is lumped at the outlet, while the optional momentum buildup term depending on the flowrate is lumped at the inlet; therefore, the state variables are the outlet pressure and the inlet flowrate. If <tt>HydraulicCapacitance = 1</tt> the reverse takes place.
<p>Start values for the pressure and flowrate state variables are specified by <tt>pstart</tt>, <tt>wstart</tt>. The start values for the node temperatures are linearly distributed from <tt>Tstartin</tt> at the inlet to <tt>Tstartout</tt> at the outlet. The (uniform) start value of the gas composition is specified by <tt>Xstart</tt>.
<p>A bank of <tt>Nt</tt> identical tubes working in parallel can be modelled by setting <tt>Nt > 1</tt>. The geometric parameters always refer to a <i>single</i> tube.
<p>This models makes the temperature and external heat flow distributions available to connected components through the <tt>wall</tt> connector. If other variables (e.g. the heat transfer coefficient) are needed by external components to compute the actual heat flow, the <tt>wall</tt> connector can be replaced by an extended version of the <tt>DHT</tt> connector.
</html>",
        revisions="<html>
<ul>
<li><i>30 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Initialisation support added.</li>
<li><i>24 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       <tt>QuasiStatic</tt> added.<br>
       <tt>FFtypes</tt> package and <tt>NoFriction</tt> option added.</li>
<li><i>19 Nov 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<li><i>5 Mar 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),
    DymolaStoredErrors);
end Flow1D;
