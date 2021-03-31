import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Sugg_rec extends StatefulWidget {
  @override
  _Sugg_recState createState() => _Sugg_recState();
}

class _Sugg_recState extends State<Sugg_rec> {

  UserPackages _selectedPackage;
  List<UserPackages> packageList = [
    UserPackages(id: 1, type: 'rec'),
    UserPackages(id: 2, type: 'sugg')
  ];

  @override
  void initState() {
    super.initState();
    //fetchPackages();
    print('test ----> ${packageList.length}');
    _selectedPackage = new UserPackages(id: 0, type: "empty");
  }

  @override
  Widget build(BuildContext context) {

    List<DropdownMenuItem> items = packageList.map((item) {
      if(packageList.isNotEmpty){
        return DropdownMenuItem<UserPackages>(
          child: Text(item.type.toString()),
          value: item,
        );
      }
    }).toList();

    // if list is empty, create a dummy item
    if (items.isEmpty) {
      items = [
        DropdownMenuItem(
          child: Text(_selectedPackage.type),
          value: _selectedPackage,
        )
      ];
    }

    return Scaffold(
      appBar: AppBar(title: Text('Add Claim')),
      body: Center(
        child: DropdownButton(
          items: items,
          onChanged: (newVal) => setState(() => _selectedPackage = newVal),
          value: _selectedPackage,
        ),
      ),
    );
  }

  Future <List<dynamic>>fetchPackages() async {

    String myUrl = 'https://bc.meks.ma/BC/v1/type_rec_sugg/';

    String username = 'TelcoBill_Api_User_V2|1|6';
    String password = '4398eefebc6342f42cd25e93250484fe76e19427bccc9c3d538a4c02faa267e81a6e4cdcb9ff10d90ef809fe2426d28cac87c2a314a9913aed56b64f687e616f';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Response response = await get(Uri.parse(myUrl), headers: { 'Accept': 'Application/json', 'authorization': basicAuth},
    );
    if (response.statusCode == 200)
      setState(() {
        var data = jsonDecode(response.body);
        //_selectedPackage = packageList[0];
        print('data =======> ${data['data'][0]['type']}');

        for(var i = 0 ; i<= data.length; i++){
          UserPackages up = new UserPackages(id: data['data'][i]['type_id'], type: data['data'][i]['type']);
          packageList.add(up);
        }
        print('data/// =======> ${packageList[0].type}');

      });
    else
      print("Error occurred");
  }

}

class UserPackages {

  int id;
  String type;

  UserPackages({this.id, this.type});

  UserPackages.fromJson(Map<String, dynamic> json)
      : id = json['data']['type_id'],
        type = json['data']['type'];

  dynamic toJson() => {'type_id': id, 'type': type};
}
