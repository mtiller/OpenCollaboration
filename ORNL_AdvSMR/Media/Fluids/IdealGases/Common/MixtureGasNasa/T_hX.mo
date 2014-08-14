within ORNL_AdvSMR.Media.Fluids.IdealGases.Common.MixtureGasNasa;
function T_hX "Return temperature from specific enthalpy and mass fraction"
  input SpecificEnthalpy h "specific enthalpy";
  input MassFraction[:] X "mass fractions of composition";
  input Boolean exclEnthForm=excludeEnthalpyOfFormation
    "If true, enthalpy of formation Hf is not included in specific enthalpy h";
  input Choices.ReferenceEnthalpy refChoice=referenceChoice
    "Choice of reference enthalpy";
  input SI.SpecificEnthalpy h_off=h_offset
    "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
  output Temperature T "temperature";
protected
  MassFraction[nX] Xfull=if size(X, 1) == nX then X else cat(
      1,
      X,
      {1 - sum(X)});
  package Internal
    "Solve h(data,T) for T with given h (use only indirectly via temperature_phX)"
    extends Modelica.Media.Common.OneNonLinearEquation;
    redeclare record extends f_nonlinear_Data
      "Data to be passed to non-linear function"
      extends DataRecord;
    end f_nonlinear_Data;

    redeclare function extends f_nonlinear
    algorithm
      y := h_TX(x, X);
    end f_nonlinear;

    // Dummy definition has to be added for current Dymola
    redeclare function extends solve
    end solve;
  end Internal;

algorithm
  T := Internal.solve(
    h,
    200,
    6000,
    1.0e5,
    Xfull,
    data[1]);
  annotation (inverse(h=h_TX(
          T,
          X,
          exclEnthForm,
          refChoice,
          h_off)));
end T_hX;
