import 'package:flutter/material.dart';
import 'package:bc_app/services/revendeurService.dart';

class AddRevendeur extends StatefulWidget {
  @override
  _AddRevendeurState createState() => _AddRevendeurState();
}

class _AddRevendeurState extends State<AddRevendeur> {

  final fname = TextEditingController();
  final lname = TextEditingController();
  final company = TextEditingController();
  final ice = TextEditingController();
  final city = TextEditingController();
  final address = TextEditingController();
  final tel = TextEditingController();
  final cNumber = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text("Bonbino Confort",
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
        actions: [
          IconButton(
            icon:
            const Icon(Icons.notifications_none, color: Color(0xFF545D68)),
            tooltip: 'Show Notification',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Show Notification')));
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color:  Color(0xFF545D68)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
            child: Column(
              children: [
                SizedBox(height: 30.0,),
                Text(
                  "Add new user",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.red
                  ),
                ),
                SizedBox(height: 30.0,),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'First name'
                  ),
                  controller: fname,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Last name'
                  ),
                  controller: lname,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Company'
                  ),
                  controller: company,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'ICE'
                  ),
                  controller: ice,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'City'
                  ),
                  controller: city,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Address'
                  ),
                  controller: address,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Telephone'
                  ),
                  controller: tel,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Client number'
                  ),
                  controller: cNumber,
                ),

                ElevatedButton(
                    onPressed: (){
                      _addNewRevendeur();
                    },
                    child: Text('Add'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red
                    ),
                )
              ],
            ),
          ),
        ),
      );
  }

  void _addNewRevendeur() {
    RevendeurService _rs = new RevendeurService();
    _rs.add(fname.text, lname.text, company.text, ice.text, city.text, address.text, tel.text, cNumber.text);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Client added')));
    Navigator.of(context).pop();
  }
}
