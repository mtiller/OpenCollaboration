within ORNL_AdvSMR.SmAHTR.PowerConversionSystem;
package ElectricGenerators "Simplified models of electric power components"
  extends Modelica.Icons.Library;


















  annotation (Documentation(info="<html>
<p>This package allows to describe the flow of active power between a synchronous generator and a grid, through simplified power transmission line models, assuming ideal voltage control. </p>
<p>These models are meant to be used as simplified boundary conditions for a thermal power plant model, rather than for fully modular description of three-phase networks. Specialized libraries should be used for this purpose; bear in mind, however, that full three-phase models of electrical machinery and power lines could make the power plant simulation substantially heavier, if special numeric integration strategies are not adopted.
</html>"));
end ElectricGenerators;
