within ORNL_AdvSMR.BaseClasses.HeatTransfer;
model ConstantFlowHeatTransfer
  "ConstantHeatTransfer: Constant heat transfer coefficient"
  extends PartialFlowHeatTransfer;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha0
    "heat transfer coefficient";
equation
  Q_flows = {alpha0*surfaceAreas[i]*(heatPorts[i].T - Ts[i])*nParallel for i
     in 1:n};
  annotation (Documentation(info="<html>
Simple heat transfer correlation with constant heat transfer coefficient, used as default component in <a distributed pipe models.
</html>"));
end ConstantFlowHeatTransfer;
