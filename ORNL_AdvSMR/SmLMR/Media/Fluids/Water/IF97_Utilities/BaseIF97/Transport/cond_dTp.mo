within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Transport;
function cond_dTp
  "Thermal conductivity lam(d,T,p) (industrial use version) only in one-phase region"
  extends Modelica.Icons.Function;
  input SI.Density d "density";
  input SI.Temperature T "temperature (K)";
  input SI.Pressure p "pressure";
  input Integer phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Boolean industrialMethod=true
    "if true, the industrial method is used, otherwise the scientific one";
  output SI.ThermalConductivity lambda "thermal conductivity";
protected
  Integer region(min=1, max=5) "IF97 region, valid values:1,2,3, and 5";
  constant Real n0=1.0 "conductivity coefficient";
  constant Real n1=6.978267 "conductivity coefficient";
  constant Real n2=2.599096 "conductivity coefficient";
  constant Real n3=-0.998254 "conductivity coefficient";
  constant Real[30] nn=array(
                      1.3293046,
                      1.7018363,
                      5.2246158,
                      8.7127675,
                      -1.8525999,
                      -0.40452437,
                      -2.2156845,
                      -10.124111,
                      -9.5000611,
                      0.9340469,
                      0.2440949,
                      1.6511057,
                      4.9874687,
                      4.3786606,
                      0.0,
                      0.018660751,
                      -0.76736002,
                      -0.27297694,
                      -0.91783782,
                      0.0,
                      -0.12961068,
                      0.37283344,
                      -0.43083393,
                      0.0,
                      0.0,
                      0.044809953,
                      -0.1120316,
                      0.13333849,
                      0.0,
                      0.0) "conductivity coefficient";
  constant SI.ThermalConductivity lamstar=0.4945 "scaling conductivity";
  constant SI.Density rhostar=317.763 "scaling density";
  constant SI.Temperature tstar=647.226 "scaling temperature";
  constant SI.Pressure pstar=22.115e6 "scaling pressure";
  constant SI.DynamicViscosity etastar=55.071e-6 "scaling viscosity";
  Integer i "auxiliary variable";
  Integer j "auxiliary variable";
  Real delta "dimensionless density";
  Real tau "dimensionless temperature";
  Real deltam1 "dimensionless density";
  Real taum1 "dimensionless temperature";
  Real Lam0 "part of thermal conductivity";
  Real Lam1 "part of thermal conductivity";
  Real Lam2 "part of thermal conductivity";
  Real tfun "auxiliary variable";
  Real rhofun "auxiliary variable";
  Real dpitau "auxiliary variable";
  Real ddelpi "auxiliary variable";
  Real d2 "auxiliary variable";
  Common.GibbsDerivs g
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
  Common.HelmholtzDerivs f
    "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
  Real Tc=T - 273.15 "Celsius temperature for region check";
  Real Chi "symmetrized compressibility";
  // slightly different variables for industrial use
  constant SI.Density rhostar2=317.7 "Reference density";
  constant SI.Temperature Tstar2=647.25 "Reference temperature";
  constant SI.ThermalConductivity lambdastar=1 "Reference thermal conductivity";
  parameter Real TREL=T/Tstar2 "Relative temperature";
  parameter Real rhoREL=d/rhostar2 "Relative density";
  Real lambdaREL "Relative thermal conductivity";
  Real deltaTREL "Relative temperature increment";
  constant Real[:] C={0.642857,-4.11717,-6.17937,0.00308976,
      0.0822994,10.0932};
  constant Real[:] dpar={0.0701309,0.0118520,0.00169937,-1.0200};
  constant Real[:] b={-0.397070,0.400302,1.060000};
  constant Real[:] B={-0.171587,2.392190};
  constant Real[:] a={0.0102811,0.0299621,0.0156146,-0.00422464};
  Real Q;
  Real S;
  Real lambdaREL2
    "function, part of the interpolating equation of the thermal conductivity";
  Real lambdaREL1
    "function, part of the interpolating equation of the thermal conductivity";
  Real lambdaREL0
    "function, part of the interpolating equation of the thermal conductivity";
