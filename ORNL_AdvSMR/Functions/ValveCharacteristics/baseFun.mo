within ORNL_AdvSMR.Functions.ValveCharacteristics;
partial function baseFun "Base class for valve characteristics"
  extends Modelica.Icons.Function;
  input Real pos "Stem position (per unit)";
  output Real rc "Relative coefficient (per unit)";
end baseFun;
