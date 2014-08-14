within ORNL_AdvSMR.BaseClasses.CharacteristicNumbers;
function spliceFunction
  input Real pos "Argument of x > 0";
  input Real neg "Argument of x < 0";
  input Real x "Independent value";
  input Real deltax "Half width of transition interval";
  output Real out "Smoothed value";
protected
  Real scaledX;
  Real scaledX1;
  Real y;
algorithm
  scaledX1 := x/deltax;
  scaledX := scaledX1*Modelica.Math.asin(1);
  if scaledX1 <= -0.999999999 then
    y := 0;
  elseif scaledX1 >= 0.999999999 then
    y := 1;
  else
    y := (Modelica.Math.tanh(Modelica.Math.tan(scaledX)) + 1)/2;
  end if;
  out := pos*y + (1 - y)*neg;

  annotation (smoothOrder=1,derivative=BaseClasses.der_spliceFunction);
end spliceFunction;
