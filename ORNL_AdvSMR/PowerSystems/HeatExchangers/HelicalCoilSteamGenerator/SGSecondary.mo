within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
function SGSecondary "Calculates the secondary side derivatives"

  // extends Modelica.Icons.Function;
  // redeclare replaceable extends BaseProperties;

  import SI = Modelica.SIunits;
  import NonSI = Modelica.SIunits.Conversions.NonSIunits;
  import Cons = Modelica.Constants;
  import Water = Modelica.Media.Water.WaterIF97_base;

protected
  Real C02=1.2 "Drift flux distribution parameter";
  Real C03=1.05;
  Real fVgj2=2.9;
  // Need to fix units
  Real fVgj3=2.9;
  Real rfw;
  Real rho1bar;
  Real drho1bardh;
  Real drho1bardp;
  SI.Density rhog;
  SI.Density rhof;
  SI.SpecificEnthalpy hg;
  SI.SpecificEnthalpy hf;
  SI.SpecificEnthalpy hfg;
  Real dhgdp;
  Real dhfdp;
  Real drhogdp;
  Real drhofdp;
  Real Gsec;
  Real sigmaf;
  Real muf;
  Real jf;
  Real jg;
  Real Ref;
  Water.SaturationProperties sat(Tsat(start=300.0), psat(start=1.0e5))
    "saturation temperature and pressure";
  Water.ThermodynamicState state "thermodynamic state of the fluid";
  Real kXDNBff=0.8920185118542;
  Real jsqrd;
  Real dXdG;
  Real dXdp;
  Real Vgj2;
  Real aDF2;
  Real bDF2;
  Real aoverb2;
  Real logADFBDF2;

public
  input SI.Length L;
  input SI.Pressure Psec;
  input Real hfw;
  input Real h1;
  input Real h4;
  input Real hstmR;
  input Real Wfw;
  input Real Wsl;
  input Real Pfw;
  input Real Tm;
  input Real hpri;
  input Real Wpri;
  input Real Ppri;
  input SI.Area Asec;
  input SI.Area Apri;
  input Real Dhsec;
  input Real Dhpri;
  input Real Do;
  input Real Di;
  input Real Nsec;
  input Real eetube;
  input Real theta;
  input SI.ThermalConductivity ktube;
  input Real khtcff;
  output SI.Velocity dzdt;
  output Real dh1dt;
  output Real dh4dt;
  output Real dPsecdt;
  output Real hsec;
  output Real Tsec;
  output Real rsec;
  output Real Qpri;
  output Real Qsec;
  output Real alpha2bar;
  output Real alpha3bar;
  output Real XDNB;
  output Real ffricTP;
  output Real dWfwdt;

algorithm
  // Water properties
  // Subcooled region
  rfw := rhoSCph(Pfw, hfw);
  rho1bar := rhoSCph(Psec, h1);
  drho1bardh := drhodhSCph(Psec, h1);
  drho1bardp := drhodpSCph(Psec, h1);

  // Saturation properties
  rhog := rhogp(Psec);
  rhof := rhofp(Psec);
  hg := hgp(Psec);
  hf := hfp(Psec);
  hfg := hg - hf;
  dhgdp := dhgdpp(Psec);
  dhfdp := dhfdpp(Psec);
  drhogdp := drhogdpp(Psec);
  drhofdp := drhofdpp(Psec);

  // Nucleate boiling region void fraction calculations
  // drift-flux correlation for void
  Gsec := Wfw/Asec;
  sigmaf := Water.surfaceTension(sat);
  // surface tension
  muf := Water.dynamicViscosity(state);
  // dynamic viscosity

  // single-phase friction factor for flow inside tubes
  jf := Gsec/rhof;
  jg := Gsec/rhog;

  Ref := Gsec*Dhsec/muf;

  ffricTP := WoodsFrictionFactor(
    Gsec,
    Dhsec,
    hf,
    Psec);

  jsqrd := 6.6*sigmaf*Cons.g_n*cos(theta)*sqrt(rhof - rhog)/(rhof*ffricTP*2.17^
    2);
  XDNB := min(1613 .* rhof/(rhog*hfg*sqrt(Gsec))*kXDNBff, 0.99);

  if (XDNB < 0.99) then
    dXdG := -1/2*XDNB/Gsec;
    dXdp := XDNB*(drhofdp/rhof - (dhgdp - dhfdp)/hfg - drhogdp/rhog);
  else
    dXdG := 0;
    dXdp := 0;
  end if;

  Vgj2 := fVgj2*((rhof - rhog)/rhof^2*sigmaf*Cons.g_n)^0.25*sin(theta);
  // drift velocity

  aDF2 := rhog*(C02/rhof + Vgj2/Gsec);
  bDF2 := C02*(1 - rhog/rhof);

  // Temporary variables for nucleate boiling region void fraction correlations
  aoverb2 := aDF2/bDF2;
  logADFBDF2 := log(aDF2/(aDF2 + bDF2*XDNB));

  annotation (Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Bitmap(extent={{-100,100},{100,-100}},
          fileName="modelica://aSMR/Icons/HelicalCoilSteamGenerator.png")}),
      Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5})));
end SGSecondary;
