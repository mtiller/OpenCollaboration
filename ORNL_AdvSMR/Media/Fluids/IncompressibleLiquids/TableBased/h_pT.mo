within ORNL_AdvSMR.Media.Fluids.IncompressibleLiquids.TableBased;
function h_pT "Compute specific enthalpy from pressure and temperature"
  import Modelica.SIunits.Conversions.to_degC;
  extends Modelica.Icons.Function;
  input SI.Pressure p "Pressure";
  input SI.Temperature T "Temperature";
  input Boolean densityOfT=false
    "include or neglect density derivative dependence of enthalpy"
    annotation (Evaluate);
  output SI.SpecificEnthalpy h "Specific enthalpy at p, T";
algorithm
  h := h0 + Poly.integralValue(
    poly_Cp,
    if TinK then T else Cv.to_degC(T),
    if TinK then T0 else Cv.to_degC(T0)) + (p - reference_p)/Poly.evaluate(
    poly_rho, if TinK then T else Cv.to_degC(T))*(if densityOfT then (1 + T/
    Poly.evaluate(poly_rho, if TinK then T else Cv.to_degC(T))*
    Poly.derivativeValue(poly_rho, if TinK then T else Cv.to_degC(T))) else 1.0);
  annotation (smoothOrder=2);
end h_pT;
