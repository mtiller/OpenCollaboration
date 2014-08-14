within ORNL_AdvSMR.Media.Interfaces.Types;
record HelmholtzDerivatives
  "derivatives of Helmholtz-function w.r.t density and temperature"
  extends Modelica.Icons.Record;
  Modelon.Media.Interfaces.State.Units.Density d "density";
  Modelon.Media.Interfaces.State.Units.Temperature T "temperature";
  Modelon.Media.Interfaces.State.Units.SpecificHeatCapacity R
    "specific heat capacity";
  Real a(unit="1") "Helmholtz-energy / R*T";
  Real ad(unit="m3/kg") "derivative of a w.r.t. density";
  Real add(unit="m6/(kg2)") "2nd derivative of a w.r.t. density";
  Real at(unit="1/K") "derivative of a w.r.t. temperature";
  Real att(unit="1/K2") "2nd derivative of a w.r.t. temperature";
  Real adt(unit="m3/(kg.K)") "derivative of a w.r.t. density and temperature";
end HelmholtzDerivatives;
