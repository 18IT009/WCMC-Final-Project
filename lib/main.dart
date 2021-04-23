import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:flutter/services.dart';

int motor_number;
int feedback_number_a;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  motor_number = await prefs.getInt("motor_number");
  feedback_number_a = await prefs.getInt("feedback_number_a");

  print('motor_number ${motor_number}');
  print('feedback_number_a ${feedback_number_a}');

  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String x, a;
  final feedbacknumberController_a = TextEditingController();
  final motornumberController = TextEditingController();

  int displaymotornumber(int mn) {
    return (mn);
  }

  int displayfeedbacknumber(int fn) {
    return (fn);
  }

  @override
  void dispose() {
    feedbacknumberController_a.dispose();
    motornumberController.dispose();
    super.dispose();
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        "motor_number", int.tryParse(motornumberController.text));
    await prefs.setInt(
        "feedback_number_a", int.tryParse(feedbacknumberController_a.text));
    var num1 = int.tryParse(motornumberController.text);
    var num2 = int.tryParse(feedbacknumberController_a.text);

    x = displaymotornumber(num1).toString();
    a = displayfeedbacknumber(num2).toString();

    setState(() {});
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (context) => new Control_page(
            text: x,
          )));
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Registration_page()));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (motor_number != null && feedback_number_a != null) {
        feedbacknumberController_a.text = feedback_number_a.toString();
        motornumberController.text = motor_number.toString();
        x = displaymotornumber(motor_number).toString();
        a = displayfeedbacknumber(feedback_number_a).toString();

        setState(() {});
      }
    });
    Future.delayed(
      Duration(seconds: 6),
          () {
        checkFirstSeen();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Registration_page(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/Krsik_X_logo.gif'),
              height: 400,
              width: 700,
            ),
            SizedBox(
              height: 50,
            ),
            Image(
              image: AssetImage('assets/loadinghouse.gif'),
              height: 100,
              width: 70,
            )
          ],
        ),
      ),
    );
  } //Splash Screen
}

// ignore: camel_case_types
class Registration_page extends StatefulWidget {
  @override
  _Registration_pageState createState() => _Registration_pageState();
}

// ignore: camel_case_types
class _Registration_pageState extends State<Registration_page> {
  String x, a;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final feedbacknumberController_a = TextEditingController();
  final motornumberController = TextEditingController();

  int displaymotornumber(int mn) {
    return (mn);
  }

  int displayfeedbacknumber(int fn) {
    return (fn);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (motor_number != null && feedback_number_a != null) {
        feedbacknumberController_a.text = feedback_number_a.toString();
        motornumberController.text = motor_number.toString();
        x = displaymotornumber(motor_number).toString();
        a = displayfeedbacknumber(feedback_number_a).toString();

        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    feedbacknumberController_a.dispose();
    motornumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Center(
                child: Image.asset('images/ZatCo_logo.png',
                    height: 200.0, width: 400.0),
              ),
            ),
          ), //SwBandhi logo
          Expanded(
            child: Form(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                  ),
                  Text(
                    'Register Here !!!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        color: Colors.green),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: motornumberController,
                      maxLength: 10,
                      autovalidate: true,
                      keyboardType: TextInputType.number,
                      validator: (input) {
                        final isDigitsOnly = int.tryParse(input);
                        return isDigitsOnly == null
                            ? 'Input needs to be digits only'
                            : null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Enter your machine mobile number'),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: feedbacknumberController_a,
                      maxLength: 10,
                      autovalidate: true,
                      keyboardType: TextInputType.number,
                      validator: (input) {
                        final isDigitsOnly = int.tryParse(input);
                        return isDigitsOnly == null
                            ? 'Input needs to be digits only'
                            : null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Enter your feedback mobile number'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Center(
                        child: MaterialButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            await prefs.setInt("motor_number",
                                int.tryParse(motornumberController.text));
                            await prefs.setInt("feedback_number_a",
                                int.tryParse(feedbacknumberController_a.text));
                            var num1 = int.tryParse(motornumberController.text);
                            var num2 =
                            int.tryParse(feedbacknumberController_a.text);
                            x = displaymotornumber(num1).toString();
                            a = displayfeedbacknumber(num2).toString();
                            setState(() {});
                            _sendDataToSecondScreen(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Control_page(
                                      text: x.substring(0, 10),
                                    )));
                            String address = x.toString();
                            String sms1 =
                                "sms:" + address + "?body=A\u002B91" + a;
                            launch(sms1);
                          },
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: Text('Submit'),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendDataToSecondScreen(BuildContext context) {
    String textToSend = x;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Control_page(
            text: x.substring(0, 10),
          ),
        ));
  }
}

class app1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, title: "Sms", home: Control_page());
  }
}

class Control_page extends StatefulWidget {
  final String text;
  Control_page({Key key, @required this.text}) : super(key: key);
  @override
  _Control_pageState createState() => _Control_pageState();
}

