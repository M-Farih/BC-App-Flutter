import 'dart:io';

import 'package:bc_app/views/widgets/photoViewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RistourneWidget extends StatefulWidget {
  final String imageLink;
  final File imagePath;
  final bool isLocal;

  const RistourneWidget({Key key, this.imageLink, this.isLocal, this.imagePath})
      : super(key: key);

  @override
  _RistourneWidgetState createState() => _RistourneWidgetState();
}

class _RistourneWidgetState extends State<RistourneWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width - 50,
            height: 230.0,
            child: Center(
                child: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'أساس حساب الخصم',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                    textDirection: TextDirection.rtl,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width - 50,
                              height: 166,
                              child: !widget.isLocal
                                  ? Image.network(
                                '${widget.imageLink}',
                                fit: BoxFit.contain,
                              )
                                  : Image.file(
                                widget.imagePath,
                                fit: BoxFit.contain,
                              )),
                        ],
                      ),
                    ),
                    onTap: () {
                      print("image clicked!!!");
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MyPhotoViewer(
                              imageUrl:
                              widget.imageLink
                          )));
                    })),
          ),
        ),
      ],
    );
  }
}