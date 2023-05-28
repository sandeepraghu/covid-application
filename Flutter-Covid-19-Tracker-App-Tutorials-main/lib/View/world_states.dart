import 'package:covid_tracker/Models/world_states_model.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'countries_list.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xFF28B5F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              FutureBuilder(
                future: statesServices.fetchWorldStateRecords(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Center(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases!.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Death":
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.03),
                          child: Card(
                            child: Column(children: [
                              ResuableRow(
                                  title: "Total",
                                  value: snapshot.data!.cases.toString()),
                              ResuableRow(
                                  title: "Total",
                                  value: snapshot.data!.deaths.toString()),
                              ResuableRow(
                                  title: "Total",
                                  value: snapshot.data!.active.toString()),
                              ResuableRow(
                                  title: "Total",
                                  value: snapshot.data!.recovered.toString()),
                              ResuableRow(
                                  title: "Total",
                                  value: snapshot.data!.critical.toString()),
                              ResuableRow(
                                  title: "Total",
                                  value: snapshot.data!.todayDeaths.toString()),
                              ResuableRow(
                                  title: "Total",
                                  value:
                                      snapshot.data!.todayRecovered.toString()),
                            ]),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CountriesList(),
                                ));
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                                color: const Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(child: Text("Track Countries")),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}

// ignore: must_be_immutable
class ResuableRow extends StatelessWidget {
  String title, value;
  ResuableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 05),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
