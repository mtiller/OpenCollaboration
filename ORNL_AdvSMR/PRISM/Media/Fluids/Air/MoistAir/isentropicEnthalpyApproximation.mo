within ORNL_AdvSMR.PRISM.Media.Fluids.Air.MoistAir;
function isentropicEnthalpyApproximation
  "Approximate calculation of h_is from upstream properties, downstream pressure, gas part only"
  extends Modelica.Icons.Function;
  input AbsolutePressure p2 "downstream pressure";
  input ThermodynamicState state "thermodynamic state at upstream location";
  output SpecificEnthalpy h_is "isentropic enthalpy";
protected
  SpecificEnthalpy h "specific enthalpy at upstream location";
  IsentropicExponent gamma=isentropicExponent(state) "Isentropic exponent";
protected
  MassFraction[nX] X "complete X-vector";
algorithm
  X := if reducedX then cat(
    1,
    state.X,
    {1 - sum(state.X)}) else state.X;
  h := {SingleGasNasa.h_Tlow(
    data=steam,
    T=state.T,
    refChoice=3,
    h_off=46479.819 + 2501014.5),SingleGasNasa.h_Tlow(
    data=dryair,
    T=state.T,
    refChoice=3,
    h_off=25104.684)}*X;

  h_is := h + gamma/(gamma - 1.0)*(state.T*gasConstant(state))*((p2/state.p)^((
    gamma - 1)/gamma) - 1.0);
end isentropicEnthalpyApproximation;
