import 'package:flutter/material.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class HeartDataInput extends StatefulWidget {
  const HeartDataInput({Key? key}) : super(key: key);

  @override
  _HeartDataInputState createState() => _HeartDataInputState();
}

class _HeartDataInputState extends State<HeartDataInput> {
  final _formKey = GlobalKey<FormState>();

  FocusNode _field1preejectionPeriodFocusNode = FocusNode();
  FocusNode _field2TotalSystolicPeriodFocusNode = FocusNode();
  FocusNode _field3EndSystolicVolumeFocusNode = FocusNode();
  FocusNode _field4EndDiastolicVolumeFocusNode = FocusNode();
  FocusNode _field5SystolicFocusNode = FocusNode();
  FocusNode _field6DiastolicFocusNode = FocusNode();
  FocusNode _field7HearRateFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _checkIfTermsAccepted();
  }

  void _checkIfTermsAccepted() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bool terms_have_been_accepted =
          (prefs.getBool('terms_have_been_accepted') ?? false);
      if (!terms_have_been_accepted) {
        Navigator.pushNamed(
          context,
          '/show_and_accept_terms',
        );
      }
    });
  }

  late double input_1_preejection_period;
  late double input_2_systolic_period;
  late double input_3a_end_systolic_volume;
  late double input_3b_end_diastolic_volume;
  late double input_4a_systolic_bloodpressure;
  late double input_4b_diastolic_bloodpressure;
  late double input_5_heartrate;

  void calculate_And_Display_Results() {
    var valid = _formKey.currentState!.validate();
    if (!valid) {
      return;
    }

    Map<String, double> calculatedResults = {};

    List<double> array_ai_fixed_values = [
      0.35695,
      -7.2266,
      74.249,
      -307.39,
      684.54,
      -856.92,
      571.95,
      -159.1
    ];
    double temp_e_nd_sum = 0.0;
    double quotient_preejection_durch_totalsystolic =
        input_1_preejection_period / input_2_systolic_period;
    for (int i = 1; i <= 7; i++) {
      temp_e_nd_sum += array_ai_fixed_values[i - 1] *
          pow(quotient_preejection_durch_totalsystolic, i);
    }
    calculatedResults["E_Nd(avg)"] = temp_e_nd_sum;

    double SV_stroke_volume =
        (input_3b_end_diastolic_volume - input_3a_end_systolic_volume);

    calculatedResults["stroke_volume"] = SV_stroke_volume;

    double ejection_fraction = SV_stroke_volume / input_3b_end_diastolic_volume;
    calculatedResults["ejection_fraction"] = ejection_fraction;

    double P_es_endsystolic_bloodpressure =
        0.9 * input_4a_systolic_bloodpressure;
    calculatedResults["P_es_endsystolic_bloodpressure"] =
        P_es_endsystolic_bloodpressure;

    double E_Nd_est = 0.0275 -
        (0.165 * ejection_fraction) +
        0.3656 *
            (input_4b_diastolic_bloodpressure /
                P_es_endsystolic_bloodpressure) +
        0.515 * temp_e_nd_sum;
    calculatedResults["E_Nd(est)"] = E_Nd_est;

    double E_es_sb = (input_4b_diastolic_bloodpressure -
            (E_Nd_est * input_4a_systolic_bloodpressure * 0.9)) /
        (SV_stroke_volume * E_Nd_est);
    calculatedResults["E_es_sb"] = E_es_sb;

    double Ea_arterial_elastance =
        P_es_endsystolic_bloodpressure / SV_stroke_volume;
    calculatedResults["Ea_arterial_elastance"] = Ea_arterial_elastance;

    double SW_stroke_work = P_es_endsystolic_bloodpressure * SV_stroke_volume;
    calculatedResults["SW_stroke_work"] = SW_stroke_work;

    double V_0 = input_3a_end_systolic_volume -
        (P_es_endsystolic_bloodpressure / E_es_sb);
    calculatedResults["V_0"] = V_0;

    double Epot = 0.5 *
        (input_3a_end_systolic_volume - V_0) *
        P_es_endsystolic_bloodpressure;
    calculatedResults["Epot"] = Epot;

    double PVA_Pressure_volume_area = Epot + SW_stroke_work;
    calculatedResults["PVA_Pressure_volume_area"] = PVA_Pressure_volume_area;

    double CW_cardiac_work = SW_stroke_work * input_5_heartrate;
    calculatedResults["CW_cardiac_work"] = CW_cardiac_work;

    double Work_efficiency = SW_stroke_work / PVA_Pressure_volume_area;
    calculatedResults["Work_efficiency"] = Work_efficiency;

    double reciprocal_cardiac_efficiency =
        PVA_Pressure_volume_area / SV_stroke_volume;
    calculatedResults["reciprocal_cardiac_efficiency"] =
        reciprocal_cardiac_efficiency;

    double VAC_ventricular_arterial_coupling = Ea_arterial_elastance / E_es_sb;
    calculatedResults["VAC_ventricular_arterial_coupling"] =
        VAC_ventricular_arterial_coupling;

    Navigator.pushNamed(
      context,
      '/display_analysis',
      arguments: calculatedResults,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   // Add a ListView to the drawer. This ensures the user can scroll
      //   // through the options in the drawer if there isn't enough vertical
      //   // space to fit everything.
      //   child: ListView(
      //     // Important: Remove any padding from the ListView.
      //     padding: EdgeInsets.zero,
      //     children: [
      //       const DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.green,
      //         ),
      //         child: Text('Menu'),
      //       ),
      //       ListTile(
      //         title: const Text('Terms and conditions'),
      //         onTap: () {
      //           Navigator.pushNamed(
      //             context,
      //             '/show_and_accept_terms',
      //           );
      //         },
      //       ),
      //       ListTile(
      //         title: const Text('Impressum'),
      //         onTap: () {
      //           Navigator.pushNamed(
      //             context,
      //             '/impressum',
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        title: const Text('Input of data'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: calculate_And_Display_Results,
              child: const Text('Analyze'),
            ),
          ),
        ],
      ),

      body: Container(
        child: Container(
          // constraints: BoxConstraints(
          //   // minHeight: 500, //minimum height
          //   // minWidth: 300, // minimum width
          //   //
          //   // maxHeight: MediaQuery.of(context).size.height,
          //   // //maximum height set to 100% of vertical height
          //
          //   maxWidth: 700,
          //   //maximum width set to 100% of width
          // ),
          child: Form(
            key: _formKey,
            child: Scrollbar(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        input_1_preejection_period = double.parse(value);
                      },
                      focusNode: _field1preejectionPeriodFocusNode,
                      onFieldSubmitted: (String val) {
                        _field1preejectionPeriodFocusNode.unfocus();
                        FocusScope.of(context)
                            .requestFocus(_field2TotalSystolicPeriodFocusNode);
                      },
                      decoration: InputDecoration(
                        filled: true,
                        hintText: '(msec)',
                        labelText:
                            'Pre-ejection period left ventricular outflow tract',
                        suffixIcon: IconButton(
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                  'Aortic Doppler waveform and the determination of pre-ejection and and total-systolic period'),
                              content: InteractiveViewer(
                                child: Padding(
                                  child: const Image(
                                    image: AssetImage(
                                        'assets/five_chamber_view_app.png'),
                                  ),
                                  padding: const EdgeInsets.all(1.0),
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ),
                          icon: Icon(
                            Icons.info,
                            color: Colors.blue,
                            size: 27.0,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a value.';
                        }
                      },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        input_2_systolic_period = double.parse(value);
                      },
                      focusNode: _field2TotalSystolicPeriodFocusNode,
                      onFieldSubmitted: (String val) {
                        _field2TotalSystolicPeriodFocusNode.unfocus();
                        FocusScope.of(context)
                            .requestFocus(_field3EndSystolicVolumeFocusNode);
                      },
                      decoration: InputDecoration(
                        filled: true,
                        hintText: '(msec)',
                        labelText:
                            'Total systolic period left ventricular outflow tract',
                        suffixIcon: IconButton(
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('How to measure:'),
                              content: InteractiveViewer(
                                child: Padding(
                                  child: const Image(
                                    image: AssetImage(
                                        'assets/five_chamber_view_app.png'),
                                  ),
                                  padding: const EdgeInsets.all(1.0),
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ),
                          icon: Icon(
                            Icons.info,
                            color: Colors.blue,
                            size: 27.0,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a value.';
                        }
                      },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        input_3a_end_systolic_volume = double.parse(value);
                      },
                      focusNode: _field3EndSystolicVolumeFocusNode,
                      onFieldSubmitted: (String val) {
                        _field3EndSystolicVolumeFocusNode.unfocus();
                        FocusScope.of(context)
                            .requestFocus(_field4EndDiastolicVolumeFocusNode);
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: '(mL)',
                        labelText: 'End-systolic volume',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a value.';
                        }
                      },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        input_3b_end_diastolic_volume = double.parse(value);
                      },
                      focusNode: _field4EndDiastolicVolumeFocusNode,
                      onFieldSubmitted: (String val) {
                        _field4EndDiastolicVolumeFocusNode.unfocus();
                        FocusScope.of(context)
                            .requestFocus(_field5SystolicFocusNode);
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: '(mL)',
                        labelText: 'End-diastolic volume',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a value.';
                        }
                      },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {
                                input_4a_systolic_bloodpressure =
                                    double.parse(value);
                              },
                              focusNode: _field5SystolicFocusNode,
                              onFieldSubmitted: (String val) {
                                _field5SystolicFocusNode.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_field6DiastolicFocusNode);
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: '(mmHg)',
                                labelText: 'Systolic blood pressure',
                                suffixIcon: IconButton(
                                  onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text(
                                          'Notes about measuring blood pressure.'),
                                      content: InteractiveViewer(
                                        child: Padding(
                                          child: const Text(
                                              "Blood pressure should be measured in laying position simultaneously to echocardiographic examination."),
                                          padding: const EdgeInsets.all(1.0),
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.info,
                                    color: Colors.blue,
                                    size: 27.0,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a value.';
                                }
                              },
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          Text(
                            ' / ',
                            style: const TextStyle(fontSize: 30),
                          ),
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {
                                input_4b_diastolic_bloodpressure =
                                    double.parse(value);
                              },
                              focusNode: _field6DiastolicFocusNode,
                              onFieldSubmitted: (String val) {
                                _field6DiastolicFocusNode.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_field7HearRateFocusNode);
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: '(mmHg)',
                                labelText: 'Diastolic blood pressure',
                                suffixIcon: IconButton(
                                  onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text(
                                          'Notes about measuring blood pressure.'),
                                      content: InteractiveViewer(
                                        child: Padding(
                                          child: const Text(
                                              "Blood pressure should be measured in laying position simultaneously to echocardiographic examination."),
                                          padding: const EdgeInsets.all(1.0),
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.info,
                                    color: Colors.blue,
                                    size: 27.0,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a value.';
                                }
                              },
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        input_5_heartrate = double.parse(value);
                      },
                      focusNode: _field7HearRateFocusNode,
                      // onFieldSubmitted: (String val) {
                      //   _field6DiastolicFocusNode.unfocus();
                      //   FocusScope.of(context).requestFocus(_field7HearRateFocusNode);
                      // },
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: '(bpm)',
                        labelText: 'Heart rate',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a value.';
                        }
                      },
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        calculate_And_Display_Results();
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Analyze'),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
