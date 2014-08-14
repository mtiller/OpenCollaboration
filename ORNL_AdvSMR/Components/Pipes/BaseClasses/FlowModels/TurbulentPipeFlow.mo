within ORNL_AdvSMR.Components.Pipes.BaseClasses.FlowModels;
model TurbulentPipeFlow
  "TurbulentPipeFlow: Pipe wall friction in the quadratic turbulent regime (simple characteristic, mu not used)"
  import SMR = ORNL_AdvSMR.SmAHTR;
  extends Components.Pipes.BaseClasses.FlowModels.PartialGenericPipeFlow(
    redeclare package WallFriction =
        Components.Pipes.BaseClasses.WallFriction.QuadraticTurbulent,
    use_mu_nominal=not show_Res,
    pathLengths_internal=pathLengths,
    dp_nominal=1e3*dp_small,
    m_flow_nominal=1e2*m_flow_small);

  annotation (Documentation(info="<html>
<p>
This model defines only the quadratic turbulent regime of wall friction:
dp = k*m_flow*|m_flow|, where \"k\" depends on density and the roughness
of the pipe and is not a function of the Reynolds number.
This relationship is only valid for large Reynolds numbers.
The turbulent pressure loss correlation might be useful to optimize models that are only facing turbular flow.
</p>

</html>"));
end TurbulentPipeFlow;
