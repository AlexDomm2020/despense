class ToBuyItem {
  ToBuyItem(
    this.id,
    this.name,
    this.description,
    this.isBought,
  );

  final int id;
  final String name;
  final String description;
  final bool isBought;

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'name' : name,
      'description' : description,
      'isbought' : isBought,
    };
  }
}
