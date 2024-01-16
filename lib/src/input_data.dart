import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'dart:math';
import 'tum_colors.dart';
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

class HeartDataInput extends StatefulWidget {
  const HeartDataInput({super.key});

  @override
  _HeartDataInputState createState() => _HeartDataInputState();
}

class _HeartDataInputState extends State<HeartDataInput> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _field1preejectionPeriodFocusNode = FocusNode();
  final FocusNode _field2TotalSystolicPeriodFocusNode = FocusNode();
  final FocusNode _field3EndSystolicVolumeFocusNode = FocusNode();
  final FocusNode _field4EndDiastolicVolumeFocusNode = FocusNode();
  final FocusNode _field5SystolicFocusNode = FocusNode();
  final FocusNode _field6DiastolicFocusNode = FocusNode();
  final FocusNode _field7HearRateFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _checkIfTermsAccepted();
  }

  void _checkIfTermsAccepted() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bool termsHaveBeenAccepted =
          (prefs.getBool('terms_have_been_accepted') ?? false);
      if (!termsHaveBeenAccepted) {
        Navigator.pushNamed(
          context,
          '/welcome_disclaimer',
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

    List<double> arrayAiFixedValues = [
      0.35695,
      -7.2266,
      74.249,
      -307.39,
      684.54,
      -856.92,
      571.95,
      -159.1
    ];
    double tempENdSum = 0.0;
    double quotientPreejectionDurchTotalsystolic =
        input_1_preejection_period / input_2_systolic_period;
    for (int i = 0; i <= 7; i++) {
      tempENdSum += arrayAiFixedValues[i] *
          pow(quotientPreejectionDurchTotalsystolic, i);
    }
    calculatedResults["E_Nd(avg)"] = tempENdSum;

    double svStrokeVolume =
        (input_3b_end_diastolic_volume - input_3a_end_systolic_volume);

    calculatedResults["stroke_volume"] = svStrokeVolume;

    double ejectionFraction = svStrokeVolume / input_3b_end_diastolic_volume;
    calculatedResults["ejection_fraction"] = ejectionFraction;

    double pEsEndsystolicBloodpressure =
        0.9 * input_4a_systolic_bloodpressure;
    calculatedResults["P_es_endsystolic_bloodpressure"] =
        pEsEndsystolicBloodpressure;

    double eNdEst = 0.0275 -
        (0.165 * ejectionFraction) +
        0.3656 *
            (input_4b_diastolic_bloodpressure /
                pEsEndsystolicBloodpressure) +
        0.515 * tempENdSum;
    calculatedResults["E_Nd(est)"] = eNdEst;

    double eEsSb = (input_4b_diastolic_bloodpressure -
            (eNdEst * input_4a_systolic_bloodpressure * 0.9)) /
        (svStrokeVolume * eNdEst);
    calculatedResults["E_es_sb"] = eEsSb;

    double eaArterialElastance =
        pEsEndsystolicBloodpressure / svStrokeVolume;
    calculatedResults["Ea_arterial_elastance"] = eaArterialElastance;

    double swStrokeWork = pEsEndsystolicBloodpressure * svStrokeVolume;
    calculatedResults["SW_stroke_work"] = swStrokeWork;

    double v0 = input_3a_end_systolic_volume -
        (pEsEndsystolicBloodpressure / eEsSb);
    calculatedResults["V_0"] = v0;

    double Epot = 0.5 *
        (input_3a_end_systolic_volume - v0) *
        pEsEndsystolicBloodpressure;
    calculatedResults["Epot"] = Epot;

    double pvaPressureVolumeArea = Epot + swStrokeWork;
    calculatedResults["PVA_Pressure_volume_area"] = pvaPressureVolumeArea;

    double cwCardiacWork = swStrokeWork * input_5_heartrate;
    calculatedResults["CW_cardiac_work"] = cwCardiacWork;

    double workEfficiency = swStrokeWork / pvaPressureVolumeArea;
    calculatedResults["Work_efficiency"] = workEfficiency;

    double reciprocalCardiacEfficiency =
        pvaPressureVolumeArea / svStrokeVolume;
    calculatedResults["reciprocal_cardiac_efficiency"] =
        reciprocalCardiacEfficiency;

    double vacVentricularArterialCoupling = eaArterialElastance / eEsSb;
    calculatedResults["VAC_ventricular_arterial_coupling"] =
        vacVentricularArterialCoupling;

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
      //             '/welcome_disclaimer',
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
      // backgroundColor: const Color(0x25bababa),
      appBar: AppBar(
        title: const Text('Input of data'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              onPressed: calculate_And_Display_Results,
              child: const Text('Analyze'),
            ),
          ),
        ],
      ),

      body: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 5,
                offset: const Offset(0, 7), // changes position of shadow
              ),
            ],
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          alignment: Alignment.topCenter,
          constraints: const BoxConstraints(
            maxWidth: 700,
          ),
          child: Form(
            key: _formKey,
            child: Scrollbar(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        String commasReplaced = value.replaceAll(',', '.');
                        input_1_preejection_period =
                            double.parse(commasReplaced);
                        developer.log(
                            'input_1_preejection_period: $input_1_preejection_period',
                            name: 'input_1_preejection_period');
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
                                maxScale: 1.9,
                                child: const Padding(
                                  padding: EdgeInsets.all(1.0),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/five_chamber_view_app.png'),
                                  ),
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
                          icon: const Icon(
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
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        String commasReplaced = value.replaceAll(',', '.');
                        input_2_systolic_period = double.parse(commasReplaced);
                        developer.log(
                            'input_2_systolic_period: $input_2_systolic_period',
                            name: 'input_2_systolic_period');
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
                                maxScale: 1.9,
                                child: const Padding(
                                  padding: EdgeInsets.all(1.0),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/five_chamber_view_app.png'),
                                  ),
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
                          icon: const Icon(
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
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        String commasReplaced = value.replaceAll(',', '.');
                        input_3a_end_systolic_volume =
                            double.parse(commasReplaced);
                        developer.log(
                            'input_3a_end_systolic_volume: $input_3a_end_systolic_volume',
                            name: 'input_3a_end_systolic_volume');
                      },
                      focusNode: _field3EndSystolicVolumeFocusNode,
                      onFieldSubmitted: (String val) {
                        _field3EndSystolicVolumeFocusNode.unfocus();
                        FocusScope.of(context)
                            .requestFocus(_field4EndDiastolicVolumeFocusNode);
                      },
                      decoration: InputDecoration(
                        filled: true,
                        hintText: '(mL)',
                        labelText: 'End-systolic volume',
                        suffixIcon: IconButton(
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                  'Left ventricular end-systolic (LV ESV) and end-diastolic volume (LV EDV) should be assessed in apical four chamber view.'),
                              content: InteractiveViewer(
                                maxScale: 1.9,
                                child: const Padding(
                                  padding: EdgeInsets.all(1.0),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/LV_EDV_ESV_infobox.png'),
                                  ),
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
                          icon: const Icon(
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
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        String commasReplaced = value.replaceAll(',', '.');
                        input_3b_end_diastolic_volume =
                            double.parse(commasReplaced);
                        developer.log(
                            'input_3b_end_diastolic_volume: $input_3b_end_diastolic_volume',
                            name: 'input_3b_end_diastolic_volume');
                      },
                      focusNode: _field4EndDiastolicVolumeFocusNode,
                      onFieldSubmitted: (String val) {
                        _field4EndDiastolicVolumeFocusNode.unfocus();
                        FocusScope.of(context)
                            .requestFocus(_field5SystolicFocusNode);
                      },
                      decoration: InputDecoration(
                        filled: true,
                        hintText: '(mL)',
                        labelText: 'End-diastolic volume',
                        suffixIcon: IconButton(
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                  'Left ventricular end-systolic (LV ESV) and end-diastolic volume (LV EDV) should be assessed in apical four chamber view.'),
                              content: InteractiveViewer(
                                maxScale: 1.9,
                                child: const Padding(
                                  padding: EdgeInsets.all(1.0),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/LV_EDV_ESV_infobox.png'),
                                  ),
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
                          icon: const Icon(
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
                        return null;
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
                                String commasReplaced =
                                    value.replaceAll(',', '.');
                                input_4a_systolic_bloodpressure =
                                    double.parse(commasReplaced);
                                developer.log(
                                    'input_4a_systolic_bloodpressure: $input_4a_systolic_bloodpressure',
                                    name: 'input_4a_systolic_bloodpressure');
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
                                        maxScale: 1.9,
                                        child: const Padding(
                                          padding: EdgeInsets.all(1.0),
                                          child: Text(
                                              "Blood pressure should be measured in laying position simultaneously to echocardiographic examination."),
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
                                  icon: const Icon(
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
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          const Text(
                            ' / ',
                            style: TextStyle(fontSize: 30),
                          ),
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {
                                String commasReplaced =
                                    value.replaceAll(',', '.');
                                input_4b_diastolic_bloodpressure =
                                    double.parse(commasReplaced);
                                developer.log(
                                    'input_4b_diastolic_bloodpressure: $input_4b_diastolic_bloodpressure',
                                    name: 'input_4b_diastolic_bloodpressure');
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
                                        maxScale: 1.9,
                                        child: const Padding(
                                          padding: EdgeInsets.all(1.0),
                                          child: Text(
                                              "Blood pressure should be measured in laying position simultaneously to echocardiographic examination."),
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
                                  icon: const Icon(
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
                                return null;
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
                        String commasReplaced = value.replaceAll(',', '.');
                        input_5_heartrate = double.parse(commasReplaced);
                        developer.log('input_5_heartrate: $input_5_heartrate',
                            name: 'input_5_heartrate');
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
                        return null;
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
                        foregroundColor: Colors.white,
                        backgroundColor: Palette.tum_color_swatch,
                      ),
                      child: const Text('Analyze'),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: MarkdownBody(
                        data:
                            "[Privacy\u{00A0}policy](https://github.com/DominikBitzer/heart_work_culator/blob/master/assets/privacy_policy.md)",
                        onTapLink: (text, url, title) {
                          Navigator.pushNamed(
                            context,
                            '/privacy_policy',
                          );

                          // launch(url!);
                        },
                      ),
                    )
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
