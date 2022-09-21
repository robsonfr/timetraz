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
        appBar: AppBar(
            title: const Text('Editar item'),
            leading: BackButton(
              onPressed: () => Navigator.pop(context, widget.entry),
            )),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Título',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      )),
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Título', border: OutlineInputBorder()),
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
                  const Text('Descrição',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      )),
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Descrição', border: OutlineInputBorder()),
                    keyboardType: TextInputType.multiline,
                    minLines: 7,
                    maxLines: 7,
                    initialValue: widget.entry.description,
                    onChanged: (value) {
                      setState(() {
                        widget.entry.description = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
