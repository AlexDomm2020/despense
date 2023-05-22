import 'package:flutter/material.dart';
import 'package:mydespenseapp/despense/domain/despense_entity.dart';
import 'package:mydespenseapp/despense/presentation/widgets/alert_dialog_widget.dart';
import 'package:mydespenseapp/providers/sqlite_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<DespenseItem> _items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DespenseApp"),
        centerTitle: true,
      ),
      body: _items.isNotEmpty
          ? ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return Text(
                  _items[index].name!,
                );
              })
          : const SizedBox.shrink(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => PantryAlertDialog(),
          ).then((_) async {
            _items.clear();
            _items.addAll(await DespenseDatabase.instance.getDespenseItems());
            setState(() {});
          });
        },
      ),
    );
  }
}
