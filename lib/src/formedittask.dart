import 'package:flutter/material.dart';
import 'package:timetraz/src/timerentry.dart';

class FormEditTask extends StatefulWidget {
  final TimerEntry entry;

  const FormEditTask({super.key, required this.entry});

  @override
  State<StatefulWidget> createState() => _FormEditTaskState();
}

class _FormEditTaskState extends State<FormEditTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Editar item')),
        body: Center(
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: 'Título'),
                validator: (String? valor) {
                  if ((valor == null) || (valor.isEmpty)) {
                    return 'Título é obrigatório';
                  }
                  return null;
                },
                initialValue: widget.entry.title,
                onChanged: (value) {
                  setState(() {
                    widget.entry.title = value;
                  });
                },
              ),
            ],
          )),
        ));
  }
}
