import "dart:convert";

import "package:covid_tracker/Models/world_states_model.dart";
import "package:covid_tracker/Services/Utilities/app_url.dart";
import "package:http/http.dart" as http;

class StatesServices {
  Future<WorldStatesModel> fetchWorldStateRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception();
    }
  }
}

Future<List<dynamic>> countriesListApi() async {
  // ignore: prefer_typing_uninitialized_variables
  var data;
  final response = await http.get(Uri.parse(AppUrl.countriesList));

  if (response.statusCode == 200) {
    data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception();
  }
}