class _Control_pageState extends State<Control_page> {
  @override
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  int count = 0;

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit ZatCo RC?'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(child: Text("YES"), onTap: () => exit(0)),
        ],
      ),
    ) ??
        false;
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Container(
                      child: Image.asset('images/ZatCo_logo.png',
                          height: 200, width: 400),
                    ),
                  ),
                ), //SwBandhi logo

                Container(
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'JATKA MACHINE CONTROLLER',
                        style: TextStyle(
                            color: Colors.green[900] ,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ), //Controller banner
                Center(
                  child: SizedBox(
                    height: 0.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 25.0,
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Icon(
                            Icons.flash_on,
                            color: Colors.blue[900],
                            size: 40.0,
                          ),
                        ),
                      ), //Jatka Machine logo
                      SizedBox(
                        width: 20.0,
                      ),
                      Flexible(
                        flex: 10,
                        child: Container(
                          child: SwitchListTile(
                              title: new Text(
                                'JATKA MACHINE : ',
                                style: TextStyle(
                                    color: Colors.green[900],
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              value: isSwitched2,
                              activeColor: Colors.black,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched2 = value;
                                  if (isSwitched2 == true) {
                                    sendsmsontojatka();
                                  } else {
                                    sendsmsofftojatka();
                                  }
                                });
                              }),
                        ),
                      ), // Jatka Machine switch
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 25.0,
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Icon(
                            Icons.network_check,
                            color: Colors.blue[500],
                            size: 40.0,
                          ),
                        ),
                      ), //Jatka Machine logo
                      SizedBox(
                        width: 20.0,
                      ),
                      Flexible(
                        flex: 10,
                        child: Container(
                          child: new ButtonBar(
                            mainAxisSize: MainAxisSize
                                .min, // this will take space as minimum as posible(to center)
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: 300,
                                buttonColor: Colors.white,
                                child: new RaisedButton(
                                  child: new Text(
                                    'NETWORK STATUS',
                                    style: TextStyle(
                                        color: Colors.green[800],
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: sendsmsstatustojatka,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ), // Jatka Machine switch
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 25.0,
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Icon(
                            Icons.battery_unknown,
                            color: Colors.blue[600],
                            size: 40.0,
                          ),
                        ),
                      ), //Jatka Machine logo
                      SizedBox(
                        width: 20.0,
                      ),
                      Flexible(
                        flex: 10,
                        child: Container(
                          child: new ButtonBar(
                            mainAxisSize: MainAxisSize
                                .min, // this will take space as minimum as posible(to center)
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: 300,
                                buttonColor: Colors.white,
                                child: new RaisedButton(
                                  child: new Text(
                                    'BATTERY STATUS',
                                    style: TextStyle(
                                        color: Colors.green[700],
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: sendsmsbatterytojatka,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ), // Jatka Machine switch
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 25.0,
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Icon(
                            Icons.format_list_numbered,
                            color: Colors.blue[700],
                            size: 40.0,
                          ),
                        ),
                      ), //Jatka Machine logo
                      SizedBox(
                        width: 20.0,
                      ),
                      Flexible(
                        flex: 10,
                        child: Container(
                          child: new ButtonBar(
                            mainAxisSize: MainAxisSize
                                .min, // this will take space as minimum as posible(to center)
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: 300,
                                buttonColor: Colors.white,
                                child: new RaisedButton(
                                  child: new Text(
                                    'VERIFY NUMBERS',
                                    style: TextStyle(
                                        color: Colors.green[600],
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: sendsmsnumbertojatka,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ), // Jatka Machine switch
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 25.0,
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Icon(
                            Icons.lock,
                            color: Colors.blue[800],
                            size: 40.0,
                          ),
                        ),
                      ), //Jatka Machine logo
                      SizedBox(
                        width: 20.0,
                      ),
                      Flexible(
                        flex: 10,
                        child: Container(
                          child: new ButtonBar(
                            mainAxisSize: MainAxisSize
                                .min, // this will take space as minimum as posible(to center)
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: 300,
                                buttonColor: Colors.white,
                                child: new RaisedButton(
                                  child: new Text(
                                    'CHANGE PASSWORD',
                                    style: TextStyle(
                                        color: Colors.green[500],
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: sendsmspasswordtojatka,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ), // Jatka Machine switch
                    ],
                  ),
                ),

                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Center(
                      child: RaisedButton(
                        child: Text(
                          'UPDATE NUMBERS',
                        ),
                        color: Colors.lightGreen,
                        elevation: 20.0,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registration_page()),
                          );
                        },
                      ), //CC call
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Center(
                      child: RaisedButton(
                        child: Text(
                          'Call for Care',
                        ),
                        color: Colors.lightGreen,
                        elevation: 20.0,
                        onPressed: () {
                          String call1 = "tel:+91 9924720999";
                          launch(call1);
                        },
                      ), //CC call
                    ),
                    Center(
                      child: RaisedButton(
                        child: Text(
                          'Visit KRSIKX',
                        ),
                        color: Colors.lightGreen,
                        elevation: 20.0,
                        onPressed: () {
                          String url1 =
                              "https://www.krsikx.com/";
                          launch(url1);
                        },
                      ), //Website Button
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                )
              ],
            )),
      ),
    );
  }

  sendsmsontojatka() {
    String address = widget.text.toString();
    String sms1 = "sms:" + address + "?body=ZK%20ON";
    launch(sms1);
  }

  sendsmsofftojatka() {
    String address = widget.text.toString();
    String sms1 = "sms:" + address + "?body=ZK%20OFF";
    launch(sms1);
  }

  sendsmsbatterytojatka() {
    String address = widget.text.toString();
    String sms1 = "sms:" + address + "?body=BATTERY";
    launch(sms1);
  }

  sendsmsstatustojatka() {
    String address = widget.text.toString();
    String sms1 = "sms:" + address + "?body=STATUS";
    launch(sms1);
  }

  sendsmspasswordtojatka() {
    String address = widget.text.toString();
    String sms1 = "sms:" + address + "?body=PASSWARD";
    launch(sms1);
  }

  sendsmsnumbertojatka() {
    String address = widget.text.toString();
    String sms1 = "sms:" + address + "?body=NUMBER";
    launch(sms1);
  }
}