algorithm
  // region := BaseIF97.Regions.region_dT(d,T,phase);
  // simplified region check, assuming that calling arguments are legal
  //  assert(phase <> 2,
  //   "thermalConductivity can not be called with 2-phase inputs!");
  assert(d > triple.dvtriple,
    "IF97 medium function cond_dTp called with too low density\n"
     + "d = " + String(d) + " <= " + String(triple.dvtriple) +
    " (triple point density)");
  assert((p <= 100e6 and (Tc >= 0.0 and Tc <= 500)) or (p <=
    70e6 and (Tc > 500.0 and Tc <= 650)) or (p <= 40e6 and (Tc
     > 650.0 and Tc <= 800)),
    "IF97 medium function cond_dTp: thermal conductivity computed outside the range\n"
     + "of validity of the IF97 formulation: p = " + String(p)
     + " Pa, Tc = " + String(Tc) + " K");
  if industrialMethod == true then
    deltaTREL := abs(TREL - 1) + C[4];
    Q := 2 + C[5]/deltaTREL^(3/5);
    if TREL >= 1 then
      S := 1/deltaTREL;
    else
      S := C[6]/deltaTREL^(3/5);
    end if;
    lambdaREL2 := (dpar[1]/TREL^10 + dpar[2])*rhoREL^(9/5)*
      Modelica.Math.exp(C[1]*(1 - rhoREL^(14/5))) + dpar[3]*S*
      rhoREL^Q*Modelica.Math.exp((Q/(1 + Q))*(1 - rhoREL^(1 + Q)))
       + dpar[4]*Modelica.Math.exp(C[2]*TREL^(3/2) + C[3]/
      rhoREL^5);
    lambdaREL1 := b[1] + b[2]*rhoREL + b[3]*Modelica.Math.exp(B[
      1]*(rhoREL + B[2])^2);
    lambdaREL0 := TREL^(1/2)*sum(a[i]*TREL^(i - 1) for i in 1:4);
    lambdaREL := lambdaREL0 + lambdaREL1 + lambdaREL2;
    lambda := lambdaREL*lambdastar;
  else
    if p < data.PLIMIT4A then
      //regions are 1 or 2,
      if d > data.DCRIT then
        region := 1;
      else
        region := 2;
      end if;
    else
      //region is 3, or illegal
      assert(false,
        "the scientific method works only for temperature up to 623.15 K");
    end if;
    tau := tstar/T;
    delta := d/rhostar;
    deltam1 := delta - 1.0;
    taum1 := tau - 1.0;
    Lam0 := 1/(n0 + (n1 + (n2 + n3*tau)*tau)*tau)/(tau^0.5);
    Lam1 := 0.0;
    tfun := 1.0;
    for i in 1:5 loop
      if (i <> 1) then
        tfun := tfun*taum1;
      end if;
      rhofun := 1.0;
      for j in 0:5 loop
        if (j <> 0) then
          rhofun := rhofun*deltam1;
        end if;
        Lam1 := Lam1 + nn[i + j*5]*tfun*rhofun;
      end for;
    end for;
    if (region == 1) then
      g := Basic.g1(p, T);
      // dp/dT @ cont d = -g.p/g.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
      dpitau := -tstar/pstar*(data.PSTAR1*(g.gpi - data.TSTAR1/
        T*g.gtaupi)/g.gpipi/T);
      ddelpi := -pstar/rhostar*data.RH2O/data.PSTAR1/data.PSTAR1
        *T*d*d*g.gpipi;
      Chi := delta*ddelpi;
    elseif (region == 2) then
      g := Basic.g2(p, T);
      dpitau := -tstar/pstar*(data.PSTAR2*(g.gpi - data.TSTAR2/
        T*g.gtaupi)/g.gpipi/T);
      ddelpi := -pstar/rhostar*data.RH2O/data.PSTAR2/data.PSTAR2
        *T*d*d*g.gpipi;
      Chi := delta*ddelpi;
      //         elseif (region == 3) then
      //           f := Basic.f3(T, d);
      //            dpitau := tstar/pstar*(f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau));
      //           ddelpi := pstar*d*d/(rhostar*p*p)/(f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta));
      //    Chi := delta*ddelpi;
    else
      assert(false,
        "thermal conductivity can only be called in the one-phase regions below 623.15 K\n"
         + "(p = " + String(p) + " Pa, T = " + String(T) +
        " K, region = " + String(region) + ")");
    end if;
    taum1 := 1/tau - 1;
    d2 := deltam1*deltam1;
    Lam2 := 0.0013848*etastar/visc_dTp(
                      d,
                      T,
                      p)/(tau*tau*delta*delta)*dpitau*dpitau*
      max(Chi, Modelica.Constants.small)^0.4678*(delta)^0.5*
      Modelica.Math.exp(-18.66*taum1*taum1 - d2*d2);
    lambda := lamstar*(Lam0*Modelica.Math.exp(delta*Lam1) +
      Lam2);
  end if;
end cond_dTp;
