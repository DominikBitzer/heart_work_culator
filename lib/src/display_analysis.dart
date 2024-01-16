import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DisplayOfAnalysis extends StatelessWidget {
  const DisplayOfAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    final calculatedResults =
        ModalRoute.of(context)!.settings.arguments as Map<String, double>;

    double workEfficiencyInPercent =
        100 * calculatedResults['Work_efficiency']!;
    String workEfficiencyInPercentString =
        "${workEfficiencyInPercent.toStringAsFixed(0)}%";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Analysis of data"),
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

          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Your calculated results are:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FlexColumnWidth(),
                        1: FixedColumnWidth(70),
                        2: FixedColumnWidth(40),
                      },
                      children: [
                        TableRow(children: [
                          const TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text(
                                  "Left ventricular end-systolic elastance (E_es_sb,\u{00A0}mmHg/mL):"),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                  calculatedResults['E_es_sb']!
                                      .toStringAsFixed(2),
                                  textAlign: TextAlign.end),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(6.0),
                          ),
                        ]),
                        TableRow(children: [
                          const TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child:
                                  Text("Arterial elastance (Ea,\u{00A0}mmHg\u{2060}/\u{2060}mL):"),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                  calculatedResults['Ea_arterial_elastance']!
                                      .toStringAsFixed(2),
                                  textAlign: TextAlign.end),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(6.0),
                          ),
                        ]),
                        TableRow(children: [
                          const TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text(
                                  "Ventricular arterial coupling (Ea\u{2060}/\u{2060}E_es_sb):"),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                  calculatedResults[
                                          'VAC_ventricular_arterial_coupling']!
                                      .toStringAsFixed(2),
                                  textAlign: TextAlign.end),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(6.0),
                          ),
                        ]),
                        TableRow(children: [
                          const TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child:
                                  Text("Potential energy (Epot,\u{00A0}mmHg*mL):"),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                  calculatedResults['Epot']!.toStringAsFixed(0),
                                  textAlign: TextAlign.end),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: IconButton(
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Potential energy:'),
                                  content: const Text(
                                      "Energy that is not actively engaged in left ventricular ejection."),
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
                        ]),
                        TableRow(children: [
                          const TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text("Stroke work (SW,\u{00A0}mmHg*mL):"),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                  calculatedResults['SW_stroke_work']!
                                      .toStringAsFixed(0),
                                  textAlign: TextAlign.end),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: IconButton(
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Stroke work:'),
                                  content: const Text(
                                      "Effective external work carried out by the left ventricle."),
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
                        ]),
                        TableRow(children: [
                          const TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text(
                                  "Pressure–volume area (PVA,\u{00A0}mmHg*mL):"),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                  calculatedResults['PVA_Pressure_volume_area']!
                                      .toStringAsFixed(0),
                                  textAlign: TextAlign.end),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: IconButton(
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Pressure–volume area:'),
                                  content: const Text(
                                      "Total mechanical energy carried out by the left ventricle."),
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
                        ]),
                        TableRow(children: [
                          const TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text(
                                  "Cardiac work (CW,\u{00A0}mmHg*mL*Heart Rate):"),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                  calculatedResults['CW_cardiac_work']!
                                      .toStringAsFixed(0),
                                  textAlign: TextAlign.end),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: IconButton(
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Cardiac work:'),
                                  content: const Text(
                                      "Effective external work carried out by the left ventricle over one minute."),
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
                        ]),
                        TableRow(children: [
                          const TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text("Work efficiency (SW\u{2060}/\u{2060}PVA):"),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(workEfficiencyInPercentString,
                                  textAlign: TextAlign.end
                                  // calculatedResults['Work_efficiency']!
                                  // .toStringAsFixed(2)
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: IconButton(
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Work efficiency:'),
                                  content: const Text(
                                      "Efficiency of energy transfer from the left ventricle to the arterial system."),
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
                        ]),
                        TableRow(children: [
                          const TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text(
                                  "Cardiac efficiency (PVA\u{2060}/\u{2060}Stroke\u{00A0}Volume,\u{00A0}mmHg):"),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                  calculatedResults[
                                          'reciprocal_cardiac_efficiency']!
                                      .toStringAsFixed(0),
                                  textAlign: TextAlign.end),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: IconButton(
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Cardiac efficiency:'),
                                  content: const Text(
                                      "Total mechanical energy required to generate one milliliter of left ventricular stroke volume."),
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
                        ]),
                      ],
                    ),
                  ),
                  InteractiveViewer(
                    maxScale: 1.9,
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Image(
                        image: AssetImage('assets/pvl_diagram.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: MarkdownBody(
                                  data:
                                      "**Fig.\u{00A0}1**: Non-invasive left ventricular pressure–volume loop"),
                            ),
                            IconButton(
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                      'Non-invasive left ventricular pressure–volume loop'),
                                  content: Scrollbar(
                                    child: SingleChildScrollView(
                                      // child: Text(

                                      child: Table(
                                        columnWidths: const <int,
                                            TableColumnWidth>{
                                          0: FixedColumnWidth(70),
                                          1: FlexColumnWidth(),
                                        },
                                        children: const [
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("A"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("ESV/0 mmHg"),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("B"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("EDV/0 mmHg"),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("C"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("EDV/Pes"),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("D"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("ESV/Pes"),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("Pes"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text(
                                                  "End-systolic blood pressure"),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("A–B"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("Diastolic filling"),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("B–C"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text(
                                                  "Isovolumic contraction"),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("C–D"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("Ejection"),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("D–A"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child:
                                                  Text("Isovolumic relaxation"),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("ESPVR"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text(
                                                  "End-systolic pressure–volume relation"),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("Ees(sb)"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text(
                                                  "Left ventricular end-systolic elastance"),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("V0"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text(
                                                  "Intersection ESPVR and x-axis"),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("Ea"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("Arterial elastance"),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("Epot"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("Potential energy"),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("SW"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("Stroke work"),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child: Text("PVA"),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(6.0),
                                              child:
                                                  Text("Pressure–volume area"),
                                            ),
                                          ]),
                                        ],
                                      ),

                                      // const MarkdownBody(
                                      //   data:
                                      //       // "ESV left ventricular end-systolic volume,  \n"
                                      //       // "EDV left ventricular end-diastolic volume,  \n"
                                      //       // "SV stroke volume,  \n"
                                      //       "**A**     \t(ESV/0 mmHg)  \n"
                                      //       "**B**     \t(EDV/0 mmHg)  \n"
                                      //       "**C**     \t(EDV/Pes)  \n"
                                      //       "**D**     \t(ESV/Pes)  \n"
                                      //       "**Pes**  \t(end-systolic blood pressure)  \n"
                                      //       "**A–B**   \t(diastolic filling)  \n"
                                      //       "**B–C**   \t(isovolumic contraction)  \n"
                                      //       "**C–D**   \t(ejection)  \n"
                                      //       "**D–A**   \t(isovolumic relaxation)  \n"
                                      //       "**ESPVR** \t(end-systolic pressure–volume relation)  \n"
                                      //       "**Ees(sb)** \t(Left ventricular end-systolic elastance)  \n"
                                      //       "**V0**    \t(intersection ESPVR and x-axis)  \n"
                                      //       // "V100 left ventricular volume at an end-systolic pressure of 100 mmHg,  \n"
                                      //       "**Ea**   \t(Arterial elastance)   \n"
                                      //       "**Epot**   \t(Potential energy)  \n"
                                      //       "**SW**    \t(Stroke work)  \n"
                                      //       "**PVA**    \t(Pressure–volume area)  \n",

                                      // style: TextStyle(
                                      //     height: 1.2
                                      // ),
                                      // ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        if (Navigator.canPop(context)) {
                                          Navigator.pop(context, 'OK');
                                        } else {
                                          Navigator.pushNamed(
                                            context,
                                            '/input_data',
                                          );
                                        }
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              ),
                              icon: const Icon(
                                Icons.info,
                                color: Colors.blue,
                                size: 30.0,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Go back to input'),
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
