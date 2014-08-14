within ORNL_AdvSMR.Media.Fluids.IncompressibleLiquids.TableBased;
function density_T "Return density as function of temperature"

  input Temperature T "temperature";
  output Density d "density";
algorithm
  d := Poly.evaluate(poly_rho, if TinK then T else Cv.to_degC(T));
  annotation (smoothOrder=2);
end density_T;
