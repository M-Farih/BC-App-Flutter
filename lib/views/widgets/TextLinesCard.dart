import 'package:flutter/material.dart';

class TextLinesCard extends StatelessWidget {
  final List<Map<String, dynamic>> linesData;
  final Color backgroundColor, titleTextColor, valueTextColor;

  TextLinesCard({
    @required this.linesData,
    this.backgroundColor = Colors.white,
    this.titleTextColor = Colors.black,
    this.valueTextColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30.0,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: backgroundColor,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: linesData.asMap().entries.map((entry) {
            final index = entry.key;
            final lineData = entry.value;
            final title = lineData.keys.first;
            final value = lineData.values.first;
            final isRTL = lineData['isRTL'] ?? true;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        value == null ? '----------------------' : value,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: valueTextColor,
                        ),
                        textDirection:
                            isRTL ? TextDirection.rtl : TextDirection.ltr,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        title == null ? '-----------' : '$title:',
                        style: TextStyle(
                          color: titleTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
                index == linesData.length - 1
                    ? SizedBox()
                    : SizedBox(height: 8.0),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
