within ORNL_AdvSMR.PRISM.Media.Common;
function cvdpT2Phase
  "compute isochoric specific heat capacity inside the two-phase region and derivative of pressure w.r.t. temperature"

  extends Modelica.Icons.Function;
  input PhaseBoundaryProperties liq "properties on the boiling curve";
  input PhaseBoundaryProperties vap "properties on the condensation curve";
  input SI.MassFraction x "vapour mass fraction";
  input SI.Temperature T "temperature";
  input SI.Pressure p "preoperties";
  output SI.SpecificHeatCapacity cv "isochoric specific heat capacity";
  output Real dpT "derivative of pressure w.r.t. temperature";
protected
  Real dxv "derivative of vapour mass fraction w.r.t. specific volume";
  Real dvTl "derivative of liquid specific volume w.r.t. temperature";
  Real dvTv "derivative of vapour specific volume w.r.t. temperature";
  Real duTl "derivative of liquid specific inner energy w.r.t. temperature";
  Real duTv "derivative of vapour specific inner energy w.r.t. temperature";
  Real dxt "derivative of vapour mass fraction w.r.t. temperature";
algorithm
  dxv := if (liq.d <> vap.d) then liq.d*vap.d/(liq.d - vap.d) else 0.0;
  dpT := (vap.s - liq.s)*dxv;
  // wrong at critical point
  dvTl := (liq.pt - dpT)/liq.pd/liq.d/liq.d;
  dvTv := (vap.pt - dpT)/vap.pd/vap.d/vap.d;
  dxt := -dxv*(dvTl + x*(dvTv - dvTl));
  duTl := liq.cv + (T*liq.pt - p)*dvTl;
  duTv := vap.cv + (T*vap.pt - p)*dvTv;
  cv := duTl + x*(duTv - duTl) + dxt*(vap.u - liq.u);
end cvdpT2Phase;
