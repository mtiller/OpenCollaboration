within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Isentropic;
function hofps3 "isentropic specific enthalpy in region 3 h(p,s)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  output SI.SpecificEnthalpy h "specific enthalpy";
protected
  SI.Density d "density";
  SI.Temperature T "temperature (K)";
  SI.Pressure delp=IterationData.DELP "iteration accuracy";
  SI.SpecificEntropy dels=IterationData.DELS "iteration accuracy";
  Integer error "error if not 0";
algorithm
  (d,T,error) := Inverses.dtofps3(
                    p=p,
                    s=s,
                    delp=delp,
                    dels=dels);
  h := hofdT3(d, T);
end hofps3;
