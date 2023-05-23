class ToBuyItem {
  ToBuyItem(
    this.id,
    this.despenseitemid,
    this.name,
    this.isBought,
  );

  final int? id;
  final int? despenseitemid;
  final String name;
  bool isBought;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'despenseitemid': despenseitemid,
      'name': name,
      'isbought': isBought.toString(),
    };
  }
}
