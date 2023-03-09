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
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: widget.turnover,
                      activeColor: Color(0xFF2C7DBF),
                      inactiveColor: Color(0xFFBEE1FF),
                      min: min,
                      max: max,
                      divisions: 20,
                      label: widget.turnover.round().toString(),
                      onChanged: (double newValue) {},
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.turnover.round()}',
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Dhs',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
                      )
                    ],
                  ),
                ))
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
