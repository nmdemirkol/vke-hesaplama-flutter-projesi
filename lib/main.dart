import 'package:flutter/material.dart';

import 'package:kdgaugeview/kdgaugeview.dart';

void main() => runApp(MyApp());

double size = 1.70;
double weight = 65;
double age = 25;
double result = 0;
bool resultActive = false;
String resultText = "";
Color color;

enum SingingCharacter { male, female }

SingingCharacter gender = SingingCharacter.male;

GlobalKey<KdGaugeViewState> key = GlobalKey<KdGaugeViewState>();

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.green[600],
          accentColor: Colors.green[600],
        ),
        debugShowCheckedModeBanner: false,
        title: "Vücut Kitle Endeksi Hesapla",
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              "Vücut Kitle Endeksi Hesapla",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: <Widget>[
              Container(
                  alignment: Alignment.bottomCenter,
                  child: Image(
                      image: AssetImage("assets/images/Başlıksız-1-01.jpg"))),
              Container(
                margin: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      /*   Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(20),
                      child: Counter(),
                    ),*/
                      InputSlider(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  Counter({Key key}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int counter = 0;

  void counterAdded() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("Counter = $counter"),
        Container(
          child: RaisedButton(onPressed: counterAdded, child: Text("Added")),
        ),
      ],
    ));
  }
}

class InputSlider extends StatefulWidget {
  InputSlider({Key key}) : super(key: key);

  @override
  _InputSliderState createState() => _InputSliderState();
}

class _InputSliderState extends State<InputSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text("Boyunuzu Giriniz"),
          Row(
            children: <Widget>[
              Flexible(
                flex: 6,
                child: Slider(
                  activeColor: Colors.green[600],
                  inactiveColor: Colors.green[200],
                  value: size,
                  min: 1.0,
                  max: 2.3,
                  label: size.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      size = value;
                    });
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(size.toStringAsFixed(2).toString() + " m"),
              ),
            ],
          ),
          Text("Kilonuzu Giriniz"),
          Row(
            children: <Widget>[
              Flexible(
                flex: 6,
                child: Slider(
                  activeColor: Colors.green[600],
                  inactiveColor: Colors.green[200],
                  value: weight,
                  min: 30,
                  max: 150,
                  label: weight.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      weight = value;
                    });
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(weight.toStringAsFixed(0).toString() + " kg"),
              ),
            ],
          ),
          Text("Yaşınızı Giriniz"),
          Row(
            children: <Widget>[
              Flexible(
                flex: 6,
                child: Slider(
                  activeColor: Colors.green[600],
                  inactiveColor: Colors.green[200],
                  value: age,
                  min: 0,
                  max: 100,
                  label: age.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      age = value;
                    });
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(age.toStringAsFixed(0).toString() + " yaş"),
              ),
            ],
          ),
          Text("Cinsiyetinizi Seçiniz"),
          Container(
            margin: EdgeInsets.only(left: 50, right: 50),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: RadioListTile<SingingCharacter>(
                    title: const Text('Erkek'),
                    value: SingingCharacter.male,
                    groupValue: gender,
                    onChanged: (SingingCharacter value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: RadioListTile<SingingCharacter>(
                    title: const Text('Kadın'),
                    value: SingingCharacter.female,
                    groupValue: gender,
                    onChanged: (SingingCharacter value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                if (gender == SingingCharacter.male) {
                  result = (weight / (size * size)) * (1 - (age * 0.0005));
                  resultActive = true;
                  key.currentState.updateSpeed(result, animate: resultActive);
                } else if (gender == SingingCharacter.female) {
                  result =
                      (weight * 1.005 / (size * size)) * (1 - (age * 0.0005));
                  resultActive = true;
                  key.currentState.updateSpeed(result, animate: resultActive);
                }

                if (result < 18) {
                  resultText = "ZAYIF";
                  color = Colors.blue[200];
                } else if (result < 25) {
                  resultText = "NORMAL";
                  color = Colors.green[300];
                } else if (result < 30) {
                  resultText = "KİLOLU";
                  color = Colors.yellow[700];
                } else if (result < 35) {
                  resultText = "OBEZ";
                  color = Colors.orange[700];
                } else if (result < 40) {
                  resultText = "AŞIRI OBEZ";
                  color = Colors.red[500];
                } else {
                  resultText = "AŞIRI OBEZ 2";
                  color = Colors.red[900];
                }
              });
            },
            child: Text("Hesapla"),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.white70,
                  width: 350,
                  height: 350,
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: KdGaugeView(
                    key: key,
                    divisionCircleColors: Colors.grey[400],
                    gaugeWidth: 30,
                    fractionDigits: 1,
                    inactiveGaugeColor: Colors.grey[400],
                    subDivisionCircleColors: Colors.grey[400],
                    innerCirclePadding: 30,
                    unitOfMeasurement: "VKE",
                    minSpeed: 0,
                    maxSpeed: 45,
                    speed: result,
                    animate: resultActive,
                    alertSpeedArray: [18, 25, 30, 35, 40],
                    activeGaugeColor: Colors.blue[200],
                    alertColorArray: [
                      Colors.green[300],
                      Colors.yellow[700],
                      Colors.orange[700],
                      Colors.red[500],
                      Colors.red[900]
                    ],
                    duration: Duration(seconds: 1),
                  ),
                )
              ],
            ),
          ),
          Container(
        
            padding: EdgeInsets.all(20),
            width: 200,
            color: Colors.white,
            child: Text(
              resultText,
              textAlign: TextAlign.center,
              style: TextStyle(
                
                  fontSize: 32, fontWeight: FontWeight.bold, color: color),
            ),
          ),
            
        ],
      ),
    );
  }
}
