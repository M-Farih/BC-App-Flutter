import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class MyPhotoViewer extends StatelessWidget {
  final String imageUrl;
  MyPhotoViewer({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Container(
          child: PhotoView(
            imageProvider: AssetImage('$imageUrl'),
          ),
        )
    );
  }

  _return(BuildContext context) {
    Navigator.pop(context);
  }
}
