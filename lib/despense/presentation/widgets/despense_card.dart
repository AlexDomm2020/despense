import 'package:flutter/material.dart';

class DespenseCard extends StatefulWidget {
  DespenseCard({Key? key, this.expansionPanelTitle}) : super(key: key);

  final String? expansionPanelTitle;

  @override
  State<DespenseCard> createState() => _DespenseCardState();
}

class _DespenseCardState extends State<DespenseCard> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        active = !active;
        setState(() {});
      },
      children: [
        ExpansionPanel(
          headerBuilder: (context, isExpanded) =>
              Text(widget.expansionPanelTitle!),
          body: Container(),
          isExpanded: active,
          canTapOnHeader: true,
        ),
      ],
    );
  }
}
