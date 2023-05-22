class DespenseItem {
  DespenseItem(
    this.id,
    this.name,
  );

  final int? id;
  final String? name;

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'name' : name,
    };
  }
}
