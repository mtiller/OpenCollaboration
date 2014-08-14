within ORNL_AdvSMR.Media.Fluids.IncompressibleLiquids.TableBased;
function s_T "compute specific entropy"
  input Temperature T "temperature";
  output SpecificEntropy s "specific entropy";
algorithm
  s := s0 + (if TinK then Poly.integralValue(
    poly_Cp[1:npol],
    T,
    T0) else Poly.integralValue(
    poly_Cp[1:npol],
    Cv.to_degC(T),
    Cv.to_degC(T0))) + Modelica.Math.log(T/T0)*Poly.evaluate(poly_Cp, if TinK
     then 0 else Modelica.Constants.T_zero);
  annotation (smoothOrder=2);
end s_T;
