import 'package:bc_app/views/revendeur/addRevendeur.dart';
import 'package:bc_app/views/revendeur/listRevendeur.dart';
import 'package:bc_app/views/sugg_rec/sugg_rec.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            TextButton.icon(
              onPressed: () {
                print('Add new seller');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddRevendeur()),
                );
              },
              icon: Icon(Icons.add, size: 18),
              label: Text("Add a new seller"),
            ),
            TextButton.icon(
              onPressed: () {
                print('List all sellers');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListRevendeur()),
                );
              },
              icon: Icon(Icons.supervised_user_circle, size: 18),
              label: Text("List all sellers"),
            ),
            TextButton.icon(
              onPressed: () {
                print('Suggestion et reclamation');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sugg_rec()),
                );
              },
              icon: Icon(Icons.auto_awesome_motion, size: 18),
              label: Text("reclamation / suggestion"),
            ),
          ],
        ),
      ),
    );
  }
}
