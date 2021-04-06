import 'package:flutter/material.dart';

class InfoContainer extends StatelessWidget {

  final String text;
  InfoContainer({this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 80,
        height: 50.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: Text(
                '$text',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
