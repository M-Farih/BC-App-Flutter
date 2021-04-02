import 'package:flutter/material.dart';

class SliderVerticalWidget extends StatefulWidget {
  final String imgUrl, title;
  final double turnover;
  SliderVerticalWidget({this.imgUrl, this.title, this.turnover});

  @override
  _SliderVerticalWidgetState createState() => _SliderVerticalWidgetState();
}

class _SliderVerticalWidgetState extends State<SliderVerticalWidget> {
  @override
  Widget build(BuildContext context) {
    final double min = 0;
    final double max = 100000;

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
        height: MediaQuery.of(context).size.height/3,
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: Stack(
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: widget.turnover,
                      activeColor: Color(0xFF2C7DBF),
                      //inactiveColor:Colors.blue ,
                      min: min,
                      max: max,
                      divisions: 20,
                      label: widget.turnover.round().toString(),
                      onChanged:(v){
                        print('s');
                      },
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${widget.turnover.round()} Dhs',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: 75.0,
              height: 75.0,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('${widget.imgUrl}', height: 40.0, width: 40.0,),
                    Text('${widget.title}')
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }

}