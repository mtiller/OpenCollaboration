within ORNL_AdvSMR.Media;
package Solids "Thermophysical properties of common alloys"

  extends Modelica.Icons.MaterialPropertiesPackage;

  package Common "Implementation of material property models"
    model MaterialTable
      "Material property model based on table data and polynomial interpolations"
      import Modelica.SIunits.*;

      import Poly =
        ThermoPower3.Thermal.MaterialProperties.Functions.Polynomials_Temp;
      // Attenzione e' una funzione temporanea di Media!!!

      extends
        ThermoPower3.Thermal.MaterialProperties.Interfaces.PartialMaterial(
          materialName="tableMaterial", materialDescription="tableMaterial");

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
      constant LinearExpansionCoefficient[:, :] tableLinearExpansionCoefficient
        =fill(0,
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
      final constant Real poly_ultimateStress[:]=if size(tableUltimateStress, 1)
           > 1 then Poly.fitting(
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
      final constant Real poly_alfa[:]=if size(tableLinearExpansionCoefficient,
          1) > 1 then Poly.fitting(
              tableLinearExpansionCoefficient[:, 1],
              tableLinearExpansionCoefficient[:, 2],
              npol) else if size(tableLinearExpansionCoefficient, 1) == 1 then
          array(
              0,
              0,
              tableLinearExpansionCoefficient[1, 2]) else zeros(npol + 1)
        annotation (keepConstant=true);
      final constant Real poly_kappa[:]=if size(tableThermalConductivity, 1) >
          1 then Poly.fitting(
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
      assert(size(tableSpecificHeatCapacity, 1) > 0, "Material " + materialName
         + " can not be used without assigning tableYoungModulus.");
      assert(size(tableLinearExpansionCoefficient, 1) > 0, "Material " +
        materialName + " can not be used without assigning tableYoungModulus.");
      assert(size(tableThermalConductivity, 1) > 0, "Material " + materialName
         + " can not be used without assigning tableYoungModulus.");

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
  end Common;

  package Functions
    "Utility functions. Provide conversions and interpolation for table data."

    function CtoKTable
      extends Modelica.SIunits.Conversions.ConversionIcon;

      input Real[:, :] table_degC;
      output Real table_degK[size(table_degC, 1), size(table_degC, 2)];
    algorithm
      table_degK := table_degC;

      for i in 1:size(table_degC, 1) loop
        table_degK[i, 1] := Modelica.SIunits.Conversions.from_degC(table_degC[i,
          1]);
      end for;
    end CtoKTable;

    package Polynomials_Temp "Temporary Functions operating on polynomials (including polynomial fitting), extracted from Modelica.Media.Incompressible.TableBased;
   only to be used in Material.MaterialTable"
      extends Modelica.Icons.Library;

      function evaluate "Evaluate polynomial at a given abszissa value"
        extends Modelica.Icons.Function;
        input Real p[:]
          "Polynomial coefficients (p[1] is coefficient of highest power)";
        input Real u "Abszissa value";
        output Real y "Value of polynomial at u";
      algorithm
        y := p[1];
        for j in 2:size(p, 1) loop
          y := p[j] + u*y;
        end for;
      end evaluate;

      function fitting
        "Computes the coefficients of a polynomial that fits a set of data points in a least-squares sense"
        extends Modelica.Icons.Function;
        input Real u[:] "Abscissa data values";
        input Real y[size(u, 1)] "Ordinate data values";
        input Integer n(min=1)
          "Order of desired polynomial that fits the data points (u,y)";
        output Real p[n + 1]
          "Polynomial coefficients of polynomial that fits the date points";
      protected
        Real V[size(u, 1), n + 1] "Vandermonde matrix";
      algorithm
        // Construct Vandermonde matrix
        V[:, n + 1] := ones(size(u, 1));
        for j in n:-1:1 loop
          V[:, j] := {u[i]*V[i, j + 1] for i in 1:size(u, 1)};
        end for;

        // Solve least squares problem
        p := Modelica.Math.Matrices.leastSquares(V, y);
      end fitting;
    end Polynomials_Temp;
    annotation (Documentation(info=""));
  end Functions;

  package Graphite_0
    "GRAPHITE: Thermodynamic properties for unirradiated nuclear graphite"
    extends ORNL_AdvSMR.Media.Interfaces.PartialAlloy(materialName="Graphite",
        materialDescription="Nuclear-grade graphite");

    redeclare function extends density "Density as a function of temperature"
    algorithm
      rho := 1776.66 "Constant density (kg/m3)";
    end density;

    redeclare function extends thermalConductivity
      "Thermal conductivity as a function of temperature"
    algorithm
      // k := 237.9808 - 0.3368*T + 2.3356e-4*T^2 - 5.7930e-8*T^3;
      k := 169.245 - 1.24890e-1*T + 3.28248e-5*T^2;
    end thermalConductivity;

    redeclare function extends specificHeatCapacity
      "Specific heat capacity as a function of temperature"
    algorithm
      cp := -143.9883 + 3.6677*T - 0.0022*T^2 + 4.6251e-7*T^3;
    end specificHeatCapacity;

    redeclare function extends linearExpansionCoefficient
      "Linear expansion coefficient as a function of temperature"
    algorithm
      alpha := 0;
    end linearExpansionCoefficient;

  end Graphite_0;

  package Graphite_1
    "GRAPHITE: Thermodynamic properties for nuclear graphite at 0.2e25-n/m2 fluence"

    extends ORNL_AdvSMR.Media.Interfaces.PartialAlloy(materialName="Graphite",
        materialDescription="Nuclear-grade graphite");

    redeclare function extends density "Density as a function of temperature"
    algorithm
      rho := 1776.66 "Constant density (kg/m3)";
    end density;

    redeclare function extends thermalConductivity
      "Thermal conductivity as a function of temperature"
    algorithm
      k := 90.1445 - 3.64930e-2*T - 3.42932e-6*T^2 + 4.56817e-9*T^3;
    end thermalConductivity;

    redeclare function extends specificHeatCapacity
      "Specific heat capacity as a function of temperature"
    algorithm
      cp := -143.9883 + 3.6677*T - 0.0022*T^2 + 4.6251e-7*T^3;
    end specificHeatCapacity;

    redeclare function extends linearExpansionCoefficient
      "Linear expansion coefficient as a function of temperature"
    algorithm
      alpha := 0;
    end linearExpansionCoefficient;

  end Graphite_1;

  package Graphite_2
    "GRAPHITE: Thermodynamic properties for nuclear graphite at 0.5e25-n/m2 fluence"

    extends ORNL_AdvSMR.Media.Interfaces.PartialAlloy(materialName="Graphite",
        materialDescription="Nuclear-grade graphite");

    redeclare function extends density "Density as a function of temperature"
    algorithm
      rho := 1776.66 "Constant density (kg/m3)";
    end density;

    redeclare function extends thermalConductivity
      "Thermal conductivity as a function of temperature"
    algorithm
      k := 46.6649 - 6.75616e-3*T - 7.83929e-6*T^2 + 3.33540e-9*T^3;
    end thermalConductivity;

    redeclare function extends specificHeatCapacity
      "Specific heat capacity as a function of temperature"
    algorithm
      cp := -143.9883 + 3.6677*T - 0.0022*T^2 + 4.6251e-7*T^3;
    end specificHeatCapacity;

    redeclare function extends linearExpansionCoefficient
      "Linear expansion coefficient as a function of temperature"
    algorithm
      alpha := 0;
    end linearExpansionCoefficient;

  end Graphite_2;

  package Graphite_3
    "GRAPHITE: Thermodynamic properties for nuclear graphite at 1e25-n/m2 fluence"

    extends ORNL_AdvSMR.Media.Interfaces.PartialAlloy(materialName="Graphite",
        materialDescription="Nuclear-grade graphite");

    redeclare function extends density "Density as a function of temperature"
    algorithm
      rho := 1776.66 "Constant density (kg/m3)";
    end density;

    redeclare function extends thermalConductivity
      "Thermal conductivity as a function of temperature"
    algorithm
      k := 30.5337 - 1.55010e-3*T - 5.51300e-6*T^2 + 2.03348e-9*T^3;
    end thermalConductivity;

    redeclare function extends specificHeatCapacity
      "Specific heat capacity as a function of temperature"
    algorithm
      cp := -143.9883 + 3.6677*T - 0.0022*T^2 + 4.6251e-7*T^3;
    end specificHeatCapacity;

    redeclare function extends linearExpansionCoefficient
      "Linear expansion coefficient as a function of temperature"
    algorithm
      alpha := 0;
    end linearExpansionCoefficient;

  end Graphite_3;

  package Graphite_4
    "GRAPHITE: Thermodynamic properties for nuclear graphite at 3-8e25-n/m2 fluence"

    extends ORNL_AdvSMR.Media.Interfaces.PartialAlloy(materialName="Graphite",
        materialDescription="Nuclear-grade graphite");

    redeclare function extends density "Density as a function of temperature"
    algorithm
      rho := 1776.66 "Constant density (kg/m3)";
    end density;

    redeclare function extends thermalConductivity
      "Thermal conductivity as a function of temperature"
    algorithm
      k := 29.8193 - 7.56914e-3*T + 1.20901e-6*T^2;
    end thermalConductivity;

    redeclare function extends specificHeatCapacity
      "Specific heat capacity as a function of temperature"
    algorithm
      cp := -143.9883 + 3.6677*T - 0.0022*T^2 + 4.6251e-7*T^3;
    end specificHeatCapacity;

    redeclare function extends linearExpansionCoefficient
      "Linear expansion coefficient as a function of temperature"
    algorithm
      alpha := 0;
    end linearExpansionCoefficient;

  end Graphite_4;

  model U_Pu_Zr "U-Pu-Zr thermophysical properties"
    extends Common.MaterialTable(
      final materialName="Hastelloy N",
      final materialDescription="Nickel-base alloy (71Ni-7Cr-16Mo-5Fe-1Si)",
      final density=8860,
      final poissonRatio=0.3,
      tableYoungModulus=Functions.CtoKTable([21, 2.061e11; 93, 2.034e11; 149,
          1.999e11; 204, 1.972e11; 260, 1.930e11; 316, 1.889e11; 371, 1.834e11;
          427, 1.772e11; 482, 1.689e11; 538, 1.586e11]),
      tableUltimateStress=Functions.CtoKTable([21, 4.1412e8]),
      tableYieldStress=Functions.CtoKTable([21, 2.07e8; 93, 1.92e8; 149, 1.87e8;
          204, 1.86e8; 260, 1.86e8; 316, 1.86e8; 371, 1.86e8; 427, 1.84e8; 482,
          1.77e8; 538, 1.63e8]),
      tableLinearExpansionCoefficient=Functions.CtoKTable([204, 11.6e-6; 316,
          12.3e-6; 427, 12.7e-6; 538, 13.4e-6; 649, 14.0e-6; 760, 14.7e-6; 871,
          15.3e-6; 982, 15.8e-6]),
      tableSpecificHeatCapacity=Functions.CtoKTable([100, 419; 200, 440; 300,
          456; 400, 469; 480, 477; 540, 485; 570, 523; 590, 565; 620, 586; 660,
          582; 680, 578; 700, 578]),
      tableThermalConductivity=Functions.CtoKTable([100, 11.5; 200, 13.1; 300,
          14.4; 400, 16.5; 500, 18.0; 600, 20.3; 700, 23.6]));

  end U_Pu_Zr;

  model HT9 "HT9 high-temperature steel"
    extends Common.MaterialTable(
      final materialName="Hastelloy N",
      final materialDescription="Nickel-base alloy (71Ni-7Cr-16Mo-5Fe-1Si)",
      final density=8860,
      final poissonRatio=0.3,
      tableYoungModulus=Functions.CtoKTable([21, 2.061e11; 93, 2.034e11; 149,
          1.999e11; 204, 1.972e11; 260, 1.930e11; 316, 1.889e11; 371, 1.834e11;
          427, 1.772e11; 482, 1.689e11; 538, 1.586e11]),
      tableUltimateStress=Functions.CtoKTable([21, 4.1412e8]),
      tableYieldStress=Functions.CtoKTable([21, 2.07e8; 93, 1.92e8; 149, 1.87e8;
          204, 1.86e8; 260, 1.86e8; 316, 1.86e8; 371, 1.86e8; 427, 1.84e8; 482,
          1.77e8; 538, 1.63e8]),
      tableLinearExpansionCoefficient=Functions.CtoKTable([204, 11.6e-6; 316,
          12.3e-6; 427, 12.7e-6; 538, 13.4e-6; 649, 14.0e-6; 760, 14.7e-6; 871,
          15.3e-6; 982, 15.8e-6]),
      tableSpecificHeatCapacity=Functions.CtoKTable([100, 419; 200, 440; 300,
          456; 400, 469; 480, 477; 540, 485; 570, 523; 590, 565; 620, 586; 660,
          582; 680, 578; 700, 578]),
      tableThermalConductivity=Functions.CtoKTable([100, 11.5; 200, 13.1; 300,
          14.4; 400, 16.5; 500, 18.0; 600, 20.3; 700, 23.6]));

  end HT9;

  model HastelloyN "Material properties for Hastelloy N (R)"
    extends Common.MaterialTable(
      final materialName="Hastelloy N",
      final materialDescription="Nickel-base alloy (71Ni-7Cr-16Mo-5Fe-1Si)",
      final density=8860,
      final poissonRatio=0.3,
      tableYoungModulus=Functions.CtoKTable([21, 2.061e11; 93, 2.034e11; 149,
          1.999e11; 204, 1.972e11; 260, 1.930e11; 316, 1.889e11; 371, 1.834e11;
          427, 1.772e11; 482, 1.689e11; 538, 1.586e11]),
      tableUltimateStress=Functions.CtoKTable([21, 4.1412e8]),
      tableYieldStress=Functions.CtoKTable([21, 2.07e8; 93, 1.92e8; 149, 1.87e8;
          204, 1.86e8; 260, 1.86e8; 316, 1.86e8; 371, 1.86e8; 427, 1.84e8; 482,
          1.77e8; 538, 1.63e8]),
      tableLinearExpansionCoefficient=Functions.CtoKTable([204, 11.6e-6; 316,
          12.3e-6; 427, 12.7e-6; 538, 13.4e-6; 649, 14.0e-6; 760, 14.7e-6; 871,
          15.3e-6; 982, 15.8e-6]),
      tableSpecificHeatCapacity=Functions.CtoKTable([100, 419; 200, 440; 300,
          456; 400, 469; 480, 477; 540, 485; 570, 523; 590, 565; 620, 586; 660,
          582; 680, 578; 700, 578]),
      tableThermalConductivity=Functions.CtoKTable([100, 11.5; 200, 13.1; 300,
          14.4; 400, 16.5; 500, 18.0; 600, 20.3; 700, 23.6]));

  end HastelloyN;

  model StandardSteel
    extends Common.MaterialTable(
      final materialName="Standard Steel",
      final materialDescription="Standard Steel",
      final density=7763,
      final poissonRatio=0.3,
      tableYoungModulus=Functions.CtoKTable([21, 1.923e11]),
      tableUltimateStress=Functions.CtoKTable([21, 4.83e8]),
      tableYieldStress=Functions.CtoKTable([21, 2.76e8]),
      tableLinearExpansionCoefficient=Functions.CtoKTable([21, 10.93e-6]),
      tableSpecificHeatCapacity=Functions.CtoKTable([21, 478.2]),
      tableThermalConductivity=Functions.CtoKTable([21, 62.30]));

  end StandardSteel;

  model CarbonSteel_A106C
    extends Common.MaterialTable(
      final materialName="ASME A106-C",
      final materialDescription="Carbon steel (%C <= 0.30)",
      final density=7763,
      final poissonRatio=0.3,
      tableYoungModulus=Functions.CtoKTable([21, 1.923e11; 93, 1.910e11; 149,
          1.889e11; 204, 1.861e11; 260, 1.820e11; 316, 1.772e11; 371, 1.710e11;
          427, 1.613e11; 482, 1.491e11; 538, 1.373e11]),
      tableUltimateStress=Functions.CtoKTable([21, 4.83e8]),
      tableYieldStress=Functions.CtoKTable([21, 2.76e8; 93, 2.50e8; 149, 2.45e8;
          204, 2.37e8; 260, 2.23e8; 316, 2.05e8; 371, 1.98e8; 427, 1.84e8; 482,
          1.75e8; 538, 1.57e8]),
      tableLinearExpansionCoefficient=Functions.CtoKTable([21, 10.93e-6; 93,
          11.48e-6; 149, 11.88e-6; 204, 12.28e-6; 260, 12.64e-6; 316, 13.01e-6;
          371, 13.39e-6; 427, 13.77e-6; 482, 14.11e-6; 538, 14.35e-6]),
      tableSpecificHeatCapacity=Functions.CtoKTable([21, 478.2; 93, 494.1; 149,
          510.4; 204, 526.3; 260, 541.0; 316, 556.9; 371, 581.2; 427, 608.8;
          482, 665.3; 538, 684.6]),
      tableThermalConductivity=Functions.CtoKTable([21, 62.30; 93, 60.31; 149,
          57.45; 204, 54.68; 260, 51.57; 316, 48.97; 371, 46.38; 427, 43.96;
          482, 41.18; 538, 39.11]));

  end CarbonSteel_A106C;

  model CarbonSteel_A106B
    extends Common.MaterialTable(
      final materialName="ASME A106-B",
      final materialDescription="Carbon steel (%C <= 0.30)",
      final density=7763,
      final poissonRatio=0.3,
      tableYoungModulus=Functions.CtoKTable([21, 1.923e11; 93, 1.910e11; 149,
          1.889e11; 204, 1.861e11; 260, 1.820e11; 316, 1.772e11; 371, 1.710e11;
          427, 1.613e11; 482, 1.491e11; 538, 1.373e11]),
      tableUltimateStress=Functions.CtoKTable([21, 4.1412e8]),
      tableYieldStress=Functions.CtoKTable([40, 2.41e8; 100, 2.18e8; 150,
          2.14e8; 200, 2.08e8; 250, 1.98e8; 300, 1.83e8; 350, 1.75e8; 400,
          1.68e8; 450, 1.56e8; 475, 1.54e8]),
      tableLinearExpansionCoefficient=Functions.CtoKTable([21, 10.93e-6; 93,
          11.48e-6; 149, 11.88e-6; 204, 12.28e-6; 260, 12.64e-6; 316, 13.01e-6;
          371, 13.39e-6; 427, 13.77e-6; 482, 14.11e-6; 538, 14.35e-6]),
      tableSpecificHeatCapacity=Functions.CtoKTable([21, 478.2; 93, 494.1; 149,
          510.4; 204, 526.3; 260, 541.0; 316, 556.9; 371, 581.2; 427, 608.8;
          482, 665.3; 538, 684.6]),
      tableThermalConductivity=Functions.CtoKTable([21, 62.30; 93, 60.31; 149,
          57.45; 204, 54.68; 260, 51.57; 316, 48.97; 371, 46.38; 427, 43.96;
          482, 41.18; 538, 39.11]));

  end CarbonSteel_A106B;

  model AlloySteel_A335P22
    extends Common.MaterialTable(
      final materialName="ASME A335-P22",
      final materialDescription="Alloy steel (2 1/4 Cr - 1 Mo)",
      final density=7763,
      final poissonRatio=0.3,
      tableYoungModulus=Functions.CtoKTable([21, 2.061e11; 93, 2.034e11; 149,
          1.999e11; 204, 1.972e11; 260, 1.930e11; 316, 1.889e11; 371, 1.834e11;
          427, 1.772e11; 482, 1.689e11; 538, 1.586e11]),
      tableUltimateStress=Functions.CtoKTable([21, 4.1412e8]),
      tableYieldStress=Functions.CtoKTable([21, 2.07e8; 93, 1.92e8; 149, 1.87e8;
          204, 1.86e8; 260, 1.86e8; 316, 1.86e8; 371, 1.86e8; 427, 1.84e8; 482,
          1.77e8; 538, 1.63e8]),
      tableLinearExpansionCoefficient=Functions.CtoKTable([21, 10.93e-6; 93,
          11.48e-6; 149, 11.88e-6; 204, 12.28e-6; 260, 12.64e-6; 316, 13.01e-6;
          371, 13.39e-6; 427, 13.77e-6; 482, 14.11e-6; 538, 14.35e-6]),
      tableSpecificHeatCapacity=Functions.CtoKTable([21, 478.2; 93, 494.1; 149,
          510.4; 204, 526.3; 260, 541.0; 316, 556.9; 371, 581.2; 427, 608.8;
          482, 665.3; 538, 684.6]),
      tableThermalConductivity=Functions.CtoKTable([21, 62.30; 93, 60.31; 149,
          57.45; 204, 54.68; 260, 51.57; 316, 48.97; 371, 46.38; 427, 43.96;
          482, 41.18; 538, 39.11]));

  end AlloySteel_A335P22;

  model AlloySteel_A335P12
    extends Common.MaterialTable(
      final materialName="ASME A335-P12",
      final materialDescription="Alloy steel (1 Cr - 1/2 Mo)",
      final density=7763,
      final poissonRatio=0.3,
      tableYoungModulus=Functions.CtoKTable([25, 2.050e11; 100, 2.000e11; 150,
          1.960e11; 200, 1.930e11; 250, 1.900e11; 300, 1.870e11; 350, 1.830e11;
          400, 1.790e11; 450, 1.740e11; 475, 1.720e11; 500, 1.697e11; 550,
          1.648e11]),
      tableUltimateStress=Functions.CtoKTable([21, 4.1404e8]),
      tableYieldStress=Functions.CtoKTable([40, 2.07e8; 100, 1.92e8; 150,
          1.85e8; 200, 1.81e8; 250, 1.79e8; 300, 1.76e8; 350, 1.66e8; 400,
          1.56e8; 425, 1.55e8; 450, 1.51e8; 475, 1.46e8; 500, 1.43e8; 525,
          1.39e8]),
      tableLinearExpansionCoefficient=Functions.CtoKTable([50, 10.49e-6; 100,
          11.08e-6; 150, 11.63e-6; 200, 12.14e-6; 250, 12.60e-6; 300, 13.02e-6;
          350, 13.40e-6; 400, 13.74e-6; 425, 13.89e-6; 450, 14.02e-6; 500,
          14.28e-6; 550, 14.50e-6]),
      tableSpecificHeatCapacity=Functions.CtoKTable([25, 439.5; 100, 477.2; 150,
          498.1; 200, 523.3; 250, 540.0; 300, 560.9; 350, 577.5; 400, 602.8;
          425, 611.2; 450, 627.9; 475, 644.6; 500, 657.2; 550, 690.7]),
      tableThermalConductivity=Functions.CtoKTable([25, 41.9; 100, 42.2; 150,
          41.9; 200, 41.4; 250, 40.6; 300, 39.7; 350, 38.5; 400, 37.4; 425,
          36.7; 450, 36.3; 475, 35.7; 500, 35.0; 550, 34.0]));

  end AlloySteel_A335P12;

end Solids;
