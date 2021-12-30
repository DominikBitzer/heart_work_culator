import 'package:flutter/material.dart';

class DisplayOfAnalysis extends StatelessWidget {
  const DisplayOfAnalysis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calculatedResults =
        ModalRoute.of(context)!.settings.arguments as Map<String, double>;

    return Scaffold(
      appBar: AppBar(
        title: Text("Analysis of data"),
      ),
      body: Container(
        child: Center(
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "Your calculated results are:",
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(),
                      1: FixedColumnWidth(80),
                    },
                    children: [
                      TableRow(children: [
                        Padding(
                          child: Text("Ees_sb:"),
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Padding(
                          child: Text(
                              calculatedResults['E_es_sb']!.toStringAsFixed(2)),
                          padding: const EdgeInsets.all(8.0),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          child: Text("Ea arterial elastance:"),
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Padding(
                          child: Text(
                              calculatedResults['Ea_arterial_elastance']!
                                  .toStringAsFixed(2)),
                          padding: const EdgeInsets.all(8.0),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          child: Text("VAC ventricular arterial coupling:"),
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Padding(
                          child: Text(calculatedResults[
                                  'VAC_ventricular_arterial_coupling']!
                              .toStringAsFixed(2)),
                          padding: const EdgeInsets.all(8.0),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          child: Text("Epot:"),
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Padding(
                          child: Text(
                              calculatedResults['Epot']!.toStringAsFixed(2)),
                          padding: const EdgeInsets.all(8.0),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          child: Text("SW stroke work:"),
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Padding(
                          child: Text(calculatedResults['SW_stroke_work']!
                              .toStringAsFixed(2)),
                          padding: const EdgeInsets.all(8.0),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          child: Text("PVA Pressure volume area:"),
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Padding(
                          child: Text(
                              calculatedResults['PVA_Pressure_volume_area']!
                                  .toStringAsFixed(2)),
                          padding: const EdgeInsets.all(8.0),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          child: Text("CW cardiac work:"),
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Padding(
                          child: Text(calculatedResults['CW_cardiac_work']!
                              .toStringAsFixed(2)),
                          padding: const EdgeInsets.all(8.0),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          child: Text("Work efficiency:"),
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Padding(
                          child: Text(calculatedResults['Work_efficiency']!
                              .toStringAsFixed(2)),
                          padding: const EdgeInsets.all(8.0),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          child: Text("Reciprocal cardiac efficiency:"),
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Padding(
                          child: Text(calculatedResults[
                                  'reciprocal_cardiac_efficiency']!
                              .toStringAsFixed(2)),
                          padding: const EdgeInsets.all(8.0),
                        ),
                      ])
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Go back to input'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
