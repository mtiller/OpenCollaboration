within ORNL_AdvSMR.Media.Interfaces.State.Units;
type IsochoricPressureCoefficient = Real (
    min=1e-12,
    max=1000.0,
    final quantity="IsochoricPressureCoefficient",
    unit="1/K");
