import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer/next_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'タイマー',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title,});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int second = 0;
  int minute = 0;
  int millisecond = 0;
  Timer? _timer;
  bool _isRunning = false;

  //一秒ごとにカウントアップ
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('タイマー'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}.${(millisecond ~/ 10).toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 60,
                fontFamily:'Courier New',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                toggleTimer();
              }, 
              child: Text(_isRunning ? 'ストップ' : 'スタート'),
            ),
            ElevatedButton(
              onPressed: () {
               reset();
              }, 
              child: const Text('リセット'),
            ),
          ],
        ),
      ),
    );
  }

  void toggleTimer() {
    if(_isRunning){
      _timer?.cancel();
    }else{
      _timer = Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
          setState(() {
            millisecond += 10;
            if (millisecond >= 1000) {
              millisecond = 0;
              second++;
              if (second >= 60) {
                second = 0;
                minute++;
                if(minute == 1){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context){
                        return const NextPage();
                      }));
                  _timer?.cancel();
                  _isRunning = false;
                }
              }
            }
          });
        });
      }
    setState(() {
      _isRunning =! _isRunning;
    });
  }

  void reset(){
    _timer?.cancel();
    setState(() {
      minute = 0;
      second = 0;
      millisecond = 0;
      _isRunning = false;
    });
  }
}
