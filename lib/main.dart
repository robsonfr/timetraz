import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timetraz/src/formedittask.dart';
import 'package:timetraz/src/timerentry.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timetraz/src/conta.dart';
import 'package:timetraz/src/login.dart';
import 'package:timetraz/src/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Supabase.initialize(
    url: '<SUPABASE_URL>',
    anonKey:
        '<SUPABASE_ANON_KEY>',
  );
  runApp(MyApp());
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Supabase.initialize(
//     // TODO: Replace credentials with your own
//     url: '[YOUR_SUPABASE_URL]',
//     anonKey: '[YOUR_SUPABASE_ANNON_KEY]',
//   );
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Flutter',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: Colors.green,
          ),
        ),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/account': (_) => const AccountPage(),
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Time Traz',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.orange,
//       ),
//       home: const MyHomePage(title: 'Time Traz'),
//     );
//   }
// }

class TimeItem {
  final TimerEntry entry;

  const TimeItem(this.entry);
}

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: const [
//         Card(
//             semanticContainer: true,
//             elevation: 4,
//             //   shape: RoundedRectangleBorder(
//             //     borderRadius: BorderRadius.circular(6)),
//             child: Image(
//               image: AssetImage('images/clock01.jpeg'),
//             )),
//       ],
//     ));
//   }
// }

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
    List<TimerEntry> actived =
        entries.where((e) => e.active && !e.done).toList();
    if (actived.isNotEmpty) {
      setState(() {
        for (var e in actived) {
          e.seconds++;
        }
      });
    }
  }

  void _toggleActive(TimerEntry entry) {
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

  void _resetEntry(TimerEntry entry) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Confirmar'),
              content:
                  const Text('Tem certeza que deseja ressetar esta tarefa?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('N??o'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      entry.seconds = 0;
                    });
                    Navigator.pop(context, 'OK');
                  },
                  child: const Text('Sim'),
                ),
              ],
            ));
  }

  void _updateEntry(TimerEntry oldEntry, TimerEntry newEntry) {
    setState(() {
      oldEntry.title = newEntry.title;
      oldEntry.description = newEntry.description;
    });
  }

  void _removeEntry(TimerEntry entry) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Confirmar'),
              content:
                  const Text('Tem certeza que deseja excluir esta tarefa?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('N??o'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      entries.remove(entry);
                    });
                    Navigator.pop(context, 'OK');
                  },
                  child: const Text('Sim'),
                ),
              ],
            ));
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
          elevation: 8,
          actions: [
            ElevatedButton(
              onPressed: _addNewEntry,
              child: const Icon(Icons.add),
            ),
          ]),
      body: Container(
        alignment: Alignment.topCenter,
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView.builder(
          // children: doEntries,
          shrinkWrap: true,
          itemBuilder: getEntry,
          itemCount: entries.length,
        ),
      ),
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
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Checkbox(
                    value: e.done,
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          e.done = value;
                        }
                      });
                    },
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(minWidth: 160.0),
                  child: Text(
                    e.title,
                    style: TextStyle(
                      // fontFamily: 'Lucida Casual',
                      fontSize: 14,
                      color: e.done ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "${(e.seconds ~/ 60).toString().padLeft(2, '0')}:${(e.seconds % 60).toString().padLeft(2, '0')}",
              style: TextStyle(
                // fontFamily: 'Arial',
                fontSize: 14,
                color: e.done ? Colors.grey : Colors.black,
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
                  onPressed: () {
                    _resetEntry(e);
                  },
                  child: const Icon(
                    Icons.restart_alt,
                    color: Colors.white,
                    size: 12.0,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _removeEntry(e);
                  },
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 12.0,
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      TimerEntry n = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FormEditTask(entry: e)));
                      _updateEntry(e, n);
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 12.0,
                    )),
                ElevatedButton(
                  onPressed: () {
                    _toggleActive(e);
                  },
                  child: Icon(
                    !e.active ? Icons.play_arrow : Icons.pause,
                    color: Colors.white,
                    size: 12.0,
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
