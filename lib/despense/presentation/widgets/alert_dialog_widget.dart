import 'package:flutter/material.dart';
import 'package:mydespenseapp/despense/domain/despense_entity.dart';
import 'package:mydespenseapp/despense/domain/to_buy_entity.dart';
import 'package:mydespenseapp/providers/sqlite_provider.dart';

class PantryAlertDialog extends StatefulWidget {
  PantryAlertDialog({Key? key, this.isPantry = true, this.pantryId}) : super(key: key);

  final bool? isPantry;
  final int? pantryId;

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
      title: widget.isPantry!
          ? const Text('Add new Pantry')
          : const Text('Add new Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: widget.isPantry!
            ? [
                textfield('Name the Pantry', _controller, widget.isPantry!),
              ]
            : [
                textfield('Name the Item', _controller, widget.isPantry!),
              ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget textfield(
      String title, TextEditingController controller, bool isPantry) {
    return TextField(
      decoration: InputDecoration(
        hintText: title,
      ),
      controller: controller,
      onSubmitted: isPantry
          ? (value) async {
              await DespenseDatabase.instance
                  .insertDespenseItem(
                    DespenseItem(null, controller.text),
                  )
                  .then((value) => Navigator.of(context).pop());
            }
          : (value) async {
              await DespenseDatabase.instance
                  .insertToButItem(
                    ToBuyItem(null, widget.pantryId, controller.text, false)
                  )
                  .then((value) => Navigator.of(context).pop());
            },
    );
  }
}
