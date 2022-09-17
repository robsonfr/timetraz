import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timetraz/timerentry.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Time Traz'),
    );
  }
}

class TimeItem {
  final TimerEntry entry;

  const TimeItem(this.entry);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TimerEntry> entries = [];

  _MyHomePageState() {
    Timer.periodic(const Duration(seconds: 1), (t) => _updateEntries(t));
  }

  void _updateEntries(Timer timer) {
    List<TimerEntry> actived = entries.where((e) => e.active).toList();
    if (actived.isNotEmpty) {
      setState(() {
        for (var e in actived) {
          e.seconds++;
        }
      });
    }
  }

  void toggleActive(TimerEntry entry) {
    setState(() => {entry.active = !entry.active});
  }

  void _addNewEntry() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      entries.add(TimerEntry());
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView.builder(
          // children: doEntries,
          itemBuilder: getEntry,
          itemCount: entries.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewEntry,
        tooltip: 'Add new entry',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getEntry(BuildContext context, int item) {
    var e = entries[item];

    return Card(
      elevation: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              e.description,
              style: const TextStyle(
                fontFamily: 'Lucida Casual',
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "${(e.seconds ~/ 60).toString().padLeft(2, '0')}:${(e.seconds % 60).toString().padLeft(2, '0')}",
              style: const TextStyle(
                fontFamily: 'Arial',
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ButtonBar(
              children: [
                ElevatedButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 16.0,
                    )),
                ElevatedButton(
                  onPressed: () {
                    toggleActive(e);
                  },
                  child: Icon(
                    !e.active ? Icons.play_arrow : Icons.stop,
                    color: Colors.white,
                    size: 16.0,
                  ),
                ),
              ],
            ),
          ),
          // ButtonBar(
          //   children: [
          //     Icon()
          //   ],
          // ),
          // const Spacer(
          //   flex: 1,
          // ),
          // ButtonBar(
          //   children: [],
          // ),
        ],
      ),
    );
  }
}
