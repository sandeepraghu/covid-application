import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      test,
      todayRecovered;
  DetailScreen(
      {Key? key,
      required this.name,
      required this.image,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.test,
      required this.todayRecovered})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(widget.image),
                    ),
                    ResuableRow(
                        title: "Cases", value: widget.totalCases.toString()),
                    ResuableRow(
                        title: "Recovered",
                        value: widget.totalRecovered.toString()),
                    ResuableRow(
                        title: "Death", value: widget.totalDeaths.toString()),
                    ResuableRow(
                        title: "Critical", value: widget.critical.toString()),
                    ResuableRow(
                        title: "Today Recovered",
                        value: widget.totalRecovered.toString()),
                    ResuableRow(
                        title: "Active", value: widget.active.toString()),
                    ResuableRow(title: "Tests", value: widget.test.toString()),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
