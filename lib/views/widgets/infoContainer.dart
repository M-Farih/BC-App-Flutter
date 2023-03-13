import 'package:flutter/material.dart';

class InfoContainer extends StatefulWidget {
  final TextEditingController textController;
  final bool canEdit;
  final TextDirection td;
  final double vec;
  final String label;

  InfoContainer(
      {this.textController, this.canEdit, this.td, this.vec, this.label});

  @override
  _InfoContainerState createState() => _InfoContainerState();
}

class _InfoContainerState extends State<InfoContainer> {
  TextEditingController textController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * widget.vec,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: widget.canEdit
              ? Colors.white
              : Color(
                  0xFFECECEC,
                ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              enabled: widget.canEdit,
              controller: widget.textController,
              cursorColor: Colors.black,
              textDirection: widget.td,
              decoration: InputDecoration(
                labelText: widget.label,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
