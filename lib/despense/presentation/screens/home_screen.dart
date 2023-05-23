import 'package:flutter/material.dart';
import 'package:mydespenseapp/despense/domain/despense_entity.dart';
import 'package:mydespenseapp/despense/presentation/widgets/alert_dialog_widget.dart';
import 'package:mydespenseapp/despense/presentation/widgets/despense_card.dart';
import 'package:mydespenseapp/providers/sqlite_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<DespenseItem> _items;
  bool isLoading = true;

  @override
  void initState() {
    _items = [];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getItems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DespenseApp"),
        centerTitle: true,
      ),
      body: !isLoading
          ? ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: DespenseCard(
                    expansionPanelTitle: _items[index].name,
                    itemId: _items[index].id!,
                  ),
                );
              })
          : const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
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

  Future getItems() async {
    _items.addAll(await DespenseDatabase.instance.getDespenseItems());
    isLoading = false;
    setState(() {});
  }
}
