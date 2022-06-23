import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class MyPhotoViewer extends StatelessWidget {
  final String imageUrl;
  MyPhotoViewer({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _return(context);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.clear),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white,
        body: Container(
          child: PhotoView(
            imageProvider: NetworkImage('$imageUrl'),
          ),
        )
    );
  }

  _return(BuildContext context) {
    Navigator.pop(context);
  }
}
