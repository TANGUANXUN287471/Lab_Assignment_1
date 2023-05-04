import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(const CountryInfo());

class CountryInfo extends StatelessWidget {
  const CountryInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Information',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Country Information'),
          ),
          body: Column(children: [
            Flexible(
                flex: 4, child: Image.asset('assets/images/map.jpg', scale: 2)),
            const Flexible(flex: 7, child: CountryInformation())
          ])),
    );
  }
}

class CountryInformation extends StatefulWidget {
  const CountryInformation({super.key});

  @override
  State<CountryInformation> createState() => _CountryInformationState();
}

class _CountryInformationState extends State<CountryInformation> {
  TextEditingController textEC = TextEditingController();
  ImageProvider nationflag = const NetworkImage('');

  var countryName = "",
      currency = "",
      capital = "",
      flag = "MY",
      desc = "",
      gdp = 0.0,
      area = 0.0,
      population = 0.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              const SizedBox(height: 20),
              const Text("Country Search",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(
                controller: textEC,
                decoration: InputDecoration(
                    hintText: "Country Name",
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: searchCountry, child: const Text("Search")),
              GridView.count(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: <Widget>[
                    SingleChildScrollView(child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.blue[200],
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("Country Flag"),
                            Image.network(
                              "https://flagsapi.com/$flag/shiny/64.png",
                              fit: BoxFit.cover,
                            ),
                            Text(countryName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                          ])),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.blue[200],
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("Currency"),
                            const Icon(
                              Icons.monetization_on_outlined,
                              size: 50,
                            ),
                            Text(currency,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.blue[200],
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("Capital"),
                            const Icon(
                              Icons.location_city,
                              size: 50,
                            ),
                            Text(capital,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.blue[200],
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("GPD"),
                            const Icon(
                              Icons.moving_outlined,
                              size: 50,
                            ),
                            Text("$gdp",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.blue[200],
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("Surface Area"),
                            const Icon(
                              Icons.landscape,
                              size: 50,
                            ),
                            Text("$area",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.blue[200],
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("Population"),
                            const Icon(
                              Icons.people,
                              size: 50,
                            ),
                            Text("$population",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                  ]),
              Text(desc, style: const TextStyle(fontStyle: FontStyle.italic)),
              ])
            ));
  }

  void searchCountry() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          Timer(const Duration(seconds: 1), () {
            Navigator.of(context).pop();
          });
          return const AlertDialog(
            title: Text("Please wait"),
            content: Text("Loadings..."),
          );
        });
    countryName = textEC.text;

    var apiId = "Txeduy0j3pROmZxwBdn3Tg==w8Y6i7fRBZVTqbdr";
    Uri url =
        Uri.parse("https://api.api-ninjas.com/v1/country?name=$countryName");
    var response = await http.get(url, headers: {"X-Api-Key": apiId});
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
    
      setState(() {
        gdp = parsedJson[0]["gdp"];
        currency = parsedJson[0]["currency"]["code"];
        capital = parsedJson[0]["capital"];
        countryName = parsedJson[0]["name"];
        area = parsedJson[0]["surface_area"];
        population = parsedJson[0]["population"];
        flag = parsedJson[0]["iso2"];
        nationflag = NetworkImage("https://flagsapi.com/$flag/shiny/64.png");
        desc = "$countryName Information Displayed";
      });
      //print(parsedJson);
    }else{
      setState(() {
      desc = "Invalid Input: NO COUNTRY FOUND !!!";
      });
    }
  }
}
