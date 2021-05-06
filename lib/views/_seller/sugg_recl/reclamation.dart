import 'dart:async';
import 'dart:io' as io;

import 'package:audioplayers/audioplayers.dart';
import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/contactProvider.dart';
import 'package:bc_app/providers/reasonProvider.dart';
import 'package:bc_app/services/authentificationService.dart';
import 'package:bc_app/services/sugg_recService.dart';
import 'package:bc_app/views/sugg_recc/listReclamation.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bc_app/views/widgets/profilInfoBtn.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ReclamationPage extends StatefulWidget {
  final LocalFileSystem localFileSystem;

  ReclamationPage({localFileSystem})
      : this.localFileSystem = localFileSystem ?? LocalFileSystem();

  @override
  _ReclamationState createState() => _ReclamationState();
}

class _ReclamationState extends State<ReclamationPage> {
  Sugg_recService srs = new Sugg_recService();
  var audio;

  int valueChoosen;
  List listItems = ['السبب الاول', 'السبب التاني', 'السبب التالت'];
  double _currentSliderValue = 2;

  final messageController = TextEditingController();

  int recordState = 0;
  bool isPlayed = false;

  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;

  AudioPlayer audioPlayer = AudioPlayer();
  int position = 0;


  double shadowValue = 0.0;

  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<ReasonProvider>(context, listen: false).getReasons(2);
      Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
    });
  }


  @override
  Widget build(BuildContext context) {
    var reasonProvider = Provider.of<ReasonProvider>(context, listen: true);
    var contactProvider = Provider.of<ContactProvider>(context, listen: true);
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      appBar: MyAppBar(),
      body: reasonProvider.isBusy
          ?Center(child: CircularProgressIndicator())
          :SingleChildScrollView(
        child: Center(
          child: new Padding(
            padding: new EdgeInsets.all(8.0),
            child: Form(
              key: _key,
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ///back btn & icon-title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacementNamed('home');
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
                                  'مطالبة',
                                  style: TextStyle(
                                      color: Color(0xFFF67B97), fontSize: 20.0),
                                ),
                                SizedBox(width: 15.0),
                                Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF67B97),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child:
                                      Icon(Icons.feedback, color: Colors.white),
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
                      height: 65.0,
                      width: MediaQuery.of(context).size.width - 40.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(brightness: Brightness.dark),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: DropdownButtonFormField(
                            validator: (value) => value == null ? '' : null,
                            isExpanded: true,
                            hint: Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: Text(
                                'الأسباب',
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                            value: valueChoosen,
                            onChanged: (newValue) {
                              setState(() {
                                valueChoosen = newValue;
                              });
                            },
                            items: reasonProvider.reasons.map((t) {
                              return DropdownMenuItem(
                                  value: t.idreason,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 6.0),
                                    child: Container(child: Text(t.reason,style: TextStyle(fontSize: 15), textDirection: TextDirection.ltr))
                                  ));
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
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        children: [
                          Container(
                            height: 120.0,
                            width: MediaQuery.of(context).size.width - 40,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                validator: (v) {
                                  if (v.isEmpty) {
                                    return 'المرجو ادخال الرسالة';
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'ادخل الرسالة',
                                  border: null,
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                controller: messageController,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                //Normal textInputField will be displayed
                                maxLines:
                                    5, // when user presses enter it will adapt to it
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              recordState == 0
                                  ?
                                  ///state 0 (initial state)
                                  Container(
                                      height: 20.0,
                                      width:
                                          MediaQuery.of(context).size.width / 1.8,
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                    )
                                  : recordState == 1
                                      ?

                                      ///state 1 (recording...)
                                      Row(
                                          children: [
                                            Icon(
                                              Icons.mic,
                                              color: Colors.red,
                                              size: 30.0,
                                            ),
                                            SizedBox(width: 10.0),
                                            Text(
                                                '${_current.duration.inSeconds.toString()}',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.black54))
                                          ],
                                        )
                                      :

                                      ///state 2 (audio recorded)
                                      Row(
                                          children: [
                                            !isPlayed
                                                ? GestureDetector(
                                                    child: Icon(
                                                      Icons.play_arrow,
                                                      size: 30.0,
                                                    ),
                                                    onTap: () {
                                                      audioController('play');
                                                      setState(() {
                                                        isPlayed = !isPlayed;
                                                      });
                                                    })
                                                : GestureDetector(
                                                    child: Icon(
                                                      Icons.stop,
                                                      color: Colors.red,
                                                      size: 30.0,
                                                    ),
                                                    onTap: () {
                                                      audioController('stop');
                                                      setState(() {
                                                        isPlayed = !isPlayed;
                                                      });
                                                    }),
                                            GestureDetector(
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: 30.0,
                                                ),
                                                onTap: () {
                                                  _init();
                                                  audioController('stop');
                                                  setState(() {
                                                    recordState = 0;
                                                  });
                                                }),
                                            Slider(
                                              max: double.parse(_current
                                                  .duration.inSeconds
                                                  .toString()),
                                              min: 0,
                                              value: position.toDouble(),
                                              onChanged: (value) {
                                                setState(() {
                                                  position = value.toInt();
                                                });
                                              },
                                            )
                                          ],
                                        ),
                              SizedBox(
                                width: 10.0,
                              ),

                              ///btn
                              Visibility(
                                visible: recordState == 2 ? false : true,
                                child: Container(
                                  height: 45.0,
                                  width: 45.0,
                                  decoration: BoxDecoration(
                                      boxShadow: [BoxShadow(
                                          color: Colors.blue[400],
                                          blurRadius: shadowValue,
                                          spreadRadius: shadowValue
                                      )],
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(40.0)),
                                  child: GestureDetector(
                                    child: Icon(
                                      Icons.mic,
                                      color: Colors.white,
                                    ),
                                    onTapDown: (TapDownDetails details) {
                                      _start();
                                      setState(() {
                                        shadowValue = 20.0;
                                        recordState = 1;
                                      });
                                    },
                                    onTapUp: (TapUpDetails details) {
                                      _stop();
                                      setState(() {
                                        shadowValue = 0.0;
                                        recordState = 2;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    ///send btn
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: ProfilInfoBtn(
                                text: 'إرسال',
                                color: 0xFF2C7DBF,
                                textColor: 0xFFFFFFFF),
                            onTap: () {
                              print('user id ${authProvider.currentUser.iduser}');
                              if(_key.currentState.validate()){
                                _key.currentState.save();
                                ///call provider

                                contactProvider.rec_sugg(authProvider.currentUser.iduser, valueChoosen, messageController.text, audio).whenComplete((){
                                  setState(() {
                                    messageController.text = "";
                                    _init();
                                    audioController('stop');
                                    recordState = 0;
                                  });
                                });
                              }
                              else
                                print('is not validate');
                            },
                          ),
                        ],
                      ),
                    ),

                    ///show history
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          child: Text(
                            'عرض كل مطالباتي',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                color: Color(0xFFF67B97), fontSize: 19.0),
                          ),
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed('list_reclamation');
                            Sugg_recService.clearLists();
                          },
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  _init() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = await getExternalStorageDirectory();
        }

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();

        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder =
            FlutterAudioRecorder(customPath, audioFormat: AudioFormat.WAV);

        await _recorder.initialized;
        // after initialization
        var current = await _recorder.current(channel: 0);

        // should be "Initialized", if all working fine
        setState(() {
          _current = current;
          _currentStatus = current.status;
        });
      } else {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }

  _start() async {
    try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      setState(() {
        _current = recording;
      });

      const tick = const Duration(milliseconds: 50);
      new Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder.current(channel: 0);
        setState(() {
          _current = current;
          _currentStatus = _current.status;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  _resume() async {
    await _recorder.resume();
    setState(() {});
  }

  _pause() async {
    await _recorder.pause();
    setState(() {});
  }

  _stop() async {
    var result = await _recorder.stop();
    audio = result.path;
    File file = widget.localFileSystem.file(result.path);

    setState(() {
      _current = result;
      _currentStatus = _current.status;
    });
  }

  void audioController(String state) async {
    switch (state) {
      case 'play':
        await audioPlayer.play(_current.path, isLocal: true);
        audioPlayer.onAudioPositionChanged.listen((Duration p) {
          setState(() => position = p.inSeconds);
        });

        break;
      case 'stop':
        audioPlayer?.pause();
        break;
    }
  }

  /// send audio
  void _send(topic_id, String message, int revendeur_id) {
    int type_id = 1; //{1 ---> reclamation}
    if (messageController.text.isNotEmpty || valueChoosen != null) {
      Sugg_recService.add(audio, topic_id, type_id, message, revendeur_id)
          .then((value) {
      });
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => (ListReclamation())));
    } else {
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        message: 'المرجو ادخال كامل المعلومات',
        duration: Duration(seconds: 3),
      )..show(context);
    }
    messageController.clear();
    _init();
  }

  /// pick the audio recorded from the device storage
  Future<void> pickAudio() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      audio = file.path;
    } else {
      // User canceled the picker
    }
  }
}
