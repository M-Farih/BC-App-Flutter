import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:flutter/material.dart';



class BeASeller extends StatefulWidget {
  @override
  _BeASellerState createState() => _BeASellerState();
}

class _BeASellerState extends State<BeASeller> {

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

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
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext ctx) => LoginPage()));
          }
        ),
    ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
                  child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 80,
                            child: buildTextField('الإسم الكامل')
                        ),
                      )
                  ),
                ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
              child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width - 80,
                        child: buildTextField('رقم الهاتف')
                    ),
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
              child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width - 80,
                        child: buildTextField('البريد الإلكتروني')
                    ),
                  )
              ),
            ),
            Center(
              child: ButtonTheme(
                minWidth: 150.0,
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    _sendRequest();
                  },
                  color: Color(0xFF2C7DBF),
                  textColor: Colors.white,
                  child: Text(
                    'ارسال الطلب',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontSize: 19.0
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String hintText){
    var myController = TextEditingController();
    var myIcon;
    switch (hintText){
      case 'الإسم الكامل': {
        myController = nameController;
        myIcon = Icons.person;
      }break;

      case 'رقم الهاتف': {
        myController = phoneController;
        myIcon = Icons.phone_android;
      }break;

      case 'البريد الإلكتروني': {
        myController = emailController;
        myIcon = Icons.mail;
      }break;
    }
    return TextField(
      controller: myController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: InputBorder.none,
        prefixIcon: Icon(myIcon),
      ),
    );
  }

  Future<void> _sendRequest() async {
    print('input name ==> ${nameController.text}');
    print('input phone ==> ${phoneController.text}');
    print('input email ==> ${emailController.text}');


  }
}
