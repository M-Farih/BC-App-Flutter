import 'package:flutter/material.dart';

class SliderVerticalWidget extends StatefulWidget {
  final String imgUrl, title;
  final double turnover, maxi;
  SliderVerticalWidget({this.imgUrl, this.title, this.turnover, this.maxi});

  @override
  _SliderVerticalWidgetState createState() => _SliderVerticalWidgetState();
}

class _SliderVerticalWidgetState extends State<SliderVerticalWidget> {
  @override
  Widget build(BuildContext context) {
    final double min = 0;
    final double max = widget.maxi;

    var _width = MediaQuery.of(context).size.width * 0.2;
    var _height = MediaQuery.of(context).size.height / 2.8;

    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 75,
        thumbShape: SliderComponentShape.noOverlay,
        overlayShape: SliderComponentShape.noOverlay,
        valueIndicatorShape: SliderComponentShape.noOverlay,
        trackShape: RectangularSliderTrackShape(),

        /// ticks in between
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
      ),
      child: Container(
        width: _width,
        height: _height,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 3.0,
                right: 3.0,
                top: 8.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${widget.turnover.round()}',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      color: Color(0xFF2C7DBF),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'درهم',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF2C7DBF),
                      fontSize: 12.5,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Slider(
                        value: widget.turnover,
                        activeColor: Color(0xFF2C7DBF),
                        inactiveColor: Color(0xFFBEE1FF),
                        min: min,
                        max: max,
                        divisions: 40,
                        label: widget.turnover.round().toString(),
                        onChanged: (double newValue) {},
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  width: _width,
                  height: _height,
                ),
              ],
            )),
            Container(
              width: 75.0,
              height: 75.0,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      '${widget.imgUrl}',
                      fit: BoxFit.fill,
                      height: 50,
                    ),
                    Text(
                      '${widget.title}',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
      ),
    );
  }
}
