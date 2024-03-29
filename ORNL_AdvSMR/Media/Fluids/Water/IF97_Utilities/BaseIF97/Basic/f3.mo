within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function f3 "Helmholtz function for region 3: f(d,T)"
  extends Modelica.Icons.Function;
  input SI.Density d "density";
  input SI.Temperature T "temperature (K)";
  output Common.HelmholtzDerivs f
    "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
protected
  Real[40] o "vector of auxiliary variables";
algorithm
  f.T := T;
  f.d := d;
  f.R := data.RH2O;
  f.tau := data.TCRIT/T;
  f.delta := if (d == data.DCRIT and T == data.TCRIT) then 1 - Modelica.Constants.eps
     else abs(d/data.DCRIT);
  o[1] := f.tau*f.tau;
  o[2] := o[1]*o[1];
  o[3] := o[2]*f.tau;
  o[4] := o[1]*f.tau;
  o[5] := o[2]*o[2];
  o[6] := o[1]*o[5]*f.tau;
  o[7] := o[5]*f.tau;
  o[8] := -0.64207765181607*o[1];
  o[9] := 0.88521043984318 + o[8];
  o[10] := o[7]*o[9];
  o[11] := -1.15244078066810 + o[10];
  o[12] := o[11]*o[2];
  o[13] := -1.26543154777140 + o[12];
  o[14] := o[1]*o[13];
  o[15] := o[1]*o[2]*o[5]*f.tau;
  o[16] := o[2]*o[5];
  o[17] := o[1]*o[5];
  o[18] := o[5]*o[5];
  o[19] := o[1]*o[18]*o[2];
  o[20] := o[1]*o[18]*o[2]*f.tau;
  o[21] := o[18]*o[5];
  o[22] := o[1]*o[18]*o[5];
  o[23] := 0.251168168486160*o[2];
  o[24] := 0.078841073758308 + o[23];
  o[25] := o[15]*o[24];
  o[26] := -6.1005234513930 + o[25];
  o[27] := o[26]*f.tau;
  o[28] := 9.7944563083754 + o[27];
  o[29] := o[2]*o[28];
  o[30] := -1.70429417648412 + o[29];
  o[31] := o[1]*o[30];
  o[32] := f.delta*f.delta;
  o[33] := -10.9153200808732*o[1];
  o[34] := 13.2781565976477 + o[33];
  o[35] := o[34]*o[7];
  o[36] := -6.9146446840086 + o[35];
  o[37] := o[2]*o[36];
  o[38] := -2.53086309554280 + o[37];
  o[39] := o[38]*f.tau;
  o[40] := o[18]*o[5]*f.tau;

  f.f := -15.7328452902390 + f.tau*(20.9443969743070 + (-7.6867707878716 + o[3]
    *(2.61859477879540 + o[4]*(-2.80807811486200 + o[1]*(1.20533696965170 -
    0.0084566812812502*o[6]))))*f.tau) + f.delta*(o[14] + f.delta*(
    0.38493460186671 + o[1]*(-0.85214708824206 + o[2]*(4.8972281541877 + (-3.05026172569650
     + o[15]*(0.039420536879154 + 0.125584084243080*o[2]))*f.tau)) + f.delta*(-0.279993296987100
     + o[1]*(1.38997995694600 + o[1]*(-2.01899150235700 + o[16]*(-0.0082147637173963
     - 0.47596035734923*o[17]))) + f.delta*(0.043984074473500 + o[1]*(-0.44476435428739
     + o[1]*(0.90572070719733 + 0.70522450087967*o[19])) + f.delta*(f.delta*(-0.0221754008730960
     + o[1]*(0.094260751665092 + 0.164362784479610*o[21]) + f.delta*(-0.0135033722413480
    *o[1] + f.delta*(-0.0148343453524720*o[22] + f.delta*(o[1]*(
    0.00057922953628084 + 0.0032308904703711*o[21]) + f.delta*(
    0.000080964802996215 - 0.000044923899061815*f.delta*o[22] -
    0.000165576797950370*f.tau))))) + (0.107705126263320 + o[1]*(-0.32913623258954
     - 0.50871062041158*o[20]))*f.tau))))) + 1.06580700285130*Modelica.Math.log(
    f.delta);

  f.fdelta := (1.06580700285130 + f.delta*(o[14] + f.delta*(0.76986920373342 +
    o[31] + f.delta*(-0.83997989096130 + o[1]*(4.1699398708380 + o[1]*(-6.0569745070710
     + o[16]*(-0.0246442911521889 - 1.42788107204769*o[17]))) + f.delta*(
    0.175936297894000 + o[1]*(-1.77905741714956 + o[1]*(3.6228828287893 +
    2.82089800351868*o[19])) + f.delta*(f.delta*(-0.133052405238576 + o[1]*(
    0.56556450999055 + 0.98617670687766*o[21]) + f.delta*(-0.094523605689436*o[
    1] + f.delta*(-0.118674762819776*o[22] + f.delta*(o[1]*(0.0052130658265276
     + 0.0290780142333399*o[21]) + f.delta*(0.00080964802996215 -
    0.00049416288967996*f.delta*o[22] - 0.00165576797950370*f.tau))))) + (
    0.53852563131660 + o[1]*(-1.64568116294770 - 2.54355310205790*o[20]))*f.tau))))))
    /f.delta;

  f.fdeltadelta := (-1.06580700285130 + o[32]*(0.76986920373342 + o[31] + f.delta
    *(-1.67995978192260 + o[1]*(8.3398797416760 + o[1]*(-12.1139490141420 + o[
    16]*(-0.049288582304378 - 2.85576214409538*o[17]))) + f.delta*(
    0.52780889368200 + o[1]*(-5.3371722514487 + o[1]*(10.8686484863680 +
    8.4626940105560*o[19])) + f.delta*(f.delta*(-0.66526202619288 + o[1]*(
    2.82782254995276 + 4.9308835343883*o[21]) + f.delta*(-0.56714163413662*o[1]
     + f.delta*(-0.83072333973843*o[22] + f.delta*(o[1]*(0.041704526612220 +
    0.232624113866719*o[21]) + f.delta*(0.0072868322696594 - 0.0049416288967996
    *f.delta*o[22] - 0.0149019118155333*f.tau))))) + (2.15410252526640 + o[1]*(
    -6.5827246517908 - 10.1742124082316*o[20]))*f.tau)))))/o[32];

  f.ftau := 20.9443969743070 + (-15.3735415757432 + o[3]*(18.3301634515678 + o[
    4]*(-28.0807811486200 + o[1]*(14.4640436358204 - 0.194503669468755*o[6]))))
    *f.tau + f.delta*(o[39] + f.delta*(f.tau*(-1.70429417648412 + o[2]*(
    29.3833689251262 + (-21.3518320798755 + o[15]*(0.86725181134139 +
    3.2651861903201*o[2]))*f.tau)) + f.delta*((2.77995991389200 + o[1]*(-8.0759660094280
     + o[16]*(-0.131436219478341 - 12.3749692910800*o[17])))*f.tau + f.delta*((
    -0.88952870857478 + o[1]*(3.6228828287893 + 18.3358370228714*o[19]))*f.tau
     + f.delta*(0.107705126263320 + o[1]*(-0.98740869776862 - 13.2264761307011*
    o[20]) + f.delta*((0.188521503330184 + 4.2734323964699*o[21])*f.tau + f.delta
    *(-0.0270067444826960*f.tau + f.delta*(-0.38569297916427*o[40] + f.delta*(f.delta
    *(-0.000165576797950370 - 0.00116802137560719*f.delta*o[40]) + (
    0.00115845907256168 + 0.084003152229649*o[21])*f.tau)))))))));

  f.ftautau := -15.3735415757432 + o[3]*(109.980980709407 + o[4]*(-252.727030337580
     + o[1]*(159.104479994024 - 4.2790807283126*o[6]))) + f.delta*(-2.53086309554280
     + o[2]*(-34.573223420043 + (185.894192367068 - 174.645121293971*o[1])*o[7])
     + f.delta*(-1.70429417648412 + o[2]*(146.916844625631 + (-128.110992479253
     + o[15]*(18.2122880381691 + 81.629654758002*o[2]))*f.tau) + f.delta*(
    2.77995991389200 + o[1]*(-24.2278980282840 + o[16]*(-1.97154329217511 -
    309.374232277000*o[17])) + f.delta*(-0.88952870857478 + o[1]*(
    10.8686484863680 + 458.39592557179*o[19]) + f.delta*(f.delta*(
    0.188521503330184 + 106.835809911747*o[21] + f.delta*(-0.0270067444826960
     + f.delta*(-9.6423244791068*o[21] + f.delta*(0.00115845907256168 +
    2.10007880574121*o[21] - 0.0292005343901797*o[21]*o[32])))) + (-1.97481739553724
     - 330.66190326753*o[20])*f.tau)))));

  f.fdeltatau := o[39] + f.delta*(f.tau*(-3.4085883529682 + o[2]*(
    58.766737850252 + (-42.703664159751 + o[15]*(1.73450362268278 +
    6.5303723806402*o[2]))*f.tau)) + f.delta*((8.3398797416760 + o[1]*(-24.2278980282840
     + o[16]*(-0.39430865843502 - 37.124907873240*o[17])))*f.tau + f.delta*((-3.5581148342991
     + o[1]*(14.4915313151573 + 73.343348091486*o[19]))*f.tau + f.delta*(
    0.53852563131660 + o[1]*(-4.9370434888431 - 66.132380653505*o[20]) + f.delta
    *((1.13112901998110 + 25.6405943788192*o[21])*f.tau + f.delta*(-0.189047211378872
    *f.tau + f.delta*(-3.08554383331418*o[40] + f.delta*(f.delta*(-0.00165576797950370
     - 0.0128482351316791*f.delta*o[40]) + (0.0104261316530551 +
    0.75602837006684*o[21])*f.tau))))))));
end f3;
