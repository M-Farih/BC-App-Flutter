import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/userProvider.dart';
import 'package:bc_app/views/_commercial/sellers/sellerDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListSellers extends StatefulWidget {
  @override
  _ListSellersState createState() => _ListSellersState();
}

class _ListSellersState extends State<ListSellers> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
      int idagent = Provider.of<AuthProvider>(context, listen: false).currentUsr.idagent;
      Provider.of<UserProvider>(context, listen: false).getSellersByAgent(idagent);
      Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
    });
  }
  final _key = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

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
                    Container(
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

                    /// sellers list
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: userProvider.sellers.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
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
                                            matelas: userProvider.sellers[index].matelas,
                                            banquette: userProvider.sellers[index].banquette,
                                            mousse: userProvider.sellers[index].mousse,
                                            divers: userProvider.sellers[index].divers,
                                            from: userProvider.sellers[index].from_date_ca,
                                            to: userProvider.sellers[index].to_date_ca,
                                            profileImg: '${userProvider.sellers[index].profileImage != "" ? userProvider.sellers[index].profileImage.replaceAll('"', '') : "https://ui-avatars.com/api/?background=FFFFF&color=2C7DBF&name=${userProvider.sellers[index].firstName}+${userProvider.sellers[index].lastName}"}'))
                                    );
                                  })

                          );
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
