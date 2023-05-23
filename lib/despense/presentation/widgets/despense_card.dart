import 'package:flutter/material.dart';
import 'package:mydespenseapp/despense/domain/to_buy_entity.dart';
import 'package:mydespenseapp/despense/presentation/widgets/alert_dialog_widget.dart';
import 'package:mydespenseapp/providers/sqlite_provider.dart';

class DespenseCard extends StatefulWidget {
  DespenseCard({Key? key, this.expansionPanelTitle, required this.itemId})
      : super(key: key);

  final String? expansionPanelTitle;
  final int itemId;

  @override
  State<DespenseCard> createState() => _DespenseCardState();
}

class _DespenseCardState extends State<DespenseCard> {
  bool active = false;
  bool _checked = false;
  late TextEditingController itemController;
  late List<ToBuyItem> itemsList;

  @override
  void initState() {
    itemsList = [];
    getItems();
    itemController = TextEditingController();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        active = !active;
        setState(() {});
      },
      children: [
        ExpansionPanel(
          headerBuilder: (context, isExpanded) => Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(widget.expansionPanelTitle!),
          ),
          body: Column(
            children: [
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => PantryAlertDialog(
                        isPantry: false, pantryId: widget.itemId),
                  ).then((value) async {
                    itemsList.clear();
                    itemsList.addAll(await DespenseDatabase.instance
                        .getToBuyItems(widget.itemId));
                    setState(() {});
                  });
                },
                child: const Text('Add item'),
              ),
              itemsList.isNotEmpty
                  ? Wrap(
                      children: List.generate(
                        itemsList.length,
                        (index) => CheckboxListTile(
                          value: itemsList[index].isBought,
                          onChanged: (value) async {
                            itemsList[index].isBought = value!;
                            await DespenseDatabase.instance.updateToBuyItems(itemsList[index].id!, value);
                            setState(() {});
                          },
                          title: Text(
                            itemsList[index].name,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          isExpanded: active,
          canTapOnHeader: true,
        ),
      ],
    );
  }

  Future getItems() async {
    itemsList
        .addAll(await DespenseDatabase.instance.getToBuyItems(widget.itemId));
  }
}
