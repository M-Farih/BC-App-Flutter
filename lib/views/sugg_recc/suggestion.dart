import 'package:bc_app/views/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class SuggestionPage extends StatefulWidget {
  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  String valueChoosen;
  List listItems = ['السبب الاول', 'السبب التاني', 'السبب التالت'];
  double _currentSliderValue = 2;

  ///audio
  FlutterSound flutterSound = new FlutterSound();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: [
          ///back btn & icon-title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.arrow_back),
                            Text(
                              'رجوع',
                              style: TextStyle(fontSize: 20.0),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text(
                        'اقتراحات',
                        style:
                            TextStyle(color: Color(0xFFFC8F6E), fontSize: 20.0),
                      ),
                      SizedBox(width: 15.0),
                      Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFFC8F6E),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Icon(Icons.thumb_up, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),

          ///dropdown
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width - 40.0,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: Theme(
              data: Theme.of(context).copyWith(brightness: Brightness.dark),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: DropdownButton(
                  hint: Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Text('الأسباب', textDirection: TextDirection.rtl,),
                  ),
                  value: valueChoosen,
                  onChanged: (newValue) {
                    setState(() {
                      valueChoosen = newValue;
                    });
                  },
                  items: listItems.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Text(valueItem, textDirection: TextDirection.rtl),
                      )
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),

          ///text area
          Container(
            height: 180.0,
            width: MediaQuery.of(context).size.width - 40,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Column(
              children: [
                Container(
                  height: 120.0,
                  width: MediaQuery.of(context).size.width - 40,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'ادخل الرسالة',
                        border: null,
                        hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 1, //Normal textInputField will be displayed
                      maxLines: 5, // when user presses enter it will adapt to it
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.play_arrow),
                      tooltip: 'Increase volume by 10',
                      onPressed: () {
                        print('play audio');
                        _record();
                      },
                    ),
                    Slider(
                      value: _currentSliderValue,
                      min: 0,
                      max: 100,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        height: 40.0,
                        width:40.0,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(60.0)
                        ),
                        child: Icon(Icons.mic, color: Colors.white),
                      ),
                      onTap: () => print('record'),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _record() {}
}
