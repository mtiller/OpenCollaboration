within ORNL_AdvSMR.Media.Fluids.IncompressibleLiquids.TableBased;
function h_T_der "Compute specific enthalpy from temperature"
  import Modelica.SIunits.Conversions.to_degC;
  extends Modelica.Icons.Function;
  input SI.Temperature T "Temperature";
  input Real dT "temperature derivative";
  output Real dh "derivative of Specific enthalpy at T";
algorithm
  dh := Poly.evaluate(poly_Cp, if TinK then T else Cv.to_degC(T))*dT;
  annotation (smoothOrder=1);
end h_T_der;
