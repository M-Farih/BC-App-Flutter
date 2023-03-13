import 'dart:async';
import 'package:bc_app/views/home/homePage.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;
  String _copyright = '';

  AnimationController _controller;
  Animation<double> animation1;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 3,
      ),
    );

    animation1 = Tween<double>(begin: 40, end: 20).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller.forward();

    Timer(
        Duration(
          seconds: 2,
        ), () {
      setState(() {
        _fontSize = 1.06;
        _copyright = '${DateTime.now().year}';
      });
    });

    Timer(
        Duration(
          seconds: 2,
        ), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(
      Duration(
        seconds: 4,
      ),
      () {
        setState(
          () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                HomePage(),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                duration: Duration(
                  milliseconds: 2000,
                ),
                curve: Curves.fastLinearToSlowEaseIn,
                height: _height / _fontSize,
              ),
              AnimatedOpacity(
                duration: Duration(
                  milliseconds: 1000,
                ),
                opacity: _textOpacity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'BONBINO CONFORT',
                      style: TextStyle(
                        color: Colors.red.shade400,
                        fontWeight: FontWeight.w900,
                        fontSize: animation1.value,
                      ),
                    ),
                    _copyright.isEmpty
                        ? SizedBox()
                        : Text(
                            ' - ©${_copyright}',
                            style: TextStyle(
                              color: Color(0xFF2C7DBF),
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: Duration(
                milliseconds: 2000,
              ),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                duration: Duration(
                  milliseconds: 2000,
                ),
                curve: Curves.fastLinearToSlowEaseIn,
                height: _width / _containerSize * 1.1,
                width: _width / _containerSize * 1.1,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                    10.0,
                  ),
                  child: Image.asset(
                    'assets/images/logo3dd.png',
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(
            milliseconds: 2000,
          ),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}
