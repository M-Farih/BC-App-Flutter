import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/userProvider.dart';
import 'package:bc_app/views/_commercial/sellers/sellerDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListSellersAdmin extends StatefulWidget {
  @override
  _ListSellersAdminState createState() => _ListSellersAdminState();
}

class _ListSellersAdminState extends State<ListSellersAdmin> {

  final ScrollController _scrollController = ScrollController();
  final _key = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      int idRole = Provider.of<AuthProvider>(context, listen: false).currentUsr.idrole;
      print('/ * / $idRole');
      Provider.of<UserProvider>(context, listen: false).getSellers(idRole);
      Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: true);
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    return userProvider.busy
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
        backgroundColor: Color(0xFFF1F4F7),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// search bar
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: authProvider.currentUsr.idrole == 0
                          ?MediaQuery.of(context).size.width * 0.65
                          :MediaQuery.of(context).size.width * 0.75,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Chercher un revendeur ici...",
                            icon: Icon(Icons.search),
                          ),
                          onChanged: (text) {
                            userProvider.filterUsersList(text);
                          },
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        authProvider.currentUsr.idrole == 0
                            ?GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: Color(0xFF2C7DBF),
                                    borderRadius:
                                    BorderRadius.circular(30)),
                                child:
                                Icon(Icons.add, color: Colors.white)),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('add-user');
                          },
                        )
                            :SizedBox(),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: Color(0xFF2C7DBF),
                                    borderRadius:
                                    BorderRadius.circular(30)),
                                child:
                                Icon(Icons.drive_folder_upload, color: Colors.white)),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('upload-csv');
                          },
                        )
                      ],
                    )
                  ],
                ),

                /// sellers list
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: userProvider.myIndex,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if(authProvider.currentUsr.idrole == 0){
                      return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 0.5, color: Color(
                                  0xFFCBCBCB)),
                            ),
                          ),
                          child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                    '${userProvider.sellers[index].profileImage != "" ? userProvider.sellers[index].profileImage.replaceAll('"', '') : "https://ui-avatars.com/api/?background=FFFFF&color=2C7DBF&name=${userProvider.sellers[index].firstName}+${userProvider.sellers[index].lastName}"}'),
                              ),
                              title: Text(
                                '${userProvider.sellers[index].firstName} ${userProvider.sellers[index].lastName}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                              Text('${userProvider.sellers[index].clientNumber}'),
                              trailing: userProvider
                                  .sellers[index].userName != ""
                                  ?Container(
                                width: 30,height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children:[
                                    userProvider.sellers[index].firstConnection == "0"
                                        ?Icon(Icons.account_circle,
                                        color: Colors.blue.withOpacity(0.3))
                                        :Icon(Icons.account_circle,
                                        color: Colors.green.withOpacity(0.3))
                                  ] ,
                                ),
                              )
                                  :Container(
                                width: 30,height: 30,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children:[
                                      Icon(Icons.account_circle,
                                          color: Colors.red.withOpacity(0.3))
                                    ]
                                ),
                              ),
                              onLongPress: (){
                                print('long press');
                                AwesomeDialog(
                                  context: context,
                                  borderSide: BorderSide(color: Color(0xFF2C7DBF), width: 2),
                                  width: MediaQuery.of(context).size.width,
                                  buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                                  headerAnimationLoop: false,
                                  customHeader: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        '${userProvider.sellers[index].profileImage != "" ? userProvider.sellers[index].profileImage.replaceAll('"', '') : "https://ui-avatars.com/api/?background=FFFFF&color=2C7DBF&name=${userProvider.sellers[index].firstName}+${userProvider.sellers[index].lastName}"}'),
                                  ),
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'INFO',
                                  desc: 'Dialog description here...',
                                  body: Column(
                                    children: [
                                      Form(
                                          key: _key,
                                          child: Column(
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
                                                          child: buildTextField('Nom d\'utilisateur', userProvider.sellers[index].userName)),
                                                    )),
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
                                                          child: buildTextField('Nouveau mot de passe', userProvider.sellers[index].userName)),
                                                    )),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                  showCloseIcon: true,
                                  btnOkText: 'Modifier',
                                  btnOkColor: Color(0xFF2C7DBF),
                                  btnOkOnPress: () {},
                                )..show();
                              },
                              onTap: () {
                                userProvider.busy = true;
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => SellerDetails(
                                        id: userProvider.sellers[index].iduser,
                                        phoneNumber: userProvider.sellers[index].telephone,
                                        mail: userProvider.sellers[index].email,
                                        username: userProvider.sellers[index].userName,
                                        password: userProvider.sellers[index].password,
                                        solde: userProvider.sellers[index].solde,
                                        ristourne: userProvider.sellers[index].ristourne,
                                        profileImg: '${userProvider.sellers[index].profileImage != "" ? userProvider.sellers[index].profileImage.replaceAll('"', '') : "https://ui-avatars.com/api/?background=FFFFF&color=2C7DBF&name=${userProvider.sellers[index].firstName}+${userProvider.sellers[index].lastName}"}'))
                                );
                              })

                      );
                    }
                    else if(authProvider.currentUsr.idrole == 1){
                      return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 0.5, color: Color(
                                  0xFFCBCBCB)),
                            ),
                          ),
                          child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                    '${userProvider.sellers[index].profileImage != "" ? userProvider.sellers[index].profileImage.replaceAll('"', '') : "https://ui-avatars.com/api/?background=FFFFF&color=2C7DBF&name=${userProvider.sellers[index].firstName}+${userProvider.sellers[index].lastName}"}'),
                              ),
                              title: Text(
                                '${userProvider.sellers[index].firstName} ${userProvider.sellers[index].lastName}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                              Text('${userProvider.sellers[index].clientNumber}'),
                              trailing: userProvider
                                  .sellers[index].userName != ""
                                  ?Container(
                                width: 30,height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children:[
                                    userProvider.sellers[index].firstConnection == "0"
                                        ?Icon(Icons.account_circle,
                                        color: Colors.blue.withOpacity(0.3))
                                        :Icon(Icons.account_circle,
                                        color: Colors.green.withOpacity(0.3))
                                  ] ,
                                ),
                              )
                                  :Container(
                                width: 30,height: 30,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children:[
                                      Icon(Icons.account_circle,
                                          color: Colors.red.withOpacity(0.3))
                                    ]
                                ),
                              ),
                              onLongPress: (){
                                print('long press');
                                AwesomeDialog(
                                  context: context,
                                  borderSide: BorderSide(color: Color(0xFF2C7DBF), width: 2),
                                  width: MediaQuery.of(context).size.width,
                                  buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                                  headerAnimationLoop: false,
                                  customHeader: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        '${userProvider.sellers[index].profileImage != "" ? userProvider.sellers[index].profileImage.replaceAll('"', '') : "https://ui-avatars.com/api/?background=FFFFF&color=2C7DBF&name=${userProvider.sellers[index].firstName}+${userProvider.sellers[index].lastName}"}'),
                                  ),
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'INFO',
                                  desc: 'Dialog description here...',
                                  body: Column(
                                    children: [
                                      Form(
                                          key: _key,
                                          child: Column(
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
                                                          child: buildTextField('Nom d\'utilisateur', userProvider.sellers[index].userName)),
                                                    )),
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
                                                          child: buildTextField('Nouveau mot de passe', userProvider.sellers[index].userName)),
                                                    )),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                  showCloseIcon: true,
                                  btnOkText: 'Modifier',
                                  btnOkColor: Color(0xFF2C7DBF),
                                  btnOkOnPress: () {},
                                )..show();
                              },
                              onTap: () {
                                userProvider.busy = true;
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => SellerDetails(
                                        id: userProvider.sellers[index].iduser,
                                        phoneNumber: userProvider.sellers[index].telephone,
                                        mail: userProvider.sellers[index].email,
                                        username: userProvider.sellers[index].userName,
                                        password: userProvider.sellers[index].password,
                                        solde: userProvider.sellers[index].solde,
                                        ristourne: userProvider.sellers[index].ristourne,
                                        profileImg: '${userProvider.sellers[index].profileImage != "" ? userProvider.sellers[index].profileImage.replaceAll('"', '') : "https://ui-avatars.com/api/?background=FFFFF&color=2C7DBF&name=${userProvider.sellers[index].firstName}+${userProvider.sellers[index].lastName}"}'))
                                );
                              })
                      );
                    }
                    else{
                      return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(
                                '${userProvider.sellers[index].profileImage != "" ? userProvider.sellers[index].profileImage.replaceAll('"', '') : "https://ui-avatars.com/api/?background=FFFFF&color=2C7DBF&name=${userProvider.sellers[index].firstName}+${userProvider.sellers[index].lastName}"}'),
                          ),
                          title: Text(
                            '${userProvider.sellers[index].firstName} ${userProvider.sellers[index].lastName}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle:
                          Text('${userProvider.sellers[index].clientNumber}'),
                          onTap: () {
                            userProvider.busy = true;
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => SellerDetails(
                                    id: userProvider.sellers[index].iduser,
                                    phoneNumber: userProvider.sellers[index].telephone,
                                    mail: userProvider.sellers[index].email,
                                    username: userProvider.sellers[index].userName,
                                    password: userProvider.sellers[index].password,
                                    solde: userProvider.sellers[index].solde,
                                    ristourne: userProvider.sellers[index].ristourne,
                                    profileImg: '${userProvider.sellers[index].profileImage != "" ? userProvider.sellers[index].profileImage.replaceAll('"', '') : "https://ui-avatars.com/api/?background=FFFFF&color=2C7DBF&name=${userProvider.sellers[index].firstName}+${userProvider.sellers[index].lastName}"}'))
                            );
                          });
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }

  Widget buildTextField(String hintText, username) {
    var myController = TextEditingController();
    var myIcon;
    var _keyboardType;
    nameController.text = '$username';
    switch (hintText) {
      case 'Nom d\'utilisateur':
        {
          myController = nameController;
          myIcon = Icons.person;
          _keyboardType = TextInputType.text;
        }
        break;

      case 'Nouveau mot de passe':
        {
          myController = passwordController;
          myIcon = Icons.lock;
          _keyboardType = TextInputType.text;
        }
        break;
    }
    return TextFormField(
      validator: (v) {
        if (v.isEmpty) {
          return 'Champs obligatoire';
        }
        else if(myController == passwordController){
          if(v.length != 10){
            return 'Champs obligatoire';
          }
          else
            return null;
        }

        else {
          return null;
        }
      },
      controller: myController,
      keyboardType: _keyboardType,
      decoration: InputDecoration(
          hintText: hintText,
          hintTextDirection: TextDirection.ltr,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(myIcon)
      ),
    );
  }

}
