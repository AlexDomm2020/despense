import 'package:flutter/material.dart';
import 'package:mydespenseapp/despense/domain/despense_entity.dart';
import 'package:mydespenseapp/providers/sqlite_provider.dart';

class PantryAlertDialog extends StatefulWidget {
  PantryAlertDialog({Key? key}) : super(key: key);

  @override
  State<PantryAlertDialog> createState() => _PantryAlertDialogState();
}

class _PantryAlertDialogState extends State<PantryAlertDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add new Pantry'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          textfield('Name the Pantry', _controller),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget textfield(String title, TextEditingController controller) {
    return TextField(
      decoration: InputDecoration(
        hintText: title,
      ),
      controller: controller,
      onSubmitted: (value) async {
        await DespenseDatabase.instance.insertDespenseItem(
          DespenseItem(null, controller.text),
        ).then((value) => Navigator.of(context).pop());
      },
    );
  }
}
