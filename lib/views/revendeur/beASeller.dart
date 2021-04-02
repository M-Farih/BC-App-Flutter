import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:bc_app/views/widgets/appbar.dart';
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back, size: 20.0,),
                      Text(
                        'رجوع',
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                        textDirection: TextDirection.rtl,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
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
