within ORNL_AdvSMR.Media.DataDefinitions;
package LinearLiquids "Data records for linear compressibility liquids"
// extends Modelon.Icons.Package;
import ORNL_AdvSMR.Media.Interfaces.State.Units;

constant ORNL_AdvSMR.Media.DataDefinitions.LinearLiquids.LinearFluid
  Coldwaterdata(
  reference_p=101325,
  reference_T=278.15,
  reference_d=997.05,
  reference_h=104929,
  reference_s=100.0,
  cp_const=4181.9,
  beta_const=2.5713e-4,
  kappa_const=4.5154e-10,
  MM=0.01801528);


annotation (Icon(graphics={Rectangle(
        extent={{-76,-8},{56,-88}},
        fillColor={255,255,127},
        fillPattern=FillPattern.Solid,
        lineColor={0,0,255}),Line(points={{-76,-64},{56,-64}}, color={0,0,0}),
        Line(points={{-10,-8},{-10,-88}}, color={0,0,0}),Line(points={{-76,-36},
        {56,-36}}, color={0,0,0})}));
end LinearLiquids;
