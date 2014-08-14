within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Isentropic;
function water_hisentropic_dyn
  "isentropic specific enthalpy from p,s and good guesses of d and T"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  input SI.Density dguess "good guess density, e.g., from adjacent volume";
  input SI.Temperature Tguess
    "good guess temperature, e.g., from adjacent volume";
  input Integer phase "1 for one phase, 2 for two phase";
  output SI.SpecificEnthalpy h "specific enthalpy";
protected
  Common.GibbsDerivs g
    "derivatives of dimensionless Gibbs-function w.r.t. dimensionless pi and tau";
  Common.HelmholtzDerivs f
    "derivatives of dimensionless Helmholtz-function w.r.t. dimensionless delta and tau";
  Integer region(min=1, max=5) "IF97 region";
  Integer error "error if not 0";
  SI.Temperature T "temperature";
  SI.Density d "density";
algorithm
  region := Regions.region_ps(
                    p=p,
                    s=s,
                    phase=phase);
  if (region == 1) then
    h := hofps1(p, s);
  elseif (region == 2) then
    h := hofps2(p, s);
  elseif (region == 3) then
    h := hofpsdt3(    p=p,
                      s=s,
                      dguess=dguess,
                      Tguess=Tguess,
                      delp=IterationData.DELP,
                      dels=IterationData.DELS);
  elseif (region == 4) then
    h := hofps4(p, s);
  elseif (region == 5) then
    (T,error) := Inverses.tofpst5(
                      p=p,
                      s=s,
                      Tguess=Tguess,
                      relds=IterationData.DELS);
    h := hofpT5(p, T);
  end if;
end water_hisentropic_dyn;
