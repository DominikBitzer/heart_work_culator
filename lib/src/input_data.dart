import 'package:flutter/material.dart';
import 'dart:math';

class HeartDataInput extends StatefulWidget {
  const HeartDataInput({Key? key}) : super(key: key);

  @override
  _HeartDataInputState createState() => _HeartDataInputState();
}

class _HeartDataInputState extends State<HeartDataInput> {
  final _formKey = GlobalKey<FormState>();

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
      body: Form(
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
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: '(msec)',
                    labelText:
                        'Pre-ejection period left ventricular outflow tract',
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
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: '(msec)',
                    labelText:
                        'Total systolic period left ventricular outflow tract',
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
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: '(mmHg)',
                            labelText: 'Systolic blood pressure',
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
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: '(mmHg)',
                            labelText: 'Diastolic blood pressure',
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
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
