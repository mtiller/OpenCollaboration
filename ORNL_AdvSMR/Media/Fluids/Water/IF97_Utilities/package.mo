within ORNL_AdvSMR.Media.Fluids.Water;
package IF97_Utilities "Low level and utility computation for high accuracy water properties according to the IAPWS/IF97 standard"


extends Modelica.Icons.Package;


replaceable record iter = BaseIF97.IterationData;


protected 
package ThermoFluidSpecial
  function water_ph
    "calculate the property record for dynamic simulation properties using p,h as states"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Integer phase=0
      "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
    output Common.ThermoFluidSpecial.ThermoProperties_ph pro
      "property record for dynamic simulation";
  protected
    Common.GibbsDerivs g
      "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
    Common.HelmholtzDerivs f
      "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
    Integer region(min=1, max=5) "IF97 region";
    Integer error "error flag";
    SI.Temperature T "temperature";
    SI.Density d "density";
    algorithm
    region := BaseIF97.Regions.region_ph(
          p,
          h,
          phase);
    if (region == 1) then
      T := BaseIF97.Basic.tph1(p, h);
      g := BaseIF97.Basic.g1(p, T);
      pro := Common.ThermoFluidSpecial.gibbsToProps_ph(g);
    elseif (region == 2) then
      T := BaseIF97.Basic.tph2(p, h);
      g := BaseIF97.Basic.g2(p, T);
      pro := Common.ThermoFluidSpecial.gibbsToProps_ph(g);
    elseif (region == 3) then
      (d,T,error) := BaseIF97.Inverses.dtofph3(
            p=p,
            h=h,
            delp=1.0e-7,
            delh=1.0e-6);
      f := BaseIF97.Basic.f3(d, T);
      pro := Common.ThermoFluidSpecial.helmholtzToProps_ph(f);
    elseif (region == 4) then
      pro := BaseIF97.TwoPhase.waterR4_ph(p=p, h=h);
    elseif (region == 5) then
      (T,error) := BaseIF97.Inverses.tofph5(
            p=p,
            h=h,
            reldh=1.0e-7);
      g := BaseIF97.Basic.g5(p, T);
      pro := Common.ThermoFluidSpecial.gibbsToProps_ph(g);
    end if;
    end water_ph;

  function water_dT
    "calculate property record for dynamic simulation properties using d and T as dynamic states"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "temperature";
    input Integer phase=0
      "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
    output Common.ThermoFluidSpecial.ThermoProperties_dT pro
      "property record for dynamic simulation";
  protected
    SI.Pressure p "pressure";
    Integer region(min=1, max=5) "IF97 region";
    Common.GibbsDerivs g
      "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
    Common.HelmholtzDerivs f
      "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
    Integer error "error flag";
    algorithm
    region := BaseIF97.Regions.region_dT(
          d,
          T,
          phase);
    if (region == 1) then
      (p,error) := BaseIF97.Inverses.pofdt125(
            d=d,
            T=T,
            reldd=iter.DELD,
            region=1);
      g := BaseIF97.Basic.g1(p, T);
      pro := Common.ThermoFluidSpecial.gibbsToProps_dT(g);
    elseif (region == 2) then
      (p,error) := BaseIF97.Inverses.pofdt125(
            d=d,
            T=T,
            reldd=iter.DELD,
            region=2);
      g := BaseIF97.Basic.g2(p, T);
      pro := Common.ThermoFluidSpecial.gibbsToProps_dT(g);
    elseif (region == 3) then
      f := BaseIF97.Basic.f3(d, T);
      pro := Common.ThermoFluidSpecial.helmholtzToProps_dT(f);
    elseif (region == 4) then
      pro := BaseIF97.TwoPhase.waterR4_dT(d=d, T=T);
    elseif (region == 5) then
      (p,error) := BaseIF97.Inverses.pofdt125(
            d=d,
            T=T,
            reldd=iter.DELD,
            region=5);
      g := BaseIF97.Basic.g5(p, T);
      pro := Common.ThermoFluidSpecial.gibbsToProps_dT(g);
    end if;
    end water_dT;

  function water_pT
    "calculate property record for dynamic simulation properties using p and T as dynamic states"

    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    output Common.ThermoFluidSpecial.ThermoProperties_pT pro
      "property record for dynamic simulation";
  protected
    SI.Density d "density";
    Integer region(min=1, max=5) "IF97 region";
    Common.GibbsDerivs g
      "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
    Common.HelmholtzDerivs f
      "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
    Integer error "error flag";
    algorithm
    region := BaseIF97.Regions.region_pT(p, T);
    if (region == 1) then
      g := BaseIF97.Basic.g1(p, T);
      pro := Common.ThermoFluidSpecial.gibbsToProps_pT(g);
    elseif (region == 2) then
      g := BaseIF97.Basic.g2(p, T);
      pro := Common.ThermoFluidSpecial.gibbsToProps_pT(g);
    elseif (region == 3) then
      (d,error) := BaseIF97.Inverses.dofpt3(
            p=p,
            T=T,
            delp=iter.DELP);
      f := BaseIF97.Basic.f3(d, T);
      pro := Common.ThermoFluidSpecial.helmholtzToProps_pT(f);
    elseif (region == 5) then
      g := BaseIF97.Basic.g5(p, T);
      pro := Common.ThermoFluidSpecial.gibbsToProps_pT(g);
    end if;
    end water_pT;
  end ThermoFluidSpecial;

