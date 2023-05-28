import 'package:covid_tracker/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'detail_screen.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  // @override

  StatesServices statesServices = StatesServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  hintText: "Search with Country Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: countriesListApi(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                        children: [
                          ListTile(
                            title: Container(
                              height: 10,
                              width: 89,
                              color: Colors.white,
                            ),
                            subtitle: Container(
                              height: 10,
                              width: 89,
                              color: Colors.white,
                            ),
                            leading: Container(
                              height: 10,
                              width: 89,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    String name = snapshot.data![index]["country"];

                    if (searchController.text.isEmpty ||
                        name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return DetailScreen(
                                    image: snapshot.data![index]["countryInfo"]
                                        ["flag"],
                                    name: snapshot.data![index]["country"],
                                    totalCases: snapshot.data![index]["cases"],
                                    totalRecovered: snapshot.data![index]
                                        ["recovered"],
                                    totalDeaths: snapshot.data![index]
                                        ["deaths"],
                                    active: snapshot.data![index]["active"],
                                    test: snapshot.data![index]["tests"],
                                    critical: snapshot.data![index]["critical"],
                                    todayRecovered: snapshot.data![index]
                                        ["todayRecovered"],
                                  );
                                },
                              ));
                            },
                            child: ListTile(
                              title: Text(snapshot.data![index]["country"]),
                              subtitle: Text(
                                  snapshot.data![index]["cases"].toString()),
                              leading: Image.network(
                                snapshot.data![index]["countryInfo"]["flag"],
                                height: 50,
                                width: 50,
                                // image: NetworkImage(snapshot.data![index]
                                //     ["countryInfo"]["flag"]
                                //     ),
                              ),
                            ),
                          )
                        ],
                      );
                    } else {
                      Container();
                    }
                    return null;
                  },
                );
              }
            },
          ))
        ],
      )),
    );
  }
}
