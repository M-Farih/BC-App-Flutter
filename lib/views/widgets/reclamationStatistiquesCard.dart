import 'package:flutter/material.dart';

class reclamationStatistiques extends StatelessWidget {
  final int wColor;
  final IconData wIcon;
  final String wCount, wStatus;
  final Function onClick;

  const reclamationStatistiques(
      {Key key, color, this.wColor, this.wIcon, this.wCount, this.wStatus, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width / 4.5,
          height: 130,
          decoration: BoxDecoration(
              color: Color(wColor), borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(wIcon, color: Colors.white),
                Text('$wCount',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
                Text('$wStatus',
                    style: TextStyle(color: Colors.white, fontSize: 17)),
                Icon(Icons.arrow_drop_down_outlined, color: Colors.white,)
              ],
            ),
          ),
        ),
        onTap: onClick,
      ),
    );
  }
}