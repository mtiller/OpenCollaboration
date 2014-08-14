within ORNL_AdvSMR.Components.Pipes.BaseClasses.WallFriction;
package NoFriction "No pipe wall friction, no static head"
extends Modelica.Icons.Package;


extends PartialWallFriction(
  final use_mu=false,
  final use_roughness=false,
  final use_dp_small=false,
  final use_m_flow_small=false,
  final dp_is_zero=true);


redeclare function extends massFlowRate_dp
  "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction"

  algorithm
  assert(false, "function massFlowRate_dp (option: from_dp=true)
cannot be used for WallFriction.NoFriction. Use instead
function pressureLoss_m_flow (option: from_dp=false)");
  annotation (Documentation(info="<html>

</html>"));
  end massFlowRate_dp;


redeclare function extends pressureLoss_m_flow
  "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction"

  algorithm
  dp := 0;
  annotation (Documentation(info="<html>

</html>"));
  end pressureLoss_m_flow;


redeclare function extends massFlowRate_dp_staticHead
  "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction and static head"

  algorithm
  assert(false, "function massFlowRate_dp (option: from_dp=true)
cannot be used for WallFriction.NoFriction. Use instead
function pressureLoss_m_flow (option: from_dp=false)");
  annotation (Documentation(info="<html>

</html>"));
  end massFlowRate_dp_staticHead;


redeclare function extends pressureLoss_m_flow_staticHead
  "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction and static head"

  /* To include only static head:
protected
  Real dp_grav_a = g_times_height_ab*rho_a
    "Static head if mass flows in design direction (a to b)";
  Real dp_grav_b = g_times_height_ab*rho_b
    "Static head if mass flows against design direction (b to a)";
*/
  algorithm
  //  dp := Utilities.regStep(m_flow, dp_grav_a, dp_grav_a, m_flow_small);
  dp := 0;
  assert(abs(g_times_height_ab) < Modelica.Constants.small,
    "WallFriction.NoFriction does not consider static head and cannot be used with height_ab<>0!");
  annotation (Documentation(info="<html>

</html>"));
  end pressureLoss_m_flow_staticHead;


annotation (Documentation(info="<html>
<p>
This component sets the pressure loss due to wall friction
to zero, i.e., it allows to switch off pipe wall friction.
</p>
</html>"));
end NoFriction;
