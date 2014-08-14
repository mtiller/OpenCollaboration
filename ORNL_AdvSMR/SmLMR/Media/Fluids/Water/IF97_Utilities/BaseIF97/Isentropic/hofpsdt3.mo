within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Isentropic;
function hofpsdt3
  "isentropic specific enthalpy in region 3 h(p,s) with given good guess in d and T"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  input SI.Density dguess "good guess density, e.g., from adjacent volume";
  input SI.Temperature Tguess
    "good guess temperature, e.g., from adjacent volume";
  input SI.Pressure delp=IterationData.DELP "relative error in p";
  input SI.SpecificEntropy dels=IterationData.DELS "relative error in s";
  output SI.SpecificEnthalpy h "specific enthalpy";
protected
  SI.Density d "density";
  SI.Temperature T "temperature (K)";
  Integer error "error flag";
algorithm
  (d,T,error) := Inverses.dtofpsdt3(
                    p=p,
                    s=s,
                    dguess=dguess,
                    Tguess=Tguess,
                    delp=delp,
                    dels=dels);
  h := hofdT3(d, T);
end hofpsdt3;
