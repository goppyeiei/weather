import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weathet App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Weathet App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  var temp;
  var feel;
  String cname;
  String dropdownValue = 'Select your province';

  @override
  void initState() {
    super.initState();
    // Weather();
  }

  void Weather(String newValue) async {
    var api =
        "http://api.openweathermap.org/data/2.5/weather?q=$newValue&appid=ef88ca0d89d13b37e925b728ab702429";
    var response = await http.get(api);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var keltemp = data["main"]["temp"];
      var kelfeel = data["main"]["feels_like"];
      var xtemp = keltemp - 273.15;
      var xfeel = kelfeel - 273.15;
      var newtemp = xtemp;
      var newfeel = xfeel;
      newtemp = newtemp.toStringAsFixed(2);
      newfeel = newfeel.toStringAsFixed(2);
      setState(() {
        temp = newtemp;
        feel = newfeel;
        cname = data["name"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    print("เลือกจังหวัด => $newValue");
                    dropdownValue = newValue;
                  });
                  Weather(newValue);
                },
                items: <String>[
                  'Select your province',
                  'Bangkok',
                  'Ratchaburi',
                  'Ranong',
                  'Phayao',
                  'Lamphun',
                  'Lampang',
                  'Krabi',
                  'Kanchanaburi',
                  'Chumphon',
                  'Yasothon',
                  'Yala',
                  'Uttaradit',
                  'Trat',
                  'Surin',
                  'Songkhla',
                  'Satun',
                  'Saraburi',
                  'Rayong'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Text(
                "$dropdownValue" == "Select your province" ? "" : "$cname",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ),
              Text(
                  "$dropdownValue" == "Select your province"
                      ? ""
                      : "อุณหภูมิจริง : $temp องศาเซลเซียส",
                  style: TextStyle(fontStyle: FontStyle.italic, height: 3)),
              Text(
                  "$dropdownValue" == "Select your province"
                      ? ""
                      : "รู้สึกเหมือน : $feel องศาเซลเซียส",
                  style: TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
        ));
  }
}
