import 'package:flutter/material.dart';
import 'package:bc_app/services/revendeurService.dart';

class UpdateRevendeur extends StatefulWidget {

  final id, fname, lname, userName, password, company, ice, city, address, telephone, clientNumber;

  UpdateRevendeur(this.id, this.fname, this.lname, this.userName, this.password, this.company, this.ice, this.city, this.address, this.telephone, this.clientNumber);


  @override
  _UpdateRevendeurState createState() => _UpdateRevendeurState();
}

class _UpdateRevendeurState extends State<UpdateRevendeur> {


  final c_fname = TextEditingController();
  final c_lname = TextEditingController();
  final c_company = TextEditingController();
  final c_ice = TextEditingController();
  final c_city = TextEditingController();
  final c_address = TextEditingController();
  final c_tel = TextEditingController();
  final c_cNumber = TextEditingController();

  @override
  void initState() {
    c_fname.text = widget.fname;
    c_lname.text = widget.lname;
    c_company.text = widget.company;
    c_ice.text = widget.ice;
    c_city.text = widget.city;
    c_address.text = widget.address;
    c_tel.text = widget.telephone;
    c_cNumber.text = widget.clientNumber;
    super.initState();
  }

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
                "Update ${widget.lname + ' ' +  widget.fname} information ",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                ),
              ),
              SizedBox(height: 30.0,),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'First name'
                ),
                controller: c_fname,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Last name'
                ),
                controller: c_lname,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Company'
                ),
                controller: c_company,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'ICE'
                ),
                controller: c_ice,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'City'
                ),
                controller: c_city,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Address'
                ),
                controller: c_address,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Telephone'
                ),
                controller: c_tel,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Client number'
                ),
                controller: c_cNumber,
              ),

              ElevatedButton(
                onPressed: (){
                  _updateRevendeur();
                },
                child: Text('Update'),
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

  void _updateRevendeur() {
    RevendeurService _rs = new RevendeurService();
    _rs.update(1, c_fname.text, c_lname.text, c_company.text, c_ice.text, c_city.text, c_address.text, c_tel.text, c_cNumber.text);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User updated')));
    Navigator.of(context).pop();
  }
}
