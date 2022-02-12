import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DisplayOfAnalysis extends StatelessWidget {
  const DisplayOfAnalysis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calculatedResults =
        ModalRoute.of(context)!.settings.arguments as Map<String, double>;

    double Work_efficiency_in_percent =
        100 * calculatedResults['Work_efficiency']!;
    String Work_efficiency_in_percent_string =
        Work_efficiency_in_percent.toStringAsFixed(0) + "%";

    return Scaffold(
      appBar: AppBar(
        title: Text("Analysis of data"),
      ),
      body: Center(
        child: Container(

          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 7), // changes position of shadow
              ),
            ],
            color: Theme.of(context).scaffoldBackgroundColor,

          ),

          alignment: Alignment.topCenter,
          constraints: BoxConstraints(
            maxWidth: 700,
          ),

          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Your calculated results are:",
                    style: const TextStyle(
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
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              child: Text(
                                  "Left ventricular end-systolic elastance (E_es_sb,\u{00A0}mmHg/mL):"),
                              padding: const EdgeInsets.all(6.0),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              child: Text(
                                  calculatedResults['E_es_sb']!
                                      .toStringAsFixed(2),
                                  textAlign: TextAlign.end),
                              padding: const EdgeInsets.all(6.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                          ),
                        ]),
                        TableRow(children: [
                          const TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              child:
                                  Text("Arterial elastance (Ea,\u{00A0}mmHg\u{2060}/\u{2060}mL):"),
                              padding: EdgeInsets.all(6.0),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              child: Text(
                                  calculatedResults['Ea_arterial_elastance']!
                                      .toStringAsFixed(2),
                                  textAlign: TextAlign.end),
                              padding: const EdgeInsets.all(6.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              child: Text(
                                  "Ventricular arterial coupling (Ea\u{2060}/\u{2060}E_es_sb):"),
                              padding: const EdgeInsets.all(6.0),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              child: Text(
                                  calculatedResults[
                                          'VAC_ventricular_arterial_coupling']!
                                      .toStringAsFixed(2),
                                  textAlign: TextAlign.end),
                              padding: const EdgeInsets.all(6.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              child:
                                  Text("Potential energy (Epot,\u{00A0}mmHg*mL):"),
                              padding: const EdgeInsets.all(6.0),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              child: Text(
                                  calculatedResults['Epot']!.toStringAsFixed(0),
                                  textAlign: TextAlign.end),
                              padding: const EdgeInsets.all(6.0),
                            ),
                          ),
                          Padding(
                            child: IconButton(
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Potential energy:'),
                                  content: Text(
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
                              icon: Icon(
                                Icons.info,
                                color: Colors.blue,
                                size: 27.0,
                              ),
                            ),
                            padding: const EdgeInsets.all(0.0),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              child: Text("Stroke work (SW,\u{00A0}mmHg*mL):"),
                              padding: const EdgeInsets.all(6.0),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              child: Text(
                                  calculatedResults['SW_stroke_work']!
                                      .toStringAsFixed(0),
                                  textAlign: TextAlign.end),
                              padding: const EdgeInsets.all(6.0),
                            ),
                          ),
                          Padding(
                            child: IconButton(
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Stroke work:'),
                                  content: Text(
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
                              icon: Icon(
                                Icons.info,
                                color: Colors.blue,
                                size: 27.0,
                              ),
                            ),
                            padding: const EdgeInsets.all(0.0),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              child: Text(
                                  "Pressure–volume area (PVA,\u{00A0}mmHg*mL):"),
                              padding: const EdgeInsets.all(6.0),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              child: Text(
                                  calculatedResults['PVA_Pressure_volume_area']!
                                      .toStringAsFixed(0),
                                  textAlign: TextAlign.end),
                              padding: const EdgeInsets.all(6.0),
                            ),
                          ),
                          Padding(
                            child: IconButton(
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Pressure–volume area:'),
                                  content: Text(
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
                              icon: Icon(
                                Icons.info,
                                color: Colors.blue,
                                size: 27.0,
                              ),
                            ),
                            padding: const EdgeInsets.all(0.0),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              child: Text(
                                  "Cardiac work (CW,\u{00A0}mmHg*mL*Heart Rate):"),
                              padding: const EdgeInsets.all(6.0),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              child: Text(
                                  calculatedResults['CW_cardiac_work']!
                                      .toStringAsFixed(0),
                                  textAlign: TextAlign.end),
                              padding: const EdgeInsets.all(6.0),
                            ),
                          ),
                          Padding(
                            child: IconButton(
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Cardiac work:'),
                                  content: Text(
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
                              icon: Icon(
                                Icons.info,
                                color: Colors.blue,
                                size: 27.0,
                              ),
                            ),
                            padding: const EdgeInsets.all(0.0),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              child: Text("Work efficiency (SW\u{2060}/\u{2060}PVA):"),
                              padding: const EdgeInsets.all(6.0),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              child: Text(Work_efficiency_in_percent_string,
                                  textAlign: TextAlign.end
                                  // calculatedResults['Work_efficiency']!
                                  // .toStringAsFixed(2)
                                  ),
                              padding: const EdgeInsets.all(6.0),
                            ),
                          ),
                          Padding(
                            child: IconButton(
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Work efficiency:'),
                                  content: Text(
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
                              icon: Icon(
                                Icons.info,
                                color: Colors.blue,
                                size: 27.0,
                              ),
                            ),
                            padding: const EdgeInsets.all(0.0),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              child: Text(
                                  "Cardiac efficiency (PVA\u{2060}/\u{2060}Stroke\u{00A0}Volume,\u{00A0}mmHg):"),
                              padding: const EdgeInsets.all(6.0),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              child: Text(
                                  calculatedResults[
                                          'reciprocal_cardiac_efficiency']!
                                      .toStringAsFixed(0),
                                  textAlign: TextAlign.end),
                              padding: const EdgeInsets.all(6.0),
                            ),
                          ),
                          Padding(
                            child: IconButton(
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Cardiac efficiency:'),
                                  content: Text(
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
                              icon: Icon(
                                Icons.info,
                                color: Colors.blue,
                                size: 27.0,
                              ),
                            ),
                            padding: const EdgeInsets.all(0.0),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  InteractiveViewer(
                    maxScale: 1.9,
                    child: Padding(
                      child: const Image(
                        image: AssetImage('assets/pvl_diagram.png'),
                      ),
                      padding: const EdgeInsets.all(6.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
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
                                        children: [
                                          TableRow(children: [
                                            Padding(
                                              child: Text("A"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                            Padding(
                                              child: Text("ESV/0 mmHg"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              child: Text("B"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                            Padding(
                                              child: Text("EDV/0 mmHg"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              child: Text("C"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                            Padding(
                                              child: Text("EDV/Pes"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              child: Text("D"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                            Padding(
                                              child: Text("ESV/Pes"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              child: Text("Pes"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                            Padding(
                                              child: Text(
                                                  "End-systolic blood pressure"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              child: Text("A–B"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                            Padding(
                                              child: Text("Diastolic filling"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              child: Text("B–C"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                            Padding(
                                              child: Text(
                                                  "Isovolumic contraction"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              child: Text("C–D"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                            Padding(
                                              child: Text("Ejection"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              child: Text("D–A"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                            Padding(
                                              child:
                                                  Text("Isovolumic relaxation"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              child: Text("ESPVR"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                            Padding(
                                              child: Text(
                                                  "End-systolic pressure–volume relation"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              child: Text("Ees(sb)"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                            Padding(
                                              child: Text(
                                                  "Left ventricular end-systolic elastance"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              child: Text("V0"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                            Padding(
                                              child: Text(
                                                  "Intersection ESPVR and x-axis"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              child: Text("Ea"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                            Padding(
                                              child: Text("Arterial elastance"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              child: Text("Epot"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                            Padding(
                                              child: Text("Potential energy"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              child: Text("SW"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                            Padding(
                                              child: Text("Stroke work"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              child: Text("PVA"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                            ),
                                            Padding(
                                              child:
                                                  Text("Pressure–volume area"),
                                              padding:
                                                  const EdgeInsets.all(6.0),
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
                              icon: Icon(
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
