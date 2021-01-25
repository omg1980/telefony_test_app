import 'dart:async';

import 'package:flt_telephony_info/flt_telephony_info.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TelephonyInfo info;
  Timer timer;
  String networkType = '?';

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 4), (_) {
      getTelephonyInfo();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> getTelephonyInfo() async {
    try {
      info = await FltTelephonyInfo.info;

      print('///////////////!!!! \n${info?.networkType}\n${info.rawString()}');
    } catch (_) {}
    setState(() {
      networkType = (info?.networkType != null
          ? (NetworksType.values[info?.networkType]).toString()
          : '?');
    });
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'netwotk!',
            ),
            Text(
              networkType,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
