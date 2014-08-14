within ORNL_AdvSMR.Components;
model Flow1Dfem2ph
  "1-dimensional fluid flow model for water/steam (finite elements)"
  import Modelica.Math.*;
  import ThermoPower3.Choices.Flow1D.FFtypes;
  import ThermoPower3.Choices.Flow1D.HCtypes;
  extends ThermoPower3.Water.Flow1DBase(redeclare replaceable package Medium =
        ThermoPower3.Water.StandardWater constrainedby
      Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model");
  parameter Real alpha(
    min=0,
    max=2) = 1 "Numerical stabilization coefficient";
  parameter Real ML(
    min=0,
    max=1) = 0.2 "Mass Lumping Coefficient";
  constant Real g=Modelica.Constants.g_n;
  final parameter Boolean evenN=(div(N, 2)*2 == N)
    "The number of nodes is even";
  constant Modelica.SIunits.Pressure pzero=10 "Small deltap for calculations";
  constant Modelica.SIunits.Pressure pc=Medium.fluidConstants[1].criticalPressure;
  constant Modelica.SIunits.SpecificEnthalpy hzero=1e-3;

  Medium.ThermodynamicState fluidState[N]
    "Thermodynamic state of the fluid at the nodes";
  Medium.SaturationProperties sat "Properties of saturated fluid";
  Medium.ThermodynamicState dew "Thermodynamic state at dewpoint";
  Medium.ThermodynamicState bubble "Thermodynamic state at bubblepoint";
  Modelica.SIunits.Length omega_hyd "Hydraulic perimeter (single tube)";
  Real dwdt "Dynamic momentum term";
  Medium.AbsolutePressure p "Fluid pressure";
  Modelica.SIunits.Pressure Dpfric "Pressure drop due to friction";
  Modelica.SIunits.Pressure Dpfric1
    "Pressure drop due to friction (from inlet to capacitance)";
  Modelica.SIunits.Pressure Dpfric2
    "Pressure drop due to friction (from capacitance to outlet)";
  Modelica.SIunits.Pressure Dpstat "Pressure drop due to static head";
  Modelica.SIunits.MassFlowRate w[N](start=wnom*ones(N))
    "Mass flowrate (single tube)";
  Modelica.SIunits.Velocity u[N] "Fluid velocity";
  Modelica.SIunits.HeatFlux phi[N] "External heat flux";
  Medium.Temperature T[N] "Fluid temperature";
  Medium.SpecificEnthalpy h[N](start=hstart) "Fluid specific enthalpy";
  Medium.Density rho[N] "Fluid density";
  Modelica.SIunits.SpecificVolume v[N] "Fluid specific volume";

  Medium.Temperature Ts "Saturation temperature";
  Medium.SpecificEnthalpy hl(start=Medium.bubbleEnthalpy(Medium.setSat_p(pstart)))
    "Saturated liquid specific enthalpy";
  Medium.SpecificEnthalpy hv(start=Medium.dewEnthalpy(Medium.setSat_p(pstart)))
    "Saturated vapour specific enthalpy";
  Real x[N] "Steam quality";
  ThermoPower3.LiquidDensity rhol "Saturated liquid density";
  ThermoPower3.GasDensity rhov "Saturated vapour density";

  Real Kf[N] "Friction coefficient";
  Real Cf[N] "Fanning friction factor";
  Real Phi[N] "Two-phase friction multiplier";
protected
  Modelica.SIunits.DerDensityByEnthalpy drdh[N]
    "Derivative of density by enthalpy";
  Modelica.SIunits.DerDensityByPressure drdp[N]
    "Derivative of density by pressure";

  Modelica.SIunits.DerDensityByPressure drl_dp
    "Derivative of liquid density by pressure just before saturation";
  Modelica.SIunits.DerDensityByPressure drv_dp
    "Derivative of vapour density by pressure just before saturation";
  Modelica.SIunits.DerDensityByEnthalpy drl_dh
    "Derivative of liquid density by enthalpy just before saturation";
  Modelica.SIunits.DerDensityByEnthalpy drv_dh
    "Derivative of vapour density by enthalpy just before saturation";

  Real dhl "Derivative of saturated liquid enthalpy by pressure";
  Real dhv "Derivative of saturated vapour enthalpy by pressure";

  Real drl "Derivative of saturatd liquid density by pressure";
  Real drv "Derivative of saturated vapour density by pressure";

  ThermoPower3.Density rhos[N - 1];
  Modelica.SIunits.MassFlowRate ws[N - 1];
  Real rs[N - 1];

  Real Y[N, N];
  Real YY[N, N];

  Real Y2ph[N, N];
  Real M[N, N];
  Real D[N];
  Real D1[N];
  Real D2[N];
  Real G[N];
  Real B[N, N];
  Real B2ph[N, N];
  Real C[N, N];
  Real K[N, N];

  Real by[8, N];
  Real beta[8, N];
  //coefficients matrix for 2-phases augmented FEM matrices
  Real alpha_sgn;

  Real gamma_rho[N - 1];
  Real gamma_w[N - 1];
  //coefficients for gamma functions

  Real a;
  Real b;
  Real betap;
  Real c;
  Real d;
  Real ee[N - 1];
  Real f[N - 1];

  Real dMbif[N - 1];
  Real dMmono[N - 1];

equation
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

  //Friction factor calculation
  omega_hyd = 4*A/Dhyd;
  for i in 1:N loop
    if FFtype == FFtypes.NoFriction then
      Cf[i] = 0;
    elseif FFtype == FFtypes.Cfnom then
      Cf[i] = Cfnom*Kfc;
    else
      assert(true, "Unsupported friction factor selection");
    end if;
    Kf[i] = Cf[i]*omega_hyd*L/(2*A^3)
      "Relationship between friction coefficient and Fanning friction factor";
  end for;

  //Dynamic Momentum [not] accounted for
  if DynamicMomentum then
    if HydraulicCapacitance == HCtypes.Upstream then
      dwdt = -der(outfl.m_flow)/Nt;
    else
      dwdt = der(infl.m_flow)/Nt;
    end if;

  else
    dwdt = 0;
  end if;

  //Momentum balance equation
  L/A*dwdt + (outfl.p - infl.p) + Dpstat + Dpfric = 0;

  w[1] = infl.m_flow/Nt;
  w[N] = -outfl.m_flow/Nt;

  Dpfric = Dpfric1 + Dpfric2 "Total pressure drop due to friction";

  if FFtype == FFtypes.NoFriction then
    Dpfric1 = 0;
    Dpfric2 = 0;
  else
    Dpfric1 = homotopy(sum(Kf[i]/L*squareReg(w[i], wnom/Nt*wnf)*D1[i]/rho[i]*
      Phi[i] for i in 1:N), dpnom/2/(wnom/Nt)*w[1])
      "Pressure drop from inlet to capacitance";
    Dpfric2 = homotopy(sum(Kf[i]/L*squareReg(w[i], wnom/Nt*wnf)*D2[i]/rho[i]*
      Phi[i] for i in 1:N), dpnom/2/(wnom/Nt)*w[N])
      "Pressure drop from capacitance to outlet";
  end if "Pressure drop due to friction";

  for i in 1:N loop
    if FFtype == FFtypes.NoFriction or noEvent(h[i] <= hl or h[i] >= hv) then
      Phi[i] = 1;
    else
      // Chisholm-Laird formulation of Martinelli-Lockhart correlation for turbulent-turbulent flow
      // Phi_l^2 = 1 + 20/Xtt + 1/Xtt^2
      // same fixed Fanning friction factor Cfnom is assumed for liquid and vapour, so Xtt = (rhov/rhol)^0.5 * (1-x)/x
      Phi[i] = rho[i]/rhol*((1 - x[i])^2 + 20*sqrt(rhol/rhov)*x[i]*(1 - x[i])
         + rhol/rhov*x[i]^2);
    end if;
  end for;

  Dpstat = if abs(dzdx) < 1e-6 then 0 else g*dzdx*rho*D
    "Pressure drop due to static head";

  //Energy balance equations
  l/12*((1 - ML)*Y + ML*YY + 0*Y2ph)*der(h) + (1/A)*(B + 0*B2ph)*h + C*h/A =
    der(p)*G + M*(omega/A)*phi + K*w/A;

  //  (Ts,rhol,rhov,hl,hv,drl_dp,drv_dp,drl_dh,drv_dh,dhl,dhv,drl,drv) =
  //  propsat_p_2der(noEvent(min(p, pc - pzero)));

  sat.psat = p;
  sat.Tsat = Medium.saturationTemperature(p);
  Ts = sat.Tsat;
  bubble = Medium.setBubbleState(sat);
  dew = Medium.setDewState(sat);
  rhol = Medium.bubbleDensity(sat);
  rhov = Medium.dewDensity(sat);
  hl = Medium.bubbleEnthalpy(sat);
  hv = Medium.dewEnthalpy(sat);
  drl = Medium.dBubbleDensity_dPressure(sat);
  drv = Medium.dDewDensity_dPressure(sat);
  dhl = Medium.dBubbleEnthalpy_dPressure(sat);
  dhv = Medium.dDewEnthalpy_dPressure(sat);
  drl_dp = Medium.density_derp_h(bubble);
  drv_dp = Medium.density_derp_h(dew);
  drl_dh = Medium.density_derh_p(bubble);
  drv_dh = Medium.density_derh_p(dew);

  a = ((hv - hl)*(rhol^2*drv + rhov^2*drl) + rhov*rhol*(rhol - rhov)*(dhv - dhl))
    /(rhol - rhov)^2;
  betap = ((rhol - rhov)*(rhov*dhv - rhol*dhl) + (hv - hl)*(rhol*drv - rhov*drl))
    /(rhol - rhov)^2;
  b = a*c + d*betap;
  c = (rhov*hv - rhol*hl)/(rhol - rhov);
  d = -rhol*rhov*(hv - hl)/(rhol - rhov);

  //Computation of fluid properties
  for j in 1:N loop
    fluidState[j] = Medium.setState_ph(p, h[j]);
    T[j] = Medium.temperature(fluidState[j]);
    rho[j] = Medium.density(fluidState[j]);
    drdp[j] = if Medium.singleState then 0 else Medium.density_derp_h(
      fluidState[j]);
    drdh[j] = Medium.density_derh_p(fluidState[j]);
    v[j] = 1/rho[j];
    u[j] = w[j]/(rho[j]*A);
    x[j] = noEvent(min(max((h[j] - hl)/(hv - hl), 0), 1));
  end for;

  //Wall energy flux and  temperature
  T = wall.T;
  phi = wall.phi;

  //Boundary Values

  h[1] = infl.h_outflow;
  h[N] = outfl.h_outflow;

  alpha_sgn = alpha*sign(infl.m_flow - outfl.m_flow);

  //phase change determination
  for i in 1:N - 1 loop
    (w[i] - w[i + 1]) = dMmono[i] + dMbif[i];
    if noEvent(abs(h[i + 1] - h[i]) < hzero) then

      rs[i] = 0;
      rhos[i] = 0;
      gamma_rho[i] = 0;

      gamma_w[i] = 0;
      ws[i] = 0;

      dMmono[i] = A*l*(der(p)*1/2*(drdp[i + 1] + drdp[i]) + 1/6*(der(h[i])*(2*
        drdh[i] + drdh[i + 1]) + der(h[i + 1])*(drdh[i] + 2*drdh[i + 1])));

      dMbif[i] = 0;

      ee[i] = 0;
      f[i] = 0;

    elseif noEvent((h[i] < hl) and (h[i + 1] >= hl) and (h[i + 1] <= hv)) then
      //liquid - two phase

      rs[i] = (hl - h[i])/(h[i + 1] - h[i]);
      rhos[i] = rhol;
      gamma_rho[i] = (rhos[i] - rho[i]*(1 - rs[i]) - rho[i + 1]*rs[i]);

      gamma_w[i] = (ws[i] - w[i]*(1 - rs[i]) - w[i + 1]*rs[i]);

      (w[i] - ws[i]) = dMmono[i];

      dMmono[i] = A*rs[i]*l*(der(p)*1/2*(drl_dp + drdp[i]) + 1/6*(der(h[i])*(2*
        drdh[i] + drl_dh) + (der(h[i])*(1 - rs[i]) + der(h[i + 1])*rs[i])*(drdh[
        i] + 2*drl_dh)));

      dMbif[i] = A*(1 - rs[i])*l/(h[i + 1] - hl)*(der(p)*((b - a*c)*(h[i + 1]
         - hl)/((c + h[i + 1])*(c + hl)) + a*log((c + h[i + 1])/(c + hl))) + ((
        d*f[i] - d*c*ee[i])*(h[i + 1] - hl)/((c + h[i + 1])*(c + hl)) + d*ee[i]
        *log((c + h[i + 1])/(c + hl))));

      ee[i] = (der(h[i + 1]) - (der(h[i + 1])*rs[i] + der(h[i])*(1 - rs[i])))/(
        h[i + 1] - hl);
      f[i] = ((der(h[i + 1])*rs[i] + der(h[i])*(1 - rs[i]))*h[i + 1] - der(h[i
         + 1])*hl)/(h[i + 1] - hl);

    elseif noEvent((h[i] >= hl) and (h[i] <= hv) and (h[i + 1] < hl)) then
      //two phase-liquid

      rs[i] = (hl - h[i])/(h[i + 1] - h[i]);
      rhos[i] = rhol;
      gamma_rho[i] = (rhos[i] - rho[i]*(1 - rs[i]) - rho[i + 1]*rs[i]);

      gamma_w[i] = (ws[i] - w[i]*(1 - rs[i]) - w[i + 1]*rs[i]);

      (w[i] - ws[i]) = dMbif[i];

      dMmono[i] = A*(1 - rs[i])*l*(der(p)*1/2*(drdp[i + 1] + drl_dp) + 1/6*(der(
        h[i])*(2*drl_dh + drdh[i + 1]) + (der(h[i + 1])*rs[i] + der(h[i])*(1 -
        rs[i]))*(drl_dh + 2*drdh[i + 1])));

      dMbif[i] = A*rs[i]*l/(hl - h[i])*(der(p)*((b - a*c)*(hl - h[i])/((c + hl)
        *(c + h[i])) + a*log((c + hl)/(c + h[i]))) + ((d*f[i] - d*c*ee[i])*(hl
         - h[i])/((c + hl)*(c + h[i])) + d*ee[i]*log((c + hl)/(c + h[i]))));

      ee[i] = ((der(h[i + 1])*rs[i] + der(h[i])*(1 - rs[i])) - der(h[i]))/(hl
         - h[i]);
      f[i] = (der(h[i])*hl - (der(h[i + 1])*rs[i] + der(h[i])*(1 - rs[i]))*h[i])
        /(hl - h[i]);

    elseif noEvent((h[i] >= hl) and (h[i] <= hv) and (h[i + 1] > hv)) then
      //two phase - vapour

      rs[i] = (hv - h[i])/(h[i + 1] - h[i]);
      rhos[i] = rhov;
      gamma_rho[i] = (rhos[i] - rho[i]*(1 - rs[i]) - rho[i + 1]*rs[i]);

      gamma_w[i] = (ws[i] - w[i]*(1 - rs[i]) - w[i + 1]*rs[i]);
      (w[i] - ws[i]) = dMbif[i];

      dMmono[i] = A*(1 - rs[i])*l*(der(p)*1/2*(drdp[i + 1] + drv_dp) + 1/6*(der(
        h[i])*(2*drv_dh + drdh[i + 1]) + (der(h[i + 1])*rs[i] + der(h[i])*(1 -
        rs[i]))*(drv_dh + 2*drdh[i + 1])));

      dMbif[i] = A*rs[i]*l/(hv - h[i])*(der(p)*((b - a*c)*(hv - h[i])/((c + hv)
        *(c + h[i])) + a*log((c + hv)/(c + h[i]))) + ((d*f[i] - d*c*ee[i])*(hv
         - h[i])/((c + hv)*(c + h[i])) + d*ee[i]*log((c + hv)/(c + h[i]))));

      ee[i] = ((der(h[i + 1])*rs[i] + der(h[i])*(1 - rs[i])) - der(h[i]))/(hv
         - h[i]);
      f[i] = (der(h[i])*hv - (der(h[i + 1])*rs[i] + der(h[i])*(1 - rs[i]))*h[i])
        /(hv - h[i]);

    elseif noEvent((h[i] > hv) and (h[i + 1] >= hl) and (h[i + 1] <= hv)) then
      // vapour - two phase

      rs[i] = (hv - h[i])/(h[i + 1] - h[i]);
      rhos[i] = rhov;
      gamma_rho[i] = (rhos[i] - rho[i]*(1 - rs[i]) - rho[i + 1]*rs[i]);

      gamma_w[i] = (ws[i] - w[i]*(1 - rs[i]) - w[i + 1]*rs[i]);
      (w[i] - ws[i]) = dMmono[i];

      dMmono[i] = A*rs[i]*l*(der(p)*1/2*(drv_dp + drdp[i]) + 1/6*(der(h[i])*(2*
        drdh[i] + drv_dh) + (der(h[i])*(1 - rs[i]) + der(h[i + 1])*rs[i])*(drdh[
        i] + 2*drv_dh)));

      dMbif[i] = A*(1 - rs[i])*(der(p)*((b - a*c)*(h[i + 1] - hv)/((c + h[i + 1])
        *(c + hv)) + a*log((c + h[i + 1])/(c + hv))) + ((d*f[i] - d*c*ee[i])*(h[
        i + 1] - hv)/((c + h[i + 1])*(c + hv)) + d*ee[i]*log((c + h[i + 1])/(c
         + hv))));

      ee[i] = (der(h[i + 1]) - (der(h[i + 1])*rs[i] + der(h[i])*(1 - rs[i])))/(
        h[i + 1] - hv);
      f[i] = ((der(h[i + 1])*rs[i] + der(h[i])*(1 - rs[i]))*h[i + 1] - der(h[i
         + 1])*hv)/(h[i + 1] - hv);

    elseif noEvent((h[i] >= hl) and (h[i] <= hv) and (h[i + 1] >= hl) and (h[i
         + 1] <= hv)) then
      //two phase

      rs[i] = 0;
      rhos[i] = 0;
      gamma_rho[i] = 0;

      gamma_w[i] = 0;

      ws[i] = 0;

      dMmono[i] = 0;

      dMbif[i] = A*l/(h[i + 1] - h[i])*(der(p)*((b - a*c)*(h[i + 1] - h[i])/((c
         + h[i + 1])*(c + h[i])) + a*log((c + h[i + 1])/(c + h[i]))) + ((d*f[i]
         - d*c*ee[i])*(h[i + 1] - h[i])/((c + h[i + 1])*(c + h[i])) + d*ee[i]*
        log((c + h[i + 1])/(c + h[i]))));

      ee[i] = (der(h[i + 1]) - der(h[i]))/(h[i + 1] - h[i]);
      f[i] = (der(h[i])*h[i + 1] - der(h[i + 1])*h[i])/(h[i + 1] - h[i]);

    elseif noEvent(((h[i] < hl) and (h[i + 1] < hl)) or ((h[i] > hv) and (h[i
         + 1] > hv))) then
      //single-phase

      rs[i] = 0;
      rhos[i] = 0;
      gamma_rho[i] = 0;

      gamma_w[i] = 0;
      ws[i] = 0;

      dMmono[i] = A*l*(der(p)*1/2*(drdp[i + 1] + drdp[i]) + 1/6*(der(h[i])*(2*
        drdh[i] + drdh[i + 1]) + der(h[i + 1])*(drdh[i] + 2*drdh[i + 1])));
      dMbif[i] = 0;

      ee[i] = 0;
      f[i] = 0;
    else
      //double transition (not supported!)
      assert(0 > 1,
        "Error: two phase transitions between two adiacent nodes. Try increasing the number of nodes");
      rs[i] = 0;
      rhos[i] = 0;
      gamma_rho[i] = 0;

      gamma_w[i] = 0;
      ws[i] = 0;

      dMmono[i] = 0;
      dMbif[i] = 0;

      ee[i] = 0;
      f[i] = 0;
    end if;
  end for;

  // Energy equation FEM matrices

  Y[1, 1] = rho[1]*(3 - 2*alpha_sgn) + rho[2]*(1 - alpha_sgn);
  Y[1, 2] = rho[1]*(1 - alpha_sgn) + rho[2]*(1 - 2*alpha_sgn);
  Y[N, N] = rho[N - 1]*(alpha_sgn + 1) + rho[N]*(3 + 2*alpha_sgn);
  Y[N, N - 1] = rho[N - 1]*(1 + 2*alpha_sgn) + rho[N]*(1 + alpha_sgn);
  if N > 2 then
    for i in 2:N - 1 loop
      Y[i, i - 1] = rho[i - 1]*(1 + 2*alpha_sgn) + rho[i]*(1 + alpha_sgn);
      Y[i, i] = rho[i - 1]*(1 + alpha_sgn) + rho[i]*6 + rho[i + 1]*(1 -
        alpha_sgn);
      Y[i, i + 1] = rho[i]*(1 - alpha_sgn) + rho[i + 1]*(1 - 2*alpha_sgn);
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
  B[N, N - 1] = (-1/6 - alpha_sgn/4)*w[N - 1] + (-1/3 - alpha_sgn/4)*w[N];
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

  G[1] = l/2*(1 - alpha_sgn);
  G[N] = l/2*(1 + alpha_sgn);
  if N > 2 then
    for i in 2:N - 1 loop
      G[i] = l;
    end for;
  end if;

  //boundary conditions

  C[1, 1] = if noEvent(infl.m_flow >= 0) then (1 - alpha_sgn/2)*w[1] else 0;
  C[N, N] = if noEvent(outfl.m_flow >= 0) then -(1 + alpha_sgn/2)*w[N] else 0;
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

  K[1, 1] = if noEvent(infl.m_flow >= 0) then (1 - alpha_sgn/2)*inStream(infl.h_outflow)
     else 0;
  K[N, N] = if noEvent(outfl.m_flow >= 0) then -(1 + alpha_sgn/2)*inStream(
    outfl.h_outflow) else 0;
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

  by[1, 1] = 0;
  by[2, 1] = 0;
  by[3, 1] = l/12*rs[1]*(6 - 8*rs[1] + 3*rs[1]^2 + alpha_sgn*(2*rs[1] - 3));
  by[4, 1] = -l/12*(1 - rs[1])^2*(2*alpha_sgn + 3*rs[1] - 3);
  by[5, 1] = -l/12*rs[1]^2*(2*alpha_sgn + 3*rs[1] - 4);
  by[6, 1] = -l/12*(1 - rs[1])*(3*rs[1]^2 - 2*rs[1] + 2*alpha_sgn*rs[1] +
    alpha_sgn - 1);
  by[7, 1] = 0;
  by[8, 1] = 0;
  by[1, N] = l/12*rs[N - 1]^2*(2*alpha_sgn + 3*rs[N - 1]);
  by[2, N] = l/12*(1 - rs[N - 1])*(1 + alpha_sgn + 2*rs[N - 1] + 2*alpha_sgn*rs[
    N - 1] + 3*rs[N - 1]^2);
  by[3, N] = 0;
  by[4, N] = 0;
  by[5, N] = 0;
  by[6, N] = 0;
  by[7, N] = l/12*rs[N - 1]*(alpha_sgn*(3 - 2*rs[N - 1]) + rs[N - 1]*(4 - 3*rs[
    N - 1]));
  by[8, N] = l/12*(1 - rs[N - 1])^2*(2*alpha_sgn + 3*rs[N - 1] + 1);
  if N > 2 then
    for i in 2:N - 1 loop
      by[1, i] = l/12*rs[i - 1]^2*(2*alpha_sgn + 3*rs[i - 1]);
      by[2, i] = l/12*(1 - rs[i - 1])*(1 + alpha_sgn + 2*rs[i - 1] + 2*
        alpha_sgn*rs[i - 1] + 3*rs[i - 1]^2);
      by[3, i] = l/12*rs[i]*(6 - 8*rs[i] + 3*rs[i]^2 + alpha_sgn*(2*rs[i] - 3));
      by[4, i] = -l/12*(1 - rs[i])^2*(2*alpha_sgn + 3*rs[i] - 3);
      by[5, i] = -l/12*rs[i]^2*(2*alpha_sgn + 3*rs[i] - 4);
      by[6, i] = -l/12*(1 - rs[i])*(3*rs[i]^2 - 2*rs[i] + 2*alpha_sgn*rs[i] +
        alpha_sgn - 1);
      by[7, i] = l/12*rs[i - 1]*(alpha_sgn*(3 - 2*rs[i - 1]) + rs[i - 1]*(4 - 3
        *rs[i - 1]));
      by[8, i] = l/12*(1 - rs[i - 1])^2*(2*alpha_sgn + 3*rs[i - 1] + 1);
    end for;
  end if;

  //additional 2 phases Y-matrix
  Y2ph[1, 1] = (gamma_rho[1]*by[3, 1] + gamma_rho[1]*by[4, 1]);
  Y2ph[1, 2] = (gamma_rho[1]*by[5, 1] + gamma_rho[1]*by[6, 1]);
  Y2ph[N, N] = (gamma_rho[N - 1]*by[1, N] + gamma_rho[N - 1]*by[2, N]);
  Y2ph[N, N - 1] = (gamma_rho[N - 1]*by[7, N] + gamma_rho[N - 1]*by[8, N]);
  if N > 2 then
    for i in 2:N - 1 loop
      Y2ph[i, i - 1] = (gamma_rho[i - 1]*by[7, i] + gamma_rho[i - 1]*by[8, i]);
      Y2ph[i, i] = (gamma_rho[i - 1]*by[1, i] + gamma_rho[i - 1]*by[2, i]) + (
        gamma_rho[i]*by[3, i] + gamma_rho[i]*by[4, i]);
      Y2ph[i, i + 1] = (gamma_rho[i]*by[5, i] + gamma_rho[i]*by[6, i]);
      Y2ph[1, i + 1] = 0;
      Y2ph[N, i - 1] = 0;
      for j in 1:(i - 2) loop
        Y2ph[i, j] = 0;
      end for;
      for j in (i + 2):N loop
        Y2ph[i, j] = 0;
      end for;
    end for;
  end if;

  //computation of beta functions for additional matrices
  beta[1, 1] = 0;
  beta[2, 1] = 0;
  beta[3, 1] = 1/12*rs[1]*(3*alpha_sgn + 4*rs[1] - 6);
  beta[4, 1] = 1/12*(1 - rs[1])*(3*alpha_sgn + 4*rs[1] - 4);
  beta[5, 1] = -beta[3, 1];
  beta[6, 1] = -beta[4, 1];
  beta[7, 1] = 0;
  beta[8, 1] = 0;
  beta[1, N] = 1/12*rs[N - 1]*(3*alpha_sgn + 4*rs[N - 1]);
  beta[2, N] = 1/12*(1 - rs[N - 1])*(3*alpha_sgn + 4*rs[N - 1] + 2);
  beta[3, N] = 0;
  beta[4, N] = 0;
  beta[5, N] = 0;
  beta[6, N] = 0;
  beta[7, N] = -beta[1, N];
  beta[8, N] = -beta[2, N];
  if N > 2 then
    for i in 2:N - 1 loop
      beta[1, i] = 1/12*rs[i - 1]*(3*alpha_sgn + 4*rs[i - 1]);
      beta[2, i] = 1/12*(1 - rs[i - 1])*(3*alpha_sgn + 4*rs[i - 1] + 2);
      beta[3, i] = 1/12*rs[i]*(3*alpha_sgn + 4*rs[i] - 6);
      beta[4, i] = 1/12*(1 - rs[i])*(3*alpha_sgn + 4*rs[i] - 4);
      beta[5, i] = -beta[3, i];
      beta[6, i] = -beta[4, i];
      beta[7, i] = -beta[1, i];
      beta[8, i] = -beta[2, i];
    end for;
  end if;

  //additional 2 phases B-matrix
  B2ph[1, 1] = (gamma_w[1]*beta[3, 1] + gamma_w[1]*beta[4, 1]);
  B2ph[1, 2] = (gamma_w[1]*beta[5, 1] + gamma_w[1]*beta[6, 1]);
  B2ph[N, N] = (gamma_w[N - 1]*beta[1, N] + gamma_w[N - 1]*beta[2, N]);
  B2ph[N, N - 1] = (gamma_w[N - 1]*beta[7, N] + gamma_w[N - 1]*beta[8, N]);
  if N > 2 then
    for i in 2:N - 1 loop
      B2ph[i, i - 1] = (gamma_w[i - 1]*beta[7, i] + gamma_w[i - 1]*beta[8, i]);
      B2ph[i, i] = (gamma_w[i - 1]*beta[1, i] + gamma_w[i - 1]*beta[2, i]) + (
        gamma_w[i]*beta[3, i] + gamma_w[i]*beta[4, i]);
      B2ph[i, i + 1] = (gamma_w[i]*beta[5, i] + gamma_w[i]*beta[6, i]);
      B2ph[1, i + 1] = 0;
      B2ph[N, i - 1] = 0;
      for j in 1:(i - 2) loop
        B2ph[i, j] = 0;
      end for;
      for j in (i + 2):N loop
        B2ph[i, j] = 0;
      end for;
    end for;
  end if;
  Q = Nt*omega*D*phi "Total heat flow through lateral boundary";
  Tr = noEvent(sum(rho)*A*l/max(infl.m_flow/Nt, Modelica.Constants.eps));
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
  else
    assert(false, "Unsupported initialisation option");
  end if;
  annotation (
    Diagram(graphics),
    Icon(graphics={Text(extent={{-100,-52},{100,-82}}, textString="%name")}),
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
<p>The mass, momentum, and energy balance equation are discretised with the Finite Element Method (Stabilised Galerkin Least Squares). The state variables are one pressure, one flowrate (optional) and N specific enthalpies.
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
<li><tt>FFtype = FFtypes.NoFriction</tt>: no friction is assumed across the pipe.</ul><p>If <tt>HydraulicCapacitance = 2</tt> (default option) then the mass buildup term depending on the pressure is lumped at the outlet, while the optional momentum buildup term depending on the flowrate is lumped at the inlet. If <tt>HydraulicCapacitance = 1</tt> the reverse takes place.
<p>Start values for pressure and flowrate are specified by <tt>pstart</tt>, <tt>wstart</tt>. The start values for the node enthalpies are linearly distributed from <tt>hstartin</tt> at the inlet to <tt>hstartout</tt> at the outlet.
<p>A bank of <tt>Nt</tt> identical tubes working in parallel can be modelled by setting <tt>Nt > 1</tt>. The geometric parameters always refer to a <i>single</i> tube.
<p>This models makes the temperature and external heat flow distributions visible through the <tt>wall</tt> connector. If other variables (e.g. the heat transfer coefficient) are needed by external components to compute the actual heat flow, the <tt>wall</tt> connector can be replaced by an extended version of the <tt>DHT</tt> connector.
</HTML>", revisions="<html>
<ul>
<li><i>30 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Initialisation support added.</li>
<li><i>24 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       <tt>FFtypes</tt> package and <tt>NoFriction</tt> option added.
       <br>Residence time added</li>
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
       First release.</li>
</ul>
</html>
"));
end Flow1Dfem2ph;