//   function isentropicEnthalpy
//     "isentropic specific enthalpy from p,s (preferably use dynamicIsentropicEnthalpy in dynamic simulation!)"
//     extends Modelica.Icons.Function;
//     input SI.Pressure p "pressure";
//     input SI.SpecificEntropy s "specific entropy";
//     input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
//     output SI.SpecificEnthalpy h "specific enthalpy";
//   algorithm
//    h := BaseIF97.Isentropic.water_hisentropic(p,s,phase);
//   end isentropicEnthalpy;


annotation (Documentation(info="<HTML>
      <h4>Package description:</h4>
      <p>This package provides high accuracy physical properties for water according
      to the IAPWS/IF97 standard. It has been part of the ThermoFluid Modelica library and been extended,
      reorganized and documented to become part of the Modelica Standard library.</p>
      <p>An important feature that distinguishes this implementation of the IF97 steam property standard
      is that this implementation has been explicitly designed to work well in dynamic simulations. Computational
      performance has been of high importance. This means that there often exist several ways to get the same result
      from different functions if one of the functions is called often but can be optimized for that purpose.
   </p>
      <p>
      The original documentation of the IAPWS/IF97 steam properties can freely be distributed with computer
      implementations, so for curious minds the complete standard documentation is provided with the Modelica
      properties library. The following documents are included
      (in directory Modelica/Resources/Documentation/Media/Water/IF97documentation):
      <ul>
      <li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IF97.pdf</a> The standards document for the main part of the IF97.</li>
      <li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/Back3.pdf\">Back3.pdf</a> The backwards equations for region 3.</li>
      <li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/crits.pdf\">crits.pdf</a> The critical point data.</li>
      <li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/meltsub.pdf\">meltsub.pdf</a> The melting- and sublimation line formulation (in IF97_Utilities.BaseIF97.IceBoundaries)</li>
      <li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/surf.pdf\">surf.pdf</a> The surface tension standard definition</li>
      <li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/thcond.pdf\">thcond.pdf</a> The thermal conductivity standard definition</li>
      <li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/visc.pdf\">visc.pdf</a> The viscosity standard definition</li>
      </ul>
   </p>
      <h4>Package contents
      </h4>
      <p>
      <ul>
      <li>Package <b>BaseIF97</b> contains the implementation of the IAPWS-IF97 as described in
      <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IF97.pdf</a>. The explicit backwards equations for region 3 from
      <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/Back3.pdf\">Back3.pdf</a> are implemented as initial values for an inverse iteration of the exact
      function in IF97 for the input pairs (p,h) and (p,s).
      The low-level functions in BaseIF97 are not needed for standard simulation usage,
      but can be useful for experts and some special purposes.</li>
      <li>Function <b>water_ph</b> returns all properties needed for a dynamic control volume model and properties of general
      interest using pressure p and specific entropy enthalpy h as dynamic states in the record ThermoProperties_ph. </li>
      <li>Function <b>water_ps</b> returns all properties needed for a dynamic control volume model and properties of general
      interest using pressure p and specific entropy s as dynamic states in the record ThermoProperties_ps. </li>
      <li>Function <b>water_dT</b> returns all properties needed for a dynamic control volume model and properties of general
      interest using density d and temperature T as dynamic states in the record ThermoProperties_dT. </li>
      <li>Function <b>water_pT</b> returns all properties needed for a dynamic control volume model and properties of general
      interest using pressure p and temperature T as dynamic states in the record ThermoProperties_pT. Due to the coupling of
      pressure and temperature in the two-phase region, this model can obviously
      only be used for one-phase models or models treating both phases independently.</li>
      <li>Function <b>hl_p</b> computes the liquid specific enthalpy as a function of pressure. For overcritical pressures,
      the critical specific enthalpy is returned</li>
      <li>Function <b>hv_p</b> computes the vapour specific enthalpy as a function of pressure. For overcritical pressures,
      the critical specific enthalpy is returned</li>
      <li>Function <b>sl_p</b> computes the liquid specific entropy as a function of pressure. For overcritical pressures,
      the critical  specific entropy is returned</li>
      <li>Function <b>sv_p</b> computes the vapour  specific entropy as a function of pressure. For overcritical pressures,
      the critical  specific entropyis returned</li>
      <li>Function <b>rhol_T</b> computes the liquid density as a function of temperature. For overcritical temperatures,
      the critical density is returned</li>
      <li>Function <b>rhol_T</b> computes the vapour density as a function of temperature. For overcritical temperatures,
      the critical density is returned</li>
      <li>Function <b>dynamicViscosity</b> computes the dynamic viscosity as a function of density and temperature.</li>
      <li>Function <b>thermalConductivity</b> computes the thermal conductivity as a function of density, temperature and pressure.
      <b>Important note</b>: Obviously only two of the three
      inputs are really needed, but using three inputs speeds up the computation and the three variables
      are known in most models anyways. The inputs d,T and p have to be consistent.</li>
      <li>Function <b>surfaceTension</b> computes the surface tension between vapour
          and liquid water as a function of temperature.</li>
      <li>Function <b>isentropicEnthalpy</b> computes the specific enthalpy h(p,s,phase) in all regions.
          The phase input is needed due to discontinuous derivatives at the phase boundary.</li>
      <li>Function <b>dynamicIsentropicEnthalpy</b> computes the specific enthalpy h(p,s,,dguess,Tguess,phase) in all regions.
          The phase input is needed due to discontinuous derivatives at the phase boundary. Tguess and dguess are initial guess
          values for the density and temperature consistent with p and s. This function should be preferred in
          dynamic simulations where good guesses are often available.</li>
      </ul>
   </p>
      <h4>Version Info and Revision history
      </h4>
      <ul>
      <li>First implemented: <i>July, 2000</i>
      by Hubertus Tummescheit for the ThermoFluid Library with help from Jonas Eborn and Falko Jens Wagner
      </li>
      <li>Code reorganization, enhanced documentation, additional functions:   <i>December, 2002</i>
      by <a href=\"mailto:Hubertus.Tummescheit@modelon.se\">Hubertus Tummescheit</a> and moved to Modelica
      properties library.</li>
      </ul>
      <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
      </address>
      </HTML>", revisions="<h4>Intermediate release notes during development</h4>
<p>Currenly the Events/noEvents switch is only implmented for p-h states. Only after testing that implmentation, it will be extended to dT.</p>"));
end IF97_Utilities;
