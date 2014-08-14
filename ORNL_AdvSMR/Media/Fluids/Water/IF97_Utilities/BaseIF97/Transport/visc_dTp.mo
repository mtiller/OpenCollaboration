within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Transport;
function visc_dTp "dynamic viscosity eta(d,T,p), industrial formulation"
  extends Modelica.Icons.Function;
  input SI.Density d "density";
  input SI.Temperature T "temperature (K)";
  input SI.Pressure p "pressure (only needed for region of validity)";
  input Integer phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output SI.DynamicViscosity eta "dynamic viscosity";
protected
  constant Real n0=1.0 "viscosity coefficient";
  constant Real n1=0.978197 "viscosity coefficient";
  constant Real n2=0.579829 "viscosity coefficient";
  constant Real n3=-0.202354 "viscosity coefficient";
  constant Real[42] nn=array(
      0.5132047,
      0.3205656,
      0.0,
      0.0,
      -0.7782567,
      0.1885447,
      0.2151778,
      0.7317883,
      1.241044,
      1.476783,
      0.0,
      0.0,
      -0.2818107,
      -1.070786,
      -1.263184,
      0.0,
      0.0,
      0.0,
      0.1778064,
      0.460504,
      0.2340379,
      -0.4924179,
      0.0,
      0.0,
      -0.0417661,
      0.0,
      0.0,
      0.1600435,
      0.0,
      0.0,
      0.0,
      -0.01578386,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      -0.003629481,
      0.0,
      0.0) "viscosity coefficients";
  constant SI.Density rhostar=317.763 "scaling density";
  constant SI.DynamicViscosity etastar=55.071e-6 "scaling viscosity";
  constant SI.Temperature tstar=647.226 "scaling temperature";
  Integer i "auxiliary variable";
  Integer j "auxiliary variable";
  Real delta "dimensionless density";
  Real deltam1 "dimensionless density";
  Real tau "dimensionless temperature";
  Real taum1 "dimensionless temperature";
  Real Psi0 "auxiliary variable";
  Real Psi1 "auxiliary variable";
  Real tfun "auxiliary variable";
  Real rhofun "auxiliary variable";
  Real Tc=T - 273.15 "Celsius temperature for region check";
  //      Integer region "region of IF97";
algorithm
  //      if phase == 0 then
  //        region := BaseIF97.Regions.region_dT(d,T,0);
  //      end if;
  //      if phase == 2 then
  //        region := 4;
  //      end if;
  // assert(phase <> 2, "viscosity can not be computed for two-phase states");
  delta := d/rhostar;
  assert(d > triple.dvtriple,
    "IF97 medium function visc_dTp for viscosity called with too low density\n"
     + "d = " + String(d) + " <= " + String(triple.dvtriple) +
    " (triple point density)");
  assert((p <= 500e6 and (Tc >= 0.0 and Tc <= 150)) or (p <= 350e6 and (Tc >
    150.0 and Tc <= 600)) or (p <= 300e6 and (Tc > 600.0 and Tc <= 900)),
    "IF97 medium function visc_dTp: viscosity computed outside the range\n" +
    "of validity of the IF97 formulation: p = " + String(p) + " Pa, Tc = " +
    String(Tc) + " K");
  deltam1 := delta - 1.0;
  tau := tstar/T;
  taum1 := tau - 1.0;
  Psi0 := 1/(n0 + (n1 + (n2 + n3*tau)*tau)*tau)/(tau^0.5);
  Psi1 := 0.0;
  tfun := 1.0;
  for i in 1:6 loop
    if (i <> 1) then
      tfun := tfun*taum1;
    end if;
    rhofun := 1.;
    for j in 0:6 loop
      if (j <> 0) then
        rhofun := rhofun*deltam1;
      end if;
      Psi1 := Psi1 + nn[i + j*6]*tfun*rhofun;
    end for;
  end for;
  eta := etastar*Psi0*Modelica.Math.exp(delta*Psi1);
end visc_dTp;
