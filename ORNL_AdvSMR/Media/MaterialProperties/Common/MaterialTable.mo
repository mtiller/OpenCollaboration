within ORNL_AdvSMR.Media.MaterialProperties.Common;
model MaterialTable
  "Material property model based on table data and polynomial interpolations"
  import Modelica.SIunits.*;

  import Poly = ORNL_AdvSMR.Media.MaterialProperties.Functions.Polynomials_Temp;
  // Attenzione e' una funzione temporanea di Media!!!

  extends Interfaces.PartialMaterial(materialName="tableMaterial",
      materialDescription="tableMaterial");

  // Tables defining temperature dependent properties of material
protected
  constant ModulusOfElasticity[:, :] tableYoungModulus=fill(
      0,
      0,
      0) "Table for youngModulus(T)";
  constant Stress[:, :] tableYieldStress=fill(
      0,
      0,
      0) "Table for yieldStress(T)";
  constant Stress[:, :] tableUltimateStress=fill(
      0,
      0,
      0) "Table for ultimateStress(T)";
  constant SpecificHeatCapacity[:, :] tableSpecificHeatCapacity=fill(
      0,
      0,
      0) "Table for cp(T)";
  constant LinearExpansionCoefficient[:, :] tableLinearExpansionCoefficient=
      fill(
      0,
      0,
      0) "Table for alfa(T)";
  constant ThermalConductivity[:, :] tableThermalConductivity=fill(
      0,
      0,
      0) "Table for kappa(T)";
  // Functions to interpolate table data
public
  constant Integer npol=2 "degree of polynomial used for fitting";
protected
  final constant ModulusOfElasticity poly_youngModulus[:]=if size(
      tableYoungModulus, 1) > 1 then Poly.fitting(
      tableYoungModulus[:, 1],
      tableYoungModulus[:, 2],
      npol) else if size(tableYoungModulus, 1) == 1 then array(
      0,
      0,
      tableYoungModulus[1, 2]) else zeros(npol + 1)
    annotation (keepConstant=true);
  final constant Real poly_yieldStress[:]=if size(tableYieldStress, 1) > 1
       then Poly.fitting(
      tableYieldStress[:, 1],
      tableYieldStress[:, 2],
      npol) else if size(tableYieldStress, 1) == 1 then array(
      0,
      0,
      tableYieldStress[1, 2]) else zeros(npol + 1)
    annotation (keepConstant=true);
  final constant Real poly_ultimateStress[:]=if size(tableUltimateStress, 1) >
      1 then Poly.fitting(
      tableUltimateStress[:, 1],
      tableUltimateStress[:, 2],
      npol) else if size(tableUltimateStress, 1) == 1 then array(
      0,
      0,
      tableUltimateStress[1, 2]) else zeros(npol + 1)
    annotation (keepConstant=true);
  final constant Real poly_cp[:]=if size(tableSpecificHeatCapacity, 1) > 1
       then Poly.fitting(
      tableSpecificHeatCapacity[:, 1],
      tableSpecificHeatCapacity[:, 2],
      npol) else if size(tableSpecificHeatCapacity, 1) == 1 then array(
      0,
      0,
      tableSpecificHeatCapacity[1, 2]) else zeros(npol + 1)
    annotation (keepConstant=true);
  final constant Real poly_alfa[:]=if size(tableLinearExpansionCoefficient, 1)
       > 1 then Poly.fitting(
      tableLinearExpansionCoefficient[:, 1],
      tableLinearExpansionCoefficient[:, 2],
      npol) else if size(tableLinearExpansionCoefficient, 1) == 1 then array(
      0,
      0,
      tableLinearExpansionCoefficient[1, 2]) else zeros(npol + 1)
    annotation (keepConstant=true);
  final constant Real poly_kappa[:]=if size(tableThermalConductivity, 1) > 1
       then Poly.fitting(
      tableThermalConductivity[:, 1],
      tableThermalConductivity[:, 2],
      npol) else if size(tableThermalConductivity, 1) == 1 then array(
      0,
      0,
      tableThermalConductivity[1, 2]) else zeros(npol + 1)
    annotation (keepConstant=true);

equation
  // Table for main properties of the material should be defined!
  assert(size(tableYoungModulus, 1) > 0, "Material " + materialName +
    " can not be used without assigning tableYoungModulus.");
  assert(size(tableSpecificHeatCapacity, 1) > 0, "Material " + materialName +
    " can not be used without assigning tableYoungModulus.");
  assert(size(tableLinearExpansionCoefficient, 1) > 0, "Material " +
    materialName + " can not be used without assigning tableYoungModulus.");
  assert(size(tableThermalConductivity, 1) > 0, "Material " + materialName +
    " can not be used without assigning tableYoungModulus.");

  youngModulus = Poly.evaluate(poly_youngModulus, T);
  yieldStress = Poly.evaluate(poly_yieldStress, T);
  ultimateStress = Poly.evaluate(poly_ultimateStress, T);
  specificHeatCapacity = Poly.evaluate(poly_cp, T);
  linearExpansionCoefficient = Poly.evaluate(poly_alfa, T);
  thermalConductivity = Poly.evaluate(poly_kappa, T);
  annotation (Documentation(info="<html>
This model computes the thermal and mechanical properties of a generic material. The data is provided in the form of tables, and interpolated by polinomials. 
<p>To use the model, set the material temperature to the desired value by a suitable equation.
</html>"));
end MaterialTable;
