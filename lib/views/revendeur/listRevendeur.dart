import 'package:bc_app/models/user.dart';
import 'package:bc_app/services/revendeurService.dart';
import 'package:bc_app/views/revendeur/addRevendeur.dart';
import 'package:bc_app/views/revendeur/updateRevendeur.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bc_app/views/widgets/slidableTiles.dart';
import 'package:flutter/material.dart';



class ListRevendeur extends StatefulWidget {
  @override
  _ListRevendeurState createState() => _ListRevendeurState();
}

class _ListRevendeurState extends State<ListRevendeur> {

  RevendeurService _rs = new RevendeurService();
  List<User> userList = [];


  TextEditingController searchController = TextEditingController();




    @override
  initState() {
    super.initState();
    _rs.getAllUsers();
  }

  getUserList() async {
    userList = await _rs.getAllUsers();
    print('User list ///// ${userList.length.toString()}');
    return userList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: null,
                controller: searchController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: FutureBuilder<dynamic>(
                future: getUserList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: userList.length,
                      itemBuilder: (context, index){
                        if(snapshot.data == null){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }else{
                          //return userCard(userList, index);
                          return UserTile(
                            child: buildListTile(userList[index]),
                            onDismissed: (action) => dismissSlidableItem(context, index, action, userList[index] ),
                          );
                        }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildListTile(User user) =>ListTile(
    contentPadding: EdgeInsets.all(8.0),
    onTap: (){},
    leading: CircleAvatar(
      radius: 28,
      backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(user.fname, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(user.lname)
      ],
    ),
  );

  dismissSlidableItem(BuildContext context, int index, SlidableAction action, User user) {

    switch (action){

      case SlidableAction.edit:
        setState(() {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UpdateRevendeur(user.id, user.fname,user.lname,user.username,user.password,user.company,user.ice,
            user.city,user.address,user.telephone,user.cNumber )));
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('user edited')));
        break;

      case SlidableAction.delete:
        _deleteUser(context, user.id.toString()).then((value) => setState(() {
          userList.removeAt(index);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('user deleted')));
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => super.widget));
        }));
        break;
    }

  }

  Future<void> _deleteUser(context, String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Supprimer le compte du revendeur'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Confirmer la suppression'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Supprimer'),
              onPressed: () {
               ///delete method
                _rs.delete(id);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
