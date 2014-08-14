within ORNL_AdvSMR.Media.Interfaces.Types;
record GibbsDerivatives "Gibbs energy derivatives wrt. p and T"
  Modelica.SIunits.SpecificEnergy g "Gibbs energy";
  Real gt "Derivative of g w.r.t. T";
  Real gtt "Second derivative of g w.r.t. T";
  Real gttt "Third derivative of g w.r.t. T";
  Real gp "Derivative of g w.r.t. p";
  Real gpp "Second derivative of g w.r.t. p";
  Real gppp "Third derivative of g w.r.t. p";
  Real gtp "Mixed derivative of g";
  Real gtpp "Mixed derivative of g";
  Real gttp "Mixed derivative of g";
end GibbsDerivatives;
