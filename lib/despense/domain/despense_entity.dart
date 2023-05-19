import 'package:mydespenseapp/despense/domain/to_buy_entity.dart';

class DespenseItem {
  DespenseItem(
    this.id,
    this.name,
    this.toBuyItems,
  );

  final int id;
  final String name;
  final List<ToBuyItem> toBuyItems;
}
